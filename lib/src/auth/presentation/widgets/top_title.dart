import 'package:education_app/core/common/widgets/simple_text.dart';
import 'package:education_app/core/res/fonts.dart';
import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget {
  const TopTitle({
    required this.title,
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SimpleText(
      mgLeft: 13,
      text: title,
      fontSize: 30,
      fontWeight: FontWeight.w700,
      alignment: Alignment.centerLeft,
      mgBottom: screenSize.height * 0.02,
      mgTop: 16,
      fontFamily: Fonts.aeonik,
      maxlines: 2,
    );
  }
}
