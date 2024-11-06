import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sn_video_player_method_channel.dart';

abstract class SnVideoPlayerPlatform extends PlatformInterface {
  /// Constructs a SnVideoPlayerPlatform.
  SnVideoPlayerPlatform() : super(token: _token);

  static final Object _token = Object();

  static SnVideoPlayerPlatform _instance = MethodChannelSnVideoPlayer();

  /// The default instance of [SnVideoPlayerPlatform] to use.
  ///
  /// Defaults to [MethodChannelSnVideoPlayer].
  static SnVideoPlayerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SnVideoPlayerPlatform] when
  /// they register themselves.
  static set instance(SnVideoPlayerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
