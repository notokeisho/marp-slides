#!/usr/bin/env node

const inquirer = require("inquirer").default;
const fs = require("fs");
const path = require("path");

async function createNewSlide() {
  console.log("Creating new Marp slide...\n");

  try {
    // ファイル名入力
    const { filename } = await inquirer.prompt([
      {
        type: "input",
        name: "filename",
        message: "Enter filename (without .md):",
        validate: (input) => {
          if (!input || input.trim() === "") {
            return "Filename cannot be empty";
          }
          const slidePath = path.join(process.cwd(), "slides", `${input}.md`);
          if (fs.existsSync(slidePath)) {
            return `slides/${input}.md already exists`;
          }
          return true;
        },
      },
    ]);

    // テーマディレクトリを取得
    const themesDir = path.join(process.cwd(), "themes");
    const themes = fs.readdirSync(themesDir).filter((file) => {
      const stat = fs.statSync(path.join(themesDir, file));
      return stat.isDirectory();
    });

    // defaultテーマを追加して、先頭に配置
    const allThemes = ["default", ...themes.filter((t) => t !== "default")];

    if (allThemes.length === 0) {
      console.error("Error: No themes found");
      process.exit(1);
    }

    // テーマ選択
    const { theme } = await inquirer.prompt([
      {
        type: "list",
        name: "theme",
        message: "Select theme:",
        choices: allThemes,
      },
    ]);

    // テンプレートをコピー
    const templatePath = path.join(
      process.cwd(),
      "templates",
      theme,
      "template.md"
    );
    const slidePath = path.join(process.cwd(), "slides", `${filename}.md`);

    if (!fs.existsSync(templatePath)) {
      console.error(`Error: Template not found at ${templatePath}`);
      process.exit(1);
    }

    fs.copyFileSync(templatePath, slidePath);

    console.log("\nCreated: slides/" + filename + ".md");
    console.log("   Theme: " + theme);
  } catch (error) {
    if (error.isTtyError) {
      console.error("Error: Prompt could not be rendered in this environment");
    } else {
      console.error("Error:", error.message);
    }
    process.exit(1);
  }
}

createNewSlide();
