/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install --cask	\
	intellij-idea	\
	android-studio	\
	docker		\
	iterm2		\
	ngrok

brew install		\
	zsh		\
	zsh-completions	\
	docker-compose	\
	rbenv		\
	ruby-build	\
	postgresql	\
	libyaml		\
	readline	\
	openssl		\
	node		\
	watchman	\
	npm		\
	nvm

echo "Configuring zsh..."
echo /usr/local/bin/zsh | sudo tee -a /etc/shells
chsh -s /usr/local/bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ./zshrc ~/.zshrc

echo "Configuring. NVM"
mkdir ~/.nvm
nvm install --lts
npm install -g yarn

echo "Configuring React Native"
rbenv install 2.7.6
npm install -g yarn

echo "Configuring Docker..."
mkdir -p ~/.docker/cli-plugins
ln -sfn /usr/local/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
open --background -a Docker

echo "Configuring SSH..."
ssh-keygen -t ed25519 -C "dev@antoineaudrain.com"
ssh-add
eval "$(ssh-agent -s)"
touch ~/.ssh/config
tee -a ~/.ssh/config << END
Host *.github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
END
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub

echo "Configuring Ruby On Rails..."
brew install
rbenv install $(rbenv install -l | grep -v - | tail -1)
rbenv global $(rbenv install -l | grep -v - | tail -1)
gem install	\
	bundler	\
	rails

echo "Configuring workspace..."
mkdir -p ~/Documents/Workspace
npm i -g create-react-app @vue/cli react-native-cli react-devtools
