#!/bin/sh

# ========== github folder

github="${HOME}/github"
if [ ! -d "${HOME}/Documents/github" ]; then mkdir "${HOME}/Documents/github"; fi
if [ ! -d "${github}" ]; then ln -s "${HOME}/Documents/github" "${github}"; fi

# ========== geek tools

# -- intall RubyGems via ruby

if [ ! -d "${github}/rubygems_rubygems" ]; then
    git clone "https://github.com/rubygems/rubygems" "${github}/rubygems_rubygems"
fi
pushd "${github}/rubygems_rubygems"
    sudo ruby setup.rb
popd

# -- install Homebrew via

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# -- install cocoapods via gem

sudo gem install cocoapods

# -- install composer via gem

sudo gem install composer

# -- install oh-my-zsh via curl

curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

# -- update openssl via brew
brew install openssl

# ========== custom configurations

# -- dotfiles

if [ ! -d "${github}/mantislin_dotfiles" ]; then
    git clone "https://github.com/mantislin/dotfiles" "${github}/mantislin_dotfiles"
fi
pushd "${github}/mantislin_dotfiles"
    chmod +x setup.command
    ./setup.command
popd

# -- github global configurations

if [ -f "${PWD}/setup/git_global_configs" ]; then
    chmod +x "${PWD}/setup/git_global_configs"
    "${PWD}/setup/git_global_configs"
fi

# -- github generate ssh keys

if [ -f "${PWD}/setup/git_sshkey_generating" ]; then
    chmod +x "${PWD}/setup/git_sshkey_generating"
    "${PWD}/setup/git_sshkey_generating"
fi

# ========== proxy cases: goagent and cow

# -- config python for running goagent
xcode-select --install
brew install python python3
sudo easy_install PyOpenSSL
sudo easy_install PyCrypto

# -- cow

if [ ! -d "${HOME}/local/cow" ]; then
    mkdir -pv "${HOME}/local/cow"
fi
pushd "${HOME}/local/cow"
    curl -L git.io/cow | bash
popd

# ========== OSX configurations

# -- turn on hibernate mode

if [ -f "${PWD}/setup/pmset_hibernatemode_on" ]; then
    chmod +x "${PWD}/setup/pmset_hibernatemode_on"
    "${PWD}/setup/pmset_hibernatemode_on"
fi

# -- show Library folder in HOME

if [ -f "${PWD}/setup/library_folder_hidden" ]; then
    chmod +x "${PWD}/setup/library_folder_hidden"
    "${PWD}/setup/library_folder_hidden"
fi

# -- finder show hidden files

if [ -f "${PWD}/setup/finder_hidden_files_show" ]; then
    chmod +x "${PWD}/setup/finder_hidden_files_show"
    "${PWD}/setup/finder_hidden_files_show"
fi

# -- finder show folders first

if [ -f "${PWD}/setup/finder_show_folders_last" ]; then
    chmod +x "${PWD}/setup/finder_show_folders_last"
    "${PWD}/setup/finder_show_folders_last"
fi

# ========== Xcode cases

# -- Alcatraz, the plugins manager

if [ -d "/Applications/Xcode.app" -o -d "${HOME}/Applications/Xcode.app" ]; then
    sudo curl -fsSL https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh
fi

# ========== make links

# -- minilyrics

if [ -f "${PWD}/setup/mklink_minilyrics" ]; then
    chmod +x "${PWD}/setup/mklink_minilyrics"
    "${PWD}/setup/mklink_minilyrics"
fi
