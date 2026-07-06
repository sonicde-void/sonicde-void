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
    printf "repository=https://github.com/sonicde-void/packages/releases/latest/download/\n" | sudo tee /etc/xbps.d/99-repository-sonicde.conf
    ```

3. Synchronize the repository and accept the fingerprint (Y):

    ```shell
    sudo xbps-install -S
    ```

## Manual build

1. Clone both this repository and [void-packages](https://github.com/void-linux/void-packages):

    ```shell
    git clone https://github.com/sonicde-void/packages.git
    git clone https://github.com/void-linux/void-packages.git
    ```

2. Copy the template files into `void-packages`:

    ```shell
    cp -r packages/srcpkgs/* void-packages/srcpkgs/
    ```

3. Bootstrap the build system:

    ```shell
    ./xbps-src binary-bootstrap
    ```

4. Build the desired packages:

    ```shell
    ./xbps-src pkg sonic-win sonic-workspace ...
    ```

5. Install the built packages:

    ```shell
    sudo xbps-install --repository /hostdir/binpkgs/ sonic-win sonic-workspace ...
    ```
