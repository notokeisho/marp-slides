# Mermaid 図の使い方

Marp スライドで Mermaid 図（フローチャート、シーケンス図など）を使用する方法です。

## 重要な注意点

**Marp は Mermaid をネイティブサポートしていません。**

```markdown
<!-- これは動作しません -->
```mermaid
graph LR
    A --> B
```

上記のように書くと、コードブロックとして表示されてしまいます。

## 解決方法：SVG に変換

Mermaid 図を SVG 画像に変換してからスライドに挿入します。

SVG（ベクター形式）を使用するため、どんなサイズでも鮮明に表示されます。

### ステップ 1: .mmd ファイルを作成

`workspace/img/` に `.mmd` ファイルを作成します。

```bash
# 例: workspace/img/workflow.mmd
```

**ファイル内容の例：**

```
graph LR
    A[作業ディレクトリ] -->|git add| B[ステージング]
    B -->|git commit| C[ローカルリポジトリ]
    C -->|git push| D[リモートリポジトリ]
```

### ステップ 2: SVG に変換

```bash
make mermaid FILE=workspace/img/workflow.mmd
```

これで `workspace/img/workflow.svg` が生成されます。

### ステップ 3: スライドに挿入

```markdown
![width:600px](../img/workflow.svg)
```

## Mermaid 記法の例

### フローチャート

```
graph LR
    A[開始] --> B{条件}
    B -->|Yes| C[処理1]
    B -->|No| D[処理2]
    C --> E[終了]
    D --> E
```

### シーケンス図

```
sequenceDiagram
    participant User
    participant Server
    User->>Server: リクエスト
    Server-->>User: レスポンス
```

### Git グラフ

```
gitGraph
    commit id: "初期コミット"
    branch feature
    checkout feature
    commit id: "機能追加"
    checkout main
    merge feature
```

### 円グラフ

```
pie title 売上構成
    "製品A" : 40
    "製品B" : 30
    "製品C" : 30
```

## コマンドリファレンス

```bash
# 単一ファイルを変換
make mermaid FILE=workspace/img/diagram.mmd

# 出力: workspace/img/diagram.svg
```

## トラブルシューティング

### エラー: mmdc not found

```bash
# 依存関係を再インストール
make install
```

### 図が正しく表示されない

1. `.mmd` ファイルの構文を確認
2. [Mermaid Live Editor](https://mermaid.live/) でプレビュー
3. 修正後、再度 `make mermaid` を実行

## 参考リンク

- [Mermaid 公式ドキュメント](https://mermaid.js.org/)
- [Mermaid Live Editor](https://mermaid.live/) - オンラインプレビュー
