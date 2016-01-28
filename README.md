# graze-web-features

This is an _example_ framework for a docker based configuration of [behat](https://github.com/Behat/Behat#readme) and [selenium](http://docs.seleniumhq.org/); decoupled from the web application it's testing.

<img src="https://i.imgur.com/Wywm50T.gif" align="right" width="450" />

## Getting Started

Get started by installing the [docker toolbox](https://www.docker.com/products/docker-toolbox).

Then just run:

```bash
~$ make install
~$ make serve
~$ HOST=https://www.graze.com make test
```

The password for the VNC connection is `secret`.

### Passing Arguments to Behat

The format is `make test -- <arguments>`. To print the usage information for example, run:

```bash
~$ HOST=https://www.graze.com make test -- --help
```
