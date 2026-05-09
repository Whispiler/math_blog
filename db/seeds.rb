# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
tags = [
  # 純粋数学
  "数学",
  "代数学",
  "線形代数",
  "群論",
  "環論",
  "体論",
  "ガロア理論",
  "圏論",
  "集合論",
  "位相空間",
  "微分幾何",
  "代数幾何",
  "楕円曲線",
  "数論",
  "複素解析",
  "実解析",
  "関数解析",
  "微分方程式",
  "確率論",
  "統計学",

  # 幾何・フラクタル系
  "幾何学",
  "非ユークリッド幾何",
  "フラクタル",
  "自己相似",
  "カオス",
  "マンデルブロ集合",

  # 計算・情報系
  "アルゴリズム",
  "計算数学",
  "離散数学",
  "情報理論",
  "暗号",
  "機械学習",

  # 物理・応用
  "数理物理",
  "量子力学",
  "相対性理論",

  # Web・開発系
  "Ruby",
  "Rails",
  "JavaScript",
  "Three.js",
  "Web開発",
  "Docker",
  "Blender",
  "CG",
  "OpenGL",

  # 記法・表現
  "LaTeX",
  "Markdown",
  "可視化",

  # 思想・抽象
  "抽象化",
  "数学哲学",
  "論理",
  "証明"
]

tags.each do |tag_name|
  Tag.find_or_create_by!(name: tag_name)
end