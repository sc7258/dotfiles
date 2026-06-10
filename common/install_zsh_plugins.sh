#!/bin/bash

echo "⚙️  Zsh 및 필수 플러그인을 설치합니다..."

# 1. Oh My Zsh 설치 (설치되어 있지 않거나 깨진 경우)
if [ ! -f "$HOME/.oh-my-zsh/oh-my-zsh.sh" ]; then
    echo "   -> Oh My Zsh를 설치(또는 복구)합니다..."
    
    # 만약 폴더만 있고 알맹이가 없는 경우(설치 실패 잔재) 삭제
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo "   -> 기존의 손상된 .oh-my-zsh 폴더를 삭제합니다..."
        rm -rf "$HOME/.oh-my-zsh"
    fi

    # 자동 설치 중 셸 변경 방지, 기존 .zshrc 유지, 실행 후 바로 종료되도록 설정
    curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o install_omz.sh
    KEEP_ZSHRC=yes RUNZSH=no CHSH=no sh install_omz.sh
    rm install_omz.sh
else
    echo "   -> Oh My Zsh가 이미 올바르게 설치되어 있습니다."
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

# 5. NVM (Node Version Manager) 및 Node.js (LTS) 설치
if [ ! -d "$HOME/.nvm" ]; then
    echo "   -> NVM (Node Version Manager)을 설치합니다..."
    # 최신 버전 스크립트 실행
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.5/install.sh | bash
    
    # 설치 직후 현재 세션에서 NVM을 사용하기 위한 환경 변수 로드
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    echo "   -> Node.js 최신 LTS 버전을 설치합니다..."
    nvm install --lts
    nvm use --lts
    nvm alias default 'lts/*'
else
    echo "   -> NVM이 이미 설치되어 있습니다."
fi

echo "✅ Zsh 플러그인 및 개발 환경(NVM) 설치가 완료되었습니다."
