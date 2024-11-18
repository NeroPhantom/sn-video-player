import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sn_video_player_platform_interface.dart';

/// An implementation of [SnVideoPlayerPlatform] that uses method channels.
class MethodChannelSnVideoPlayer extends SnVideoPlayerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sn_video_player');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
