# Claude Code - 開発専用ルール

⚠️ **このファイルの用途**
このファイルはシステム開発・テーマ開発時のみ使用してください。
**スライド作成時は使用禁止です。** スライド作成時は `CLAUDE.md` を使用してください。

## プロジェクト概要

Marp（Markdown Presentation Ecosystem）スライド管理リポジトリです。MarkdownファイルはMarp CLIを使用してPDF、PowerPoint、HTMLプレゼンテーションに変換されます。

## アーキテクチャ

### ディレクトリ構造の設計思想

```
slides/                     # スライドソース（Git管理対象）
  ├─ example.md
  └─ presentation.md
templates/                  # テーマ別テンプレート（Git管理対象）
  ├─ default/
  │  └─ template.md
  ├─ gradient/
  │  └─ template.md
  └─ darkmode/
     └─ template.md
themes/[theme-name]/        # テーマCSSファイル（Git管理対象）
  ├─ gradient/
  │  └─ gradient.css
  └─ darkmode/
     └─ darkmode.css
assets/                     # 共有画像・リソース（Git管理対象）
dist/                       # 生成物（Git管理対象外）
  ├─ pdf/
  ├─ pptx/
  └─ html/
scripts/                    # Node.jsスクリプト
  └─ new-slide.js           # インタラクティブなスライド作成
docs/                       # ドキュメント
  ├─ setup.md
  ├─ usage.md
  ├─ themes.md
  ├─ architecture.md
  └─ troubleshooting.md
.claude/                    # 開発用ドキュメント
  ├─ dev-rules.md           # このファイル
  └─ theme-development.md   # テーマ開発手順
```

**重要な設計原則**: スライドは`slides/`ディレクトリ直下に配置されます（ユーザーごとのサブディレクトリは作成しません）。

### テーマシステム

3つのテーマが利用可能です：

1. **default** (Marp標準テーマ)
   - Marpのデフォルトテーマ
   - シンプルで汎用的なデザイン
   - テンプレートのみ存在（CSSファイルなし）
   - 使用方法: Front Matterで`theme: default`

2. **gradient** (`themes/gradient/gradient.css`)
   - グラデーションオーバーレイ付き明るい背景
   - 紫色のカラースキーム (#667eea → #764ba2)
   - 使用方法: Front Matterで`theme: gradient`

3. **darkmode** (`themes/darkmode/darkmode.css`)
   - 放射状グラデーション付きダーク背景
   - 青色のカラースキーム (#a5c9ff)
   - Marpの"gaia"テーマをベースにカスタマイズ
   - 使用方法: Front Matterで`theme: darkmode`

カスタムテーマ（gradient, darkmode）の共通点：
- Google Fonts（Inter、Noto Sans JP）をインポート
- `.vscode/settings.json`と`.marprc.yml`に登録されている
- CSSファイルの先頭で`@theme [名前]`を使用する必要がある

### Marp設定

**VS Code統合:**
- `.vscode/extensions.json`: 推奨拡張機能リスト（Marp for VS Code）
- `.vscode/settings.json`: Marp for VS Code拡張機能用にテーマパスを登録

**CLI設定:**
- `.marprc.yml`: コマンドライン用にテーマを登録

**ビルドオプション:**
- すべてのビルドで`--allow-local-files`フラグを使用してローカル画像参照を許可

### 必須拡張機能

**Marp for VS Code** (`marp-team.marp-vscode`)
- リポジトリを開くと自動的にインストールを提案
- `.vscode/extensions.json`に定義済み
- カスタムテーマ（gradient, darkmode）を使用するために必須
- 拡張機能なしでは`.vscode/settings.json`のテーマ設定が機能しない

## よく使うコマンド

### セットアップ

```bash
make install              # npmパッケージのインストール (Marp CLI, inquirer)
```

**インストールされるもの:**
- `@marp-team/marp-cli`: Markdownからスライドを生成
- `inquirer`: `make new`でのインタラクティブUI

### 開発用コマンド

```bash
# セットアップ
make install

# 新規スライド作成（動作確認）
make new

# ビルド
make build                # 全形式ビルド
make pdf                  # PDFのみ
make pptx                 # PowerPointのみ
make html                 # HTMLのみ
make build-one FILE=slides/example.md  # 単一ファイル

# クリーンアップ
make clean

# ヘルプ
make help
```

### ビルド動作

- `slides/*.md`を反復処理
- 出力ファイル名: `[filename].[拡張子]`
- 例: `slides/demo.md` → `dist/pdf/demo.pdf`

## 新しいテーマの追加

詳細は `.claude/theme-development.md` を参照してください。

**概要:**
1. `themes/new-theme/` ディレクトリ作成
2. `themes/new-theme/new-theme.css` 作成（`@theme new-theme` ディレクティブ必須）
3. `.vscode/settings.json` と `.marprc.yml` に登録
4. `templates/new-theme/template.md` 作成
5. ドキュメント更新（`docs/themes.md`, `README.md`）

## Gitワークフロー

**コミット対象:**
- `slides/` 内のMarkdownファイル
- `templates/` 内のテンプレートファイル
- `themes/` 内のテーマファイル
- `assets/` 内の共有画像ファイル
- 設定ファイル（`.vscode/`, `.marprc.yml`, `Makefile`, `package.json`）

**コミット対象外:**
- `dist/` 内の生成物（PDF, PPTX, HTML）
- `node_modules/`
- OSファイル（`.DS_Store`, `Thumbs.db`）

**ブランチ命名規則:**
- `feature/new-theme-ocean` - 新テーマ追加
- `feature/presentation-name` - スライド作成（通常はスライド作成者が使用）
- `fix/theme-gradient-header` - テーマバグ修正

## 重要な注意事項

### Marp固有の制約

- MarpはYAML Front Matterの厳密なフォーマットを要求（前後に3つのダッシュ）
- スライドは`---`で区切られる（独立した行である必要がある）
- Front Matterのテーマ名はCSSの`@theme`ディレクティブと完全に一致する必要がある
- ローカル画像参照には`--allow-local-files`フラグが必要（Makefileに含まれている）
- 出力ファイル名のパターンはMakefileのロジックを変更しない限り変更不可

### システム設計上の制約

- スライドは `slides/` 直下に配置（サブディレクトリなし）
- テーマ名とディレクトリ名は一致させる必要がある
- `scripts/new-slide.js` は自動的に `themes/` から利用可能なテーマを検出

## ドキュメント構成

- `README.md`: プロジェクト概要とクイックスタート（一般向け）
- `CLAUDE.md`: スライド作成専用ルール（非エンジニア向け）
- `.claude/dev-rules.md`: このファイル（開発者向け）
- `.claude/theme-development.md`: テーマ開発手順（開発者向け）
- `docs/`: 詳細ドキュメント（全ユーザー向け）

## 参考資料

- [Marp公式ドキュメント](https://marpit.marp.app/)
- [Marp CLI](https://github.com/marp-team/marp-cli)
- [Marp for VS Code](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode)
