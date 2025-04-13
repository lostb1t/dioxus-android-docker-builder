FROM ubuntu:24.04

RUN apt update  \
    && apt install -y unzip default-jre libwebkit2gtk-4.1-dev build-essential curl wget file libxdo-dev libssl-dev libayatana-appindicator3-dev librsvg2-dev pkg-config \
    && curl --proto '=https' --tlsv1.2 -sSf -o install-rust.sh https://sh.rustup.rs \
    && chmod +x install-rust.sh \
    && ./install-rust.sh -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android \
    && cargo install cargo-binstall \
    && cargo binstall dioxus-cli \
    && mkdir -p android-sdk/cmdline-tools \
    && curl -o commandlinetools.zip https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip \
    && unzip commandlinetools.zip && mv cmdline-tools android-sdk/cmdline-tools/latest
ENV JAVA_HOME='/usr/lib/jvm/java-21-openjdk-amd64/' \
    ANDROID_HOME="/android-sdk" \
    PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator"

RUN yes | sdkmanager "emulator" "ndk;28.0.13004108" "cmake;3.6.4111459"

ENV NDK_HOME="/android-sdk/ndk/28.0.13004108" \
    PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig"

RUN mkdir app
WORKDIR app
COPY Cargo.lock Cargo.toml Dioxus.toml ./
COPY ./assets/ ./assets/
COPY ./src/ ./src/

RUN dx bundle --platform android
