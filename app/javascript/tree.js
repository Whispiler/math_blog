import * as THREE from "three";
import { GLTFLoader } from "three/addons/loaders/GLTFLoader.js";

const canvas = document.getElementById("bg");

let tree;

let currentScale = 0.1;
let targetScale = 0.1;

let currentRotation = 0;
let targetRotation = 0;

let currentY = 0;
let targetY = 0;

if (canvas) {
  const scene = new THREE.Scene();

  const camera = new THREE.PerspectiveCamera(
    75,
    window.innerWidth / window.innerHeight,
    0.1,
    1000
  );

  camera.position.z = 5;

  const renderer = new THREE.WebGLRenderer({
    canvas: canvas,
    alpha: true,
    antialias: true
  });

  renderer.setSize(window.innerWidth, window.innerHeight);

  renderer.setPixelRatio(window.devicePixelRatio);

  // ライト
  const directionalLight = new THREE.DirectionalLight(0xffffff, 3);

  directionalLight.position.set(3, 3, 3);

  scene.add(directionalLight);

  const ambientLight = new THREE.AmbientLight(0xffffff, 1);

  scene.add(ambientLight);

  // モデル読み込み
  const loader = new GLTFLoader();

  loader.load("/models/tree.glb", (gltf) => {
    tree = gltf.scene;

    // 初期サイズ
    tree.scale.set(0.1, 0.1, 0.1);

    // 初期位置
    tree.position.y = 0;

    scene.add(tree);

    animate();
  });

  // スクロールイベント
  window.addEventListener("scroll", () => {
    if (!tree) return;

    const scrollY = window.scrollY;

    // 目標値
    targetScale = 0.1 + scrollY * 0.001;

    targetRotation = scrollY * 0.01;

    targetY = -scrollY * 0.002;
  });

  // リサイズ対応
  window.addEventListener("resize", () => {
    camera.aspect = window.innerWidth / window.innerHeight;

    camera.updateProjectionMatrix();

    renderer.setSize(window.innerWidth, window.innerHeight);
  });

  // アニメーション
  function animate() {
    requestAnimationFrame(animate);

    if (tree) {
      // なめらか補間
      currentScale += (targetScale - currentScale) * 0.05;

      currentRotation += (targetRotation - currentRotation) * 0.05;

      currentY += (targetY - currentY) * 0.05;

      // 反映
      tree.scale.set(currentScale, currentScale, currentScale);

      tree.rotation.y = currentRotation;

      tree.position.y = currentY;
    }

    renderer.render(scene, camera);
  }
}