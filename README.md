
## Transmission Bittorrent Client - Docker Image (Multiarch)
===
### Building the image

In order to build the image, make sure you have docker or podman installed and then

``` podman build -t transmission .```

### Running the container

Point the /LOCAL_PATH_DOWNLOAD_FILES and /LOCAL_PATH_INCOMPLETE_DOWNLOAD_FILES to your local diretory where the torrents will be stored

 ```podman run -d --restart=always --name transmission -v /LOCAL_PATH_DOWNLOAD_FILES:/download -v /LOCAL_PATH_INCOMPLETE_DOWNLOAD_FILES:/download/incomplete -p 9091:9091 -p 51413:51413 -p 51413:51413/udp  transmission```
