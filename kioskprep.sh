# Add chrome repository
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list'
apt-get update && sudo apt-get upgrade

# install stuff
apt-get install mc lynx gpm alsa-utils xorg nodm google-chrome-stable ubuntu-restricted-extras ntp alsa-utils crystalcursors

# install cursor-theme
wget http://kde-look.org/CONTENT/content-files/124161-aerodrop.tar.gz
tar -zxvf 124*
mv aerodrop /usr/share/icons
chown -R root:root /usr/share/icons/aerodrop
ln -s /usr/share/icons/aerodrop/index.theme /etc/X11/cursors/Aerodrop.theme
update-alternatives --install /usr/share/icons/default/index.theme x-cursor-theme /etc/X11/cursors/Aerodrop.theme 20
update-alternatives --config x-cursor-theme
sh -c 'echo "Inherits=aerodrop" >> /usr/share/icons/aerodrop/index.theme'

# xsession
touch .xsession
sh -c 'echo "#!/usr/bin/env bash" >> .xsession'
sh -c 'echo "xsetroot -cursor_name left_ptr" >> .xsession'
sh -c 'echo "google-chrome-stable" >> .xsession'
