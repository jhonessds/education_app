import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
    this.height = 60,
    this.withAnimation = false,
    this.animationHeight = 100,
    this.svg = 'loading',
  });
  final double height;
  final bool withAnimation;
  final double animationHeight;
  final String svg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: withAnimation
          ? Lottie.asset(
              'assets/lottie/$svg.json',
              height: animationHeight,
            )
          : SizedBox(
              height: height,
              width: height,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
    );
  }
}
