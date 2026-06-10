#!/bin/bash

echo "⚙️  Zsh 및 필수 플러그인을 설치합니다..."

# 1. Oh My Zsh 설치 (설치되어 있지 않은 경우에만)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "   -> Oh My Zsh를 설치합니다..."
    # 자동 설치 중 셸 변경 방지, 기존 .zshrc 유지, 실행 후 바로 종료되도록 설정
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o install_omz.sh
    KEEP_ZSHRC=yes RUNZSH=no CHSH=no sh install_omz.sh
    rm install_omz.sh
else
    echo "   -> Oh My Zsh가 이미 설치되어 있습니다."
fi

# ZSH_CUSTOM 경로 설정
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# 2. Powerlevel10k 테마 설치
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "   -> Powerlevel10k 테마를 설치합니다..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
else
    echo "   -> Powerlevel10k 테마가 이미 설치되어 있습니다."
fi

# 3. zsh-autosuggestions 설치
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "   -> zsh-autosuggestions 플러그인을 설치합니다..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "   -> zsh-autosuggestions가 이미 설치되어 있습니다."
fi

# 4. zsh-syntax-highlighting 설치
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "   -> zsh-syntax-highlighting 플러그인을 설치합니다..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo "   -> zsh-syntax-highlighting이 이미 설치되어 있습니다."
fi

echo "✅ Zsh 플러그인 설치가 완료되었습니다."
