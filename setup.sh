#!/bin/bash

# ==============================================================
# Dotfiles Setup Script (Multi-OS Support)
# ==============================================================
# 이 스크립트는 패키지를 설치하고 설정 파일들의 심볼릭 링크를 생성합니다.

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
COMMON_DIR="$DOTFILES_DIR/common"
UBUNTU_DIR="$DOTFILES_DIR/ubuntu"
MACOS_DIR="$DOTFILES_DIR/macos"

echo "🚀 새로운 시스템 구성을 시작합니다..."

# 링크 생성 도우미 함수 (기존 파일이 있으면 백업)
link_file() {
    local src=$1
    local dest=$2

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "   -> 백업 생성: $dest -> ${dest}.backup"
        mv "$dest" "${dest}.backup"
    fi

    echo "   -> 링크 생성: $dest -> $src"
    ln -s "$src" "$dest"
}

# 1. OS 감지 및 패키지 설치
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "🐧 Ubuntu(Linux) 환경을 감지했습니다."
    
    echo "📦 apt-packages.txt 로부터 패키지를 설치합니다..."
    if [ -f "$UBUNTU_DIR/apt-packages.txt" ]; then
        sudo apt update
        xargs -a "$UBUNTU_DIR/apt-packages.txt" sudo apt install -y
    else
        echo "⚠️ apt-packages.txt 파일을 찾을 수 없어 패키지 설치를 건너뜁니다."
    fi

    echo "📦 snap-packages.txt 로부터 snap 패키지를 설치합니다..."
    if command -v snap &> /dev/null && [ -f "$UBUNTU_DIR/snap-packages.txt" ]; then
        while read -r package flag; do
            if [ -n "$package" ]; then
                if [ "$flag" == "--classic" ]; then
                    sudo snap install "$package" --classic
                else
                    sudo snap install "$package"
                fi
            fi
        done < "$UBUNTU_DIR/snap-packages.txt"
    else
        echo "⚠️ snap이 설치되어 있지 않거나 snap-packages.txt 파일을 찾을 수 없습니다."
    fi

    # Ubuntu 전용 설정 파일 링크
    link_file "$UBUNTU_DIR/.zshrc_ubuntu" "$HOME/.zshrc_ubuntu"

elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 macOS 환경을 감지했습니다."
    
    # Homebrew 설치 확인 및 패키지 설치 (Brewfile 활용 가능)
    if ! command -v brew &> /dev/null; then
        echo "🍺 Homebrew가 설치되어 있지 않습니다. Homebrew를 먼저 설치해주세요."
    else
        echo "📦 Homebrew를 통해 패키지를 설치할 수 있습니다. (추후 추가 예정)"
    fi

    # macOS 전용 설정 파일 링크
    link_file "$MACOS_DIR/.zshrc_macos" "$HOME/.zshrc_macos"
else
    echo "❓ 지원하지 않는 OS입니다: $OSTYPE"
fi

# 2. 공통 심볼릭 링크 생성
echo "🔗 공통 설정 파일들의 심볼릭 링크를 생성합니다..."
link_file "$COMMON_DIR/.zshrc_common" "$HOME/.zshrc"
link_file "$COMMON_DIR/.bashrc" "$HOME/.bashrc"
link_file "$COMMON_DIR/.gitconfig" "$HOME/.gitconfig"

# kitty 설정 링크 (디렉토리 자체를 링크하거나 내부 파일을 링크)
mkdir -p "$HOME/.config/kitty"
link_file "$COMMON_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"

# zsh를 기본 셸로 설정 (선택적)
if [[ "$SHELL" != *"zsh"* ]]; then
    echo "🛠 기본 셸을 zsh로 변경합니다..."
    chsh -s "$(which zsh)"
fi

echo "✅ 모든 설정이 완료되었습니다! 터미널을 재시작하거나 새 세션을 열어주세요."
