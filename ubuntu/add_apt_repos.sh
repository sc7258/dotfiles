#!/bin/bash
# ==============================================================
# Add APT Repositories for External Packages
# ==============================================================
echo "🔑 외부 패키지용 APT 저장소 및 GPG 키를 등록합니다..."

# 필수 패키지 설치
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg apt-transport-https software-properties-common wget lsb-release

sudo mkdir -p /etc/apt/keyrings

# 1. Docker
if [ ! -f /etc/apt/keyrings/docker.asc ]; then
    echo "  -> Docker 저장소 추가"
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi

# 2. VS Code
if [ ! -f /etc/apt/keyrings/packages.microsoft.gpg ] && [ ! -f /usr/share/keyrings/microsoft.gpg ] && [ ! -f /etc/apt/sources.list.d/vscode.sources ]; then
    echo "  -> VS Code 저장소 추가"
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    rm -f packages.microsoft.gpg
fi

# 3. Kubernetes (v1.29)
if [ ! -f /etc/apt/keyrings/kubernetes-apt-keyring.gpg ]; then
    echo "  -> Kubernetes 저장소 추가"
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null
fi

# 4. Google Cloud CLI
if [ ! -f /usr/share/keyrings/cloud.google.gpg ]; then
    echo "  -> Google Cloud SDK 저장소 추가"
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list > /dev/null
fi

# 6. TablePlus
if [ ! -f /usr/share/keyrings/tableplus-archive-keyring.gpg ]; then
    echo "  -> TablePlus 저장소 추가"
    wget -qO - https://deb.tableplus.com/apt.tableplus.com.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/tableplus-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/tableplus-archive-keyring.gpg] https://deb.tableplus.com/debian/24 tableplus main" | sudo tee /etc/apt/sources.list.d/tableplus.list > /dev/null
fi

# 7. DBeaver CE
if [ ! -f /usr/share/keyrings/dbeaver.gpg ]; then
    echo "  -> DBeaver CE 저장소 추가"
    wget -O - https://dbeaver.io/debs/dbeaver.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/dbeaver.gpg
    echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list > /dev/null
fi

# 8. Google Chrome
if [ ! -f /usr/share/keyrings/googlechrome-linux-keyring.gpg ]; then
    echo "  -> Google Chrome 저장소 추가"
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
fi

echo "✅ 저장소 추가 완료."

# 9. Brave Browser
if [ ! -f /usr/share/keyrings/brave-browser-archive-keyring.gpg ]; then
    echo "  -> Brave Browser 저장소 추가"
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null
fi
