#!/bin/bash

# ==============================================================
# Dotfiles Setup Script
# ==============================================================
# 이 스크립트는 패키지를 설치하고 설정 파일들의 심볼릭 링크를 생성합니다.

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$DOTFILES_DIR/configs"

echo "🚀 새로운 시스템 구성을 시작합니다..."

# 1. 시스템 패키지 설치
echo "📦 apt-packages.txt 로부터 패키지를 설치합니다..."
if [ -f "$DOTFILES_DIR/apt-packages.txt" ]; then
    sudo apt update
    # xargs를 사용하여 패키지 일괄 설치
    xargs -a "$DOTFILES_DIR/apt-packages.txt" sudo apt install -y
else
    echo "⚠️ apt-packages.txt 파일을 찾을 수 없어 패키지 설치를 건너뜁니다."
fi

# 2. 심볼릭 링크 생성
echo "🔗 설정 파일들의 심볼릭 링크를 생성합니다..."

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

# 설정 파일들 연결 (.zshrc, .bashrc, .gitconfig, .tmux.conf)
link_file "$CONFIG_DIR/.zshrc" "$HOME/.zshrc"
link_file "$CONFIG_DIR/.bashrc" "$HOME/.bashrc"
link_file "$CONFIG_DIR/.gitconfig" "$HOME/.gitconfig"
link_file "$CONFIG_DIR/.tmux.conf" "$HOME/.tmux.conf"

# zsh를 기본 셸로 설정 (선택적)
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "🛠 기본 셸을 zsh로 변경합니다..."
    chsh -s "$(which zsh)"
fi

echo "✅ 모든 설정이 완료되었습니다! 터미널을 재시작하거나 새 세션을 열어주세요."
