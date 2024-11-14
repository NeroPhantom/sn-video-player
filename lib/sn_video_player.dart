import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:sn_video_player/sn_video_player_controller.dart';
import 'package:video_player/video_player.dart';

import 'sn_video_player_platform_interface.dart';

class SnVideoPlayer extends StatefulWidget {
  final SNVideoPlayerController controller;
  // 设置全屏状态
  final bool isFullscreen;

  const SnVideoPlayer(
    this.controller, {
    super.key,
    this.isFullscreen = false,
  });

  @override
  State<SnVideoPlayer> createState() => _SnVideoPlayer();
}

class _SnVideoPlayer extends State<SnVideoPlayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 150,
      child: Stack(
        children: [
          VideoPlayer(widget.controller),
        ],
      ),
    );
  }
}
