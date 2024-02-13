import 'package:demo/core/common/actions/app_actions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    this.animationHeight,
    this.svg = 'empty',
    this.message,
  });
  final String? message;
  final double? animationHeight;
  final String svg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/lottie/$svg.json',
            fit: BoxFit.fill,
            repeat: false,
            height: animationHeight,
          ),
          Text(
            message ?? translation().noData,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
