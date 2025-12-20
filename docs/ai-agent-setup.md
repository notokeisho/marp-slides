# AIエージェントセットアップガイド

このガイドでは、各AIコーディングエージェントのインストールと初期設定方法を説明します。

## 目次

- [Claude Code](#claude-code)
- [Cursor](#cursor)
- [GitHub Copilot CLI](#github-copilot-cli)
- [Gemini CLI](#gemini-cli)
- [Codex](#codex)

---

## Claude Code

Anthropic社が提供するCLIベースのAIコーディングエージェントです。

### インストール

```bash
# npmでグローバルインストール
npm install -g @anthropic-ai/claude-code
```

### プロジェクトを開く

```bash
# プロジェクトディレクトリに移動
cd /path/to/marp-slides

# Claude Codeを起動
claude
```

### 初回の使い方

起動したら、以下のように話しかけてください：

```
セットアップして
```

Claude Codeが自動でセットアップを実行します。

セットアップ完了後：

```
スライド作成して
```

と言うだけで、スライド作成が始まります。

### 参考リンク

- [Claude Code公式ドキュメント](https://docs.anthropic.com/claude-code)

---

## Cursor

AI機能が統合されたコードエディタです。

### インストール

1. [Cursor公式サイト](https://cursor.sh/) にアクセス
2. 「Download」をクリック
3. ダウンロードしたインストーラーを実行
4. 画面の指示に従ってインストール

### プロジェクトを開く

1. Cursorを起動
2. 「File」→「Open Folder」を選択
3. `marp-slides` フォルダを選択
4. 「Open」をクリック

### 初回の使い方

1. `Cmd + K`（Mac）または `Ctrl + K`（Windows）を押してAIチャットを開く
2. 以下のように入力：

```
セットアップして
```

CursorのAIが自動でセットアップを実行します。

セットアップ完了後：

```
スライド作成して
```

と入力すると、スライド作成が始まります。

### 参考リンク

- [Cursor公式サイト](https://cursor.sh/)
- [Cursorドキュメント](https://cursor.sh/docs)

---

## GitHub Copilot CLI

GitHub Copilotのコマンドライン版です。

### 前提条件

- GitHub Copilotのサブスクリプションが必要
- GitHub CLIがインストールされていること

### インストール

```bash
# GitHub CLIをインストール（未インストールの場合）
brew install gh

# GitHub CLIにログイン
gh auth login

# Copilot拡張機能をインストール
gh extension install github/gh-copilot
```

### プロジェクトを開く

```bash
# プロジェクトディレクトリに移動
cd /path/to/marp-slides
```

### 初回の使い方

```bash
# Copilotに質問
gh copilot suggest "セットアップして"
```

または、ターミナルで直接：

```bash
gh copilot explain "このプロジェクトをセットアップするには？"
```

### 参考リンク

- [GitHub Copilot CLI公式ドキュメント](https://docs.github.com/en/copilot/github-copilot-in-the-cli)

---

## Gemini CLI

Google DeepMindが提供するAIエージェントのCLI版です。

### 前提条件

- Google Cloud アカウント
- Gemini API キー

### インストール

```bash
# npmでグローバルインストール
npm install -g @anthropic-ai/gemini-cli
```

または、公式の方法：

```bash
# pipでインストール
pip install google-generativeai
```

### API設定

```bash
# 環境変数でAPIキーを設定
export GOOGLE_API_KEY="your-api-key"
```

`.bashrc` または `.zshrc` に追加することを推奨：

```bash
echo 'export GOOGLE_API_KEY="your-api-key"' >> ~/.zshrc
source ~/.zshrc
```

### プロジェクトを開く

```bash
# プロジェクトディレクトリに移動
cd /path/to/marp-slides

# Gemini CLIを起動
gemini
```

### 初回の使い方

起動したら、以下のように入力：

```
セットアップして
```

セットアップ完了後：

```
スライド作成して
```

### 参考リンク

- [Google AI Studio](https://aistudio.google.com/)
- [Gemini APIドキュメント](https://ai.google.dev/docs)

---

## Codex

OpenAIが提供するAIコーディングエージェントです。

### 前提条件

- OpenAI APIキー

### インストール

```bash
# npmでグローバルインストール
npm install -g @openai/codex
```

### API設定

```bash
# 環境変数でAPIキーを設定
export OPENAI_API_KEY="your-api-key"
```

### プロジェクトを開く

```bash
# プロジェクトディレクトリに移動
cd /path/to/marp-slides

# Codexを起動
codex
```

### 初回の使い方

起動したら、以下のように入力：

```
Set up the project
```

または日本語で：

```
セットアップして
```

セットアップ完了後：

```
Create slides
```

または：

```
スライド作成して
```

### 参考リンク

- [OpenAI公式サイト](https://openai.com/)
- [OpenAI APIドキュメント](https://platform.openai.com/docs)

---

## セットアップ完了後の使い方

どのAIエージェントでも、セットアップが完了したら以下のように話しかけるだけでスライドを作成できます：

| やりたいこと | 話しかける内容 |
|-------------|---------------|
| スライド作成 | 「スライド作成して」 |
| スライド修正 | 「スライドを修正して」 |
| ビルド | 「ビルドして」 |

AIエージェントが必要な情報（ファイル名、テーマ、内容など）を質問してくれるので、答えるだけでスライドが完成します。

## トラブルシューティング

### AIエージェントが起動しない

- Node.jsがインストールされているか確認: `node --version`
- npmがインストールされているか確認: `npm --version`
- 再インストールを試す: `npm install -g [エージェント名]`

### APIキーエラー

- 環境変数が正しく設定されているか確認
- APIキーが有効か確認
- 課金設定が正しいか確認

### その他の問題

[トラブルシューティングガイド](troubleshooting.md) を参照してください。
