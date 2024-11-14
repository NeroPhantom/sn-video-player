import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sn_video_player/sn_video_player.dart';
import 'package:sn_video_player/sn_video_player_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SNVideoPlayerController snVideoPlayerController;
  late SnVideoPlayer snVideoPlayer;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  // 创建播放器实例
  initPlayer() {
    // 测试地址
    String url =
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
    snVideoPlayerController = SNVideoPlayerController.networkUrl(Uri.parse(url))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            SnVideoPlayer(snVideoPlayerController),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      snVideoPlayerController.setFullscreen(context, true);
                    },
                    child: const Text('全屏'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
