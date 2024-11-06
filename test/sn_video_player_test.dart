import 'package:flutter_test/flutter_test.dart';
import 'package:sn_video_player/sn_video_player.dart';
import 'package:sn_video_player/sn_video_player_platform_interface.dart';
import 'package:sn_video_player/sn_video_player_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSnVideoPlayerPlatform
    with MockPlatformInterfaceMixin
    implements SnVideoPlayerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final SnVideoPlayerPlatform initialPlatform = SnVideoPlayerPlatform.instance;

  test('$MethodChannelSnVideoPlayer is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSnVideoPlayer>());
  });

  test('getPlatformVersion', () async {
    SnVideoPlayer snVideoPlayerPlugin = SnVideoPlayer();
    MockSnVideoPlayerPlatform fakePlatform = MockSnVideoPlayerPlatform();
    SnVideoPlayerPlatform.instance = fakePlatform;

    expect(await snVideoPlayerPlugin.getPlatformVersion(), '42');
  });
}
