import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sn_video_player/abstracts/sn_player_controler_abstract.dart';
import 'package:sn_video_player/fullscreen/sn_fullscreen_route.dart';
// import 'package:sn_video_player/sn_video_player_web.dart';
import 'package:video_player/video_player.dart';

part 'controller/sn_v_p_ctrl_func.part.dart';
part 'fullscreen/sn_fullscreen.part.dart';

class SNVideoPlayerController extends VideoPlayerController
    implements SNPlayerControllerAbstract {
  static void registerWith(dynamic registrar) {
    if (kIsWeb) {
      // SnVideoPlayerWeb.registerWith(registrar);
    }
  }

  // 初始化：资源加载
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

  // 使用全屏功能需要设置，不能为空
  BuildContext? _parentContext;

  BuildContext? get parentContext => _parentContext;

  set parentContext(BuildContext? value) {
    _parentContext ??= value;
  }

  // 初始化为false，非全屏状态
  bool _isFullscreen = false;

  // main plat
  Widget? plat;

  // fullscreen plat
  Widget? fullscreenPlat;

  // 获取全屏状态
  bool get isFullscreen => _isFullscreen;

  @override
  play() async {
    super.play();
    debugPrint('[SN] start play!');
  }

  @override
  pause() async {
    super.pause();
    debugPrint('[SN] pause!');
  }

  // 设置全屏状态
  set isFullscreen(bool isFullscreen) {
    // assert(parentContext != null, '全屏功能需要设置parentContext');
    if (parentContext == null) return;

    if (_isFullscreen == isFullscreen) {
      // throw Exception('全屏状态未变更 isFullscreen = $isFullscreen');
      return;
    }

    if (isFullscreen) {
      // 设置为全屏
      try {
        showFullScreenVideoPlayer(
          parentContext!,
          controller: this,
          fullscreenPlat: fullscreenPlat,
        );
      } catch (e) {
        debugPrint(e.toString());
        rethrow;
      }
    } else {
      // 退出全屏
      Navigator.pop(parentContext!);
    }

    // 更新值
    _isFullscreen = isFullscreen;
  }

  // 自动切换播放和暂停
  @override
  Future<void> playOrPause() async {
    value.isPlaying ? await pause() : await play();
  }

  // 判断是否为静音状态
  @override
  bool isMuted() {
    return value.volume == 0;
  }

  // 判断是否播放到结尾
  @override
  bool isAtEnd() {
    return value.position >= value.duration;
  }
}
