# 使い方ガイド

このガイドでは、スライドの作成からビルドまでの基本的な使い方を説明します。

## スライドの作成

### インタラクティブ作成（推奨）

```bash
make new
```

1. **ファイル名を入力**（拡張子なし）
2. **テーマを選択**（矢印キーで選択、Enter で確定）
   - default
   - gradient
   - darkmode
3. `workspace/slides/[filename].md` が自動生成されます

### 手動作成

`make new`の使用を推奨しますが、手動でテンプレートをコピーすることもできます：

```bash
# 例：Gradientテーマを使う場合
cp system/templates/gradient/template.md workspace/slides/my-presentation.md
```

## スライドの編集

### 基本構造

```markdown
---
marp: true
theme: gradient
paginate: true
header: "ヘッダーテキスト"
footer: "フッターテキスト"
---

<!-- _class: title -->

# タイトルスライド

## サブタイトル

---

## スライド2

内容
```

### スライド区切り

横線 3 つ（`---`）で次のスライドに移ります。

```markdown
---
```

### Front Matter（ヘッダー設定）

スライドファイルの先頭で設定を記述：

```yaml
---
marp: true
theme: gradient # 使用するテーマ
paginate: true # ページ番号表示
header: "ヘッダーテキスト"
footer: "フッターテキスト"
---
```

### スライドクラス

特定のスライドにクラスを適用：

```markdown
<!-- _class: title -->

# タイトルスライド
```

**利用可能なクラス:**

- `title`: タイトルスライド
- `gradient`: グラデーション背景スライド（gradient テーマのみ）
- `end`: エンドスライド

### 画像の挿入

```markdown
# サイズ指定
![width:500px](../img/image.png)
![height:300px](../img/image.png)

# 背景画像
![bg](../img/background.png)
```

**注意**: 画像パスは Markdown ファイルからの相対パスで指定します。`workspace/slides/` から `workspace/img/` への相対パスは `../img/` です。

### 2 カラムレイアウト

```markdown
<div class="columns">
<div>

### 左カラム

- ポイント 1
- ポイント 2

</div>
<div>

### 右カラム

- ポイント 3
- ポイント 4

</div>
</div>
```

### コードブロック

````markdown
```python
def hello_world():
    print("Hello, Marp!")
    return True
```
````

### 表

```markdown
| 項目 | 説明     | 備考 |
| ---- | -------- | ---- |
| A    | データ A | 重要 |
| B    | データ B | 参考 |
| C    | データ C | 補足 |
```

## スライドのビルド

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

**出力先:**

- PDF: `workspace/output/pdf/[filename].pdf`
- PPTX: `workspace/output/pptx/[filename].pptx`
- HTML: `workspace/output/html/[filename].html`

### 特定のファイルだけビルド

```bash
make build-one FILE=workspace/slides/presentation.md
```

すべての形式（PDF, PPTX, HTML）が生成されます。

### 生成物の削除

```bash
make clean
```

`workspace/output/` 内のすべての生成ファイルを削除します。

## スライドのプレビュー

### ブラウザプレビュー（推奨）

```bash
make preview
```

1. 利用可能なスライド一覧が表示される
2. ファイル名を入力（拡張子なし）
3. ブラウザでプレビューが自動的に開く
4. ファイルを保存すると自動的に更新される
5. 終了は `Ctrl+C`

**メリット:**
- VS Code より軽量
- 実際のスライド表示に近い
- ライブリロード対応

### VS Code でのプレビュー

Marp for VS Code 拡張機能がインストールされている場合：

1. `.md` ファイルを開く
2. コマンドパレット（`Cmd+Shift+P` / `Ctrl+Shift+P`）を開く
3. "Marp: Open Preview" を選択
4. リアルタイムプレビューが表示されます

**ショートカット**: エディタ右上の Marp アイコンをクリック

## よく使うコマンドまとめ

```bash
# セットアップ
make install

# 新規スライド作成
make new

# ブラウザプレビュー
make preview

# すべてビルド
make build

# クリーンアップ
make clean

# ヘルプ表示
make help
```

## 次のステップ

- [テーマガイド](themes.md)で各テーマの詳細を確認
- [トラブルシューティング](troubleshooting.md)で問題解決
