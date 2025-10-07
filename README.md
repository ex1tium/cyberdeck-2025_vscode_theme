# Cyberdeck 2025 🌃

> *A neo-retro-futuristic neural interface for the modern code cowboy.*

[![Version](https://img.shields.io/visual-studio-marketplace/v/ex1tium.cyberdeck-2025?style=flat-square&color=b141f1)](https://marketplace.visualstudio.com/items?itemName=ex1tium.cyberdeck-2025)
[![Installs](https://img.shields.io/visual-studio-marketplace/i/ex1tium.cyberdeck-2025?style=flat-square&color=00ff88)](https://marketplace.visualstudio.com/items?itemName=ex1tium.cyberdeck-2025)
[![Rating](https://img.shields.io/visual-studio-marketplace/r/ex1tium.cyberdeck-2025?style=flat-square&color=f9c80e)](https://marketplace.visualstudio.com/items?itemName=ex1tium.cyberdeck-2025)
[![License](https://img.shields.io/github/license/ex1tium/cyberdeck-2025_vscode_theme?style=flat-square&color=ff2289)](LICENSE)

**Cyberdeck 2025** is a cyberpunk-inspired dark theme for Visual Studio Code featuring deep purple backgrounds, vibrant neon accents, and comprehensive syntax highlighting. Designed for developers who want an immersive, high-contrast coding experience with modern semantic highlighting support.

---

## ✨ Features

### 🎨 Cyberpunk Aesthetic
- **Deep purple-black backgrounds** (`#130d1a`) for reduced eye strain
- **Vibrant neon accents** in hot pink, cyan, and neon green
- **High contrast** color scheme
- **Consistent visual language** across editor, UI, and terminal

### 🚀 Modern Highlighting System
- **Semantic Highlighting**: Context-aware intelligent coloring using language servers
- **TextMate Grammar**: Comprehensive fallback for many languages
- **Dual System Support**: Works perfectly with or without language servers

### 💎 First-Class Language Support

#### TypeScript/JavaScript
- Distinct colors for types, interfaces, enums, and type parameters
- Clear differentiation between variables, functions, and classes
- Styled decorators and JSX/TSX support

#### Rust
- Complete coverage for lifetimes, macros, and traits
- Ownership keywords highlighted distinctly
- Macro invocations and attributes styled

#### Go
- Goroutines and channels clearly marked
- Interface and struct highlighting
- Go-specific syntax support

#### Python
- Decorators and magic methods styled
- Type hints and annotations
- Python 3.x features supported

#### Java
- Annotations and generics
- Lambda expressions
- Modern Java syntax

#### Lua
- Complete coverage for all language features

### 🎯 Additional Features
- **25+ Languages Supported**: Zig, C/C++, C#, PHP, Ruby, HTML/CSS, JSON, Markdown, and more
- **Git Integration**: Clear visual indicators for changes
- **Terminal Colors**: Custom ANSI palette matching the theme
- **Bracket Pairs**: Styled bracket pair colorization
- **Inline Hints**: Themed parameter hints and type annotations
- **Modern UI**: Support for Command Center, Chat, Sticky Scroll, and more

---

## 📸 Screenshots

### Cyberdeck 2025 Theme Preview
![Cyberdeck 2025 Theme](screenshots/screenshot.png)

---

## 🚀 Installation

### From VS Code Marketplace

1. Open **Extensions** sidebar (`Ctrl+Shift+X` / `Cmd+Shift+X`)
2. Search for **"Cyberdeck 2025"**
3. Click **Install**
4. Click **Set Color Theme** or:
   - Open Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`)
   - Type **"Color Theme"**
   - Select **"Cyberdeck 2025"**

### From VSIX File

```bash
code --install-extension cyberdeck-2025-1.0.0.vsix
```

### Manual Installation

1. Download the latest release from [GitHub Releases](https://github.com/ex1tium/cyberdeck-2025_vscode_theme/releases)
2. Extract to your VS Code extensions folder:
   - **Windows**: `%USERPROFILE%\.vscode\extensions`
   - **macOS/Linux**: `~/.vscode/extensions`
3. Install extension from location in VS Code
4. Reload VS Code

---

## 🎨 Color Palette

### Core Colors

| Color | Hex | Usage |
|-------|-----|-------|
| Deep Purple Black | `#130d1a` | Editor background |
| Warm Off-White | `#ded2cd` | Primary text |
| Vibrant Purple | `#b141f1` | Errors, numbers, accents |
| Hot Pink | `#ff2289` | Keywords, constants |
| Cyan | `#58c7e0` | Variables, identifiers |
| Neon Green | `#00ff88` | Functions, methods |
| Lime Green | `#d6fc00` | Types, classes |
| Golden Yellow | `#f9c80e` | Strings, literals |
| Blue-Purple | `#6071cc` | Comments (italic) |

### Full Palette

See [docs/COLOR_PALETTE.md](docs/COLOR_PALETTE.md) for the complete color reference with RGB values, usage guidelines, and accessibility notes.

---

## 🔧 Recommended Settings

For the best experience with Cyberdeck 2025:

```json
{
  // Enable semantic highlighting
  "editor.semanticHighlighting.enabled": true,

  // Enable bracket pair colorization
  "editor.bracketPairColorization.enabled": true,
  "editor.guides.bracketPairs": "active",

  // Font recommendations
  "editor.fontFamily": "'Fira Code', 'JetBrains Mono', 'Cascadia Code', Consolas, monospace",
  "editor.fontLigatures": true,
  "editor.fontSize": 14,
  "editor.lineHeight": 1.6,

  // Cursor style
  "editor.cursorBlinking": "smooth",
  "editor.cursorSmoothCaretAnimation": "on",

  // Minimap
  "editor.minimap.enabled": true,
  "editor.minimap.renderCharacters": false,

  // Terminal
  "terminal.integrated.fontFamily": "'Fira Code', 'JetBrains Mono', monospace",
  "terminal.integrated.fontSize": 13
}
```

### Recommended Font

**Fira Code** or **JetBrains Mono** work beautifully with this theme:
- [Fira Code](https://github.com/tonsky/FiraCode)
- [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
- [Cascadia Code](https://github.com/microsoft/cascadia-code)

---

## � Customization

### Overriding Theme Colors

You can customize any color in the Cyberdeck 2025 theme by adding overrides to your VS Code settings. This allows you to tweak specific colors while keeping the overall theme intact.

#### How to Customize Colors

1. Open VS Code Settings (`Ctrl+,` / `Cmd+,`)
2. Click the "Open Settings (JSON)" icon in the top-right
3. Add a `workbench.colorCustomizations` section with theme-specific overrides:

```json
{
  "workbench.colorCustomizations": {
    "[Cyberdeck 2025]": {
      // Override any workbench colors here
      "editor.background": "#0f0a15",           // Darker background
      "statusBar.background": "#00ff88",        // Green status bar
      "activityBar.background": "#1a0f20",      // Slightly lighter activity bar
      "sideBar.background": "#150c1d"           // Custom sidebar color
    }
  },
  "editor.tokenColorCustomizations": {
    "[Cyberdeck 2025]": {
      // Override syntax highlighting colors
      "comments": "#8a9ba8",                    // Lighter comments
      "keywords": "#ff6b9d",                    // Softer pink keywords
      "strings": "#ffd23f",                     // Brighter yellow strings
      "functions": "#4ecdc4",                   // Teal functions
      "variables": "#a8e6cf"                    // Mint green variables
    }
  }
}
```

#### Common Customizations

**Adjust Background Darkness:**
```json
"workbench.colorCustomizations": {
  "[Cyberdeck 2025]": {
    "editor.background": "#0a0612",           // Even darker
    "sideBar.background": "#0f0a15",
    "activityBar.background": "#120a18"
  }
}
```

**Change Accent Colors:**
```json
"workbench.colorCustomizations": {
  "[Cyberdeck 2025]": {
    "statusBar.background": "#6c5ce7",        // Purple status bar
    "activityBar.activeBorder": "#fd79a8",    // Pink active border
    "button.background": "#00cec9"            // Cyan buttons
  }
}
```

**Modify Syntax Colors:**
```json
"editor.tokenColorCustomizations": {
  "[Cyberdeck 2025]": {
    "textMateRules": [
      {
        "scope": "keyword",
        "settings": {
          "foreground": "#e84393",             // Custom keyword color
          "fontStyle": "bold"
        }
      },
      {
        "scope": "string",
        "settings": {
          "foreground": "#fdcb6e"              // Custom string color
        }
      }
    ]
  }
}
```

#### Finding Color Names

To find the exact color names to override:

1. **Workbench Colors**: Check the [VS Code Theme Color Reference](https://code.visualstudio.com/api/references/theme-color)
2. **Syntax Colors**: Use the Command Palette (`Ctrl+Shift+P`) → "Developer: Inspect Editor Tokens and Scopes" to see token scopes
3. **Current Theme Colors**: Use Command Palette → "Developer: Generate Color Theme From Current Settings" to see all current colors

#### Reset Customizations

To remove your customizations and return to the original theme:

```json
{
  "workbench.colorCustomizations": {
    "[Cyberdeck 2025]": {}
  },
  "editor.tokenColorCustomizations": {
    "[Cyberdeck 2025]": {}
  }
}
```

---

## �🎯 Language Support

### Fully Tested & Optimized
- ✅ TypeScript / JavaScript / JSX / TSX
- ✅ Rust
- ✅ Go
- ✅ Python
- ✅ Java
- ✅ Lua
- ✅ C / C++
- ✅ C#
- ✅ HTML / CSS / SCSS / LESS
- ✅ JSON / JSONC / YAML / TOML
- ✅ Markdown
- ✅ Shell / Bash / Zsh

### Additional Support
PHP, Ruby, Swift, Kotlin, Dart, Elixir, Haskell, SQL, GraphQL, and many more!

---

## 📝 License

This theme is licensed under the [MIT License](LICENSE).

---


## 🔗 Links

- [GitHub Repository](https://github.com/ex1tium/cyberdeck-2025_vscode_theme)
- [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=ex1tium.cyberdeck-2025)
- [Issue Tracker](https://github.com/ex1tium/cyberdeck-2025_vscode_theme/issues)
- [Changelog](CHANGELOG.md)

---

<div align="center">

**[Install Now](https://marketplace.visualstudio.com/items?itemName=ex1tium.cyberdeck-2025)** | **[View Source](https://github.com/ex1tium/cyberdeck-2025_vscode_theme)** | **[Report Issue](https://github.com/ex1tium/cyberdeck-2025_vscode_theme/issues)**

*Made with 💜 for code cowboys everywhere.*

</div>
