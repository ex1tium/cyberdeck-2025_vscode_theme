#!/bin/bash

# Cyberdeck 2025 Release Script
# Usage: ./scripts/release.sh [patch|minor|major|<version>]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    print_error "package.json not found. Please run this script from the repository root."
    exit 1
fi

# Check if git working directory is clean
if [ -n "$(git status --porcelain)" ]; then
    print_error "Git working directory is not clean. Please commit or stash your changes."
    git status --short
    exit 1
fi

# Get current version
CURRENT_VERSION=$(node -p "require('./package.json').version")
print_status "Current version: $CURRENT_VERSION"

# Determine new version
if [ $# -eq 0 ]; then
    print_error "Usage: $0 [patch|minor|major|<version>]"
    print_status "Examples:"
    print_status "  $0 patch    # 1.1.2 → 1.1.3"
    print_status "  $0 minor    # 1.1.2 → 1.2.0"
    print_status "  $0 major    # 1.1.2 → 2.0.0"
    print_status "  $0 1.5.0    # Set specific version"
    exit 1
fi

VERSION_TYPE=$1

if [[ "$VERSION_TYPE" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    # Specific version provided
    NEW_VERSION=$VERSION_TYPE
    print_status "Setting version to: $NEW_VERSION"
    npm version $NEW_VERSION --no-git-tag-version
else
    # Use npm version command
    print_status "Bumping $VERSION_TYPE version..."
    NEW_VERSION=$(npm version $VERSION_TYPE --no-git-tag-version | sed 's/^v//')
fi

print_success "Version updated to: $NEW_VERSION"

# Prompt for changelog update
print_warning "Please update CHANGELOG.md with the changes for version $NEW_VERSION"
print_status "Press Enter when you've updated the changelog, or Ctrl+C to cancel..."
read -r

# Verify changelog was updated
if ! grep -q "\[$NEW_VERSION\]" CHANGELOG.md; then
    print_warning "Version $NEW_VERSION not found in CHANGELOG.md"
    print_status "Continue anyway? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        print_error "Release cancelled. Please update CHANGELOG.md"
        exit 1
    fi
fi

# Commit changes
print_status "Committing version bump..."
git add package.json CHANGELOG.md
git commit -m "chore: bump version to $NEW_VERSION"

# Create and push tag
print_status "Creating and pushing tag: $NEW_VERSION"
git tag $NEW_VERSION
git push origin main
git push origin $NEW_VERSION

print_success "🎉 Release process initiated!"
print_status "GitHub Actions will now:"
print_status "  1. Build the extension"
print_status "  2. Create a GitHub release"
print_status "  3. Attach the .vsix file"
print_status ""
print_status "🔗 Monitor the release at:"
print_status "   https://github.com/ex1tium/cyberdeck-2025_vscode_theme/actions"
print_status ""
print_status "📦 The release will be available at:"
print_status "   https://github.com/ex1tium/cyberdeck-2025_vscode_theme/releases"
