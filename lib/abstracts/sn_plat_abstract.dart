import 'package:flutter/material.dart';
import 'package:sn_video_player/sn_video_player.dart';
import 'package:video_player/video_player.dart';

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
    controller.addListener(_listenter);
  }

  _listenter() {
    videoUpdate(controller.value);
  }

  videoUpdate(VideoPlayerValue value) {}

  @override
  void dispose() {
    super.dispose();

    controller.removeListener(_listenter);
  }
}
