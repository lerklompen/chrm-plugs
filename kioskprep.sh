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

# Time
sed -i 's/server 0/#server 0/g' /etc/ntp.conf
sed -i 's/server 1/#server 1/g' /etc/ntp.conf
sed -i 's/server 2/#server 2/g' /etc/ntp.conf
sed -i 's/server 3/#server 3/g' /etc/ntp.conf
sed -i 's/ntp.ubuntu.com/ntp.malmo.se/g' /etc/ntp.conf
ntpdate -s ntp.malmo.se

# Add user kiosk
useradd -m kiosk
echo -e "changeme\nchangeme\n" | passwd kiosk --stdin
usermod -a -G kiosk www-data
adduser kiosk audio

# Reset chrome on restart
touch /etc/init.d/chromereset
sh -c 'echo "rm -rf /home/kiosk/.config/google-chrome" >> /etc/init.d/chromereset'
sh -c 'echo "cp -r /home/itadmin/google-chrome /home/kiosk/.config/" >> /etc/init.d/chromereset'
sh -c 'echo "chown -R kiosk:kiosk /home/kiosk/.config/google-chrome" >> /etc/init.d/chromereset'
sh -c 'echo "rm -rf /home/kiosk/Downloads/*" >> /etc/init.d/chromereset'
chmod +x /etc/init.d/chromereset

# xsession
touch /home/kiosk/.xsession
sh -c 'echo "#!/usr/bin/env bash" >> /home/kiosk/.xsession'
#sh -c 'echo "xsetroot -cursor_name left_ptr" >> /home/kiosk/.xsession'
# todo - check if file exists (for initial start...)
line="sed -i 's/\"exited_cleanly\": false/\"exited_cleanly\": true/' ~/.config/google-chrome/Default/Preferences"
echo $line >> /home/kiosk/.xsession
sh -c 'echo "xsetroot -cursor_name left_ptr" >> /home/kiosk/.xsession'
sh -c 'echo "#xmodmap -e \"keycode 67 = 0×0000\"" >> /home/kiosk/.xsession'
sh -c 'echo "xmodmap -e \"keycode 76 = 0×0000\"" >> /home/kiosk/.xsession'
sh -c 'echo "xmodmap -e \"keycode 95 = 0×0000\"" >> /home/kiosk/.xsession'
sh -c 'echo "xmodmap -e \"keycode 96 = 0×0000\"" >> /home/kiosk/.xsession'
#sh -c 'echo "google-chrome --start-maximized --incognito;" >> /home/kiosk/.xsession'
sh -c 'echo "google-chrome" >> /home/kiosk/.xsession'

# unlock
touch unlock.sh
unlock1="#sed -i -e 's/NODM_ENABLED=true/NODM_ENABLED=false/g' /etc/default/nodm"
unlock2="sed -i 's/xmodmap -e \"keycode 67 = 0×0000\"/#xmodmap -e \"keycode 67 = 0×0000\"/' /home/kiosk/.xsession"
unlock3="sed -i 's/google-chrome --start-maximized --incognito;/google-chrome;/' /home/kiosk/.xsession"
echo $unlock1 >> unlock.sh
echo $unlock2 >> unlock.sh
echo $unlock3 >> unlock.sh
chown itadmin:itadmin unlock.sh

# lock
touch lock.sh
lock1="#sed -i -e 's/NODM_ENABLED=false/NODM_ENABLED=true/g' /etc/default/nodm"
lock2="sed -i 's/#xmodmap -e \"keycode 67 = 0×0000\"/xmodmap -e \"keycode 67 = 0×0000\"/' /home/kiosk/.xsession"
lock3="sed -i 's/google-chrome;/google-chrome --start-maximized --incognito;/' /home/kiosk/.xsession"
echo $lock1 >> lock.sh
echo $lock2 >> lock.sh
echo $lock3 >> lock.sh
chown itadmin:itadmin lock.sh

# copysettings
touch copysettings.sh
copy1="NOW=\$(date +’%Y-%m-%d-%H-%M’)"
echo $copy1 >> copysettings.sh
sh -c 'echo "sudo mv google-chrome google-chrome_$NOW" >> copysettings.sh'
sh -c 'echo "sudo cp -r /home/kiosk/.config/google-chrome /home/itadmin/" >> copysettings.sh'
chown itadmin:itadmin copysettings.sh

# prep nodm
sed -i -e 's/NODM_ENABLED=false/NODM_ENABLED=true/g' /etc/default/nodm
sed -i -e 's/NODM_USER=root/NODM_USER=kiosk/g' /etc/default/nodm
sed -i -e 's/NODM_MIN_SESSION_TIME=60/NODM_MIN_SESSION_TIME=0/g' /etc/default/nodm











