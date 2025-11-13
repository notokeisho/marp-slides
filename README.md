# Marp Slides - チーム用スライド管理リポジトリ

Marp（Markdown Presentation Ecosystem）を使ったスライド共同管理リポジトリです。
Markdownでスライドを書き、PDF/PowerPoint/HTMLに自動変換します。

## 📁 ディレクトリ構造

```
marp-slides/
├─ templates/
│  ├─ gradient/
│  │  └─ template.md       # Gradientテーマ用テンプレート
│  └─ darkmode/
│     └─ template.md       # Darkmodeテーマ用テンプレート
│
├─ themes/                 # テーマCSS
│  ├─ gradient/
│  │  └─ gradient.css      # Gradientテーマ
│  └─ darkmode/
│     └─ darkmode.css      # Darkmodeテーマ
│
├─ slides/                 # 各メンバーのスライドソース(.md)
│  ├─ keisho/
│  └─ sample-user/
│
├─ assets/                 # 共通画像・素材
│
├─ dist/                   # 生成物（Git管理外）
│  ├─ pptx/                # PowerPoint出力
│  ├─ pdf/                 # PDF出力
│  └─ html/                # HTML出力
│
├─ .vscode/                # VS Code設定
│  └─ settings.json        # Marpテーマ設定
├─ .marprc.yml             # Marp CLI設定
├─ Makefile                # ビルド自動化
├─ .gitignore              # 成果物除外設定
└─ README.md               # 本ファイル
```

## 🚀 セットアップ

### 1. Marp CLIのインストール

```bash
# Makefileを使う場合
make install

# 手動でインストールする場合
npm install -g @marp-team/marp-cli
```

### 2. リポジトリのクローン

```bash
git clone <repository-url>
cd marp-slides
```

## ✍️ スライドの作成方法

### 1. 自分のディレクトリを作成

```bash
mkdir slides/your-name
```

### 2. テンプレートをコピー

```bash
# Gradientテーマを使う場合
cp templates/gradient/template.md slides/your-name/my-presentation.md

# Darkmodeテーマを使う場合
cp templates/darkmode/template.md slides/your-name/my-presentation.md
```

### 3. Markdownでスライドを編集

```markdown
---
marp: true
theme: gradient
paginate: true
---

<!-- _class: title -->

# タイトルスライド

## サブタイトル

**発表者名**

---

## スライド2

- 箇条書き1
- 箇条書き2

---

## スライド3

画像の挿入:
![width:500px](../../assets/sample.png)
```

## 🔨 ビルドコマンド

### 全スライドをビルド

```bash
# すべての形式（PDF, PPTX, HTML）を生成
make build

# PDF のみ
make pdf

# PowerPoint のみ
make pptx

# HTML のみ
make html
```

### 特定のファイルだけビルド

```bash
make build-one FILE=slides/keisho/example.md
```

### 生成物の削除

```bash
make clean
```

## 📋 Marp記法の基礎

### スライド区切り

```markdown
---
```

横線3つ（`---`）で次のスライドに移ります。

### ヘッダー設定（Front Matter）

```yaml
---
marp: true
theme: gradient
paginate: true
header: "ヘッダーテキスト"
footer: "フッターテキスト"
---
```

### スライドクラス指定

```markdown
<!-- _class: title -->     # タイトルスライド（グラデーション背景）
<!-- _class: gradient -->  # グラデーション背景スライド
<!-- _class: end -->       # エンドスライド（グラデーション背景）
```

通常のスライドは白背景で表示され、上部にグラデーションバーが表示されます。

### 画像サイズ指定

```markdown
![width:500px](path/to/image.png)
![height:300px](path/to/image.png)
![bg](path/to/background.png)  # 背景画像
```

### 2カラムレイアウト

```markdown
<div class="columns">
<div>

左カラムの内容

</div>
<div>

右カラムの内容

</div>
</div>
```

### スライドごとの設定

```markdown
<!-- _class: gradient -->
<!-- _backgroundColor: #123456 -->
```

## 🎨 Gradientテーマの特徴

### カラーパレット

- **メイングラデーション**: 紫 (#667eea) → 深紫 (#764ba2)
- **アクセント**: ピンク (#f093fb)
- **テキスト**: ダークグレー (#2d3748)

### スライドタイプ

1. **タイトルスライド** (`_class: title`)
   - 全画面グラデーション背景
   - グラデーションテキスト効果
   - 中央揃え

2. **コンテンツスライド** (デフォルト)
   - 白背景
   - 上部にグラデーションバー
   - グラデーションカラーの見出し

3. **グラデーションスライド** (`_class: gradient`)
   - 全画面グラデーション背景
   - 白色テキスト
   - 強調表現に最適

4. **エンドスライド** (`_class: end`)
   - リバースグラデーション背景
   - 白色テキスト
   - 中央揃え

### ユーティリティクラス

```markdown
<div class="text-center">中央揃えテキスト</div>
<div class="text-large">大きなテキスト</div>
<div class="text-shadow">影付きテキスト</div>
<div class="card">カードスタイルコンテナ</div>
```

## 📦 Git運用ルール

### ✅ コミット対象

- `slides/` 内のMarkdownファイル
- `templates/` 内のテンプレートファイル
- `assets/` 内の共有画像ファイル
- `gradient.css`, `darkmode.css` テーマファイル

### ❌ コミット対象外（自動除外）

- `dist/` 内の生成物（PDF, PPTX, HTML）
- `node_modules/`
- `.DS_Store`, `Thumbs.db`

### ワークフロー例

```bash
# 1. 自分のブランチを作成
git checkout -b slides/your-name/new-presentation

# 2. スライドを作成・編集
vim slides/your-name/presentation.md

# 3. ローカルでビルド確認
make build-one FILE=slides/your-name/presentation.md

# 4. コミット
git add slides/your-name/presentation.md
git commit -m "Add: New presentation about XYZ"

# 5. プッシュ
git push origin slides/your-name/new-presentation

# 6. Pull Request作成
```

## 🔧 トラブルシューティング

### Marp CLIが見つからない

```bash
# グローバルインストールを確認
npm list -g @marp-team/marp-cli

# 再インストール
npm install -g @marp-team/marp-cli
```

### 画像が表示されない

- 相対パスを確認（`../../assets/image.png`）
- `--allow-local-files` オプションが必要（Makefileに含まれています）

### テーマが適用されない

- Front Matterで `theme: gradient` が正しく設定されているか確認
- テーマCSSファイルが `gradient.css` に存在するか確認
- VS Code を再起動してテーマを再読み込み

### VS Codeでプレビューが表示されない

- Marp for VS Code 拡張機能がインストールされているか確認
- `.vscode/settings.json` にテーマパスが正しく設定されているか確認

## 📚 参考資料

- [Marp公式ドキュメント](https://marpit.marp.app/)
- [Marp CLI](https://github.com/marp-team/marp-cli)
- [Markdown記法](https://www.markdownguide.org/)
- [Marp for VS Code](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode)

## 🤝 コントリビューション

1. 自分のディレクトリ（`slides/your-name/`）内で自由に作業
2. 新しいテーマを追加する場合は `themes/new-theme/` を作成してPR
3. テンプレートを改善する場合は各テーマのテンプレートを編集してPR

---

**Happy Presenting! 🎉**
