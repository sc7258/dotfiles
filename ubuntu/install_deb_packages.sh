#!/bin/bash
# ==============================================================
# Install Direct DEB Packages
# ==============================================================

echo "📦 수동 DEB 패키지 설치를 시작합니다..."

# 임시 디렉토리 생성
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

# 1. Obsidian 설치
echo "  -> Obsidian 최신 버전 다운로드 및 설치..."
OBSIDIAN_URL=$(curl -s https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest | grep "browser_download_url.*amd64.deb" | cut -d '"' -f 4)
if [ -n "$OBSIDIAN_URL" ]; then
    wget -qO obsidian.deb "$OBSIDIAN_URL"
    sudo apt install -y ./obsidian.deb
else
    echo "⚠️ Obsidian 다운로드 URL을 찾을 수 없습니다."
fi

# 3. Synology Drive Client (정적 링크 활용 - URL이 변경될 수 있음)
echo "  -> Synology Drive Client 다운로드 및 설치..."
SYNOLOGY_URL="https://global.download.synology.com/download/Utility/SynologyDriveClient/3.4.0-15724/Ubuntu/Installer/synology-drive-client-10000.x86_64.deb"
wget -qO synology-drive.deb "$SYNOLOGY_URL"
sudo apt install -y ./synology-drive.deb

cd - > /dev/null
rm -rf "$TMP_DIR"

echo "✅ DEB 패키지 설치 완료."
