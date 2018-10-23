# pgdvs-docker

Feel free to submit Pull Requests and report any Issues that you may have found.

## Python-GoogleDrive-VideoStream

A Emby Google Drive File strm service.

https://github.com/ddurdle/Python-GoogleDrive-VideoStream

![organizr](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/organizr-icon.png)

## Usage

```
docker create \
  --name=pgdvs \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 9988:9988 \
  rxwatcher/pgdvs-docker
```

## Parameters

The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container. So `-p 8080:80` would expose port 80 from inside the container to be accessible from the host's IP on port 8080 and `http://192.168.x.x:8080` would show you what's running INSIDE the container on port 80.

* `-p 9988` - The port(s)
* `-v /config` - Mapping the config files for Organizr
* `-e PGID` Used for GroupID - see below for explanation
* `-e PUID` Used for UserID - see below for explanation

It is based on Alpine Linux with an s6 overlay.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application
This package replaces GoogleDrive-VideoStream (which was written in PHP).

This plugin is a direct port of Google Drive plugin for KODI. The purpose of this plugin is to service content delivered in Google Drive plugin for KODI through any HTML5 client.

Use cases:

export-and-import of STRM files for playback in Emby-Server
playback of media through Safari and Chrome on iOS (iphone, ipod touch, ipad)
playback of media through Firefox and Chrome on Android devices (tv players, phone, tablets)
playback of media through any web browser on Windows, Mac OS, Linux
playback of media through media player (such as VLC, KODI) that supports HTTPS streams
Current status - alpha testing.

Current status of items:

support for encfs (planned)
SRT / CC (planning stage)
cache and offline playback (planning stage)
Windows and Mac OS ready to playback without installing Python, coming soon. Right now Linux based source package is available (python required, available on all Linux systems)

At this stage, you cannot enroll an account with this application or modify user settings. You MUST import these from a KODI install. I am only supporting alpha testing with users who have used the Google Drive plugin for KODI previously.

To start the scheduler only, run:

python scheduler.py

The default dbmfile is ./gdrive.db and the default port to run on is 9988. You can override these by running:

python scheduler.py

To start the media server with no scheduler, run:

python noscheduler.py

The default dbmfile is ./gdrive.db and the default port to run on is 9988. You can override these by running:

python noscheduler.py

To start the media server with scheduler, run:

python default.py

The default dbmfile is ./gdrive.db and the default port to run on is 9988. You can override these by running:

python default.py

To use SSL using a SSL certificate (.pem file) you provide, change the port parameter (if required) and provide a third argument of the .pem file

python default.py

example:

python default.py ./gdrive.db 443 ./mycert.pem

You can use the setting.xml from either gdrive or gdrive-testing plugin for KODI. You can import this using setup.py. This is not required as you can setup the instance using the settings pane within the web interface.

A NOTE ABOUT STRM FILES:

You can import STRM files from a KODI install, but you will need to update the URL in them to resolve to the VideoStream:

A perl script that recursively updates files in a directory which has contents matched to a specified string, updating the match with a replacement can be found here: https://github.com/ddurdle/PERL-Misc_Scripts/blob/master/grep/recursive_replace.pl

You can run it such as: perl recursive_replace.pl -d directory_with_path -g "plugin://plugin.video.gdrive/" -r "http://localhost:9988/default"

which will navigate through "directory_with_path" looking for files with contents "plugin://plugin.video.gdrive/" and replacing it with "http://localhost:9988/default". This would change the STRM files to resolve to an install of VideoStream running on localhost port 9988. You can replace this with whatever applies to your situation.

You can always re-generate the STRM files using VideoStream using the web interface. When doing such, you have the option to override the protocol (http://), hostname and port.
