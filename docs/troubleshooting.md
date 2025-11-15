# トラブルシューティング

よくある問題とその解決方法をまとめています。

## セットアップ関連

### Marp CLI が見つからない

**症状:**

```bash
marp: command not found
```

**解決方法:**

```bash
# グローバルインストールを確認
npm list -g @marp-team/marp-cli

# 再インストール
npm install -g @marp-team/marp-cli

# または、プロジェクトローカルで実行
npx marp --version
```

### npm install が失敗する

**症状:**

```
npm ERR! code EACCES
```

**解決方法:**

```bash
# 権限の問題の場合、sudoを使う（macOS/Linux）
sudo npm install

# または、Node.jsのバージョンを確認
node --version  # v18.0.0以上が必要
```

## VS Code 関連

### Marp 拡張機能でプレビューが表示されない

**症状:**

- プレビューが空白
- テーマが適用されない

**解決方法:**

1. **拡張機能がインストールされているか確認**

   ```bash
   # コマンドパレットで:
   ext show marp-team.marp-vscode
   ```

2. **設定ファイルの確認**

   `.vscode/settings.json` が存在し、テーマパスが正しいか確認：

   ```json
   {
     "markdown.marp.themes": [
       "./themes/gradient/gradient.css",
       "./themes/darkmode/darkmode.css"
     ]
   }
   ```

3. **VS Code を再起動**

   設定変更後は VS Code の再起動が必要な場合があります。

### カスタムテーマが認識されない

**症状:**

- `theme: gradient` を指定してもデフォルトテーマになる

**解決方法:**

1. **テーマ CSS ファイルの確認**

   `themes/gradient/gradient.css` の先頭に `@theme gradient` があるか確認

2. **.marprc.yml の確認**

   ```yaml
   themeSet:
     - ./themes/gradient/gradient.css
     - ./themes/darkmode/darkmode.css
   ```

3. **ビルド時の確認**

   ```bash
   # Makefileを使う場合は自動で読み込まれる
   make pdf

   # 手動でmarpコマンドを使う場合は--theme-setオプションが必要
   marp --theme-set themes/gradient/gradient.css slides/example.md
   ```

## ビルド関連

### 画像が表示されない

**症状:**

- ビルドされた PDF/PPTX/HTML で画像が表示されない

**解決方法:**

1. **相対パスを確認**

   Markdown ファイルから画像への相対パスが正しいか確認：

   ```markdown
   # 正しい例（slidesディレクトリから見た相対パス）
   ![](../../assets/image.png)

   # 間違い例（絶対パスや誤った相対パス）
   ![](/assets/image.png)
   ![](assets/image.png)
   ```

2. **--allow-local-files オプションの確認**

   Makefile を使っていれば自動で付与されますが、手動でビルドする場合は：

   ```bash
   marp --pdf --allow-local-files slides/example.md
   ```

### make コマンドが使えない

**症状:**

```bash
make: command not found
```

**解決方法:**

1. **macOS の場合**

   ```bash
   # Xcode Command Line Toolsをインストール
   xcode-select --install
   ```

2. **Windows の場合**

   - Git Bash を使用
   - または [Make for Windows](http://gnuwin32.sourceforge.net/packages/make.htm) をインストール

3. **直接 npm スクリプトを使う**

   ```bash
   # make newの代わり
   npm run new

   # make buildの代わり
   npx marp --pdf --allow-local-files slides/*.md -o dist/pdf/
   ```

### ビルドが非常に遅い

**症状:**

- `make build` が数分かかる

**解決方法:**

1. **特定のファイルのみビルド**

   ```bash
   make build-one FILE=slides/presentation.md
   ```

2. **必要な形式のみビルド**

   ```bash
   # PDFのみ
   make pdf

   # PowerPointのみ
   make pptx
   ```

## スライド作成関連

### make new でエラーが出る

**症状:**

```
Error: inquirer.prompt is not a function
```

**解決方法:**

```bash
# 依存パッケージを再インストール
rm -rf node_modules package-lock.json
npm install
```

### Front Matter が認識されない

**症状:**

- ページ番号が表示されない
- テーマが適用されない

**解決方法:**

1. **YAML フォーマットの確認**

   前後に `---` が必要：

   ```markdown
   ---
   marp: true
   theme: gradient
   paginate: true
   ---
   ```

2. **インデントの確認**

   YAML ではスペースによるインデントが重要です。タブは使用しないでください。

### スライドクラスが適用されない

**症状:**

- `<!-- _class: title -->` が効かない

**解決方法:**

1. **アンダースコアの確認**

   `_class` はアンダースコアが必須です（`class` ではない）

2. **コメント形式の確認**

   ```markdown
   <!-- _class: title -->

   # タイトル
   ```

   コメントとタイトルの間に空行が必要です。

## その他

### Git で dist/ の生成物がコミットされてしまう

**症状:**

- PDF や PPTX がコミット対象になる

**解決方法:**

1. **.gitignore の確認**

   以下が含まれているか確認：

   ```
   dist/
   ```

2. **すでにコミットされている場合**

   ```bash
   # Gitキャッシュから削除
   git rm -r --cached dist/

   # コミット
   git commit -m "Remove dist/ from Git tracking"
   ```

### Node.js のバージョンが古い

**症状:**

```
This package requires Node.js v18.0.0 or higher
```

**解決方法:**

1. **Node.js のバージョンを確認**

   ```bash
   node --version
   ```

2. **Node.js を更新**

   - [Node.js 公式サイト](https://nodejs.org/)から最新版をインストール
   - または nvm を使用:

   ```bash
   # nvmで最新のLTS版をインストール
   nvm install --lts
   nvm use --lts
   ```

## サポート

上記で解決しない場合は、以下を確認してください：

- [Marp 公式ドキュメント](https://marpit.marp.app/)
- [Marp CLI GitHub Issues](https://github.com/marp-team/marp-cli/issues)
- [プロジェクトの GitHub Issues](../../issues)

## 関連ドキュメント

- [セットアップガイド](setup.md)
- [使い方ガイド](usage.md)
- [テーマガイド](themes.md)
