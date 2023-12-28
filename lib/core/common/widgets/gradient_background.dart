import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
    required this.image,
    required this.child,
  });

  final String image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
