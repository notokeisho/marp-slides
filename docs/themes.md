# テーマガイド

このガイドでは、利用可能なテーマの詳細と、カスタムテーマの作成方法を説明します。

## 利用可能なテーマ

### Default テーマ

Marp の標準テーマです。シンプルで汎用的なデザインで、どんなプレゼンテーションにも使用できます。

**特徴:**

- ミニマルでクリーンなデザイン
- 黒＋白ベースのカラースキーム
- 追加の CSS ファイル不要

**使用方法:**

```markdown
---
marp: true
theme: default
---
```

**適した用途:**

- ビジネスプレゼンテーション
- 汎用的な資料
- シンプルで読みやすいスライド

### Gradient テーマ

カスタムテーマ。グラデーションを活用した華やかなデザインです。

**カラーパレット:**

- **メイングラデーション**: 紫 (#667eea) → 深紫 (#764ba2)
- **アクセント**: ピンク (#f093fb)
- **テキスト**: ダークグレー (#2d3748)

**使用方法:**

```markdown
---
marp: true
theme: gradient
---
```

**スライドタイプ:**

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

**ユーティリティクラス:**

```markdown
<div class="text-center">中央揃えテキスト</div>
<div class="text-large">大きなテキスト</div>
<div class="text-shadow">影付きテキスト</div>
<div class="card">カードスタイルコンテナ</div>
```

**適した用途:**

- クリエイティブなプレゼンテーション
- 製品発表
- 視覚的なインパクトを与えたい場面

### Darkmode テーマ

カスタムテーマ。ダークモードでモダンなデザインです。

**カラーパレット:**

- **背景**: 放射状グラデーション（ダーク）
- **アクセント**: 青色 (#a5c9ff)
- **テキスト**: ライトカラー

**使用方法:**

```markdown
---
marp: true
theme: darkmode
---
```

**特徴:**

- Marp の "gaia" テーマをベースにカスタマイズ
- 目に優しいダークモード
- 技術系プレゼンテーションに最適

**適した用途:**

- 技術プレゼンテーション
- 開発者向け資料
- 長時間のプレゼンテーション

## カスタムテーマの作成

### 1. ディレクトリ作成

```bash
mkdir themes/new-theme
```

### 2. CSS ファイル作成

`themes/new-theme/new-theme.css` を作成：

```css
/* @theme new-theme */

@import "default";

section {
  background-color: #your-color;
  color: #your-text-color;
}

h1 {
  color: #your-heading-color;
}
```

**重要**: `@theme [テーマ名]` ディレクティブを必ず含める

### 3. 設定ファイルに登録

**.vscode/settings.json に追加:**

```json
{
  "markdown.marp.themes": [
    "./themes/gradient/gradient.css",
    "./themes/darkmode/darkmode.css",
    "./themes/new-theme/new-theme.css"
  ]
}
```

**.marprc.yml に追加:**

```yaml
themeSet:
  - ./themes/gradient/gradient.css
  - ./themes/darkmode/darkmode.css
  - ./themes/new-theme/new-theme.css
```

### 4. テンプレート作成（推奨）

`templates/new-theme/template.md` を作成：

```markdown
---
marp: true
theme: new-theme
paginate: true
---

# タイトル

内容
```

### 5. 動作確認

```bash
# VS Codeでプレビュー確認
# または
make build-one FILE=slides/test.md
```

## テーマのカスタマイズ例

### フォントの変更

```css
@import url("https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap");

section {
  font-family: "Roboto", sans-serif;
}
```

### スライドサイズの変更

```css
section {
  width: 1920px;
  height: 1080px;
}
```

### カスタムクラスの追加

```css
section.highlight {
  background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
  color: white;
}
```

使用方法:

```markdown
<!-- _class: highlight -->

# ハイライトスライド
```

## 参考資料

- [Marp 公式テーマドキュメント](https://marpit.marp.app/theme-css)
- [Marp CLI Theme Guide](https://github.com/marp-team/marp-cli#theme)
- [CSS グラデーションジェネレーター](https://cssgradient.io/)

## 次のステップ

- [使い方ガイド](usage.md)でスライド作成を学ぶ
- [アーキテクチャガイド](architecture.md)でプロジェクト構造を理解
