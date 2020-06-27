# Github self-hosted runner Dockerfile configuration

based on https://github.com/SanderKnape/github-runner

## Building the container

`docker build -t github-runner-vagrant .`

## Features

* Repository runners
* Organizational runners
* Labels
* Graceful shutdown

## Examples

Register a runner to a repository.
```
docker run --privileged -d --restart always -v /dev/vboxdrv:/dev/vboxdrv -e HOME=/home/docker \
-e GITHUB_OWNER=username-or-organization -e GITHUB_REPOSITORY=my-repository -e GITHUB_PAT=[PAT] \
-v $PWD:/home/docker/vagrant karthickk/github-runner-vagrant
```

Create an organization-wide runner.

```sh
docker run --privileged -d --restart always -v /dev/vboxdrv:/dev/vboxdrv -e HOME=/home/docker \
-e GITHUB_OWNER=username-or-organization -e GITHUB_PAT=[PAT] \
-v $PWD:/home/docker/vagrant karthickk/github-runner-vagrant
```


