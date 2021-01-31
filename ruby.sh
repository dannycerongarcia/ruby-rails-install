#!/bin/sh
#installing ruby
source variables.sh
sudo apt isntall curl
curl -sL "https://deb.nodesource.com/${nodeV14}" | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update
sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn

#installing rbenv
cd
if git clone https://github.com/rbenv/rbenv.git ~/.rbenv; then
   echo "cloned repo"
   echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
   echo 'eval "$(rbenv init -)"' >> ~/.bashrc
   exec $SHELL
else
# upgrading rbenv
    cd ~/.rbenv
    git pull
    cd
fi
# Ruby versio
if git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build; then
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
    exec $SHELL
else
# updating the list of available Ruby versions
    cd ~/.rbenv/plugins/ruby-build
    git pull
    cd
fi
rbenv install --list
#recommended 3.0.0
# read rbenv_v
# echo "you chose ${rbenv_v}"
rbenv install $rbenv_version
rbenv global $rbenv_version
#checking ruby version
ruby -v
# gem list -a
# read gem_v
gem install bundler
gem install rails -v $rails_version
rbenv rehash

rails -v