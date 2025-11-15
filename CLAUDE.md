# スライド作成ガイド - Claude Code

このファイルは、Claude Code (claude.ai/code) を使用してスライドを作成する際のガイドです。

⚠️ **重要: このドキュメントはスライド作成専用です**
- システム開発やテーマ追加は行わないでください
- `make` コマンドのみを使用してください
- ファイルやディレクトリの直接編集は避けてください

## 基本方針

### 使用できるコマンド

✅ **使用可能なコマンド:**
- `make new` - 新規スライド作成
- `make build` - 全形式ビルド
- `make pdf` - PDFのみビルド
- `make pptx` - PowerPointのみビルド
- `make html` - HTMLのみビルド
- `make build-one FILE=slides/xxx.md` - 特定のファイルのみビルド
- `make clean` - 生成物の削除

❌ **使用禁止:**
- npmコマンドの直接実行
- ファイルやディレクトリの直接作成・編集・削除
- テーマファイル (`themes/`) の変更
- 設定ファイル (`.vscode/`, `.marprc.yml`, `Makefile`) の変更
- スクリプトファイル (`scripts/`) の変更

### トラブル時の対応

`make` コマンドが使えない場合のみ、`docs/troubleshooting.md` に記載されている手動コマンドを使用してください。

## スライド作成のワークフロー

### ステップ1: 新規スライドの作成

```bash
make new
```

1. **ファイル名を入力** (拡張子なし)
   - 例: `my-presentation`, `team-meeting`
2. **テーマを選択** (矢印キーで選択、Enterで確定)
   - `default` - シンプルな標準テーマ
   - `gradient` - 紫のグラデーションテーマ
   - `darkmode` - ダークモードテーマ
3. `slides/[filename].md` が自動生成されます

### ステップ2: スライドの編集

生成されたMarkdownファイルを開き、内容を編集します。

#### Front Matter（ヘッダー設定）

```yaml
---
marp: true
theme: gradient  # 使用するテーマ
paginate: true   # ページ番号表示
header: "ヘッダーテキスト"
footer: "フッターテキスト"
---
```

#### スライドの区切り

```markdown
---
```

横線3つ (`---`) で次のスライドに移ります。

#### スライドクラスの使用

```markdown
<!-- _class: title -->

# タイトルスライド
```

**利用可能なクラス:**
- `title` - タイトルスライド（中央配置）
- `gradient` - グラデーション背景スライド（gradientテーマのみ）
- `end` - エンドスライド

#### 画像の挿入

```markdown
# サイズ指定
![width:500px](../../assets/image.png)
![height:300px](../../assets/image.png)

# 背景画像
![bg](../../assets/background.png)
```

**注意:** 画像パスはMarkdownファイルからの相対パスで指定します。

#### 2カラムレイアウト

```markdown
<div class="columns">
<div>

### 左カラム

- ポイント1
- ポイント2

</div>
<div>

### 右カラム

- ポイント3
- ポイント4

</div>
</div>
```

#### コードブロック

````markdown
```python
def hello_world():
    print("Hello, Marp!")
    return True
```
````

#### 表

```markdown
| 項目 | 説明 | 備考 |
| ---- | ---- | ---- |
| A    | データA | 重要 |
| B    | データB | 参考 |
| C    | データC | 補足 |
```

### ステップ3: ビルド

#### すべての形式でビルド

```bash
make build
```

#### 特定の形式のみビルド

```bash
make pdf   # PDFのみ
make pptx  # PowerPointのみ
make html  # HTMLのみ
```

#### 特定のファイルのみビルド

```bash
make build-one FILE=slides/my-presentation.md
```

**出力先:**
- PDF: `dist/pdf/[filename].pdf`
- PPTX: `dist/pptx/[filename].pptx`
- HTML: `dist/html/[filename].html`

### ステップ4: 確認

生成されたファイルを確認します。

```bash
# macOSの場合
open dist/pdf/my-presentation.pdf
open dist/pptx/my-presentation.pptx
open dist/html/my-presentation.html
```

## Claude Codeとの対話例

### スライド作成のリクエスト

**ユーザー:**
```
新しいプレゼンテーションを作成したい。タイトルは「プロジェクト進捗報告」で、以下の内容を含めてください：
1. タイトルスライド
2. 目次
3. 進捗状況（3つのセクション）
4. 今後の予定
5. まとめ

テーマはgradientでお願いします。
```

**Claude Codeの対応:**
1. `make new` を実行してファイル作成
2. テーマ選択でgradientを選択
3. 指定された内容でMarkdownを編集
4. `make build` を実行してPDF/PPTX/HTML生成
5. 生成されたファイルのパスを報告

### スライド内容の修正

**ユーザー:**
```
slides/project-report.md の進捗状況セクションに、各項目の進捗率を追加してください。
```

**Claude Codeの対応:**
1. `slides/project-report.md` を読み取り
2. 進捗状況セクションを特定
3. 各項目に進捗率を追加
4. 変更内容を報告

### 画像の追加

**ユーザー:**
```
スライド3に画像を追加したい。assets/chart.png を横幅600pxで挿入してください。
```

**Claude Codeの対応:**
1. スライド3を特定
2. 正しい相対パスで画像を挿入: `![width:600px](../../assets/chart.png)`
3. 変更内容を報告

## 利用可能なテーマ

### default

Marp標準テーマ。シンプルで汎用的。

**用途:**
- ビジネスプレゼンテーション
- シンプルなデザインが必要な場合

### gradient

華やかなグラデーションテーマ。

**特徴:**
- 紫色のグラデーション (#667eea → #764ba2)
- 明るく華やかなデザイン

**用途:**
- クリエイティブなプレゼンテーション
- イベントやセミナー

### darkmode

モダンなダークモードテーマ。

**特徴:**
- ダーク背景と青いアクセント (#a5c9ff)
- 目に優しいデザイン

**用途:**
- 技術系プレゼンテーション
- 暗い会場でのプレゼンテーション

詳細は `docs/themes.md` を参照してください。

## よくある質問

### Q: テーマを途中で変更したい

A: Markdownファイルの Front Matter で `theme:` を変更してください。

```yaml
---
theme: gradient  # → theme: darkmode に変更
---
```

### Q: ページ番号を非表示にしたい

A: Front Matter で `paginate: false` に設定してください。

```yaml
---
paginate: false
---
```

### Q: ヘッダーやフッターを変更したい

A: Front Matter で `header:` と `footer:` を編集してください。

```yaml
---
header: "新しいヘッダー"
footer: "新しいフッター"
---
```

### Q: スライドの順序を入れ替えたい

A: Markdown内でスライドの順序を直接入れ替えてください。`---` で区切られた各セクションを移動します。

### Q: ビルドエラーが発生した

A: 以下を確認してください：
1. Front Matterの形式が正しいか（前後に `---` があるか）
2. 画像パスが正しいか
3. `docs/troubleshooting.md` を参照

### Q: makeコマンドが使えない

A: `docs/troubleshooting.md` の「makeコマンドが使えない」セクションを参照してください。手動コマンドでの代替方法が記載されています。

## 制約事項

### システムファイルの変更禁止

以下のファイル・ディレクトリは**絶対に変更しないでください**：

- `themes/` - テーマファイル
- `templates/` - テンプレートファイル
- `scripts/` - スクリプトファイル
- `.vscode/` - VS Code設定
- `.marprc.yml` - Marp CLI設定
- `Makefile` - ビルド設定
- `package.json` - 依存関係設定

これらを変更すると、システム全体が壊れる可能性があります。

### スライド作成のみに専念

このシステムは以下の用途のみを想定しています：

✅ **可能な操作:**
- 新規スライドの作成 (`make new`)
- スライド内容の編集 (`slides/` 内のMarkdownファイル)
- スライドのビルド (`make build` 等)
- アセットの追加 (`assets/` 内の画像ファイル)

❌ **禁止されている操作:**
- 新しいテーマの追加
- 既存テーマの変更
- スクリプトやMakefileの変更
- 設定ファイルの変更
- システムの拡張や改造

## トラブルシューティング

問題が発生した場合は、以下のドキュメントを参照してください：

- **[トラブルシューティングガイド](docs/troubleshooting.md)** - よくある問題と解決方法
- **[使い方ガイド](docs/usage.md)** - 詳細な使い方
- **[テーマガイド](docs/themes.md)** - テーマの詳細

## 参考資料

- **[README.md](README.md)** - プロジェクト概要
- **[セットアップガイド](docs/setup.md)** - 初期セットアップ手順
- **[使い方ガイド](docs/usage.md)** - スライド作成と編集
- **[テーマガイド](docs/themes.md)** - テーマの詳細
- **[アーキテクチャ](docs/architecture.md)** - プロジェクト構造
- **[トラブルシューティング](docs/troubleshooting.md)** - 問題解決

## Claude Codeの動作原則

Claude Codeがスライド作成をサポートする際の原則：

1. **makeコマンドのみを使用** - 直接のnpmコマンドやファイル操作は行わない
2. **スライドファイルのみを編集** - `slides/` 内のMarkdownファイルと `assets/` 内の画像のみ
3. **システムファイルは変更しない** - テーマ、スクリプト、設定ファイルには触れない
4. **ユーザーの意図を確認** - 不明な点は質問してから実行
5. **エラー時は適切なドキュメントを案内** - `docs/troubleshooting.md` を参照するよう促す

このガイドラインに従うことで、安全にスライドを作成できます。
