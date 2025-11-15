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
3. `slides/[filename].md` が自動生成されます

### 手動作成

`make new`の使用を推奨しますが、手動でテンプレートをコピーすることもできます：

```bash
# 例：Gradientテーマを使う場合
cp templates/gradient/template.md slides/my-presentation.md
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
![width:500px](../../assets/image.png)
![height:300px](../../assets/image.png)

# 背景画像
![bg](../../assets/background.png)
```

**注意**: 画像パスは Markdown ファイルからの相対パスで指定します。

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

- PDF: `dist/pdf/[filename].pdf`
- PPTX: `dist/pptx/[filename].pptx`
- HTML: `dist/html/[filename].html`

### 特定のファイルだけビルド

```bash
make build-one FILE=slides/presentation.md
```

すべての形式（PDF, PPTX, HTML）が生成されます。

### 生成物の削除

```bash
make clean
```

`dist/` 内のすべての生成ファイルを削除します。

## VS Code でのプレビュー

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
