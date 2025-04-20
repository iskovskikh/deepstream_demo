import sys
import gi

gi.require_version('Gst', '1.0')
gi.require_version('GstRtspServer', '1.0')

from gi.repository import Gst, GstRtspServer, GLib




def on_message(bus, message, loop):
    msg_type = message.type
    if msg_type == Gst.MessageType.EOS:
        print("End of stream")
        loop.quit()
    elif msg_type == Gst.MessageType.ERROR:
        err, debug = message.parse_error()
        print(f"Error: {err}, Debug: {debug}")
        loop.quit()
    return True

def create_pipeline():
    Gst.init(None)
    Gst.debug_set_active(True)
    Gst.debug_set_default_threshold(Gst.DebugLevel.WARNING)

    # pipeline_str = """
    #     videotestsrc pattern=smpte-rp-219 !
    #     video/x-raw,width=2560,height=1440,framerate=60/1 !
    #     nvvideoconvert !
    #     nvv4l2h264enc bitrate=800000 !
    #     rtspclientsink protocols=tcp location=rtsp://mediamtx:8554/test
    # """

    pipeline_str = """
        rtspsrc location=rtsp://mediamtx:8554/test_input !
        application/x-rtp, media=video, encoding=H264 !
        rtph264depay !
        decodebin !
        nvvideoconvert !
        mirror mode=right !
        nvvideoconvert !
        nvv4l2h264enc bitrate=800000 !
        rtspclientsink protocols=tcp location=rtsp://mediamtx:8554/test_output
    """

    return Gst.parse_launch(pipeline_str)


def main():
    pipeline = create_pipeline()
    if not pipeline:
        print("Failed to create pipeline")
        return

    loop = GLib.MainLoop()
    bus = pipeline.get_bus()
    bus.add_signal_watch()
    bus.connect("message", on_message, loop)

    pipeline.set_state(Gst.State.PLAYING)
    print("Pipeline started")

    try:
        loop.run()
    except KeyboardInterrupt:
        pass
    finally:
        pipeline.set_state(Gst.State.NULL)
        print("Pipeline stopped")

if __name__ == '__main__':
    main()