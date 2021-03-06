#!/usr/bin/zsh
## override config
# override local config    # Make sure the ~/.local exists, otherwise cp will cp dir to ~/.local instead of inside of ~/.local (result in ~/.local/etc)fig
rsync -r etc ~/.local/
# mkdir -p ~/.local/; cp -r etc ~/.local/
# ranger    # Make sure the ~/.config exists, otherwise cp will cp dir to .config instead of inside of ~/.config
rsync -r etc/ranger ~/.config/
# mkdir -p ~/.config/; cp -r etc/ranger ~/.config/
# cp -r etc/ranger ~/.config/

# config newsboat. It only worked in thit fuck way.
# ln -s ~/.local/etc/newsboat/config ~/.newsboat/config 2>/dev/null
# ln -sf ~/.local/etc/newsboat/config ~/.newsboat/config
rsync -r etc/newsboat ~/.config/
# ln -sf $(realpath ./etc/ranger) ~/.config/

### Force echo to zsh tmux config file
if [[ $1 = "f" ]]
then
    _owen_force_echo=1
    echo "Force echo to zsh tmux config file~~~"
    echo "You must take care of the duplicated term in zsh/tmux config file~~~"
    echo "zsh  $(realpath ~/.zshrc)"
    echo "tmux $(realpath ~/.tmux.conf)"
else
    _owen_force_echo=
fi

# WSL config. cp pac to win10. ubt do not need it, because we use proxychain to manual control.
result=$(uname -r | grep -i "microsof" | wc -l)
if [ $result -eq 1 ]
then
    echo "we are in wsl~~~"
    cp ~/.local/etc/pac.txt /mnt/c/MY_SOFTWARE/v2rayN-windows-64/v2rayN-Core-64bit/pac.txt
    mkdir -p /mnt/d/.local/
    rsync -r ~/.local/etc/win10/* /mnt/d/.local/win10
    # "/mnt/c/Program Files/AutoHotkey/Compiler/Ahk2Exe.exe" /in d:\.local\keyremap.ahk /out d:\.local\keyremap.exe
    # cp /mnt/d/.local/keyremap.exe "/mnt/c/ProgramData/Microsoft/Windows/Start\ Menu/Programs/StartUp/keyremap.exe"
fi

# -- zsh ----------------------------------------------------------
# To activate the new .zshrc because this exists in father zsh
# unset _owen_zsh_sourced

# enable config file and avoid configed twice
if [ -e ~/.local/etc/zsh.conf ] && [ -z $_owen_force_echo ]
then
    echo "owen zsh configed"
else
    echo "# -- owen zsh configing $(realpath ./etc/zsh.conf) -----">>~/.zshrc
	echo "source ~/.local/etc/zsh.conf">>~/.zshrc
fi


# -- tmux ---------------------------------------------------------
# To activate the new .zshrc because this exists in father zsh
# unset _owen_tmux_sourced

# enable config file and avoid configed twice
# if [[ -z $_owen_zsh_configed ]] {
if [ -e ~/.local/etc/tmux.conf ] && [ -z $_owen_force_echo ]
then
    echo "owen tmux configed"
else
    echo "# -- owen tmux configing $(realpath ./etc/tmux.conf) ---">>~/.tmux.conf
    echo "source ~/.local/etc/tmux.conf">>~/.tmux.conf
fi
