# Jedi Knight - Jedi Academy Dedicated Server & JA+


**!!You need the original asset files for this to work!!**


Host your own Jedi Knight - Jedi Academy Server with JA+ preinstalled!

To start, copy the 4 assset files (asset0.pk3, asset1.pk3, asset2.pk3, asset3.pk3) files from the GameData/base folder of the game to any directory on your host, eg ~/ja/assets.

Optionally, create a new server.cfg in a different directory, eg ~/ja/japluscfg.

*For config reference, download the server files at https://jkhub.org/files/file/953-ja-server-side/ and check the readme!*


### Starting with the default config

docker run -d -p 29070:29070/udp -v ~/ja/assets/:/ja/assets/ --name jka_server tiffi/jka-japlus 

This starts a server "server name" on the map mp/ffa5 for 14 players.

### Starting with a custom config (recommended)

docker run -d -p 29070:29070/udp -v ~/ja/assets/:/ja/assets/ **-v ~/ja/japluscfg/:/ja/japluscfg/** --name jka_server tiffi/jka-japlus

This starts a server with your custom config. 

### Connecting to a server

To connect to your server, you need to add the server IP to your favorites, as the original server browser is down.

## Disclaimer

I tested this with 3 friends on a server and noticed nothing out of the ordinary, but I cannot and will not provide any support or make any promises :)

#### Reference

- Container directory for assets: /ja/assets/
- Container directory for server.cfg: /ja/japluscfg
- Exposes UDP port 29070. You can map this to any port, though you need to specify any different port when you add this server to your favorites.

Files used: 
- https://jkhub.org/files/file/953-ja-server-side/
- https://jkhub.org/files/file/390-jedi-academy-dedicated-server-for-linux/
