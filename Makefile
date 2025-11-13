# Marp Slides Management Makefile

.PHONY: help build pdf pptx html clean install check-marp new

# デフォルトターゲット
help:
	@echo "Marp Slides Build Commands:"
	@echo "  make install  - Install Marp CLI globally"
	@echo "  make new      - Create new slide (interactive)"
	@echo "  make build    - Build all formats (PDF, PPTX, HTML)"
	@echo "  make pdf      - Convert all .md to PDF"
	@echo "  make pptx     - Convert all .md to PowerPoint"
	@echo "  make html     - Convert all .md to HTML"
	@echo "  make clean    - Remove all generated files in dist/"
	@echo ""
	@echo "Single file build:"
	@echo "  make build-one FILE=slides/example.md"

# Marp CLI インストール
install:
	@echo "Installing Marp CLI..."
	npm install -g @marp-team/marp-cli

# Marp CLI チェック
check-marp:
	@command -v marp >/dev/null 2>&1 || { \
		echo "❌ ERROR: marp not found"; \
		echo "Run: make install"; \
		exit 1; \
	}

# 新規スライド作成
new:
	@echo "📝 Creating new Marp slide..."
	@read -p "Enter filename (without .md): " filename; \
	if [ -z "$$filename" ]; then \
		echo "❌ Error: Filename cannot be empty"; \
		exit 1; \
	fi; \
	if [ -f "slides/$$filename.md" ]; then \
		echo "❌ Error: slides/$$filename.md already exists"; \
		exit 1; \
	fi; \
	themes=$$(ls -1 themes/ | grep -v '.gitkeep'); \
	echo ""; \
	echo "Select theme:"; \
	select theme in $$themes; do \
		if [ -n "$$theme" ]; then \
			cp "templates/$$theme/template.md" "slides/$$filename.md"; \
			echo ""; \
			echo "✅ Created: slides/$$filename.md"; \
			echo "   Theme: $$theme"; \
			break; \
		else \
			echo "❌ Invalid selection"; \
		fi; \
	done

# 全形式ビルド
build: pdf pptx html
	@echo "✅ All formats built successfully"

# PDF生成
pdf: check-marp
	@echo "Building PDF files..."
	@mkdir -p dist/pdf
	@for file in slides/*.md; do \
		if [ -f "$$file" ]; then \
			base=$$(basename $$file .md); \
			echo "  Converting $$file → dist/pdf/$$base.pdf"; \
			marp --pdf --allow-local-files "$$file" -o "dist/pdf/$$base.pdf"; \
		fi \
	done

# PowerPoint生成
pptx: check-marp
	@echo "Building PowerPoint files..."
	@mkdir -p dist/pptx
	@for file in slides/*.md; do \
		if [ -f "$$file" ]; then \
			base=$$(basename $$file .md); \
			echo "  Converting $$file → dist/pptx/$$base.pptx"; \
			marp --pptx --allow-local-files "$$file" -o "dist/pptx/$$base.pptx"; \
		fi \
	done

# HTML生成
html: check-marp
	@echo "Building HTML files..."
	@mkdir -p dist/html
	@for file in slides/*.md; do \
		if [ -f "$$file" ]; then \
			base=$$(basename $$file .md); \
			echo "  Converting $$file → dist/html/$$base.html"; \
			marp --html --allow-local-files "$$file" -o "dist/html/$$base.html"; \
		fi \
	done

# 単一ファイルビルド
build-one: check-marp
	@if [ -z "$(FILE)" ]; then \
		echo "❌ Error: FILE parameter required"; \
		echo "Usage: make build-one FILE=slides/example.md"; \
		exit 1; \
	fi
	@echo "Building $(FILE)..."
	@mkdir -p dist/pdf dist/pptx dist/html
	@base=$$(basename $(FILE) .md); \
	marp --pdf --allow-local-files "$(FILE)" -o "dist/pdf/$$base.pdf"; \
	marp --pptx --allow-local-files "$(FILE)" -o "dist/pptx/$$base.pptx"; \
	marp --html --allow-local-files "$(FILE)" -o "dist/html/$$base.html"; \
	echo "✅ Built: dist/{pdf,pptx,html}/$$base.*"

# クリーンアップ
clean:
	@echo "Cleaning generated files..."
	rm -rf dist/pdf/* dist/pptx/* dist/html/*
	@echo "✅ Cleaned dist/ directories"
