![SonicDE on Arch Linux](./docs/img/screenshot.jpg)

# SonicDE Packages for Void Linux Systems [![Void Linux](https://img.shields.io/badge/Void_Linux-%23458161.svg?style=plastic&logo=voidlinux&logoColor=white)](#)

This third-party repository provides [SonicDE](https://sonicde.org) x86_64 binary packages for [Void Linux](https://voidlinux.org)-based distributions. SonicDE, or the Sonic Desktop Environment, aims to preserve and improve the X11-specific aspects of KDE. You can learn more about SonicDE at [sonicde.org](https://sonicde.org/).

The packages of this repository are known to work with [Void Linux](https://voidlinux.org), [LazyLinux](https://lazylinuxos.github.io). The functionality needs to be verified on other derivatives.

## Installing SonicDE

### Adding the repository

Make sure xbps.d directory exists:

```shell
sudo mkdir -p /etc/xbps.d
```

Create config file and add repository:

```shell
printf "repository=https://github.com/sonicde-void/sonicde-void/releases/latest/download/\n" | sudo tee /etc/xbps.d/99-repository-sonicde.conf
```

Synchronize the repository and accept the fingerprint (Y):

```shell
sudo xbps-install -S
```

Install SonicDE itself by installing the `sonicde-meta` package:

```shell
sudo xbps-install sonicde-meta
```

The included packages will replace any of their installed KDE counterparts. When asked, just answer with `y`.

### Manual build

For manual build follow Void Linux official documentation: [void-packages](https://github.com/void-linux/void-packages).

## Getting in Contact

Please report any enhancement requests or issues with this repository at [Issues · sonicde-void/sonicde-void](https://github.com/sonicde-void/sonicde-void/issues). In case you need help, want to report success or talk about other aspects, please also check the official SonicDE channels.

<img src="./docs/icons/bluesky.svg">&nbsp;[Bluesky](https://bsky.app/profile/sonicdesktop.bsky.social)&nbsp; <img src="./docs/icons/discord.svg">&nbsp;[Discord](https://discord.gg/cNZMQ62u5S) &nbsp; <img src="./docs/icons/mastodon.svg">&nbsp;[Mastodon](https://mastodon.social/@sonicdesktop) &nbsp; <img src="./docs/icons/matrix.svg">&nbsp;[Matrix](https://matrix.to/#/#sonicdesktop:matrix.org) &nbsp; <img src="./docs/icons/oftc.svg">&nbsp;[OFTC IRC](https://webchat.oftc.net/?channels=sonicde%2Csonicde-devel%2Csonicde-dist&uio=MT11bmRlZmluZWQb1) &nbsp; <img src="./docs/icons/telegram.svg">&nbsp;[Telegram](https://t.me/sonic_de) &nbsp; <img src="./docs/icons/x.svg">&nbsp;[X (Twitter)](https://x.com/SonicDesktop)
