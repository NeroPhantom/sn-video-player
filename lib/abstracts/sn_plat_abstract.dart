import 'package:flutter/material.dart';
import 'package:sn_video_player/sn_video_player.dart';
import 'package:sn_video_player/controller/sn_video_player_controller.dart';

abstract class SNPlat extends StatefulWidget {
  final bool isFullscreen;
  const SNPlat({
    super.key,
    required this.isFullscreen,
  });
}

abstract class SNPlatState<T extends SNPlat> extends State<T> {
  late SNVideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    // 判断父 Widget 类型
    final parent = context.findAncestorWidgetOfExactType<SnVideoPlayer>();
    if (parent == null) {
      throw FlutterError(
        "必须作为 SNVideoPlayer 的元素。",
      );
    }

    controller = parent.controller;
    controller.isFullscreen = widget.isFullscreen;
  }
}
