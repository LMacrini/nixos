# My NixOS configuration

You can automatically install this configuration on a new NixOS system by running
```bash
curl https://raw.githubusercontent.com/LMacrini/nixos/refs/heads/main/init.sh | bash
```

You can then switch your configuration with
```bash
sudo nixos-rebuild switch --flake /etc/nixos#default
```
I recommend changing the *networking hostname* (default is "DESKTOP-VKFSNVPI") as well as the *description* for the *user account* (default is "Lionel Macrini")\
Both can be found in */etc/nixos/configuration.nix*

After a reboot, your system should look just like mine.

**Do not try this, it has not been tested yet**\
(Also this is my config for the sake of my convenience,
please don't use it unless you're one of my friends)
