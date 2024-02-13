import 'package:demo/core/common/states/app_state.dart';
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
    final ext = appConfigState.value.isDarkMode ? '' : '_dark';
    return Center(
      child: withAnimation
          ? Lottie.asset(
              'assets/lottie/$svg$ext.json',
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
