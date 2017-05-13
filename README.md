# docker-transmission

A lightweight (~7MiB) standalone transmission server based on Alpine Linux. As stateless as possible, no VPNs, no need to give it additional capabilities.

## Settings

You might want to create your own container based on this one, to `COPY` a file over my `/etc/transmission/settings.json`, which just contains sane defaults. They are transmission's defaults, except for the authentication which is entirely disabled and left to the outside of the container (since Transmission's plaintext HTTP auth is just horribly unsafe anyway).

Also, if you don't intend to use any of Docker's rollout features or if you don't care about adding dependencies to the outside of your containers, you can just mount your settings over the default ones: `-v ~/your/settings.json:/etc/transmission/settings.json`.

## Running

The only stateful volume you might want to give it is `/data/downloads` (settable through `-e complete_dir=/other/path`) containing complete downloads.

**Be careful where you expose the container's 9091 TCP port**: Transmission's auth is unsafe, so, add an HTTPS reverse proxy or bind it on localhost and use an SSH tunnel.

An example of run options:

	docker run -d --restart=unless-stopped --name transmission --user 1001 -p 51413:51413 -p 127.0.0.1:9091:9091 -v /srv/ftp/:/data/download/ mtthbfft/transmission
    
## Contribute

Pull requests welcome. Help by telling me if you find bugs or have ideas on how to improve this.
