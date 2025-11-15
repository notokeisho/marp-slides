# Marp Slides

Marp（Markdown Presentation Ecosystem）を使ったスライド管理リポジトリ。
Markdown でスライドを書き、PDF/PowerPoint/HTML に自動変換します。

## ✨ 特徴

- 📝 **Markdown でスライド作成** - シンプルな記法で美しいプレゼンテーション
- 🎨 **3 つのテーマ** - Default, Gradient, Darkmode から選択
- 🚀 **インタラクティブ CLI** - Next.js ライクな UI でスライド作成
- 📦 **自動ビルド** - PDF, PowerPoint, HTML を一括生成
- 🔧 **VS Code 統合** - リアルタイムプレビュー

## 🚀 クイックスタート

### 1. セットアップ

```bash
# リポジトリをクローン
git clone git@github.com:notokeisho/marp-slides.gits
cd marp-slides

# 依存パッケージをインストール
make install
```

### 2. スライド作成

```bash
# インタラクティブに新規スライド作成
make new
```

1. ファイル名を入力
2. テーマを選択（矢印キーで選択）
3. `slides/[filename].md` が自動生成

### 3. ビルド

```bash
# すべての形式（PDF, PPTX, HTML）でビルド
make build

# 特定の形式のみ
make pdf    # PDFのみ
make pptx   # PowerPointのみ
make html   # HTMLのみ
```

**出力先**: `dist/pdf/`, `dist/pptx/`, `dist/html/`

## 🎨 利用可能なテーマ

### Default

Marp 標準テーマ。シンプルで汎用的。

- ミニマルデザイン
- ビジネス用途に最適

### Gradient

華やかなグラデーションテーマ。

- 紫色のグラデーション (#667eea → #764ba2)
- クリエイティブなプレゼンテーションに

### Darkmode

モダンなダークモードテーマ。

- 目に優しいダーク背景
- 技術系プレゼンテーションに

詳細は[テーマガイド](docs/themes.md)を参照。

## 📚 ドキュメント

- **[セットアップガイド](docs/setup.md)** - 詳細なインストール手順
- **[使い方ガイド](docs/usage.md)** - スライド作成と Marp 記法
- **[テーマガイド](docs/themes.md)** - テーマの詳細とカスタマイズ
- **[アーキテクチャ](docs/architecture.md)** - プロジェクト構造と設計思想
- **[トラブルシューティング](docs/troubleshooting.md)** - よくある問題と解決方法

## 🔨 よく使うコマンド

```bash
make install              # セットアップ
make new                  # 新規スライド作成
make build                # 全形式ビルド
make build-one FILE=...   # 単一ファイルビルド
make clean                # 生成物削除
make help                 # ヘルプ表示
```

## 📁 プロジェクト構造

```
marp-slides/
├─ slides/        # スライドソース（.md）
├─ templates/     # テーマ別テンプレート
├─ themes/        # カスタムテーマCSS
├─ assets/        # 共有画像・リソース
├─ dist/          # 生成物（Git管理外）
├─ docs/          # ドキュメント
└─ scripts/       # ビルドスクリプト
```

詳細は[アーキテクチャガイド](docs/architecture.md)を参照。

## 🤝 コントリビューション

1. `make new` でスライドを作成して編集
2. 新しいテーマを追加する場合は `themes/new-theme/` を作成して PR
3. テンプレートを改善する場合は各テーマのテンプレートを編集して PR
