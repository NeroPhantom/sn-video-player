import 'package:flutter/material.dart';
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
    snVideoPlayerController = SNVideoPlayerController.networkUrl(uri)
      ..addListener(_playerListener);

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

  // player 监听
  _playerListener() {
    DateTime now = DateTime.now();
    String newStr = now.toIso8601String();

    var value = snVideoPlayerController.value;
    // debugPrint('$newStr'
    //     'isPlaying: ${value.isPlaying}\n'
    //     'isBuffering: ${value.isBuffering}\n'
    //     'isInit:${value.isInitialized}\n');
    setState(() {});
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
                        isFullscreen: false,
                        plat: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  var value = snVideoPlayerController.value;
                                  bool isPlaying = value.isPlaying;
                                  isPlaying
                                      ? snVideoPlayerController.pause()
                                      : snVideoPlayerController.play();
                                },
                                child: Text(
                                    snVideoPlayerController.value.isPlaying
                                        ? '暂停'
                                        : '播放')),
                            ElevatedButton(
                                onPressed: () {
                                  snVideoPlayerController.isFullscreen = true;
                                },
                                child: const Text('全屏')),
                          ],
                        ),
                        fullscreenPlat: Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  var value = snVideoPlayerController.value;
                                  bool isPlaying = value.isPlaying;
                                  isPlaying
                                      ? snVideoPlayerController.pause()
                                      : snVideoPlayerController.play();
                                },
                                child: Text(
                                    snVideoPlayerController.value.isPlaying
                                        ? '暂停'
                                        : '播放')),
                            ElevatedButton(
                                onPressed: () {
                                  snVideoPlayerController.isFullscreen = false;
                                },
                                child: const Text('退出全屏')),
                          ],
                        ),
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
