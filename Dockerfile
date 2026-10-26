FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install Java 21, Maven, and minimal build tools.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        openjdk-21-jdk \
        maven \
        git \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

# Copy repository into the container.
COPY . .

# Use Maven wrapper if present (after normalizing CRLF), otherwise fallback to system Maven.
RUN if [ -f ./mvnw ]; then \
      sed -i 's/\r$//' ./mvnw; \
      chmod +x ./mvnw; \
      ./mvnw -B clean verify --file pom.xml -Dsysml.build-tag=nightly-$(date +'%Y%m%d') -Dsysml.metadata-tag=$(date +'%Y%m%d'); \
    else \
      mvn -B clean verify --file pom.xml -Dsysml.build-tag=nightly-$(date +'%Y%m%d') -Dsysml.metadata-tag=$(date +'%Y%m%d'); \
    fi

RUN if [ -f ./mvnw ]; then ./mvnw -B package -DskipTests=true; else mvn -B package -DskipTests=true; fi