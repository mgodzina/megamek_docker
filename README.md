# megamek_docker
Megamek dedicated server dockerfile. \
The image creates persistent volume for custom MegaMek assets.

# Building image
You need to have Docker installed. The image can be built using the following command. \
Replace the version number in the VERSION argument and in tag (megamek:0.49.14) with a version of MegaMek you want to run. \
(note the dot at the end)
```shell
docker build --build-arg VERSION=0.49.14 -t megamek:0.49.14 .
```

# Running container

You can run the container using the following command. \
Replace host_port with a desired port for your server. \
You can use the default port 2346

```shell
docker run -p host_port:2346 megamek:0.49.14
```

# Adding custom assets
You can add custom maps and other assets to the mounted volume of the container.

Here is a quick and dirty way to find the path of the volume: \
List all containers with megamek tag to find the ID - it will be the number at the beginning of the line.
```shell
docker ps | grep megamek
```

example output, in which `093b349b150a` is the ID:
```shell
093b349b150a   megamek:0.49.14                       "/__cacert_entrypoin…"   13 minutes ago   Up 13 minutes          0.0.0.0:2346->2346/tcp, :::2346->2346/tcp                                                                                                                                                                                                            
```

Replace ID in the following command with the one you found in the previous command.
```shell
docker inspect ID | grep Source
```

example output, it states the path that you need to navigate to in order to add assets:
```shell
                "Source": "/var/lib/docker/volumes/39120f756485ee906566204ffa50f5006284a9b595a3fab1f417cf4774dbb14a/_data",                                                                                                                                                                                                        
```
