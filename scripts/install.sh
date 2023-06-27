#!/bin/bash
#
# **********************************************************
# * Author           : qingu
# * Email            : jiangqingu@gmail.com
# * Github           : https://github.com/qingu
# * Create Time      : 2023-06-27 18:24
# * FileName         : scripts/install.sh
# * Description      :
# **********************************************************

MYDIR=$(readlink -f "$0")
MYDIR=$(dirname "$MYDIR")
echo ROOT DIR: $MYDIR

#关联数组
declare -A config_dir

config_dir["neovim"]="~/.config/nvim/"
config_dir["tmux"]="~/.tmux.conf"
#config_dir["oh-my-zsh"]="/root/.zshrc"

print_start() {
	printf "This is qingu dotfile install program. \n"
	printf "Start to install dotfile ...\n"
}

check() {
	#对关联数组的遍历
	for key in ${!config_dir[*]}; do
		str=${config_dir[$key]}
		print_is_file_or_dir_exist ${config_dir[$key]}
	done
}

print_is_file_or_dir_exist() {
	if [ -d $1 ]; then
		printf "config dir: $1 is exist, it will be delete!!!\n"
	elif [ -f $1 ]; then
		printf "config file: $1 is exist, it will be delete!!!\n"
	else
		printf "config: $1 is not existed, return.\n"
	fi
}

ln_config() {
	ln -sf $MYDIR/../tmux/tmux.conf ~/.tmux.conf
	ln -sf $MYDIR/../neovim ~/.config/nvim
	#ln -s ../powerlevel10k/p10k.zsh ~/.p10k.zsh
	#ln -s ../oh-my-zsh/zshrc ~/.zshrc
}

rm_config_path() {
	#rm ~/.zshrc
	#rm ~/.p10k.zsh
	rm ~/.tmux.conf
	rm -rf ~/.config/nvim
}

download_nvim_config() {
	printf "download neovim config\n"
}

download_tmux_config() {
	tmux source-file ~/.tmux.conf
}

download_omz_config() {
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	source ~/.zshrc
}

print_start
check
printf "\033[31mReady to rm you config?(y/n) \033[0m\n"
read is_rm_config
if [ $is_rm_config = "y" ]; then
	printf "rm config\n"
else
	printf '%s\n' "don't clean you config, return"
fi
ln_config
# rm_config_path
#
printf "\033[32mConfig is update successfully! enjoy it.\033[0m\n"
