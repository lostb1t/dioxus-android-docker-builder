# A simple example to compile Android apps using Docker

## Using the composite action

It's now easier than ever to build an APK or AAB using [Dioxus](https://dioxuslabs.com/)! Simply use the following action:
```yaml
name: Build APK & AAB
on:
  push:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: maxence-cornaton/dioxus-android-docker-builder@0.2
```