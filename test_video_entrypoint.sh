#!/usr/bin/env bash

#ffmpeg \
#  -re \
#  -f lavfi \
#  -i testsrc=size=720x404:rate=59.94 \
#  -f lavfi \
#  -i sine=frequency=400 \
#  -vcodec libx264 \
#  -pix_fmt yuv420p \
#  -acodec aac -ar 24000 \
#  -rtsp_transport tcp \
#  -f rtsp rtsp://mediamtx:8554/123

ffmpeg \
  -re \
  -f lavfi \
  -i testsrc=size=1920x1080:rate=60 \
  -vcodec libx264 \
  -pix_fmt yuv420p \
  -rtsp_transport tcp \
  -f rtsp rtsp://mediamtx:8554/test_input