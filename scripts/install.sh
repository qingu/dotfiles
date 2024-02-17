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
echo "ROOT DIR: $MYDIR"

#关联数组
declare -A config_dir

config_dir["neovim"]="$HOME/.config/nvim/"
config_dir["tmux"]="$HOME/.tmux.conf"
config_dir["tpm"]="$HOME/.tmux/plugins/tpm/"
#config_dir["oh-my-zsh"]="/root/.zshrc"

print_start() {
	printf "This is qingu dotfile install program. \n"
	printf "Start to install dotfile ...\n"
}

check() {
	#对关联数组的遍历
	for key in ${!config_dir[*]}; do
		#str=${config_dir[$key]}
		print_is_file_or_dir_exist "${config_dir[$key]}"
	done
}

print_is_file_or_dir_exist() {
	if [ -d "$1" ]; then
		printf "config dir: $1 is exist, it will be delete!!!\n"
	elif [ -f "$1" ]; then
		printf "config file: $1 is exist, it will be delete!!!\n"
	else
		printf "config: $1 is not existed, return.\n"
	fi
}

backup_config() {
	mv ~/.tmux.conf ~/.tmux.conf.bak.$$
	mv ~/.config/nvim ~/.config/nvim.bak.$$
	mv ~/.local/share/nvim ~/.local/share/nvim.bak.$$
	mv ~/.local/state/nvim ~/.local/state/nvim.bak.$$
	mv ~/.cache/nvim ~/.cache/nvim.bak.$$
}

ln_astronvim_config() {
	ln -sf "$MYDIR/../astronvim/astronvim_config" ~/.config/nvim/lua/user
}

ln_nvim_config() {
	ln -sf "$MYDIR/../neovim" ~/.config/nvim
}

ln_tmux_config() {
	ln -sf "$MYDIR/../tmux/tmux.conf" ~/.tmux.conf
	download_tmux_tpm
	echo "export PATH=~/.tmux/plugins/tmuxifier/bin:$PATH" >>~/.bashrc
	echo 'eval "$(tmuxifier init -)"' >>~/.bash_profile
	#ln -s ../powerlevel10k/p10k.zsh ~/.p10k.zsh
	#ln -s ../oh-my-zsh/zshrc ~/.zshrc
}

rm_config_path() {
	#rm ~/.zshrc
	#rm ~/.p10k.zsh
	rm ~/.tmux.conf
	rm -rf ~/.config/nvim
	rm -rf ~/.tmux/
}

download_tmux_tpm() {
	[[ ! -d ~/.tmux/plugins ]] && mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}
download_nvim_config() {
	printf "download neovim config\n"
}

download_astronvim_config() {
	printf "download astronvim config\n"
	git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
	# astronvim config
	git submodule init
	git submodule update
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
#printf "\033[31mReady to rm you config?(y/n) \033[0m\n"
#read -r is_rm_config
#if [ "$is_rm_config" = "y" ]; then
#	printf "rm config\n"
#else
#	printf '%s\n' "don't clean you config, return"
#fi

printf "\033[31mReady to backup your old config \033[0m\n"
backup_config

printf "\033[31mReady to use new config \033[0m\n"
printf "\033[31mChoose if want to use astronvim?(y/n) \033[0m\n"
read -r use_astronvim
if [ "$use_astronvim" = "y" ]; then
	printf "Use astronvim config\n"
	download_astronvim_config
	ln_astronvim_config
else
	printf '%s\n' "Use ordinary nvim config"
	download_nvim_config
	ln_nvim_config
fi

ln_tmux_config

# rm_config_path
#
printf "\033[32mConfig is update successfully! enjoy it.\033[0m\n"
