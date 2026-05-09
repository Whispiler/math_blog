// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./tree"

document.addEventListener("turbo:load", () => {
  if (window.MathJax) {
    MathJax.typesetPromise()
  }
})

document.addEventListener("turbo:load", () => {
  const editor = document.getElementById("editor");
  const preview = document.getElementById("preview");

  if (!editor) return;

  const updatePreview = () => {
    // Markdown → HTML
    preview.innerHTML = marked.parse(editor.value);

    // コードハイライト
    preview.querySelectorAll("pre code").forEach((block) => {
      hljs.highlightElement(block);
    });

    // MathJax 再描画
    if (window.MathJax) {
      MathJax.typesetPromise([preview]);
    }
  };

  editor.addEventListener("input", updatePreview);

  updatePreview();
});

document.addEventListener("turbo:load", () => {
  document.querySelectorAll(".copy-btn").forEach(button => {
    button.addEventListener("click", () => {
      const codeBlock = button.nextElementSibling.innerText;

      navigator.clipboard.writeText(codeBlock);

      button.innerText = "コピー完了！";
      setTimeout(() => {
        button.innerText = "コピー";
      }, 1500);
    });
  });
});

