import 'package:demo/core/extensions/context_extension.dart';
import 'package:demo/core/utils/helpers/user_helper.dart';
import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  const ProfileName({
    required this.height,
    required this.width,
    super.key,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: context.theme.primaryColor,
      alignment: Alignment.center,
      child: Text(
        UserHelper.name()[0],
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 19,
        ),
      ),
    );
  }
}
