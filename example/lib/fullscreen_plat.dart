import 'package:flutter/material.dart';
import 'package:sn_video_player/abstracts/sn_plat_abstract.dart';

class FullscreenPlat extends SNPlat {
  FullscreenPlat({
    super.key,
    required super.isFullscreen,
  });

  @override
  State<FullscreenPlat> createState() => _FullscreenPlatState();
}

class _FullscreenPlatState extends SNPlatState<FullscreenPlat> {
  @override
  void initState() {
    super.initState();

    controller.addListener(_playerListener);
  }

  // player 监听
  _playerListener() {
    DateTime now = DateTime.now();
    String newStr = now.toIso8601String();

    var value = controller.value;
    debugPrint('Fullscreen --> $newStr'
        'isPlaying: ${value.isPlaying}\n'
        'isBuffering: ${value.isBuffering}\n'
        'isInit:${value.isInitialized}\n');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
            onPressed: () {
              var value = controller.value;
              bool isPlaying = value.isPlaying;
              isPlaying ? controller.pause() : controller.play();
            },
            child: Text(controller.value.isPlaying ? '暂停' : '播放')),
        ElevatedButton(
            onPressed: () {
              controller.isFullscreen = false;
            },
            child: const Text('退出全屏')),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    controller.removeListener(_playerListener);
  }
}