# アーキテクチャガイド

このドキュメントでは、Marp Slides リポジトリのディレクトリ構造と設計思想を説明します。

## ディレクトリ構造

```
marp-slides/
├─ slides/                  # スライドソース（Git管理対象）
│  ├─ example.md
│  └─ presentation.md
│
├─ templates/               # テーマ別テンプレート（Git管理対象）
│  ├─ default/
│  │  └─ template.md       # Defaultテーマ用テンプレート
│  ├─ gradient/
│  │  └─ template.md       # Gradientテーマ用テンプレート
│  └─ darkmode/
│     └─ template.md       # Darkmodeテーマ用テンプレート
│
├─ themes/                  # テーマCSSファイル（Git管理対象）
│  ├─ gradient/
│  │  └─ gradient.css      # Gradientテーマ
│  └─ darkmode/
│     └─ darkmode.css      # Darkmodeテーマ
│
├─ assets/                  # 共有画像・リソース（Git管理対象）
│
├─ dist/                    # 生成物（Git管理対象外）
│  ├─ pdf/                 # PDF出力
│  ├─ pptx/                # PowerPoint出力
│  └─ html/                # HTML出力
│
├─ scripts/                 # Node.jsスクリプト
│  └─ new-slide.js         # インタラクティブなスライド作成スクリプト
│
├─ docs/                    # プロジェクトドキュメント
│  ├─ setup.md
│  ├─ architecture.md
│  ├─ usage.md
│  ├─ themes.md
│  └─ troubleshooting.md
│
├─ .vscode/                 # VS Code設定
│  ├─ extensions.json      # 推奨拡張機能リスト
│  └─ settings.json        # Marpテーマ設定
│
├─ .marprc.yml              # Marp CLI設定
├─ Makefile                 # ビルド自動化
├─ package.json             # npm依存関係
├─ .gitignore               # 成果物除外設定
├─ LICENSE                  # MITライセンス
├─ README.md                # プロジェクト概要
└─ CLAUDE.md                # Claude Code用ガイダンス
```

## 設計思想

### スライド配置

**重要な設計原則**: スライドは `slides/` ディレクトリ直下に配置されます。

- ユーザーごとのサブディレクトリは作成しません
- フラットな構造でシンプルに管理
- ファイル名で識別（例: `2025-01-presentation.md`）

### テーマシステム

3 種類のテーマが利用可能です：

1. **default**: Marp 標準テーマ（テンプレートのみ、CSS なし）
2. **gradient**: カスタムテーマ（`themes/gradient/gradient.css`）
3. **darkmode**: カスタムテーマ（`themes/darkmode/darkmode.css`）

各テーマには対応するテンプレートが `templates/[theme-name]/template.md` に配置されています。

### 設定ファイル

#### .vscode/settings.json

VS Code の Marp 拡張機能がカスタムテーマを認識するための設定：

```json
{
  "markdown.marp.themes": [
    "./themes/gradient/gradient.css",
    "./themes/darkmode/darkmode.css"
  ]
}
```

#### .marprc.yml

Marp CLI がテーマを認識するための設定：

```yaml
themeSet:
  - ./themes/gradient/gradient.css
  - ./themes/darkmode/darkmode.css
```

### ビルドシステム

Makefile による自動化：

- `make install`: 依存パッケージのインストール
- `make new`: 新規スライド作成（インタラクティブ）
- `make build`: 全スライドを全形式でビルド
- `make pdf/pptx/html`: 特定形式のみビルド
- `make build-one FILE=...`: 単一ファイルビルド
- `make clean`: 生成物の削除

### Git 運用

**コミット対象:**

- `slides/` 内の Markdown ファイル
- `templates/` 内のテンプレートファイル
- `themes/` 内のテーマファイル
- `assets/` 内の共有画像ファイル
- 設定ファイル（`.vscode/`, `.marprc.yml`, `Makefile`, `package.json`）

**コミット対象外:**

- `dist/` 内の生成物（PDF, PPTX, HTML）
- `node_modules/`
- OS ファイル（`.DS_Store`, `Thumbs.db`）

## 拡張性

### 新しいテーマの追加

1. `themes/new-theme/` ディレクトリを作成
2. `themes/new-theme/new-theme.css` を作成（`@theme new-theme` ディレクティブを含む）
3. `.vscode/settings.json` と `.marprc.yml` にテーマを登録
4. `templates/new-theme/template.md` にテンプレートを作成

### 新しいビルド形式の追加

Makefile に新しいターゲットを追加することで、他の形式（例: PNG 画像）にも対応可能です。

## 関連ドキュメント

- [セットアップガイド](setup.md)
- [使い方ガイド](usage.md)
- [テーマガイド](themes.md)
