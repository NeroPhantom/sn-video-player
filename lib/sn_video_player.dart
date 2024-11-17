import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sn_video_player/sn_video_player_controller.dart';
import 'package:video_player/video_player.dart';
// import 'package:sn_video_player/sn_video_player_web.dart';

class SnVideoPlayer extends StatefulWidget {
  static void registerWith(dynamic registrar) {
    if (kIsWeb) {
      // SnVideoPlayerWeb.registerWith(registrar);
    }
  }

  final SNVideoPlayerController controller;

  // 初始化设置全屏状态
  final bool isFullscreen;

  // main plat
  final Widget? plat;

  // fullscreen plat
  final Widget? fullscreenPlat;

  const SnVideoPlayer(
    this.controller, {
    super.key,
    this.isFullscreen = false,
    this.plat,
    this.fullscreenPlat,
  });

  @override
  State<SnVideoPlayer> createState() => _SnVideoPlayer();
}

class _SnVideoPlayer extends State<SnVideoPlayer> {
  @override
  void initState() {
    super.initState();

    widget.controller
      ..isFullscreen = widget.isFullscreen
      ..plat = widget.plat
      ..fullscreenPlat = widget.fullscreenPlat;
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.parentContext ??= context;
    return Stack(
      children: [
        VideoPlayer(widget.controller),
        if (widget.plat != null) widget.plat!,
      ],
    );
  }
}
