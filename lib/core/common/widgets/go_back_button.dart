import 'package:flutter/material.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      icon: Icon(
        Icons.arrow_back,
        color: color ?? Theme.of(context).primaryColor,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
