# sn_video_player

基于video_player扩展全屏的插件，适配三端

## 使用

和video_player一致

上层通过需要通过Stack实现，需要继承 `SNPlat`来实现

* `videoUpdate(VideoPlayerValue value)` 提供实现`listening`功能
* `SNPlat`添加了`controller`对象，也可以自行添加`listening`
* `controller`通过给`isFullscreen`赋值来切换全屏状态

## Local server

> 待更新