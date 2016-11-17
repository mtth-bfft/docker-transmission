# docker-transmission

A lightweight (~10MiB) and standalone transmission server based on Alpine Linux. As stateless as possible, no VPNs, no need to give it additional capabilities.

## How to customize

You might want to create your own container based on this one, to `COPY` a file over my `/etc/transmission/settings.json`, which just contains sane defaults. They are transmission's defaults, except for the authentication which is entirely disabled and left to the outside of the container (since Transmission's plaintext HTTP auth is just horribly unsafe).

Also, if you don't intend to use any of Docker's rollout features or if you don't care about adding dependencies to the outside of your containers, you can just add a volume option: `-v ~/your/settings.json:/etc/transmission/settings.json`.

## How to run

The only stateful volume you might want is the `/data/downloads` containing completed/incomplete torrents.

Just be careful where you expose the container's 9091 TCP port: Transmission's auth is unsafe, so, add an HTTPs reverse proxy or bind it on localhost and use an SSH tunnel.

    docker run -d --name transmission --restart=unless-stopped -p 51413:51413 -p 127.0.0.1:9091:9091 -v /your/folder/:/data/downloads mtthbfft/transmission
    
## Contribute

Help by telling me (@mtth_bfft) if you find bugs or have ideas on how to improve this.
