FROM ubuntu:24.04

RUN apt update  \
    && apt install -y unzip default-jre libwebkit2gtk-4.1-dev build-essential curl wget file libxdo-dev libssl-dev libayatana-appindicator3-dev librsvg2-dev pkg-config
RUN curl --proto '=https' --tlsv1.2 -sSf -o install-rust.sh https://sh.rustup.rs && chmod +x install-rust.sh && ./install-rust.sh -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android
RUN cargo install cargo-binstall
RUN cargo binstall dioxus-cli

RUN mkdir -p android-sdk/cmdline-tools
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-13114758_latest.zip
RUN unzip commandlinetools-linux-13114758_latest.zip && mv cmdline-tools android-sdk/cmdline-tools/latest
ENV JAVA_HOME='/usr/lib/jvm/java-21-openjdk-amd64/'
ENV ANDROID_HOME="/android-sdk/cmdline-tools/latest"
ENV PATH="$PATH:$ANDROID_HOME/bin:$ANDROID_HOME/emulator"

RUN yes | sdkmanager "emulator"
RUN yes | sdkmanager "ndk;28.0.13004108"
RUN yes | sdkmanager "cmake;3.6.4111459"
RUN yes | sdkmanager "platforms;android-33"
RUN yes | sdkmanager "build-tools;34.0.0"

ENV NDK_HOME="/android-sdk/ndk/28.0.13004108"
ENV PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig"

RUN mkdir app
WORKDIR app
COPY Cargo.lock Cargo.toml Dioxus.toml ./
COPY ./assets/ ./assets/
COPY ./src/ ./src/

ENV ANDROID_HOME="/android-sdk/"

RUN dx bundle --platform android