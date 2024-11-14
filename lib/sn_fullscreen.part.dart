part of './sn_video_player_controller.dart';

enum FullScreenType {
  rotateScreen,
  rotateBox,
}

showFullScreenVideoPlayer(
  BuildContext context, {
  FullScreenType fullScreenType = FullScreenType.rotateBox,
}) async {
  if (fullScreenType == FullScreenType.rotateBox) {
    _showFullScreenWithRotateBox(context);
    return;
  }
}

_showFullScreenWithRotateBox(BuildContext context) async {
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

        return RotatedBox(
            quarterTurns: quarterTurns, child: const Placeholder());
      },
    ),
  );
}
