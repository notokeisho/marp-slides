# テーマ開発ガイド

このガイドでは、Marp Slidesリポジトリに新しいテーマを追加する手順を詳しく説明します。

## 前提条件

- Node.js (v18.0.0以上) がインストールされていること
- リポジトリがセットアップ済みであること (`make install` 実行済み)
- Marp for VS Code拡張機能がインストールされていること（推奨）
- CSS の基礎知識があること

## テーマ追加の7ステップ

### ステップ1: テーマディレクトリの作成

新しいテーマ用のディレクトリを作成します。

```bash
# 例: "ocean" テーマを作成する場合
mkdir -p themes/ocean
```

**命名規則:**
- 小文字のみ使用
- ハイフン区切り (例: `ocean-blue`, `corporate-minimal`)
- テーマの特徴を表す名前

### ステップ2: CSSファイルの作成

`themes/[theme-name]/[theme-name].css` を作成します。

```bash
# 例: ocean テーマの場合
touch themes/ocean/ocean.css
```

**必須要件:**
1. ファイルの先頭に `@theme [theme-name]` ディレクティブを記述
2. ディレクトリ名とCSS内の `@theme` 名を一致させる
3. Google Fonts等の外部フォントを使用する場合は `@import` を先頭に配置

**最小限のテーマCSS例:**

```css
/* ocean.css */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Noto+Sans+JP:wght@400;700&display=swap');

/* @theme ocean */

section {
  font-family: 'Inter', 'Noto Sans JP', sans-serif;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: #ffffff;
  padding: 50px;
}

h1, h2, h3, h4, h5, h6 {
  color: #ffffff;
  font-weight: 700;
}

a {
  color: #a5c9ff;
  text-decoration: none;
}

code {
  background: rgba(255, 255, 255, 0.1);
  padding: 2px 6px;
  border-radius: 3px;
}

/* タイトルスライドのスタイル */
section.title {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
}

section.title h1 {
  font-size: 3em;
  margin-bottom: 0.5em;
}

section.title h2 {
  font-size: 1.5em;
  font-weight: 400;
  opacity: 0.9;
}
```

**参考にできる既存テーマ:**
- `themes/gradient/gradient.css` - グラデーション背景の明るいテーマ
- `themes/darkmode/darkmode.css` - ダークモードテーマ (Marp gaiaベース)

### ステップ3: VS Code設定への登録

`.vscode/settings.json` にテーマパスを追加します。

```json
{
  "markdown.marp.themes": [
    "./themes/gradient/gradient.css",
    "./themes/darkmode/darkmode.css",
    "./themes/ocean/ocean.css"  // 新しいテーマを追加
  ]
}
```

**注意:**
- パスはプロジェクトルートからの相対パス
- VS Codeでのリアルタイムプレビューに必要
- 追加後はVS Codeを再起動することを推奨

### ステップ4: Marp CLI設定への登録

`.marprc.yml` にテーマパスを追加します。

```yaml
options:
  allowLocalFiles: true

themeSet:
  - ./themes/gradient/gradient.css
  - ./themes/darkmode/darkmode.css
  - ./themes/ocean/ocean.css  # 新しいテーマを追加
```

**注意:**
- Marp CLIでのビルド (`make build`) に必要
- `allowLocalFiles: true` は画像参照のために必須

### ステップ5: テンプレートの作成

`templates/[theme-name]/template.md` を作成します。

```bash
# ディレクトリとファイルを作成
mkdir -p templates/ocean
touch templates/ocean/template.md
```

**テンプレート内容例:**

```markdown
---
marp: true
theme: ocean
paginate: true
header: ""
footer: ""
---

<!-- _class: title -->

# プレゼンテーションタイトル

## サブタイトル

---

## 目次

1. セクション 1
2. セクション 2
3. セクション 3
4. まとめ

---

## セクション 1

- ポイント 1
- ポイント 2
- ポイント 3

---

## セクション 2

### サブセクション

内容をここに記述

```

**テンプレートのポイント:**
- Front Matterの `theme:` をテーマ名に設定
- `<!-- _class: title -->` でタイトルスライド
- よく使うスライドパターンを含める
- 画像、コード、表などの例も含めると親切

### ステップ6: scripts/new-slide.js の更新（自動対応）

`scripts/new-slide.js` は `themes/` ディレクトリを自動スキャンするため、**手動での編集は不要**です。

ただし、テーマの表示順序を変更したい場合は、以下の部分を編集できます：

```javascript
// themes/ ディレクトリを自動スキャン
const themesDir = path.join(process.cwd(), 'themes');
const themes = fs.readdirSync(themesDir).filter((file) => {
  const stat = fs.statSync(path.join(themesDir, file));
  return stat.isDirectory();
});

// defaultテーマを追加して、先頭に配置
const allThemes = ["default", ...themes.filter((t) => t !== "default")];
```

**確認方法:**

```bash
make new
# テーマ選択肢に新しいテーマが表示されることを確認
```

### ステップ7: ドキュメントの更新

#### 7.1 `docs/themes.md` の更新

新しいテーマの説明セクションを追加します。

```markdown
### Ocean

海をイメージした青いグラデーションテーマ。

**特徴:**
- 青系のグラデーション背景 (#667eea → #764ba2)
- 白文字で高コントラスト
- 爽やかで清潔感のあるデザイン

**用途:**
- ビジネスプレゼンテーション
- 技術系セミナー
- 清潔感を重視するプレゼン

**使い方:**

Front Matterで指定:

\`\`\`yaml
---
theme: ocean
---
\`\`\`

**カスタマイズ例:**
...
```

#### 7.2 `README.md` の更新

テーマ一覧セクションに追加します。

```markdown
## 🎨 利用可能なテーマ

### Default
...

### Gradient
...

### Darkmode
...

### Ocean
海をイメージした爽やかなテーマ。

- 青系のグラデーション
- ビジネス・技術系プレゼンに最適
```

#### 7.3 `.claude/dev-rules.md` の更新（オプション）

開発者向けドキュメントにテーマを追加した記録を残します。

```markdown
3つのテーマが利用可能です：

1. **default** (Marp標準テーマ)
2. **gradient** (`themes/gradient/gradient.css`)
3. **darkmode** (`themes/darkmode/darkmode.css`)
4. **ocean** (`themes/ocean/ocean.css`)  // 新規追加
```

## テスト手順

### 1. テーマ選択のテスト

```bash
make new
```

1. ファイル名を入力
2. テーマ選択で新しいテーマが表示されることを確認
3. 新しいテーマを選択
4. `slides/` に生成されたファイルを確認

### 2. プレビューのテスト（VS Code）

1. 生成されたMarkdownファイルを開く
2. コマンドパレット (`Cmd+Shift+P` / `Ctrl+Shift+P`) → "Marp: Open Preview"
3. テーマが正しく適用されているか確認
4. タイトルスライド、通常スライドのスタイルを確認

### 3. ビルドのテスト

```bash
# 単一ファイルでテスト
make build-one FILE=slides/[生成したファイル名].md

# PDF確認
open dist/pdf/[ファイル名].pdf

# PPTX確認
open dist/pptx/[ファイル名].pptx

# HTML確認
open dist/html/[ファイル名].html
```

### 4. 確認項目

- [ ] VS Codeプレビューで正しく表示される
- [ ] PDFで正しく生成される
- [ ] PowerPointで正しく生成される
- [ ] HTMLで正しく生成される
- [ ] タイトルスライド (`<!-- _class: title -->`) が正しく表示される
- [ ] 通常スライドが正しく表示される
- [ ] フォントが正しく読み込まれている
- [ ] 画像が正しく表示される (テストする場合)
- [ ] コードブロックが正しく表示される (テストする場合)

## よくある問題と解決方法

### テーマが認識されない

**症状:** VS Codeプレビューやビルドでデフォルトテーマが適用される

**解決方法:**

1. **CSSファイルの確認**
   - `@theme [theme-name]` がファイル先頭にあるか
   - テーマ名がディレクトリ名と一致しているか

2. **設定ファイルの確認**
   - `.vscode/settings.json` にパスが追加されているか
   - `.marprc.yml` にパスが追加されているか

3. **VS Code再起動**
   - 設定変更後はVS Codeを再起動

4. **ビルドで確認**
   ```bash
   make pdf
   ```

### フォントが読み込まれない

**症状:** 指定したフォントではなくデフォルトフォントで表示される

**解決方法:**

1. **Google Fonts URLの確認**
   ```css
   @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap');
   ```

2. **font-familyの指定確認**
   ```css
   section {
     font-family: 'Inter', 'Noto Sans JP', sans-serif;
   }
   ```

3. **フォールバックの指定**
   - 必ず一般的なフォント名 (`sans-serif`, `serif`) を最後に追加

### スライドクラスが効かない

**症状:** `<!-- _class: title -->` などが適用されない

**解決方法:**

1. **CSSセレクタの確認**
   ```css
   /* 正しい */
   section.title {
     /* スタイル */
   }

   /* 間違い */
   .title {
     /* section. を忘れている */
   }
   ```

2. **アンダースコアの確認**
   - Markdownでは `_class` (アンダースコア必須)

3. **コメントと見出しの間の空行**
   ```markdown
   <!-- _class: title -->

   # タイトル
   ```
   空行が必要

## Git ワークフロー

### ブランチ作成

```bash
git checkout -b feature/new-theme-ocean
```

### コミット

```bash
git add themes/ocean/
git add templates/ocean/
git add .vscode/settings.json
git add .marprc.yml
git add docs/themes.md
git add README.md

git commit -m "新規テーマ追加: ocean

- themes/ocean/ocean.css 作成
- templates/ocean/template.md 作成
- 設定ファイルに登録
- ドキュメント更新"
```

### プルリクエスト

1. リモートにプッシュ
   ```bash
   git push -u origin feature/new-theme-ocean
   ```

2. GitHubでプルリクエストを作成

3. PR説明に以下を含める：
   - テーマの特徴
   - 用途
   - スクリーンショット (PDFのプレビュー画像など)
   - テスト結果

## ベストプラクティス

### CSSの構成

```css
/* 1. フォントのインポート */
@import url('...');

/* 2. テーマディレクティブ */
/* @theme theme-name */

/* 3. 基本スタイル */
section {
  /* 背景、フォント、色 */
}

/* 4. 見出しスタイル */
h1, h2, h3 {
  /* 見出しのスタイル */
}

/* 5. テキストスタイル */
p, a, code {
  /* テキスト関連 */
}

/* 6. スライドクラス */
section.title {
  /* タイトルスライド */
}

section.end {
  /* エンドスライド */
}
```

### カラーパレット

```css
/* CSS変数を使用すると管理しやすい */
section {
  --color-primary: #667eea;
  --color-secondary: #764ba2;
  --color-text: #ffffff;
  --color-bg: #1a1a1a;
  --color-accent: #a5c9ff;

  background: var(--color-bg);
  color: var(--color-text);
}

a {
  color: var(--color-accent);
}
```

### レスポンシブ対応

```css
/* 画面サイズに応じたフォントサイズ調整 */
section {
  font-size: 1.5em;
}

h1 {
  font-size: 2.5em;
}

/* 小さい画面用 */
@media (max-width: 1024px) {
  section {
    font-size: 1.2em;
  }

  h1 {
    font-size: 2em;
  }
}
```

### アクセシビリティ

```css
/* 十分なコントラスト比を確保 */
section {
  background: #1a1a1a;
  color: #ffffff; /* コントラスト比 15.3:1 */
}

/* リンクを明確に */
a {
  color: #a5c9ff;
  text-decoration: underline;
}

a:hover {
  text-decoration: none;
  background: rgba(165, 201, 255, 0.1);
}
```

## 参考資料

- [Marp公式ドキュメント](https://marpit.marp.app/)
- [Marp テーマCSS仕様](https://marpit.marp.app/theme-css)
- [既存テーマ例: gradient](../themes/gradient/gradient.css)
- [既存テーマ例: darkmode](../themes/darkmode/darkmode.css)
- [Google Fonts](https://fonts.google.com/)
- [MDN CSS リファレンス](https://developer.mozilla.org/ja/docs/Web/CSS)
