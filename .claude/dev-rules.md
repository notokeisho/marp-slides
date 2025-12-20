# Claude Code - 開発専用ルール

⚠️ **このファイルの用途**
このファイルはシステム開発・テーマ開発時のみ使用してください。
**スライド作成時は使用禁止です。** スライド作成時は `CLAUDE.md` を使用してください。

## 重要

- ユーザが Coding Agent を実行前に必ず、`docs/important-key.md`を確認してください。

## 🔧 開発リクエスト対応フロー

### 「テーマを追加して」「新しいテーマを作りたい」と言われたら

1. `.claude/theme-development.md` を読む
2. 7 ステップの手順に従ってテーマを作成：
   - ディレクトリ作成
   - CSS ファイル作成
   - 設定ファイル登録
   - テンプレート作成
   - ドキュメント更新
   - テスト
3. 完了したら報告

### 「システムを修正して」「スクリプトを変更して」と言われたら

1. 変更対象を確認（system/scripts/, Makefile, 設定ファイル等）
2. 変更内容を確認
3. 変更を実施
4. テスト
5. 変更内容を報告

### 開発で使用可能なコマンド

```bash
make install              # セットアップ
make new                  # スライド作成テスト
make build                # ビルドテスト
make clean                # クリーンアップ
npm install               # 依存パッケージインストール
npm run [script]          # package.jsonスクリプト実行
```

### 編集可能なファイル（開発時のみ）

- `system/themes/` - テーマ CSS
- `system/templates/` - テンプレート
- `system/scripts/` - Node.js スクリプト
- `.vscode/settings.json` - VS Code 設定
- `.marprc.yml` - Marp CLI 設定
- `Makefile` - ビルド設定
- `package.json` - 依存関係
- `docs/` - ドキュメント

## プロジェクト概要

Marp（Markdown Presentation Ecosystem）スライド管理リポジトリです。Markdown ファイルは Marp CLI を使用して PDF、PowerPoint、HTML プレゼンテーションに変換されます。

## アーキテクチャ

### ディレクトリ構造の設計思想

```
workspace/                  # ユーザー作業エリア
  ├─ slides/               # スライドソース（Git管理対象）
  │  ├─ example.md
  │  └─ presentation.md
  ├─ img/                  # 画像・リソース（Git管理対象）
  └─ output/               # 生成物（Git管理対象外）
     ├─ pdf/
     ├─ pptx/
     └─ html/
system/                     # システムファイル
  ├─ templates/            # テーマ別テンプレート（Git管理対象）
  │  ├─ default/
  │  │  └─ template.md
  │  ├─ gradient/
  │  │  └─ template.md
  │  └─ darkmode/
  │     └─ template.md
  ├─ themes/               # テーマCSSファイル（Git管理対象）
  │  ├─ gradient/
  │  │  └─ gradient.css
  │  └─ darkmode/
  │     └─ darkmode.css
  └─ scripts/              # Node.jsスクリプト
     └─ new-slide.js       # インタラクティブなスライド作成
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

**重要な設計原則**: スライドは`workspace/slides/`ディレクトリ直下に配置されます（ユーザーごとのサブディレクトリは作成しません）。

### テーマシステム

3 つのテーマが利用可能です：

1. **default** (Marp 標準テーマ)

   - Marp のデフォルトテーマ
   - シンプルで汎用的なデザイン
   - テンプレートのみ存在（CSS ファイルなし）
   - 使用方法: Front Matter で`theme: default`

2. **gradient** (`system/themes/gradient/gradient.css`)

   - グラデーションオーバーレイ付き明るい背景
   - 紫色のカラースキーム (#667eea → #764ba2)
   - 使用方法: Front Matter で`theme: gradient`

3. **darkmode** (`system/themes/darkmode/darkmode.css`)
   - 放射状グラデーション付きダーク背景
   - 青色のカラースキーム (#a5c9ff)
   - Marp の"gaia"テーマをベースにカスタマイズ
   - 使用方法: Front Matter で`theme: darkmode`

カスタムテーマ（gradient, darkmode）の共通点：

- Google Fonts（Inter、Noto Sans JP）をインポート
- `.vscode/settings.json`と`.marprc.yml`に登録されている
- CSS ファイルの先頭で`@theme [名前]`を使用する必要がある

### Marp 設定

**VS Code 統合:**

- `.vscode/extensions.json`: 推奨拡張機能リスト（Marp for VS Code）
- `.vscode/settings.json`: Marp for VS Code 拡張機能用にテーマパスを登録

**CLI 設定:**

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

- `@marp-team/marp-cli`: Markdown からスライドを生成
- `inquirer`: `make new`でのインタラクティブ UI

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
make build-one FILE=workspace/slides/example.md  # 単一ファイル

# クリーンアップ
make clean

# ヘルプ
make help
```

### ビルド動作

- `workspace/slides/*.md`を反復処理
- 出力ファイル名: `[filename].[拡張子]`
- 例: `workspace/slides/demo.md` → `workspace/output/pdf/demo.pdf`

## 新しいテーマの追加

詳細は `.claude/theme-development.md` を参照してください。

**概要:**

1. `system/themes/new-theme/` ディレクトリ作成
2. `system/themes/new-theme/new-theme.css` 作成（`@theme new-theme` ディレクティブ必須）
3. `.vscode/settings.json` と `.marprc.yml` に登録
4. `system/templates/new-theme/template.md` 作成
5. ドキュメント更新（`docs/themes.md`, `README.md`）

## Git ワークフロー

**コミット対象:**

- `workspace/slides/` 内の Markdown ファイル
- `workspace/img/` 内の画像ファイル
- `system/templates/` 内のテンプレートファイル
- `system/themes/` 内のテーマファイル
- 設定ファイル（`.vscode/`, `.marprc.yml`, `Makefile`, `package.json`）

**コミット対象外:**

- `workspace/output/` 内の生成物（PDF, PPTX, HTML）
- `node_modules/`
- OS ファイル（`.DS_Store`, `Thumbs.db`）

**ブランチ命名規則:**

- `feature/new-theme-ocean` - 新テーマ追加
- `feature/presentation-name` - スライド作成（通常はスライド作成者が使用）
- `fix/theme-gradient-header` - テーマバグ修正

## 重要な注意事項

### Marp 固有の制約

- Marp は YAML Front Matter の厳密なフォーマットを要求（前後に 3 つのダッシュ）
- スライドは`---`で区切られる（独立した行である必要がある）
- Front Matter のテーマ名は CSS の`@theme`ディレクティブと完全に一致する必要がある
- ローカル画像参照には`--allow-local-files`フラグが必要（Makefile に含まれている）
- 出力ファイル名のパターンは Makefile のロジックを変更しない限り変更不可

### システム設計上の制約

- スライドは `workspace/slides/` 直下に配置（サブディレクトリなし）
- テーマ名とディレクトリ名は一致させる必要がある
- `system/scripts/new-slide.js` は自動的に `system/themes/` から利用可能なテーマを検出

## ドキュメント構成

- `README.md`: プロジェクト概要とクイックスタート（一般向け）
- `CLAUDE.md`: スライド作成専用ルール（非エンジニア向け）
- `.claude/dev-rules.md`: このファイル（開発者向け）
- `.claude/theme-development.md`: テーマ開発手順（開発者向け）
- `docs/`: 詳細ドキュメント（全ユーザー向け）

## 参考資料

- [Marp 公式ドキュメント](https://marpit.marp.app/)
- [Marp CLI](https://github.com/marp-team/marp-cli)
- [Marp for VS Code](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode)
