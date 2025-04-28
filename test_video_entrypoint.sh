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

#ffmpeg \
#  -re \
#  -f lavfi \
#  -i testsrc=size=1920x1080:rate=60 \
#  -vcodec libx264 \
#  -pix_fmt yuv420p \
#  -rtsp_transport tcp \
#  -f rtsp rtsp://mediamtx:8554/test_input

#ffmpeg \
#  -re \
#  -stream_loop -1 \
#  -i $FILE_NAME \
#  -tune zerolatency \
#  -vcodec copy \
#  -an \
#  -rtsp_transport tcp \
#  -f rtsp rtsp://mediamtx:8554/$STREAM_NAME-0 \
#  -vcodec copy \
#  -an \
#  -rtsp_transport tcp \
#  -f rtsp rtsp://mediamtx:8554/$STREAM_NAME-1 \
#  -vcodec copy \
#  -an \
#  -rtsp_transport tcp \
#  -f rtsp rtsp://mediamtx:8554/$STREAM_NAME-2
#
#
ffmpeg \
  -re \
  -stream_loop -1 \
  -i $FILE_NAME \
  -tune zerolatency \
  -vf "drawtext=fontfile=/usr/share/fonts/noto/NotoSans-Regular.ttf:text='Stack Overflow':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2,drawtext=fontfile=/usr/share/fonts/noto/NotoSans-Regular.ttf:text='Bottom right text':fontcolor=black:fontsize=14:x=w-tw-10:y=h-th-10" \
  -an \
  -rtsp_transport tcp \
  -f rtsp rtsp://mediamtx:8554/$STREAM_NAME-0 \
  -an \
  -rtsp_transport tcp \
  -f rtsp rtsp://mediamtx:8554/$STREAM_NAME-1 \
  -an \
  -rtsp_transport tcp \
  -f rtsp rtsp://mediamtx:8554/$STREAM_NAME-2