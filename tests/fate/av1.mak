# Tests that transcoding MPEG4 WEBM to AV1 (libaom-av1) keeps HDR10+ metadata.
FATE_AV1_FFMPEG_FFPROBE-$(call TRANSCODE, LIBAOM_AV1 MPEG4, WEBM IVF) += fate-libaom-write-hdr10-plus
fate-libaom-write-hdr10-plus: CMD = transcode webm $(TARGET_SAMPLES)/mkv/hdr10_plus_vp9_sample.webm ivf "-map 0 -c:v libaom-av1 -cpu-used 8" "" "-show_frames -show_entries frame=side_data_list"

# Tests that transcoding AV1 (libaom-av1) to AV1 (libaom-av1) keeps HDR10+ metadata.
FATE_AV1_FFMPEG_FFPROBE-$(call ENCDEC, LIBAOM_AV1 LIBAOM_AV1, IVF IVF) += fate-libaom-hdr10-plus
fate-libaom-hdr10-plus: CMD = transcode ivf $(TARGET_SAMPLES)/av1/metadata_hdr10_plus.ivf ivf "-map 0 -c:v libaom-av1 -cpu-used 8" "" "-show_frames -show_entries frame=side_data_list" "" "" "-c:v libaom-av1"

FATE_SAMPLES_FFMPEG_FFPROBE += $(FATE_AV1_FFMPEG_FFPROBE-yes)

fate-av1: $(FATE_AV1_FFMPEG_FFPROBE-yes)
