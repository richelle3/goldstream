#!/usr/bin/env bash

set -e  # Прерывать выполнение при ошибке

## Проверка и установка yay (однократно в начале)
if ! command -v yay >/dev/null 2>&1; then
    echo "yay не найден. Устанавливаю..."
    sudo pacman -S --needed --noconfirm git base-devel
    tmpdir="$(mktemp -d)"
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    cd "$tmpdir/yay"
    makepkg -si --noconfirm
    cd -
    rm -rf "$tmpdir"
    echo "yay установлен."
fi

## Функция установки
install() {
    if [[ $# -eq 0 ]]; then
        echo "Usage: install <package> [package ...]"
        return 1
    fi

    echo "Installing: $*"
    yay -S --needed --noconfirm "$@"
}

## Пример использования
install "mullvad-browser-bin"

