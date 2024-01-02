import 'package:flutter/material.dart';

class SimpleText extends StatelessWidget {
  const SimpleText({
    required this.text,
    this.fontWeight = FontWeight.w300,
    this.textAlign = TextAlign.left,
    this.fontSize = 14,
    this.mgLeft = 0,
    this.mgRight = 0,
    this.mgBottom = 0,
    this.mgTop = 0,
    this.color,
    this.maxlines,
    this.decoration,
    this.fontFamily,
    this.withTextScale = true,
    this.colorContainer,
    this.width,
    this.alignment,
    super.key,
  });
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final double? width;
  final double mgLeft;
  final double mgRight;
  final double mgTop;
  final double mgBottom;
  final Color? color;
  final Color? colorContainer;
  final int? maxlines;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  final String? fontFamily;
  final bool withTextScale;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorContainer,
      width: width,
      alignment: alignment,
      margin: EdgeInsets.only(
        left: mgLeft,
        right: mgRight,
        top: mgTop,
        bottom: mgBottom,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration: decoration,
          fontFamily: fontFamily,
        ),
        textAlign: textAlign,
        maxLines: maxlines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
