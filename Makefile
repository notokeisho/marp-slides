# Marp Slides Management Makefile

.PHONY: help build pdf pptx html clean install check-marp new preview

# デフォルトターゲット
help:
	@echo "Marp Slides Build Commands:"
	@echo "  make install  - Install Marp CLI globally"
	@echo "  make new      - Create new slide (interactive)"
	@echo "  make preview  - Live preview in browser"
	@echo "  make build    - Build all formats (PDF, PPTX, HTML)"
	@echo "  make pdf      - Convert all .md to PDF"
	@echo "  make pptx     - Convert all .md to PowerPoint"
	@echo "  make html     - Convert all .md to HTML"
	@echo "  make clean    - Remove all generated files in workspace/output/"
	@echo ""
	@echo "Single file build:"
	@echo "  make build-one FILE=workspace/slides/example.md"

# 必要なツールをインストール
install:
	@echo "📦 Installing dependencies..."
	@echo ""
	@echo "Installing npm packages (Marp CLI, inquirer)..."
	npm install
	@echo ""
	@echo "✅ Installation complete!"

# Marp CLI チェック
check-marp:
	@command -v marp >/dev/null 2>&1 || { \
		echo "❌ ERROR: marp not found"; \
		echo "Run: make install"; \
		exit 1; \
	}

# 新規スライド作成
new:
	@node system/scripts/new-slide.js $(if $(NAME),--name=$(NAME)) $(if $(THEME),--theme=$(THEME))

# ライブプレビュー（ブラウザで表示、保存時に自動更新）
preview: check-marp
	@if [ -n "$(FILE)" ]; then \
		if [ -f "$(FILE)" ]; then \
			echo "🔍 Starting preview server..."; \
			echo "   Press Ctrl+C to stop"; \
			marp --preview --allow-local-files "$(FILE)"; \
		else \
			echo "❌ File not found: $(FILE)"; \
			exit 1; \
		fi \
	else \
		echo "Available slides:"; \
		ls -1 workspace/slides/*.md 2>/dev/null | sed 's/workspace\/slides\//  /' | sed 's/\.md$$//' || echo "  (no slides found)"; \
		echo ""; \
		read -p "Enter filename (without .md): " file; \
		if [ -f "workspace/slides/$$file.md" ]; then \
			echo "🔍 Starting preview server..."; \
			echo "   Press Ctrl+C to stop"; \
			marp --preview --allow-local-files "workspace/slides/$$file.md"; \
		else \
			echo "❌ File not found: workspace/slides/$$file.md"; \
			exit 1; \
		fi \
	fi

# 全形式ビルド
build: pdf pptx html
	@echo "✅ All formats built successfully"

# PDF生成
pdf: check-marp
	@echo "Building PDF files..."
	@mkdir -p workspace/output/pdf
	@for file in workspace/slides/*.md; do \
		if [ -f "$$file" ]; then \
			base=$$(basename $$file .md); \
			echo "  Converting $$file → workspace/output/pdf/$$base.pdf"; \
			marp --pdf --allow-local-files "$$file" -o "workspace/output/pdf/$$base.pdf"; \
		fi \
	done

# PowerPoint生成
pptx: check-marp
	@echo "Building PowerPoint files..."
	@mkdir -p workspace/output/pptx
	@for file in workspace/slides/*.md; do \
		if [ -f "$$file" ]; then \
			base=$$(basename $$file .md); \
			echo "  Converting $$file → workspace/output/pptx/$$base.pptx"; \
			marp --pptx --allow-local-files "$$file" -o "workspace/output/pptx/$$base.pptx"; \
		fi \
	done

# HTML生成
html: check-marp
	@echo "Building HTML files..."
	@mkdir -p workspace/output/html
	@for file in workspace/slides/*.md; do \
		if [ -f "$$file" ]; then \
			base=$$(basename $$file .md); \
			echo "  Converting $$file → workspace/output/html/$$base.html"; \
			marp --html --allow-local-files "$$file" -o "workspace/output/html/$$base.html"; \
		fi \
	done

# 単一ファイルビルド
build-one: check-marp
	@if [ -z "$(FILE)" ]; then \
		echo "❌ Error: FILE parameter required"; \
		echo "Usage: make build-one FILE=workspace/slides/example.md"; \
		exit 1; \
	fi
	@echo "Building $(FILE)..."
	@mkdir -p workspace/output/pdf workspace/output/pptx workspace/output/html
	@base=$$(basename $(FILE) .md); \
	marp --pdf --allow-local-files "$(FILE)" -o "workspace/output/pdf/$$base.pdf"; \
	marp --pptx --allow-local-files "$(FILE)" -o "workspace/output/pptx/$$base.pptx"; \
	marp --html --allow-local-files "$(FILE)" -o "workspace/output/html/$$base.html"; \
	echo "✅ Built: workspace/output/{pdf,pptx,html}/$$base.*"

# 単一ファイル・単一形式ビルド
pdf-one: check-marp
	@if [ -z "$(FILE)" ]; then \
		echo "❌ Error: FILE parameter required"; \
		echo "Usage: make pdf-one FILE=workspace/slides/example.md"; \
		exit 1; \
	fi
	@echo "Building PDF: $(FILE)..."
	@mkdir -p workspace/output/pdf
	@base=$$(basename $(FILE) .md); \
	marp --pdf --allow-local-files "$(FILE)" -o "workspace/output/pdf/$$base.pdf"; \
	echo "✅ Built: workspace/output/pdf/$$base.pdf"

pptx-one: check-marp
	@if [ -z "$(FILE)" ]; then \
		echo "❌ Error: FILE parameter required"; \
		echo "Usage: make pptx-one FILE=workspace/slides/example.md"; \
		exit 1; \
	fi
	@echo "Building PPTX: $(FILE)..."
	@mkdir -p workspace/output/pptx
	@base=$$(basename $(FILE) .md); \
	marp --pptx --allow-local-files "$(FILE)" -o "workspace/output/pptx/$$base.pptx"; \
	echo "✅ Built: workspace/output/pptx/$$base.pptx"

html-one: check-marp
	@if [ -z "$(FILE)" ]; then \
		echo "❌ Error: FILE parameter required"; \
		echo "Usage: make html-one FILE=workspace/slides/example.md"; \
		exit 1; \
	fi
	@echo "Building HTML: $(FILE)..."
	@mkdir -p workspace/output/html
	@base=$$(basename $(FILE) .md); \
	marp --html --allow-local-files "$(FILE)" -o "workspace/output/html/$$base.html"; \
	echo "✅ Built: workspace/output/html/$$base.html"

# クリーンアップ
clean:
	@echo "Cleaning generated files..."
	rm -rf workspace/output/pdf/* workspace/output/pptx/* workspace/output/html/*
	@echo "✅ Cleaned workspace/output/ directories"
