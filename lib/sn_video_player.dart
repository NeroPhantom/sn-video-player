
import 'sn_video_player_platform_interface.dart';

class SnVideoPlayer {
  Future<String?> getPlatformVersion() {
    return SnVideoPlayerPlatform.instance.getPlatformVersion();
  }
}
