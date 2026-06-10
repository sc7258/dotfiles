#!/bin/bash

# ==============================================================
# Ubuntu GNOME / Input Settings Setup
# ==============================================================

echo "⚙️  Ubuntu 입력기(한영 전환) 및 GNOME 단축키 설정을 적용합니다..."

# 입력기 프레임워크를 ibus로 지정
if command -v im-config &> /dev/null; then
    echo "  -> 기본 입력기를 ibus로 설정합니다..."
    im-config -n ibus
fi

# GNOME 입력 소스에 ibus-hangul 등록 (이 부분이 없으면 새 시스템에서 활성화되지 않음)
gsettings set org.gnome.desktop.input-sources sources "[('ibus', 'hangul')]"

# ibus-hangul 한영 전환 단축키 설정 (Shift+Space, 우측 Alt)
gsettings set org.freedesktop.ibus.engine.hangul switch-keys "'Shift+space,Alt_R'"

# 두벌식 키보드 설정
gsettings set org.freedesktop.ibus.engine.hangul hangul-keyboard "'2'"

# GNOME 기본 입력 소스 전환 단축키 설정
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['Hangul', 'Right Alt']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Shift><Super>space', '<Shift>XF86Keyboard']"

echo "✅ GNOME 단축키 설정이 완료되었습니다."
