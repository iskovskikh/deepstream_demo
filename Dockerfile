

FROM nvcr.io/nvidia/deepstream:7.1-triton-multiarch

# To get video driver libraries at runtime (libnvidia-encode.so/libnvcuvid.so)
# ENV NVIDIA_DRIVER_CAPABILITIES $NVIDIA_DRIVER_CAPABILITIES,video

RUN add-apt-repository ppa:deadsnakes/ppa

RUN apt-get -y update && apt-get install -y --no-install-recommends \
#     python3.13 \
#     python3-gi \
#     python-gst-1.0 \
#     libgirepository1.0-dev \
#     libcairo2-dev \
#     gir1.2-gstreamer-1.0

#     python3.13-full \
#     libssl3 \
#     libssl-dev \
#     libgstreamer1.0-0 \
#     gstreamer1.0-tools \
    python3-gi \
    python3-gi-cairo \
    gir1.2-gst-rtsp-server-1.0 \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    libv4l-dev
#     libx264-dev
#     gstreamer1.0-libav \
#     libgstreamer-plugins-base1.0-dev \
#     libgstrtspserver-1.0-0 \
#     libjansson4 \
#     libyaml-cpp-dev

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /root/apps

RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project

COPY ./app ./app

COPY ./uv.lock ./uv.lock
COPY ./pyproject.toml ./pyproject.toml


# COPY ./uv.lock ./uv.lock
# COPY ./pyproject.toml ./pyproject.toml
#
# RUN --mount=type=cache,target=/root/.cache/uv \
#     uv sync --frozen --no-install-project
#
# COPY ./app ./app

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen

CMD ["python3", "./app/main.py"]