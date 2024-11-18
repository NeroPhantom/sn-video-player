part of '../controller/sn_video_player_controller.dart';

enum FullScreenType {
  rotateScreen,
  rotateBox,
}

showFullScreenVideoPlayer(
  BuildContext context, {
  required SNVideoPlayerController controller,
  SNPlat? fullscreenPlat,
  FullScreenType fullScreenType = FullScreenType.rotateBox,
}) async {
  // 暂时只使用rotateBox实现
  if (fullScreenType == FullScreenType.rotateBox) {
    _showFullScreenWithRotateBox(
      context,
      controller: controller,
      fullscreenPlat: fullscreenPlat,
    );
    return;
  }
}

GlobalKey _previewContainer = GlobalKey();
_showFullScreenWithRotateBox(
  BuildContext context, {
  required SNVideoPlayerController controller,
  SNPlat? fullscreenPlat,
}) async {
  Axis axis;
  axis = Axis.horizontal;

  Navigator.push(
    context,
    SNFullScreenRoute(
      builder: (ctx) {
        var mediaQueryData = MediaQuery.of(ctx);

        int quarterTurns;

        if (axis == Axis.horizontal) {
          if (mediaQueryData.orientation == Orientation.landscape) {
            quarterTurns = 0;
          } else {
            quarterTurns = 1;
          }
        } else {
          quarterTurns = 0;
        }

        double width = mediaQueryData.size.width;
        double height = mediaQueryData.size.height;

        return RotatedBox(
          quarterTurns: quarterTurns,
          child: Material(
            child: Container(
              decoration: const BoxDecoration(color: Colors.black),
              width: height,
              height: width,
              child: PopScope(
                  canPop: true,
                  onPopInvokedWithResult: (didPop, result) {
                    debugPrint(didPop.toString());
                    debugPrint(result.toString());
                  },
                  child: LayoutBuilder(builder: (buildContext, boxConstraints) {
                    Stack stack = Stack(
                      children: [
                        Center(
                          child: AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: Container(
                              padding: const EdgeInsets.all(0),
                              color: Colors.black,
                              child: SnVideoPlayer(
                                controller,
                                fullscreenPlat: fullscreenPlat,
                              ),
                            ),
                          ),
                        ),
                        // if (fullscreenPlat != null) fullscreenPlat,
                      ],
                    );

                    return RepaintBoundary(
                      key: _previewContainer,
                      child: stack,
                    );
                  })),
            ),
          ),
        );
      },
    ),
  );
}
