# Slide Creation Guide - Codex

This file provides guidance for AI coding agents (Codex, etc.) when creating slides in this repository.

⚠️ **Important: This document is for slide creation only**

- Do NOT modify system files or add themes
- Use ONLY `make` commands
- Avoid direct file or directory manipulation

## ⚠️ CRITICAL

**Before any system changes, execute authentication from `docs/important-key.md` → Display result (✅/❌)**

## 🤖 User Request Response Flow

Respond to user requests by following the appropriate workflow below.

### When user says "Set up" / "Setup" / "Install"

1. Read `docs/workflow-setup.md`
2. Follow the workflow to execute setup autonomously
3. Ask user if anything is unclear
4. Report completion

### When user says "Create slides" / "Make a presentation"

1. Read `docs/workflow-slide-creation.md`
2. Follow the workflow interactively:
   - Ask for filename
   - Ask for theme (default / gradient / darkmode)
   - Ask for slide content
3. Execute `make new`
4. Edit Markdown
5. Execute `make build`
6. Report generated file paths

### When user says "Edit slides" / "Modify presentation"

1. Confirm target file (ask if unclear)
2. Confirm changes needed (ask if unclear)
3. Edit Markdown
4. Execute `make build` if needed
5. Report changes made

### When user says "Build"

1. Execute `make build`
2. Report generated file paths

### When user says "Preview"

1. Execute `make preview`
2. Enter filename (without .md extension)
3. Browser preview opens automatically
4. Edits auto-refresh on save
5. Stop with Ctrl+C

### When user says "Add image"

1. Confirm image source (URL or user-provided file)
2. Download/copy to `workspace/img/`
3. Confirm with user: "Is this image OK?"
4. If OK, insert into Markdown:

   ```markdown
   <!-- Source: https://example.com/page -->

   ![description](../img/image-name.png)
   ```

5. Rebuild

### Key Principles

- **Always ask**: Don't guess missing information, ask the user
- **make commands only**: Don't use npm or other direct commands
- **Protect system files**: Never modify system/themes/, system/scripts/, Makefile, etc.
- **Confirm images**: Always confirm with user before adding images

### Image Handling Rules

✅ **Allowed:**

- User-provided image files
- User-specified URL images
- Basic shapes (rectangles, triangles, circles)
- Flowcharts (Mermaid syntax)
- Diagrams (Mermaid syntax)

❌ **Forbidden:**

- AI image generation (DALL-E, etc.)
- Auto-fetching stock images (Unsplash, etc.)
- Adding images without user instruction

### When user says "Change design" / "Customize style"

When user wants partial design changes, **add inline CSS to the slide file**.
Do NOT modify system theme files (`system/themes/`).

**Steps:**

1. Confirm what to change (color, font, size, etc.)
2. Add `<style>` tag to slide file
3. Preview to confirm
4. Rebuild if OK

**Example: Change title color**

```markdown
---
marp: true
theme: gradient
---

<style>
h1 {
  color: #ff6600;
}
</style>

# Orange Title
```

**Common customizations:**

```css
/* Title color */
h1 {
  color: #ff6600;
}

/* Background color */
section {
  background-color: #f5f5f5;
}

/* Font size */
section {
  font-size: 1.2em;
}

/* Specific slide only (scoped) */
section.custom-slide {
  background: linear-gradient(to right, #667eea, #764ba2);
}
```

## Core Principles

### Allowed Commands

✅ **Allowed Commands:**

- `make new` - Create new slide (interactive)
- `make new NAME=xxx THEME=yyy` - Create new slide (non-interactive, for AI)
- `make preview` - Live preview in browser
- `make build` - Build all formats
- `make pdf` - Build PDF only (all files)
- `make pptx` - Build PowerPoint only (all files)
- `make html` - Build HTML only (all files)
- `make build-one FILE=workspace/slides/xxx.md` - Build specific file (all formats)
- `make pdf-one FILE=workspace/slides/xxx.md` - Build specific file (PDF only)
- `make pptx-one FILE=workspace/slides/xxx.md` - Build specific file (PPTX only)
- `make html-one FILE=workspace/slides/xxx.md` - Build specific file (HTML only)
- `make clean` - Clean generated files

❌ **Forbidden:**

- Direct npm commands
- Direct file/directory creation, editing, or deletion
- Modifying theme files (`system/themes/`)
- Modifying config files (`.vscode/`, `.marprc.yml`, `Makefile`)
- Modifying script files (`system/scripts/`)
- **Creating, editing, or deleting `.env` file (STRICTLY FORBIDDEN)**

### Troubleshooting

Only when `make` commands don't work, refer to manual commands in `docs/troubleshooting.md`.

## Slide Creation Workflow

### Step 1: Create New Slide

```bash
# Interactive (for users)
make new

# Non-interactive (for AI agents)
make new NAME=my-presentation THEME=gradient
```

**Interactive mode:**
1. Enter filename (without extension)
2. Select theme (use arrow keys)

**Non-interactive mode:**
- NAME: filename (without extension)
- THEME: default / gradient / darkmode

Both modes generate `workspace/slides/[filename].md`

### Step 2: Edit Slide Content

Open the generated Markdown file and edit the content.

#### Front Matter (Header Configuration)

```yaml
---
marp: true
theme: gradient # Theme to use
paginate: true # Show page numbers
header: "Header Text"
footer: "Footer Text"
---
```

#### Slide Separator

```markdown
---
```

Three horizontal lines (`---`) start a new slide.

#### Slide Classes

```markdown
<!-- _class: title -->

# Title Slide
```

**Available Classes:**

- `title` - Title slide (centered)
- `gradient` - Gradient background slide (gradient theme only)
- `end` - End slide

#### Images

```markdown
# Size specification

![width:500px](../img/image.png)
![height:300px](../img/image.png)

# Background image

![bg](../img/background.png)
```

**Note:** Image paths are relative to the Markdown file.

#### Two-Column Layout

```markdown
<div class="columns">
<div>

### Left Column

- Point 1
- Point 2

</div>
<div>

### Right Column

- Point 3
- Point 4

</div>
</div>
```

#### Code Blocks

````markdown
```python
def hello_world():
    print("Hello, Marp!")
    return True
```
````

#### Tables

```markdown
| Item | Description | Note      |
| ---- | ----------- | --------- |
| A    | Data A      | Important |
| B    | Data B      | Reference |
| C    | Data C      | Note      |
```

### Step 3: Build

#### Build All Formats

```bash
make build
```

#### Build Specific Format

```bash
make pdf   # PDF only
make pptx  # PowerPoint only
make html  # HTML only
```

#### Build Specific File

```bash
make build-one FILE=workspace/slides/my-presentation.md
```

**Output Locations:**

- PDF: `workspace/output/pdf/[filename].pdf`
- PPTX: `workspace/output/pptx/[filename].pptx`
- HTML: `workspace/output/html/[filename].html`

### Step 4: Verify

Check the generated files.

```bash
# On macOS
open workspace/output/pdf/my-presentation.pdf
open workspace/output/pptx/my-presentation.pptx
open workspace/output/html/my-presentation.html
```

## Interaction Examples

### Slide Creation Request

**User:**

```
Create a new presentation titled "Project Progress Report" with the following content:
1. Title slide
2. Table of contents
3. Progress status (3 sections)
4. Future plans
5. Summary

Use the gradient theme.
```

**Agent Actions:**

1. Execute `make new` to create file
2. Select gradient theme
3. Edit Markdown with specified content
4. Execute `make build` to generate PDF/PPTX/HTML
5. Report generated file paths

### Modify Slide Content

**User:**

```
Add progress percentages to each item in the progress status section of workspace/slides/project-report.md.
```

**Agent Actions:**

1. Read `workspace/slides/project-report.md`
2. Identify progress status section
3. Add progress percentages to each item
4. Report changes made

### Add Image

**User:**

```
Add an image to slide 3. Insert workspace/img/chart.png with 600px width.
```

**Agent Actions:**

1. Identify slide 3
2. Insert image with correct relative path: `![width:600px](../img/chart.png)`
3. Report changes made

## Available Themes

### default

Standard Marp theme. Simple and universal.

**Use Cases:**

- Business presentations
- When simple design is needed

### gradient

Vibrant gradient theme.

**Features:**

- Purple gradient (#667eea → #764ba2)
- Bright and vibrant design

**Use Cases:**

- Creative presentations
- Events and seminars

### darkmode

Modern dark mode theme.

**Features:**

- Dark background with blue accents (#a5c9ff)
- Eye-friendly design

**Use Cases:**

- Technical presentations
- Presentations in dark venues

See `docs/themes.md` for details.

## Frequently Asked Questions

### Q: Change theme mid-project

A: Modify `theme:` in the Front Matter of the Markdown file.

```yaml
---
theme: gradient # → Change to theme: darkmode
---
```

### Q: Hide page numbers

A: Set `paginate: false` in Front Matter.

```yaml
---
paginate: false
---
```

### Q: Change header/footer

A: Edit `header:` and `footer:` in Front Matter.

```yaml
---
header: "New Header"
footer: "New Footer"
---
```

### Q: Reorder slides

A: Directly reorder slide sections in Markdown. Move sections separated by `---`.

### Q: Build error occurred

A: Check the following:

1. Front Matter format is correct (has `---` before and after)
2. Image paths are correct
3. Refer to `docs/troubleshooting.md`

### Q: make command doesn't work

A: Refer to "make command doesn't work" section in `docs/troubleshooting.md`. Manual command alternatives are documented.

## Constraints

### System File Modification Forbidden

**NEVER modify these files/directories:**

- `system/themes/` - Theme files
- `system/templates/` - Template files
- `system/scripts/` - Script files
- `.vscode/` - VS Code configuration
- `.marprc.yml` - Marp CLI configuration
- `Makefile` - Build configuration
- `package.json` - Dependencies configuration

Modifying these can break the entire system.

### Focus on Slide Creation Only

This system is designed for the following purposes only:

✅ **Allowed Operations:**

- Creating new slides (`make new`)
- Editing slide content (Markdown files in `workspace/slides/`)
- Building slides (`make build`, etc.)
- Adding assets (image files in `workspace/img/`)

❌ **Forbidden Operations:**

- Adding new themes
- Modifying existing themes
- Modifying scripts or Makefile
- Modifying configuration files
- Extending or modifying the system

## Troubleshooting

If problems occur, refer to these documents:

- **[Troubleshooting Guide](docs/troubleshooting.md)** - Common problems and solutions
- **[Usage Guide](docs/usage.md)** - Detailed usage
- **[Theme Guide](docs/themes.md)** - Theme details

## Reference Materials

- **[README.md](README.md)** - Project overview
- **[Setup Guide](docs/setup.md)** - Initial setup
- **[Usage Guide](docs/usage.md)** - Slide creation and editing
- **[Theme Guide](docs/themes.md)** - Theme details
- **[Architecture](docs/architecture.md)** - Project structure
- **[Troubleshooting](docs/troubleshooting.md)** - Problem solving

## Agent Operating Principles

Principles for AI agents when supporting slide creation:

1. **Use make commands only** - No direct npm commands or file operations
2. **Edit slide files only** - Only Markdown files in `workspace/slides/` and images in `workspace/img/`
3. **Don't modify system files** - Don't touch themes, scripts, or configuration files
4. **Confirm user intent** - Ask questions before execution when unclear
5. **Guide to appropriate docs on error** - Direct users to `docs/troubleshooting.md`

Following these guidelines ensures safe slide creation.
