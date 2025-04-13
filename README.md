# A simple example to compile Android apps using Docker

## The base image
In order to avoid downloading and building all the dependencies required by [Dioxus](https://dioxuslabs.com/) and Android each time you'd like to build the APK or AAB files, this project uses [a base image](Dockerfile). It is also available as an already-built image on [Docker Hub](https://hub.docker.com/repository/docker/abrikot/dioxus-android-docker-builder).

## How to build the final APK and AAB files?
This repo provides 2 examples of how to compile an Android app using [Dioxus](https://dioxuslabs.com/):
- Either use [the GitHub action](.github/workflows/build-apk.yml)
- Or build your app on the [apk.Dockerfile](apk.Dockerfile) model and dump its content to the disk (`docker build -f apk.Dockerfile -o <output-folder> .`)