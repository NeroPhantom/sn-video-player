import 'package:flutter/material.dart';
import 'package:sn_video_player/abstracts/sn_plat_abstract.dart';
import 'package:video_player/video_player.dart';

class Plat extends SNPlat {
  Plat({
    super.key,
    required super.isFullscreen,
  });

  @override
  State<Plat> createState() => _PlatState();
}

class _PlatState extends SNPlatState<Plat> {
  @override
  void initState() {
    super.initState();

    // 第二种方式
    controller.addListener(_playerListener);
  }

  // player 监听
  _playerListener() {
    DateTime now = DateTime.now();
    String newStr = now.toIso8601String();

    var value = controller.value;
    debugPrint('NormScreen -> $newStr'
        'isPlaying: ${value.isPlaying}\n'
        'isBuffering: ${value.isBuffering}\n'
        'isInit:${value.isInitialized}\n');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    debugPrint(size.toString());

    return Stack(children: [
      Center(
        child: ElevatedButton(
            onPressed: () {
              var value = controller.value;
              bool isPlaying = value.isPlaying;
              isPlaying ? controller.pause() : controller.play();
            },
            child: Text(controller.value.isPlaying ? '暂停' : '播放')),
      ),
      Positioned(
        bottom: 0,
        right: 0,
        child: ElevatedButton(
            onPressed: () {
              controller.isFullscreen = true;
            },
            child: const Text('全屏')),
      ),
    ]);
  }

  @override
  videoUpdate(VideoPlayerValue value) {
    // 第一种方式
    bool isPlayering = value.isPlaying;
    debugPrint(isPlayering.toString());
  }

  @override
  void dispose() {
    super.dispose();

    controller.removeListener(_playerListener);
  }
}
