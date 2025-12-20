#!/usr/bin/env node

const inquirer = require("inquirer").default;
const fs = require("fs");
const path = require("path");

// コマンドライン引数をパース
function parseArgs() {
  const args = {};
  process.argv.slice(2).forEach(arg => {
    const match = arg.match(/^--(\w+)=(.+)$/);
    if (match) {
      args[match[1]] = match[2];
    }
  });
  return args;
}

// テーマ一覧を取得
function getAvailableThemes() {
  const themesDir = path.join(process.cwd(), "system/themes");
  const themes = fs.readdirSync(themesDir).filter((file) => {
    const stat = fs.statSync(path.join(themesDir, file));
    return stat.isDirectory();
  });
  return ["default", ...themes.filter((t) => t !== "default")];
}

// バリデーション
function validateFilename(input) {
  if (!input || input.trim() === "") {
    return "Filename cannot be empty";
  }
  const slidePath = path.join(process.cwd(), "workspace/slides", `${input}.md`);
  if (fs.existsSync(slidePath)) {
    return `workspace/slides/${input}.md already exists`;
  }
  return true;
}

function validateTheme(input, availableThemes) {
  if (!availableThemes.includes(input)) {
    return `Invalid theme. Available: ${availableThemes.join(", ")}`;
  }
  return true;
}

// スライド作成
function createSlide(filename, theme) {
  const templatePath = path.join(process.cwd(), "system/templates", theme, "template.md");
  const slidePath = path.join(process.cwd(), "workspace/slides", `${filename}.md`);

  if (!fs.existsSync(templatePath)) {
    console.error(`Error: Template not found at ${templatePath}`);
    process.exit(1);
  }

  fs.copyFileSync(templatePath, slidePath);
  console.log("\nCreated: workspace/slides/" + filename + ".md");
  console.log("   Theme: " + theme);
}

async function main() {
  console.log("Creating new Marp slide...\n");

  const args = parseArgs();
  const availableThemes = getAvailableThemes();

  // 引数が両方指定されている場合 → 非対話型
  if (args.name && args.theme) {
    const filenameValid = validateFilename(args.name);
    if (filenameValid !== true) {
      console.error("Error:", filenameValid);
      process.exit(1);
    }

    const themeValid = validateTheme(args.theme, availableThemes);
    if (themeValid !== true) {
      console.error("Error:", themeValid);
      process.exit(1);
    }

    createSlide(args.name, args.theme);
    return;
  }

  // 引数がない/不足 → 対話型
  try {
    const { filename } = await inquirer.prompt([
      {
        type: "input",
        name: "filename",
        message: "Enter filename (without .md):",
        default: args.name || undefined,
        validate: validateFilename,
      },
    ]);

    const { theme } = await inquirer.prompt([
      {
        type: "list",
        name: "theme",
        message: "Select theme:",
        choices: availableThemes,
        default: args.theme || undefined,
      },
    ]);

    createSlide(filename, theme);
  } catch (error) {
    if (error.isTtyError) {
      console.error("Error: Prompt could not be rendered in this environment");
      console.error("Hint: Use 'make new NAME=xxx THEME=yyy' for non-interactive mode");
    } else {
      console.error("Error:", error.message);
    }
    process.exit(1);
  }
}

main();
