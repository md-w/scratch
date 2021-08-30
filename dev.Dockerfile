FROM ubuntu:20.04
RUN DEBIAN_FRONTEND=noninteractive apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y locales 

RUN DEBIAN_FRONTEND=noninteractive apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y subversion git curl wget \
    ninja-build build-essential gdb python3-tk python3-pip python3-dev \
    unzip ffmpeg libgtk-3-dev zip openjdk-8-jdk

RUN echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
  && curl https://bazel.build/bazel-release.pub.gpg | apt-key add - && DEBIAN_FRONTEND=noninteractive apt update && apt-get install -y bazel

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN pip3 install -U pip

RUN pip install protobuf

RUN wget -c https://dl.google.com/go/go1.17.linux-amd64.tar.gz -O - | tar -xz -C /usr/local

# RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

RUN go install github.com/bazelbuild/buildtools/buildifier@latest

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

RUN groupmod --gid $USER_GID $USERNAME \
    && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME