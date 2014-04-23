# Add chrome repository
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list'
apt-get update && sudo apt-get upgrade

# install stuff
apt-get install mc lynx gpm alsa-utils xorg nodm google-chrome-stable ubuntu-restricted-extras ntp alsa-utils dmz-cursor-theme

# install cursor-theme
wget http://kde-look.org/CONTENT/content-files/124161-aerodrop.tar.gz
tar -zxvf 124*
mv aerodrop /usr/share/icons
chown -R root:root /usr/share/icons/aerodrop
chmod -R 755 /usr/share/icons/aerodrop
touch /usr/share/icons/aerodrop/aerodrop.theme
sh -c 'echo "[Icon Theme]" >> /usr/share/icons/aerodrop/aerodrop.theme'
sh -c 'echo "Inherits=aerodrop" >> /usr/share/icons/aerodrop/aerodrop.theme'
update-alternatives --install /usr/share/icons/default/index.theme x-cursor-theme /usr/share/icons/aerodrop/aerodrop.theme 100
update-alternatives --config x-cursor-theme
sh -c 'echo "Inherits=aerodrop" >> /usr/share/icons/aerodrop/index.theme'

# xsession
touch .xsession
sh -c 'echo "#!/usr/bin/env bash" >> .xsession'
sh -c 'echo "xsetroot -cursor_name left_ptr" >> .xsession'
sh -c 'echo "google-chrome-stable" >> .xsession'

sed -i 's/server 0/#server 0/g' /etc/ntp.conf
sed -i 's/server 1/#server 1/g' /etc/ntp.conf
sed -i 's/server 2/#server 2/g' /etc/ntp.conf
sed -i 's/server 3/#server 3/g' /etc/ntp.conf
sed -i 's/ntp.ubuntu.com/ntp.malmo.se/g' /etc/ntp.conf

ntpdate -s ntp.malmo.se
