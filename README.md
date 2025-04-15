# A GitHub action to compile Dioxus projects into Android apps

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

## The OpenSSL issue

If the application depends on OpenSSL, its compilation may fail. It's usually the case of `reqwest`-depending application. The easiest way to work around the issue is to switch to Rustls. It acts as a pure Rust OpenSSL alternative. E.g. for `reqwest`:
```toml
# Disabling default features is mandatory as it would otherwise try and use OpenSSL
reqwest = { version = "0.12.15", default-features = false, features = ["rustls-tls"] }
```

## How does this action work?

It is based on a [Ubuntu-based Docker image](Dockerfile) which contains all required dependencies to cross-compile Dioxus projects into Android apps.
The image itself takes a lot of time to build (10 minutes on GitHub workers) and is quite big (~2.5 GB). Besides, as Dioxus Android support is still on its early days, it takes a lot of time to get everything right. Thus, leveraging a pre-built image makes it smoother to compile Android apps!
