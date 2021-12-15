#! /bin/sh

#TODO check git

GIT_DIR=$HOME/.dotfiles/.gitdir
BACKUP_DIR=$HOME/.config-backup

git clone --bare https://github.com/suiljex/dotfiles/ $HOME/.dotfiles/.gitdir
function gitdf {
   /usr/bin/git --git-dir=$GIT_DIR --work-tree=$HOME $@
}

gitdf config status.showUntrackedFiles no

gitdf checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  exit 0
else
  echo "Backing up pre-existing dot files.";
  mkdir --parents $BACKUP_DIR
  gitdf checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $BACKUP_DIR/{}
fi;

gitdf checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  exit 0
else
  echo "Error while bootstrapping"
  exit 1
fi;
