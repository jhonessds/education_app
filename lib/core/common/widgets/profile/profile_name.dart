import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  const ProfileName({
    required this.size,
    this.fontSize = 19,
    super.key,
  });

  final double size;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      color: context.theme.primaryColor,
      alignment: Alignment.center,
      child: Text(
        UserHelper.name()[0],
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
