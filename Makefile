# Marp Slides Management Makefile

.PHONY: help build pdf pptx html clean install

# デフォルトターゲット
help:
	@echo "Marp Slides Build Commands:"
	@echo "  make install  - Install Marp CLI globally"
	@echo "  make build    - Build all formats (PDF, PPTX, HTML)"
	@echo "  make pdf      - Convert all .md to PDF"
	@echo "  make pptx     - Convert all .md to PowerPoint"
	@echo "  make html     - Convert all .md to HTML"
	@echo "  make clean    - Remove all generated files in dist/"
	@echo ""
	@echo "Single file build:"
	@echo "  make build-one FILE=slides/user/example.md"

# Marp CLI インストール
install:
	@echo "Installing Marp CLI..."
	npm install -g @marp-team/marp-cli

# 全形式ビルド
build: pdf pptx html
	@echo "✅ All formats built successfully"

# PDF生成
pdf:
	@echo "Building PDF files..."
	@mkdir -p dist/pdf
	@for file in slides/*/*.md; do \
		if [ -f "$$file" ]; then \
			user=$$(basename $$(dirname $$file)); \
			base=$$(basename $$file .md); \
			echo "  Converting $$file → dist/pdf/$$user-$$base.pdf"; \
			marp --pdf --allow-local-files "$$file" -o "dist/pdf/$$user-$$base.pdf"; \
		fi \
	done

# PowerPoint生成
pptx:
	@echo "Building PowerPoint files..."
	@mkdir -p dist/pptx
	@for file in slides/*/*.md; do \
		if [ -f "$$file" ]; then \
			user=$$(basename $$(dirname $$file)); \
			base=$$(basename $$file .md); \
			echo "  Converting $$file → dist/pptx/$$user-$$base.pptx"; \
			marp --pptx --allow-local-files "$$file" -o "dist/pptx/$$user-$$base.pptx"; \
		fi \
	done

# HTML生成
html:
	@echo "Building HTML files..."
	@mkdir -p dist/html
	@for file in slides/*/*.md; do \
		if [ -f "$$file" ]; then \
			user=$$(basename $$(dirname $$file)); \
			base=$$(basename $$file .md); \
			echo "  Converting $$file → dist/html/$$user-$$base.html"; \
			marp --html --allow-local-files "$$file" -o "dist/html/$$user-$$base.html"; \
		fi \
	done

# 単一ファイルビルド
build-one:
	@if [ -z "$(FILE)" ]; then \
		echo "❌ Error: FILE parameter required"; \
		echo "Usage: make build-one FILE=slides/user/example.md"; \
		exit 1; \
	fi
	@echo "Building $(FILE)..."
	@mkdir -p dist/pdf dist/pptx dist/html
	@user=$$(basename $$(dirname $(FILE))); \
	base=$$(basename $(FILE) .md); \
	marp --pdf --allow-local-files "$(FILE)" -o "dist/pdf/$$user-$$base.pdf"; \
	marp --pptx --allow-local-files "$(FILE)" -o "dist/pptx/$$user-$$base.pptx"; \
	marp --html --allow-local-files "$(FILE)" -o "dist/html/$$user-$$base.html"; \
	echo "✅ Built: dist/{pdf,pptx,html}/$$user-$$base.*"

# クリーンアップ
clean:
	@echo "Cleaning generated files..."
	rm -rf dist/pdf/* dist/pptx/* dist/html/*
	@echo "✅ Cleaned dist/ directories"
