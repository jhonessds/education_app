import 'dart:math' as math show pi, sin, sqrt;

import 'package:flutter/material.dart';

class WaveShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;
    final p = Path();
    // ignore: cascade_invocations
    p
      ..lineTo(0, 0)
      ..cubicTo(width * 1 / 2, 0, width * 2 / 4, height, width, height)
      ..lineTo(width, 0)
      ..close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<dynamic> oldClipper) => true;
}

class BottomWaveShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;
    final p = Path();
    // ignore: cascade_invocations
    p
      ..lineTo(0, 0)
      ..cubicTo(width * 1 / 2, 0, width * 2 / 4, height, width, height)
      ..lineTo(0, height)
      ..close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<dynamic> oldClipper) => true;
}

class WaveAnimation extends StatefulWidget {
  const WaveAnimation({
    required this.centerChild,
    this.size = 80.0,
    this.color = Colors.red,
    super.key,
  });
  final double size;
  final Color color;
  final Widget centerChild;

  @override
  WaveAnimationState createState() => WaveAnimationState();
}

class WaveAnimationState extends State<WaveAnimation>
    with TickerProviderStateMixin {
  late AnimationController animCtr;

  @override
  void initState() {
    super.initState();
    animCtr = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  Widget getAnimatedWidget() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size),
          gradient: RadialGradient(
            colors: [
              widget.color,
              Color.lerp(widget.color, Colors.black, .05)!,
            ],
          ),
        ),
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1).animate(
            CurvedAnimation(
              parent: animCtr,
              curve: CurveWave(),
            ),
          ),
          child: Container(
            width: widget.size * 0.5,
            height: widget.size * 0.5,
            margin: const EdgeInsets.all(6),
            child: widget.centerChild,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(animCtr, color: widget.color),
      child: SizedBox(
        width: widget.size * 1.6,
        height: widget.size * 1.6,
        child: getAnimatedWidget(),
      ),
    );
  }

  @override
  void dispose() {
    animCtr.dispose();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter(
    this.animation, {
    required this.color,
  }) : super(repaint: animation);
  final Color color;
  final Animation<double> animation;

  void circle(Canvas canvas, Rect rect, double value) {
    final opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    final rippleColor = color.withOpacity(opacity);
    final size = rect.width / 2;
    final area = size * size;
    final radius = math.sqrt(area * value / 4);
    final paint = Paint()..color = rippleColor;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, size.width, size.height);
    for (var wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + animation.value);
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => true;
}

class CurveWave extends Curve {
  @override
  double transform(double t) {
    if (t == 0 || t == 1) {
      return 0.01;
    }
    return math.sin(t * math.pi);
  }
}
