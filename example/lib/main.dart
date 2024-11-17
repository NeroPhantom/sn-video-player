import 'package:flutter/material.dart';
import 'package:sn_video_player/controller/sn_video_player_controller.dart';
import 'package:sn_video_player/sn_video_player.dart';
import 'package:sn_video_player_example/fullscreen_plat.dart';
import 'package:sn_video_player_example/plat.dart';

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

  //测试播放地址
  final String url =
      'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  // 创建播放器实例
  _initPlayer() {
    // 创建播放控制器
    Uri uri = Uri.parse(url);
    snVideoPlayerController = SNVideoPlayerController.networkUrl(uri);

    // 初始化播放
    snVideoPlayerController.initialize().then(
      (_) {
        setState(() {
          snVideoPlayerController.play();
        });
      },
      onError: (e) {
        debugPrint('init error: $e');
      },
    );
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
            AspectRatio(
              aspectRatio: snVideoPlayerController.value.aspectRatio,
              child: snVideoPlayerController.value.isInitialized
                  ? Container(
                      color: Colors.black,
                      child: SnVideoPlayer(
                        snVideoPlayerController,
                        plat: Plat(isFullscreen: false),
                        fullscreenPlat: FullscreenPlat(isFullscreen: true),
                      ),
                    )
                  : const Text('等待初始化'),
            ),
          ],
        ),
      ),
    );
  }
}
