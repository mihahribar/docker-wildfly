# Docker container for Wildfly

Docker container for the [Wildfly](http://wildfly.org) application server. Based on default [jboss container](https://github.com/jboss/dockerfiles/tree/master/wildfly), but built with ubuntu and a few project tweaks.

## Usage

Boot in standalone mode

```
docker run -it mihahribar/wildfly
```

Boot in domain mode

```
docker run -it mihahribar/wildfly /opt/wildfly/bin/domain.sh -b 0.0.0.0 -bmanagement 0.0.0.0
```
