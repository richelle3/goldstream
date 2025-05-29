#!/usr/bin/env bash
set -e

# Установка yay (однократно, если отсутствует)
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

# Проверка, установлен ли syncthing
if ! pacman -Q syncthing >/dev/null 2>&1; then
    echo "Устанавливаю syncthing..."
    yay -S syncthing --needed --noconfirm

    echo "Включаю Syncthing как systemd user service..."
    systemctl --user enable syncthing.service
    systemctl --user start syncthing.service

    echo "Syncthing установлен и запущен: http://localhost:8384"
else
    echo "Syncthing уже установлен. Пропускаю установку."
fi

