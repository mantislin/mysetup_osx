#!/bin/sh

# ========== base

# -- Ask for the administrator password upfront.
if [ "$(id -u)" != "0" ]; then
    sudo -v
fi

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

pushd "`dirname "$0"`" >/dev/null

# ========== base

command -v xcode-select >/dev/null 2>/dev/null || (
    echo "=================================================="
    echo ">>>>> Install command line tools, xcode-select --install"
    xcode-select --install
    echo ">>>>> Done!"
)

# ========== environments

echo "=================================================="
echo ">>>>> Setup BITBUCKET path..."
svnpath="${HOME}/Documents/verctrl"
svnname=bitbucket
if [ ! -d "${svnpath}/${svnname}" ]; then
    mkdir "${svnpath}/${svnname}"
fi
if [ -d "${svnpath}/${svnname}" -a ! -d "${HOME}/${svnname}" ]; then
    ln -s "${svnpath}/${svnname}" "${HOME}/${svnname}"
fi
[ -z "$bitbucket" ] && export bitbucket="${HOME}/bitbucket"
echo ">>>>> Done!"

echo "=================================================="
echo ">>>>> Setup GITHUB path..."
svnname=github
if [ ! -d "${svnpath}/${svnname}" ]; then
    mkdir "${svnpath}/${svnname}"
fi
if [ -d "${svnpath}/${svnname}" -a ! -d "${HOME}/${svnname}" ]; then
ln -s "${svnpath}/${svnname}" "${HOME}/${svnname}"
fi
[ -z "$github" ] && export github="${HOME}/github"
echo ">>>>> Done!"

echo "=================================================="
echo ">>>>> Setup SUBVERSION path..."
svnname=subversion
if [ ! -d "${svnpath}/${svnname}" ]; then
    mkdir "${svnpath}/${svnname}"
fi
if [ -d "${svnpath}/${svnname}" -a ! -d "${HOME}/${svnname}" ]; then
    ln -s "${svnpath}/${svnname}" "${HOME}/${svnname}"
fi
[ -z "$subversion" ] && export subversion="${HOME}/subversion"
echo ">>>>> Done!"

# ========== geek tools

# -- oh-my-zsh

echo ">>>>> Install oh-my-zsh via curl..."
curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh
echo ">>>>> Done!"

# -- rubygem about
pushd setup
chmod +x "./setup-rubygem"
"./setup-rubygem"
popd

# -- homebrew about

pushd setup
chmod +x "./setup-homebrew"
"./setup-homebrew"
popd

echo "=================================================="
echo ">>>>> Install some command line tools via homebrew..."
chmod +x "setup/setup-homebrew-cli-tools"
"setup/setup-homebrew-cli-tools"
echo ">>>>> Done!"

# ========== custom configurations

# -- github configs
pushd setup
chmod +x "./setup-github"
"./setup-github"
popd

# ========== programs

# -- proxy about

pushd setup
chmod +x "./setup-proxies"
"./setup-proxies"
popd

## -- Alcatraz, the plugins manager
##Alcatraz has been deprecated since Xcode8
#
#command -v xcode-select >/dev/null 2>/dev/null && (
#    [ -z "${xcodePath}" ] && xcodePath="$(xcode-select --print-path)"
#    [ ! -z "${xcodePath}" ] && xcodePath="${xcodePath%/*/*}"
#    [ "${xcodePath:(-1)}" = "/" ] && xcodePath="${xcodePath%?}"
#
#    if [ -d "${xcodePath}" ]; then
#        sudo curl -fsSL https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh
#    fi
#)

# ========== osx configs

pushd setup
chmod +x "./setup-osx-configs"
"./setup-osx-configs"
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

## -- Alcatraz, the plugins manager
#
#if [ -d "/Applications/Xcode.app" -o -d "${HOME}/Applications/Xcode.app" ]; then
#    sudo curl -fsSL https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh
#fi

# ========== make links

# -- minilyrics

if [ -f "${PWD}/setup/mklink_minilyrics" ]; then
    chmod +x "${PWD}/setup/mklink_minilyrics"
    "${PWD}/setup/mklink_minilyrics"
fi
