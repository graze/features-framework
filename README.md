# graze-features

This is an _example_ framework for a docker based configuration of [behat](https://github.com/Behat/Behat#readme) and [selenium](http://docs.seleniumhq.org/); decoupled from the web application it's testing.

<img src="https://i.imgur.com/Wywm50T.gif" align="right" width="450" />

## Getting Started

Get started by installing the [docker toolbox](https://www.docker.com/products/docker-toolbox).

Then just run:

```bash
~$ make install
~$ make serve
~$ make test HOST=https://www.graze.com
```

## Connecting via VNC

<img src="https://i.imgur.com/n54iybM.png" align="right" width="300" />

The password for the VNC connection is `secret`.

On OSX you can use the Screen Sharing app to connect to the server.

## Passing Arguments to Behat

The format is `make test -- <arguments>`. To append new snippets to your feature context for example, run:

```bash
~$ make test HOST=https://www.graze.com -- --append-snippets
```
