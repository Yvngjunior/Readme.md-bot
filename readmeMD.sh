#!/usr/bin/env bash
# neo_readme_bot.sh — fully automated Neo-level README generator

# ---- User Input ----
read -p "Project Name: " TITLE
read -p "One-line Description: " DESC
read -p "GitHub Repo URL (https://github.com/user/repo.git): " REPOURL
read -p "Features (comma separated): " FEATURES
read -p "Tech Stack (comma separated): " TECH
read -p "Preview image filename (leave blank if none): " PREVIEW
read -p "Local server command (default: python -m http.server 5500): " SERVERCMD
SERVERCMD=${SERVERCMD:-python -m http.server 5500}

# ---- Generate ASCII Banner ----
if command -v figlet >/dev/null 2>&1; then
  BANNER=$(figlet -f slant "$TITLE")
else
  BANNER="$TITLE"
fi

# ---- Convert repo URL to GitHub path ----
GITHUB_PATH=$(echo "$REPOURL" | sed -E 's#https?://github.com/([^/]+)/([^/]+)(.git)?#\1/\2#')

# ---- Generate README.md ----
cat > README.md <<EOF
\`\`\`
$BANNER
\`\`\`

$DESC

---

## Badges
[![License](https://img.shields.io/badge/license-MIT-blue.svg)]($REPOURL)  
[![GitHub stars](https://img.shields.io/github/stars/${GITHUB_PATH}?style=flat)]($REPOURL)  
[![Language](https://img.shields.io/github/languages/top/${GITHUB_PATH}?style=flat)]($REPOURL)  
[![Last Commit](https://img.shields.io/github/last-commit/${GITHUB_PATH}?style=flat)]($REPOURL)

---

## Features
$(echo "${FEATURES}" | sed 's/,/\n- /g' | sed 's/^/- /')

---

## Preview
$(if [ -n "$PREVIEW" ]; then echo "![Preview]($PREVIEW)"; else echo "_Add a screenshot or GIF here (e.g., screenshot.png)_"; fi)

---

## Installation & Setup

\`\`\`bash
# Clone the repository
git clone $REPOURL

# Enter the folder
cd $(basename "$REPOURL" .git)

# List files
ls
\`\`\`

---

## Running locally

\`\`\`bash
$SERVERCMD
\`\`\`

Open your browser at http://localhost:5500 (or your chosen port)

---

## Usage

1. Open the app in your browser  
2. Watch dynamic system logs  
3. Observe progress bar animations  
4. Enjoy the Neo-style terminal interface 😎

---

## Tech Stack
$(echo "$TECH" | sed 's/,/\n- /g' | sed 's/^/- /')

---

## Contributing

1. Fork the repo  
2. Create a branch (`git checkout -b feature/my-feature`)  
3. Commit your changes (`git commit -m "Add feature"`)  
4. Push and open a Pull Request  

---

## License

This project is released under the **MIT License**. See [LICENSE](LICENSE) for details.

---

## Terminal Neo-style Banner

Optional terminal preview if you have figlet and lolcat installed:

\`\`\`bash
figlet "$TITLE" | lolcat
\`\`\`

EOF

echo "✅ README.md generated! Open README.md to see your Neo-level masterpiece."
