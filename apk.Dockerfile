FROM abrikot/dioxus-android-docker-builder:main

# Copy the sources
COPY Cargo.lock Cargo.toml Dioxus.toml ./
COPY ./assets/ ./assets/
COPY ./src/ ./src/

# Build the app
RUN dx bundle --platform android
