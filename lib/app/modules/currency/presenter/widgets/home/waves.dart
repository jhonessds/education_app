import 'package:demo/core/extensions/context_extension.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Waves extends StatelessWidget {
  const Waves({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            color: context.theme.primaryColor.withOpacity(0.7),
            height: context.height * 0.32,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: context.height * 0.06),
          child: ClipPath(
            clipper: WaveClipperTwo(reverse: true),
            child: Container(
              color: context.theme.primaryColor.withOpacity(0.8),
              height: context.height * 0.2,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: context.height * 0.09),
          child: ClipPath(
            clipper: WaveClipperTwo(reverse: true),
            child: Container(
              color: context.theme.primaryColor.withOpacity(0.9),
              height: context.height * 0.13,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: context.height * 0.22),
          child: ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              color: context.theme.primaryColor,
              height: context.height * 0.1,
            ),
          ),
        ),
      ],
    );
  }
}
