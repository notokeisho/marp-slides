# CLAUDE.md

このファイルは、このリポジトリで作業する際にClaude Code (claude.ai/code) にガイダンスを提供します。

## プロジェクト概要

チーム管理されたMarp（Markdown Presentation Ecosystem）スライドリポジトリです。MarkdownファイルはMarp CLIを使用してPDF、PowerPoint、HTMLプレゼンテーションに変換されます。

## アーキテクチャ

### ディレクトリ構造の設計思想

```
slides/                     # スライドソース（Git管理対象）
  ├─ example.md
  └─ presentation.md
templates/                  # テーマ別テンプレート（Git管理対象）
  ├─ gradient/
  │  └─ template.md
  └─ darkmode/
     └─ template.md
themes/[theme-name]/        # テーマCSSファイル（Git管理対象）
  ├─ gradient/
  └─ darkmode/
assets/                     # 共有画像・リソース（Git管理対象）
dist/                       # 生成物（Git管理対象外）
```

**重要な設計原則**: スライドは`slides/`ディレクトリ直下に配置されます。

### テーマシステム

2つのカスタムMarpテーマが定義されています：

1. **gradient** (`themes/gradient/gradient.css`)
   - グラデーションオーバーレイ付き明るい背景
   - 紫色のカラースキーム (#842174)
   - 使用方法: Front Matterで`theme: gradient`

2. **darkmode** (`themes/darkmode/darkmode.css`)
   - 放射状グラデーション付きダーク背景
   - 青色のカラースキーム (#a5c9ff)
   - Marpの"gaia"テーマをベースにしている
   - 使用方法: Front Matterで`theme: darkmode`

両テーマ共通：
- Google Fonts（Inter、Noto Sans JP）をインポート
- `.vscode/settings.json`と`.marprc.yml`に登録されている
- CSSファイルの先頭で`@theme [名前]`を使用する必要がある

### Marp設定

- **VS Code統合**: `.vscode/settings.json`でMarp for VS Code拡張機能用にテーマパスを登録
- **CLI設定**: `.marprc.yml`でコマンドライン用にテーマを登録
- **ビルドオプション**: すべてのビルドで`--allow-local-files`フラグを使用してローカル画像参照を許可

## よく使うコマンド

### セットアップ

```bash
make install              # Marp CLIをグローバルインストール (npm install -g @marp-team/marp-cli)
```

### スライドのビルド

```bash
make install              # Marp CLIをグローバルインストール
make new                  # 新規スライド作成（インタラクティブ）
make build                # すべてのスライドを全形式でビルド（PDF、PPTX、HTML）
make pdf                  # PDFのみビルド
make pptx                 # PowerPointのみビルド
make html                 # HTMLのみビルド
make build-one FILE=slides/presentation.md  # 単一ファイルをビルド（全形式）
make clean                # dist/内のすべての生成ファイルを削除
```

### ビルド動作

- `slides/*.md`を反復処理
- 出力ファイル名: `[filename].[拡張子]`
- 例: `slides/demo.md` → `dist/pdf/demo.pdf`

## 新しいスライドの作成

### インタラクティブ作成（推奨）

1. `make new` を実行
2. ファイル名を入力
3. テーマを選択（矢印キーで選択、Enterで確定）
4. `slides/[filename].md` が自動生成される

### 手動作成

1. テンプレートをコピー:
   - Gradientテーマ: `cp templates/gradient/template.md slides/presentation.md`
   - Darkmodeテーマ: `cp templates/darkmode/template.md slides/presentation.md`
2. 内容を編集してビルド: `make build-one FILE=slides/presentation.md`

## Marp固有のパターン

### スライドクラス

- `<!-- _class: title -->` - 全画面タイトルスライド
- `<!-- _class: gradient -->` - 全面グラデーション背景スライド（gradientテーマのみ）
- `<!-- _class: end -->` - エンドスライド
- クラス指定なし = デフォルトのコンテンツスライド

### 画像の扱い

- Markdownファイルからの相対パスを使用: `../../assets/image.png`
- サイズ制御: `![width:500px](path)` または `![height:300px](path)`
- 背景: `![bg](path)`

### 2カラムレイアウト

```html
<div class="columns">
<div>
左側のコンテンツ
</div>
<div>
右側のコンテンツ
</div>
</div>
```

## 新しいテーマの追加

1. ディレクトリを作成: `mkdir themes/new-theme`
2. CSSを作成: `themes/new-theme/new-theme.css`に`@theme new-theme`ディレクティブを含める
3. 両方に登録:
   - `.vscode/settings.json`: `"./themes/new-theme/new-theme.css"`を追加
   - `.marprc.yml`: `- ./themes/new-theme/new-theme.css`を追加
4. テンプレートを作成: `templates/new-theme/template.md`に対応するテンプレートを作成することを推奨

## Gitワークフロー

**コミット対象**: `slides/`内のMarkdownファイル、`themes/`内のテーマファイル、templates、assets
**無視対象**: `dist/`内のすべて、`node_modules/`、OSファイル

ブランチ命名規則: `feature/presentation-name`

## 重要な注意事項

- MarpはYAML Front Matterの厳密なフォーマットを要求（前後に3つのダッシュ）
- スライドは`---`で区切られる（独立した行である必要がある）
- Front Matterのテーマ名はCSSの`@theme`ディレクティブと完全に一致する必要がある
- ローカル画像参照には`--allow-local-files`フラグが必要
- 出力ファイル名のパターンはMakefileのロジックを変更しない限り変更不可
