import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TopAnimation extends StatelessWidget {
  const TopAnimation({
    required this.animation,
    super.key,
    this.minHeight = 400,
    this.maxHeight = 400,
  });

  final String animation;
  final double minHeight;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * 0.34,
      child: OverflowBox(
        minHeight: minHeight,
        maxHeight: maxHeight,
        child: Lottie.asset('assets/lottie/$animation.json'),
      ),
    );
  }
}
