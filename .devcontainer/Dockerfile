FROM ubuntu:22.04

# Avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages and dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    wget \
    leiningen \
    openjdk-17-jdk \
    cloc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install code-maat
RUN mkdir -p /usr/local/code-maat \
    && cd /usr/local/code-maat \
    && wget https://github.com/adamtornhill/code-maat/releases/download/v1.0.3/code-maat-1.0.3-standalone.jar \
    && ln -s /usr/local/code-maat/code-maat-1.0.3-standalone.jar /usr/local/bin/code-maat.jar

# Create a convenience script to run code-maat
RUN echo '#!/bin/bash\njava -jar /usr/local/code-maat/code-maat-1.0.3-standalone.jar "$@"' > /usr/local/bin/code-maat \
    && chmod +x /usr/local/bin/code-maat

# Create mount point for code directory
RUN mkdir -p /workspaces/crimebox/code && chmod 777 /workspaces/crimebox/code

# Setup workspace
WORKDIR /workspace

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH 