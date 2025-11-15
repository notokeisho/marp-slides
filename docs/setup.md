# セットアップガイド

このガイドでは、Marp Slides リポジトリの初期セットアップ手順を詳しく説明します。

## 必要要件

- **Node.js**: v18.0.0 以上
- **npm**: Node.js に同梱
- **Git**: バージョン管理用

## セットアップ手順

### 1. リポジトリのクローン

```bash
git clone <repository-url>
cd marp-slides
```

### 2. 依存パッケージのインストール

```bash
make install
```

**インストールされるパッケージ:**

- `@marp-team/marp-cli` (開発依存): Markdown からスライドを生成
- `inquirer` (開発依存): インタラクティブな CLI UI

### 3. VS Code 拡張機能のインストール（推奨）

VS Code でリポジトリを開くと、自動的に推奨拡張機能のインストールを促すメッセージが表示されます。

**必須拡張機能:**

- **Marp for VS Code** (`marp-team.marp-vscode`)
  - Markdown ファイルのリアルタイムプレビュー
  - カスタムテーマ（default, gradient, darkmode）の使用
  - スライドの編集中に即座にプレビュー確認

**手動インストール方法:**

```bash
# VS Codeのコマンドパレット (Cmd+Shift+P / Ctrl+Shift+P) で:
ext install marp-team.marp-vscode
```

または [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=marp-team.marp-vscode) から直接インストール

### 4. セットアップの確認

```bash
# 新規スライド作成をテスト
make new
```

正常に動作すれば、セットアップ完了です。

## トラブルシューティング

セットアップ中に問題が発生した場合は、[トラブルシューティングガイド](troubleshooting.md)を参照してください。

## 次のステップ

- [使い方ガイド](usage.md)でスライドの作成方法を学ぶ
- [テーマガイド](themes.md)で利用可能なテーマを確認
- [アーキテクチャガイド](architecture.md)でプロジェクト構造を理解
