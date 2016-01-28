# graze-web-features

<img src="https://i.imgur.com/Wywm50T.gif" align="right" width="300" />

Get started by installing the [docker toolbox](https://www.docker.com/products/docker-toolbox).

Then just run:

```bash
~$ make install
~$ make serve
~$ HOST=https://www.graze.com make test
```

The password for the VNC connection is `secret`.

### Pass Arguments to Behat

Like so:

```bash
~$ HOST=https://www.graze.com make test -- --help
```
