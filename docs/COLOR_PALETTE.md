# Cyberdeck 2025 - Color Palette Reference

**Purpose:** Human-readable reference for all colors used in the theme. This is documentation only - not used in the build process.

---

## Core Palette

### Background Colors

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| Deep Purple Black | `#130d1a` | rgb(19, 13, 26) | Primary background (editor, activity bar, panels) |
| Darker Purple | `#100c0f` | rgb(16, 12, 15) | Secondary background (sidebar, terminal) |
| Dark Slate | `#0d181a` | rgb(13, 24, 26) | Tertiary background (peek view, selections) |
| Medium Purple | `#34294f` | rgb(52, 41, 79) | Highlights, selections, find matches |
| Dark Purple Border | `#2a2139` | rgb(42, 33, 57) | Primary borders throughout UI |

### Foreground Colors

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| Warm Off-White | `#ded2cd` | rgb(222, 210, 205) | Primary text (editor content) |
| Light Purple | `#d4cdde` | rgb(212, 205, 222) | Secondary text (inputs, notifications) |
| Muted Blue | `#495495` | rgb(73, 84, 149) | Tertiary text (line numbers, descriptions) |
| Light Lavender | `#f6c4ff` | rgb(246, 196, 255) | Special text (TypeScript, parameters) |

### Accent Colors (Primary Brand)

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| Vibrant Purple | `#b141f1` | rgb(177, 65, 241) | Primary accent (errors, badges, focus) |
| Hot Pink | `#ff2289` | rgb(255, 34, 137) | Secondary accent (keywords, active elements) |
| Bright Pink | `#f92aad` | rgb(249, 42, 173) | Tertiary accent (status bar, tabs, panels) |

### Functional Colors

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| Cyan | `#58c7e0` | rgb(88, 199, 224) | Variables, identifiers, cursor |
| Light Cyan | `#00d0ff` | rgb(0, 208, 255) | Classes, support types |
| Bright Green | `#54e484` | rgb(84, 228, 132) | Success, additions, modified tabs |
| Neon Green | `#00ff88` | rgb(0, 255, 136) | Functions, methods, badges |
| Yellow | `#ffcc00` | rgb(255, 204, 0) | Warnings, modifications |
| Golden Yellow | `#f9c80e` | rgb(249, 200, 14) | Strings, literals |
| Orange | `#ff6c11` | rgb(255, 108, 17) | Storage types, special keywords |
| Lime Green | `#d6fc00` | rgb(214, 252, 0) | Types, primitives, debugging |

### Syntax-Specific Colors

| Token Type | Hex | RGB | Font Style |
|------------|-----|-----|------------|
| Comments | `#6071cc` | rgb(96, 113, 204) | italic |
| Keywords | `#ff019a` | rgb(255, 1, 154) | bold |
| Strings | `#f9c80e` | rgb(249, 200, 14) | normal |
| Numbers | `#b141f1` | rgb(177, 65, 241) | normal |
| Functions | `#00ff88` | rgb(0, 255, 136) | normal |
| Types | `#d6fc00` | rgb(214, 252, 0) | normal |
| Variables | `#58c7e0` | rgb(88, 199, 224) | normal |
| Properties | `#ecd99b` | rgb(236, 217, 155) | normal |
| Constants | `#ff2289` | rgb(255, 34, 137) | normal |
| Classes | `#58c7e0` | rgb(88, 199, 224) | bold |

---

## Color Families

### Purple Family (Background & Accents)
```
#130d1a  ████  Deep Purple Black (darkest)
#100c0f  ████  Darker Purple
#2a2139  ████  Dark Purple Border
#34294f  ████  Medium Purple
#4c2a72  ████  Purple Accent
#794796  ████  Muted Purple
#a313f7  ████  Bright Purple
#b141f1  ████  Vibrant Purple (primary accent)
#b893ce  ████  Light Purple
#d4cdde  ████  Pale Purple
#f6c4ff  ████  Light Lavender (lightest)
```

### Pink/Magenta Family (Keywords & Accents)
```
#ff019a  ████  Hot Pink (keywords)
#ff2289  ████  Hot Pink (constants)
#f92aad  ████  Bright Pink (UI accents)
```

### Cyan/Blue Family (Variables & Identifiers)
```
#017b8b  ████  Dark Cyan
#58c7e0  ████  Cyan (variables)
#61e2ff  ████  Light Cyan
#00d0ff  ████  Bright Cyan (classes)
#6071cc  ████  Blue-Purple (comments)
```

### Green Family (Functions & Success)
```
#206d4b  ████  Dark Green
#54e484  ████  Bright Green (success)
#00ff88  ████  Neon Green (functions)
#d6fc00  ████  Lime Green (types)
```

### Yellow/Orange Family (Strings & Warnings)
```
#ff6c11  ████  Orange (storage types)
#f9c80e  ████  Golden Yellow (strings)
#ffcc00  ████  Yellow (warnings)
```

### Red Family (Errors & Deletions)
```
#9c0041  ████  Dark Red
#b16a4e  ████  Muted Red
#fa2e46  ████  Bright Red (deletions)
```

---

## Transparency Levels

The theme uses consistent alpha values for layering:

| Alpha | Hex | Opacity | Usage |
|-------|-----|---------|-------|
| 16 | `10` | 6% | Very subtle hints |
| 33 | `21` | 13% | Subtle backgrounds |
| 51 | `33` | 20% | Light highlights |
| 68 | `44` | 27% | Medium backgrounds |
| 102 | `66` | 40% | Selections |
| 136 | `88` | 53% | Strong highlights |
| 204 | `cc` | 80% | Semi-opaque |
| 238 | `ee` | 93% | Nearly opaque |

**Examples:**
- `#b141f133` - Vibrant purple at 20% (subtle glow)
- `#34294f66` - Medium purple at 40% (line highlight)
- `#34294f88` - Medium purple at 53% (word highlight)
- `#b141f1cc` - Vibrant purple at 80% (git decoration)

---

## Usage Guidelines

### When to Use Each Color

**Purple (`#b141f1`):**
- Primary accent throughout UI
- Error indicators
- Numbers in code
- Focus borders
- Active badges

**Hot Pink (`#ff2289`, `#ff019a`):**
- Keywords (if, else, return, etc.)
- Constants
- Active UI elements
- Status bar items

**Cyan (`#58c7e0`):**
- Variables
- Identifiers
- Parameters
- Cursor
- Links

**Neon Green (`#00ff88`):**
- Functions
- Methods
- Success indicators
- Badge text

**Lime Green (`#d6fc00`):**
- Types
- Classes
- Primitives
- Debugging status

**Golden Yellow (`#f9c80e`):**
- Strings
- String literals
- Template strings

**Yellow (`#ffcc00`):**
- Warnings
- Modified files
- Caution indicators

**Orange (`#ff6c11`):**
- Storage types (var, let, const)
- Special keywords
- Language keywords

**Blue-Purple (`#6071cc`):**
- Comments only
- Always italic

---

## Customization Guide

### For Users Who Want to Tweak Colors

Add to your `settings.json`:

```json
{
  "workbench.colorCustomizations": {
    "[Cyberdeck 2025]": {
      // Example: Make background darker
      "editor.background": "#0a0610",
      
      // Example: Make keywords more orange
      "editor.tokenColorCustomizations": {
        "keywords": "#ff6c11"
      }
    }
  }
}
```

### Common Customizations

**Darker Background:**
```json
"editor.background": "#0a0610"
```

**Higher Contrast:**
```json
"editor.foreground": "#ffffff"
```

**Less Neon:**
```json
"activityBarBadge.background": "#8841d1",
"activityBarBadge.foreground": "#00cc66"
```

---

## Tools & Resources

### Color Picker Tools
- [Coolors.co](https://coolors.co/) - Palette generator
- [Adobe Color](https://color.adobe.com/) - Color wheel
- [Contrast Checker](https://webaim.org/resources/contrastchecker/) - WCAG compliance

### VS Code Tools
- **Developer: Inspect Editor Tokens and Scopes** - See what colors apply
- **Developer: Generate Color Theme from Current Settings** - Export customizations

### Testing
- [Coblis](https://www.color-blindness.com/coblis-color-blindness-simulator/) - Colorblind simulator
- [Contrast Ratio](https://contrast-ratio.com/) - Quick contrast checks

---

## License

This color palette is part of the Cyberdeck 2025 theme.
See LICENSE file for details.

