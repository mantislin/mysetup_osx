#!/bin/sh

ssh-keygen -t rsa -C "mntslin@hotmail.com"
eval `ssh-agent -s`
ssh-add

pbcopy < ~/.ssh/id_rsa.pub
echo "Has copied content of \"~/.ssh/id_rsa.pub\"."
echo "If not this file, just go and copy by yourself."
echo "Then open github website to add it to your account"
read -p "Press [Enter] key to continue..."
