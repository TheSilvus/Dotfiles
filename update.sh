echo "Updating dotfiles"

rsync -av --exclude=".git/" --exclude="update.sh" --exclude=".gitmodules" . ~
