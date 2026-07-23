<div align="center">

<img width="480" height="auto" alt="SonicDE-Void" src="img/sonic-void.png" />

# SonicDE for Void Linux [![Void Linux](https://img.shields.io/badge/Void_Linux-%23458161.svg?style=plastic&logo=voidlinux&logoColor=white)](#)

</div>

## Usage

1. Make sure xbps.d directory exists:

    ```shell
    sudo mkdir -p /etc/xbps.d
    ```

2. Create config file and add repository:

    ```shell
    printf "repository=https://github.com/sonicde-void/sonicde-void/releases/latest/download/\n" | sudo tee /etc/xbps.d/99-repository-sonicde.conf
    ```

3. Synchronize the repository and accept the fingerprint (Y):

    ```shell
    sudo xbps-install -S
    ```

## Manual build

For manual build follow Void Linux official documentation: [void-packages](https://github.com/void-linux/void-packages):
