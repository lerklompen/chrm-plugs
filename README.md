chrm-plugs
==========

> Enable third party plugins on Chromium OS (flash, google talk, mp3/4 codecs, pdf viewer)

## Usage
 * `CTRL+ALT+T` to launch crosh
 * Enter `shell` in "crosh"
 * Enter `cd` to open chronos user directory
 * Become root: `sudo su` (enter password, arnoldthebat is "password", hexxeh is "facepunch")

Run the following as root user:

    curl https://raw2.github.com/lerklompen/chrm-plugs/master/chrm-plugs.sh > chrm-plugs;sh chrm-plugs


## Configuration of a Synaptics ClickPad on a ProBook 4320s
 * `CTRL+ALT+T` to launch crosh
 * Enter `shell` in "crosh"
 * Enter `cd` to open chronos user directory
 * Become root: `sudo su`

Run the following as a root user:

    curl https://raw.github.com/lerklompen/chrm-plugs/master/config-clickpad.sh > clickpad.sh ; bash clickpad.sh

