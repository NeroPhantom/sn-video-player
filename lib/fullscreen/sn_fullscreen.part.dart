part of '../sn_video_player_controller.dart';

enum FullScreenType {
  rotateScreen,
  rotateBox,
}

showFullScreenVideoPlayer(
  BuildContext context, {
  required SNVideoPlayerController controller,
  Widget? fullscreenPlat,
  FullScreenType fullScreenType = FullScreenType.rotateBox,
}) async {
  // 暂时只使用rotateBox实现
  if (fullScreenType == FullScreenType.rotateBox) {
    _showFullScreenWithRotateBox(
      context,
      controller: controller,
      plat: fullscreenPlat,
    );
    return;
  }
}

GlobalKey _previewContainer = GlobalKey();
_showFullScreenWithRotateBox(
  BuildContext context, {
  required SNVideoPlayerController controller,
  Widget? plat,
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

        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;

        return RotatedBox(
          quarterTurns: quarterTurns,
          child: Material(
            child: Container(
              decoration: const BoxDecoration(color: Colors.black),
              width: height,
              height: width,
              child: PopScope(
                  child: LayoutBuilder(builder: (buildContext, boxConstraints) {
                Stack stack = Stack(
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          color: Colors.black,
                          child: VideoPlayer(controller),
                        ),
                      ),
                    ),
                    if (plat != null) plat,
                  ],
                );

                return RepaintBoundary(
                  // key: _previewContainer,
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
