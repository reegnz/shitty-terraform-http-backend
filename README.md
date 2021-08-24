# A shitty terraform http backend

Tools used:
* [shell2http](https://github.com/msoap/shell2http)
* [jq](https://stedolan.github.io/jq/)
* bash
* sed
* cat
* stat
* rm

And of course terraform to test it.

## Usage

Run the server with `./serve.sh`

Configure terraform as seen in [backend.tf](./backend.tf).
The part after `/terraform/state/` and `/terraform/lock/state` can be anything,
I'm using a UUID.

The server can be used with or without locks.
