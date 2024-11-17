abstract class SNPlayerControllerAbstract {
  // 自动切换播放和暂停
  Future<void> playOrPause();
  // 判断是否为静音状态
  bool isMuted();
  // 判断是否播放到结尾
  bool isAtEnd();
}
