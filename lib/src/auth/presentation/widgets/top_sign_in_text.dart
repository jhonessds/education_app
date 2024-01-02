import 'package:education_app/core/res/fonts.dart';
import 'package:flutter/material.dart';

class TopSignInText extends StatelessWidget {
  const TopSignInText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: const Text(
        'Easy to learn, discover more skills.',
        style: TextStyle(
          fontFamily: Fonts.aeonik,
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
      ),
    );
  }
}
