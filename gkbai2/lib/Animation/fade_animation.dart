import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child, {super.key});
   

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween('opacity', Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500))
          .thenTween('y', Tween(begin: -30.0, end: 0.0),
          duration: const Duration(milliseconds: 500),curve: Curves.easeOut);
  //  final tween = MovieTween()
  // ..tween('width', Tween(begin: 0.0, end: 100),
  //         duration: const Duration(milliseconds: 1500), curve: Curves.easeIn)
  //     .thenTween('width', Tween(begin: 100, end: 200),
  //         duration: const Duration(milliseconds: 750), curve: Curves.easeOut);
    return PlayAnimationBuilder<Movie>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value.get("opacity"),
        child: Transform.translate(
          offset: Offset(0, value.get("y")), 
          child: child
            ),
          ),
    );
  }
}
