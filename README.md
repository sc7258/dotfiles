# My Dotfiles

이 저장소는 Ubuntu 시스템을 새로 설치했을 때 기존과 동일한 환경을 빠르게 구성하기 위해 만들어졌습니다.
설정 파일들(`conf`, `.zshrc` 등)과 설치된 프로그램 목록이 포함되어 있으며, `setup.sh` 스크립트를 통해 원클릭으로 환경을 복원할 수 있습니다.

## 🗂 디렉토리 구조 및 파일 인덱스

- `configs/`
  - `.zshrc` : Zsh 셸 설정 파일
  - `.bashrc` : Bash 셸 설정 파일
  - `.gitconfig` : Git 사용자 및 alias 설정
  - `.tmux.conf` : Tmux 멀티플렉서 설정 파일
- `apt-packages.txt` : 현재 시스템에 수동으로 설치되었던 APT 패키지 목록 (약 120+개)
- `setup.sh` : 자동 설치 및 심볼릭 링크 생성 스크립트

## 🚀 사용 방법 (새로운 컴퓨터에서)

새로운 Ubuntu 컴퓨터를 설치한 후 터미널을 열고 다음 과정을 진행합니다.

1. **저장소 클론하기** (Git이 설치되어 있어야 합니다):
   ```bash
   sudo apt install -y git
   git clone <이 저장소의 Github 주소> ~/dotfiles
   cd ~/dotfiles
   ```

2. **설치 스크립트 실행하기**:
   ```bash
   ./setup.sh
   ```
   > ⚠️ 스크립트는 패키지를 설치하기 위해 `sudo` 권한을 요구할 수 있습니다.

3. **완료 및 적용**:
   스크립트가 기존 설정 파일이 존재할 경우 `.backup` 확장자로 백업한 뒤 링크를 생성합니다. 완료되면 터미널을 재시작하시기 바랍니다.

## 📝 관리 방법 (설정 업데이트하기)

사용 중 설정 파일을 수정했다면, 새로운 컴퓨터에도 반영될 수 있도록 주기적으로 깃허브에 백업해주세요. 설정 파일들이 `~/dotfiles/configs/` 경로에 심볼릭 링크로 연결되어 있기 때문에, 홈 디렉토리에서 수정한 내용이 이 폴더에도 그대로 반영됩니다.

```bash
cd ~/dotfiles
git add .
git commit -m "Update configurations"
git push
```

만약 새로운 프로그램을 추가로 설치했다면 `apt-packages.txt`를 갱신해주세요:
```bash
apt-mark showmanual > apt-packages.txt
```
