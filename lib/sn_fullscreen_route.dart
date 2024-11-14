import 'package:flutter/material.dart';

typedef Widget AnimationPageBuilder(BuildContext context,
    Animation<double> animation, Animation<double> secondaryAnimation);

class SNDialogRoute<T> extends PageRoute<T> {
  @override
  final Color barrierColor;
  @override
  final String barrierLabel;
  @override
  final bool maintainState;
  @override
  final Duration transitionDuration;
  final AnimationPageBuilder builder;

  SNDialogRoute({
    this.barrierColor = const Color(0x44FFFFFF),
    this.barrierLabel = "full",
    this.maintainState = true,
    this.transitionDuration = const Duration(milliseconds: 300),
    required this.builder,
  }) : assert(barrierColor != Colors.transparent,
            "The barrierColor must not be transparent.");

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context, animation, secondaryAnimation);
  }
}

class SNFullScreenRoute<T> extends SNDialogRoute<T> {
  SNFullScreenRoute({required WidgetBuilder builder})
      : super(builder: (ctx, a, s) => fullScreenBuilder(ctx, builder, a, s));

  static Widget fullScreenBuilder(
    BuildContext context,
    WidgetBuilder builder,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) =>
          Opacity(opacity: animation.value, child: builder(context)),
    );
  }
}
