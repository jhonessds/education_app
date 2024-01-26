import 'package:demo/app/app_widget.dart';
import 'package:demo/core/common/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

Future<void> loadingWidget({
  bool withAnimation = false,
  double animationHeight = 100,
  String svg = '',
}) {
  final context = NavigationService.instance.currentContext;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return PopScope(
        canPop: false,
        child: LoadingWidget(
          withAnimation: withAnimation,
          svg: svg,
          animationHeight: animationHeight,
        ),
      );
    },
  );
}
