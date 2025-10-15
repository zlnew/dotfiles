---

# 🧰 Fresh Install Guide

## 🌐 Web Stack

**1. PHP Environment**

- nginx
- redis / valkey
- postgresql
- pgcli
- php-pear
- phpenv
- composer

**2. Node Environment**

- nvm
- bun

---

## ⚙️ Tools

- zellij
- zoxide
- neovim

---

## 🧠 Language Servers / Node Packages

- vue-language-server
- @vtsls/language-server
- @tailwindcss/language-server
- eslint_d
- fsouza/prettierd
- intelephense
- tree-sitter

---

## 🪄 Misc

- Setup SSH key
- Clone all projects to `~/www`

---

## Minimal KDE Plasma

- plasma-desktop
- dolphin
- kwalletmanager
- plasma-nm
- plasma-pa
- kscreen

## How to disable boot splast plymouth on CachyOS

1. Users of sdboot-manage may edit `/etc/sdboot-manage.conf` on the LINUX_OPTIONS= line.
   Add = `plymouth.enable=0 disablehooks=plymouth`
   Remove = `splash`
   Afterwards to regenrate entries with the options:
   `sudo sdboot-manage gen`
2. Edit /etc/mkinitcpio.conf and remove plymouth from HOOKS.
   Afterwards to rebuild initram run: `sudo mkinitcpio -P`

---
