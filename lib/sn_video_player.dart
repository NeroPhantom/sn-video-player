import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sn_video_player/abstracts/sn_plat_abstract.dart';
import 'package:sn_video_player/controller/sn_video_player_controller.dart';
import 'package:video_player/video_player.dart';

// export plat lib file
export 'abstracts/sn_plat_abstract.dart';
// export controller lib file
export 'controller/sn_video_player_controller.dart';

class SnVideoPlayer extends StatefulWidget {
  static void registerWith(dynamic registrar) {
    if (kIsWeb) {
      // SnVideoPlayerWeb.registerWith(registrar);
    }
  }

  final SNVideoPlayerController controller;

  // main plat
  final SNPlat? plat;

  // fullscreen plat
  final SNPlat? fullscreenPlat;

  const SnVideoPlayer(
    this.controller, {
    super.key,
    // this.isFullscreen = false,
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
      ..plat = widget.plat
      ..fullscreenPlat = widget.fullscreenPlat;
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.parentContext ??= context;
    return Stack(
      children: [
        kIsWeb
            ? Hero(
                tag: 'snplayer',
                // createRectTween: (begin, end) {
                //   debugPrint('begin: $begin\nend: $end');
                //   return FullScreenRectTween(begin: begin, end: begin);
                // },
                // flightShuttleBuilder: (flightContext, animation,
                //     flightDirection, fromHeroContext, toHeroContext) {
                //   return AnimatedBuilder(
                //     animation: animation,
                //     builder: (context, child) {
                //       // 进入全屏：放大 + 旋转 + 缓动
                //       final curvedValue =
                //           Curves.easeInOut.transform(animation.value);

                //       // 旋转
                //       final angle = flightDirection == HeroFlightDirection.push
                //           ? curvedValue * 3.14 / 2 // 90 度
                //           : (1 - curvedValue) * 3.14 / 2;

                //       // 缩放
                //       final scale = flightDirection == HeroFlightDirection.push
                //           ? 1.0 + curvedValue * 0.5 // 放大到 1.5
                //           : 1.5 - curvedValue * 0.5; // 缩小回 1.0

                //       return Transform(
                //         alignment: Alignment.center,
                //         transform: Matrix4.identity()
                //           // ..rotateZ(angle), // 旋转
                //           ..scale(scale), // 缩放
                //         child: child,
                //       );
                //     },
                //     child: toHeroContext.widget,
                //   );
                // },
                child: VideoPlayer(widget.controller),
              )
            : VideoPlayer(widget.controller),

        // VideoPlayer(widget.controller),
        widget.controller.isFullscreen
            ? ((widget.fullscreenPlat != null)
                ? widget.fullscreenPlat!
                : Container())
            : ((widget.plat != null) ? widget.plat! : Container()),
      ],
    );
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   if (kIsWeb) {
  //     if (!widget.controller.value.isPlaying) {
  //       widget.controller.play();
  //     }
  //   }
  // }
}

class FullScreenRectTween extends RectTween {
  FullScreenRectTween({super.begin, super.end});

  @override
  Rect lerp(double t) {
    // 计算宽度、位置等的过渡效果
    final width = lerpDouble(begin!.width, end!.width, t)!;
    final height = lerpDouble(begin!.height, end!.height, t)!;

    // 平滑调整 Rect 的位置和大小
    final left = lerpDouble(begin!.left, end!.left, t)!;
    final top = lerpDouble(begin!.top, end?.top, t)!;
    // return Rect.fromCircle(center: Offset(0, 0), radius: 100);
    return Rect.fromLTWH(left, top, width, height);
  }
}
