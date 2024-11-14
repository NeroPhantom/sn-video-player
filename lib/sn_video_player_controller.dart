import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sn_video_player/sn_fullscreen_route.dart';
import 'package:video_player/video_player.dart';

// import 'package:sn_video_player/sn_fullscreen_route.dart';
import 'package:sn_video_player/sn_video_player_controller.dart';

part './sn_fullscreen.part.dart';

class SNVideoPlayerController extends VideoPlayerController {
  SNVideoPlayerController.asset(
    super.dataSource, {
    super.package,
    super.closedCaptionFile,
    super.videoPlayerOptions,
  }) : super.asset();

  SNVideoPlayerController.networkUrl(
    super.url, {
    super.formatHint,
    super.closedCaptionFile,
    super.httpHeaders,
    super.videoPlayerOptions,
  }) : super.networkUrl();

  SNVideoPlayerController.file(
    super.file, {
    super.closedCaptionFile,
    super.httpHeaders,
    super.videoPlayerOptions,
  }) : super.file();

  SNVideoPlayerController.contentUri(
    super.contentUri, {
    super.closedCaptionFile,
    super.videoPlayerOptions,
  }) : super.contentUri();

  bool _isFullscreen = false;

  bool get isFullscreen => _isFullscreen;

  // 设置全屏状态
  Future<void> setFullscreen(
      BuildContext buildContext, bool isFullscreen) async {
    if (_isFullscreen == isFullscreen) {
      // throw Exception('全屏状态未变更 isFullscreen = $isFullscreen');
      return;
    }
    if (isFullscreen) {
      // 设置为全屏
      try {
        showFullScreenVideoPlayer(buildContext);
      } catch (e) {
        rethrow;
      }
    } else {
      // 退出全屏
      Navigator.pop(buildContext);
    }
    _isFullscreen = isFullscreen;
  }
}
