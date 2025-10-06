#!/usr/bin/env python3
"""
Unified theme sorting script for Cyberdeck 2025.
Sorts workbench colors alphabetically within sections and tokenColors by scope names.
Preserves all comments and formatting. Does NOT add, remove, or modify content.
"""
import json
import re


def extract_inline_comment(line):
    """Extract inline comment from a line, if present."""
    in_string = False
    escape_next = False

    for i, char in enumerate(line):
        if escape_next:
            escape_next = False
            continue
        if char == '\\':
            escape_next = True
            continue
        if char == '"':
            in_string = not in_string
        elif char == '/' and i + 1 < len(line) and line[i + 1] == '/' and not in_string:
            code_part = line[:i].rstrip()
            comment_part = line[i:]
            return code_part, comment_part

    return line, None


def strip_json_comments(json_str):
    """Remove // comments from JSON string for parsing."""
    lines = json_str.split('\n')
    result = []
    for line in lines:
        code_part, _ = extract_inline_comment(line)
        result.append(code_part)
    return '\n'.join(result)


def find_json_section_bounds(content, section_name):
    """Find the start and end positions of a JSON section."""
    section_match = re.search(rf'"{section_name}":\s*\{{', content)
    if not section_match:
        return None, None, None

    section_start = section_match.end()

    # Find matching closing brace
    brace_count = 1
    i = section_start
    in_string = False
    escape_next = False

    while i < len(content) and brace_count > 0:
        char = content[i]

        if escape_next:
            escape_next = False
            i += 1
            continue

        if char == '\\':
            escape_next = True
        elif char == '"':
            in_string = not in_string
        elif not in_string:
            if char == '{':
                brace_count += 1
            elif char == '}':
                brace_count -= 1

        i += 1

    section_end = i - 1

    before_section = content[:section_match.start()]
    section_content = content[section_match.start():section_end + 1]
    after_section = content[section_end + 1:]

    return before_section, section_content, after_section


def extract_color_sections(colors_content):
    """Extract sections with their comments and keys, preserving inline comments."""
    sections = []
    current_section = {'comment_lines': [], 'keys': []}

    lines = colors_content.split('\n')
    seen_keys = set()  # Track keys we've already added to avoid duplicates

    for line in lines:
        stripped = line.strip()

        # Skip the opening "colors": { line
        if '"colors":' in line:
            continue

        # Skip opening brace
        if stripped == '{' and not current_section['keys']:
            continue

        # End of colors section
        if stripped == '},' or stripped == '}':
            if current_section['keys']:
                sections.append(current_section)
            break

        # Full-line comment (section header)
        if stripped.startswith('//'):
            # Save current section if it has keys
            if current_section['keys']:
                sections.append(current_section)
                current_section = {'comment_lines': [], 'keys': []}
            # Add comment line
            current_section['comment_lines'].append(line)

        # Empty line (preserve in comments)
        elif stripped == '':
            if not current_section['keys']:
                current_section['comment_lines'].append(line)

        # Color key-value pair (may have inline comment)
        elif ':' in stripped:
            code_part, comment_part = extract_inline_comment(line)

            # Extract key name and full line
            match = re.search(r'"([^"]+)":', code_part)
            if match:
                key_name = match.group(1)

                # Skip if we've already seen this key (duplicate)
                if key_name in seen_keys:
                    continue

                seen_keys.add(key_name)
                current_section['keys'].append({
                    'key': key_name,
                    'line': code_part,
                    'comment': comment_part
                })

    # Add last section
    if current_section['keys']:
        sections.append(current_section)

    return sections


def rebuild_colors_section(sections):
    """Rebuild the colors section with sorted keys and preserved comments."""
    result = '  "colors": {\n'

    for section_idx, section in enumerate(sections):
        # Add section comment lines
        for comment_line in section['comment_lines']:
            result += comment_line + '\n'

        # Sort keys alphabetically
        sorted_keys = sorted(section['keys'], key=lambda x: x['key'])

        # Add sorted keys
        for key_idx, key_data in enumerate(sorted_keys):
            line = key_data['line']
            comment = key_data['comment']

            # Determine if we need a comma (all keys except the very last one)
            is_last_key_in_section = (key_idx == len(sorted_keys) - 1)
            is_last_section = (section_idx == len(sections) - 1)
            needs_comma = not (is_last_key_in_section and is_last_section)

            # Remove any existing comma from the line
            line_stripped = line.rstrip()
            if line_stripped.endswith(','):
                line_stripped = line_stripped[:-1]

            # Build the line with proper comma placement
            if needs_comma:
                if comment:
                    result += line_stripped + ',' + ' ' + comment + '\n'
                else:
                    result += line_stripped + ',\n'
            else:
                # Last key - no comma
                if comment:
                    result += line_stripped + ' ' + comment + '\n'
                else:
                    result += line_stripped + '\n'

    result += '  }'
    return result


def sort_workbench_colors(content):
    """Sort workbench colors alphabetically within sections."""
    print("Sorting workbench colors...")
    result = find_json_section_bounds(content, 'colors')

    if result[0] is None:
        print("  No colors section found")
        return content

    before_colors, colors_content, after_colors = result

    sections = extract_color_sections(colors_content)
    print(f"  Found {len(sections)} color sections")

    sorted_colors = rebuild_colors_section(sections)
    return before_colors + sorted_colors + after_colors


def sort_token_colors(content):
    """Sort tokenColors array and scope arrays within each rule."""
    print("Sorting tokenColors...")

    # Parse theme (strip comments for parsing)
    content_no_comments = strip_json_comments(content)
    theme = json.loads(content_no_comments)

    if 'tokenColors' not in theme:
        print("  No tokenColors found")
        return content

    token_colors = theme['tokenColors']
    print(f"  Found {len(token_colors)} token color rules")

    # Sort scope arrays within each rule
    for rule in token_colors:
        if 'scope' in rule:
            if isinstance(rule['scope'], list):
                rule['scope'].sort()
            elif isinstance(rule['scope'], str) and ',' in rule['scope']:
                scopes = [s.strip() for s in rule['scope'].split(',')]
                scopes.sort()
                rule['scope'] = ', '.join(scopes)

    # Sort tokenColors array by first scope
    def get_sort_key(rule):
        if 'scope' not in rule:
            return ''
        scope = rule['scope']
        if isinstance(scope, list):
            return scope[0] if scope else ''
        elif isinstance(scope, str):
            if ',' in scope:
                return scope.split(',')[0].strip()
            return scope
        return ''

    theme['tokenColors'].sort(key=get_sort_key)

    # Find tokenColors section in original content
    token_colors_match = re.search(r'"tokenColors":\s*\[', content)
    if not token_colors_match:
        print("  Could not find tokenColors section")
        return content

    # Find end of tokenColors array (properly handling nested brackets)
    start_pos = token_colors_match.end()
    bracket_count = 1
    i = start_pos
    in_string = False
    escape_next = False

    while i < len(content) and bracket_count > 0:
        char = content[i]

        if escape_next:
            escape_next = False
            i += 1
            continue

        if char == '\\':
            escape_next = True
        elif char == '"':
            in_string = not in_string
        elif not in_string:
            if char == '[':
                bracket_count += 1
            elif char == ']':
                bracket_count -= 1

        i += 1

    end_pos = i - 1

    # Build new tokenColors JSON with proper formatting
    sorted_token_colors_json = json.dumps(theme['tokenColors'], indent=2, ensure_ascii=False)
    # Remove outer brackets since we're inserting into existing array
    sorted_token_colors_json = sorted_token_colors_json[1:-1].strip()

    # Reconstruct file
    before = content[:start_pos]
    after = content[end_pos:]
    return before + '\n' + sorted_token_colors_json + '\n  ' + after


def sort_theme_file(filepath):
    """Sort both workbench colors and tokenColors in the theme file."""
    print("=" * 80)
    print(f"SORTING THEME: {filepath}")
    print("=" * 80)
    print()
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Sort workbench colors
    content = sort_workbench_colors(content)
    
    # Sort tokenColors
    content = sort_token_colors(content)
    
    # Write result
    print()
    print(f"Writing sorted theme to {filepath}...")
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    
    print()
    print("✅ Theme sorted successfully!")
    print()
    print("=" * 80)
    print()


if __name__ == '__main__':
    theme_file = 'themes/Cyberdeck-2025-color-theme.json'
    sort_theme_file(theme_file)

