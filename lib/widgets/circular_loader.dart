import 'dart:math';

import 'package:flutter/material.dart';
import 'package:plug2go/utils/app_size.dart';

class CircularLoader extends StatefulWidget {
  const CircularLoader({super.key});

  @override
  State<CircularLoader> createState() => _CircularLoaderState();
}

class _CircularLoaderState extends State<CircularLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // Repeats the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return RotationTransition(
          turns: _controller.view,
          child: CustomPaint(
            painter: LoaderPainter(_controller.value),
            child: SizedBox(
              width: AppSize.h50,
              height: AppSize.h50,
            ),
          ),
        );
      },
    );
  }
}

class LoaderPainter extends CustomPainter {
  LoaderPainter(this.progress);
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    final rect = Offset.zero & size;
    const gradient = SweepGradient(
      colors: [Colors.white, Colors.grey, Colors.black],
    );

    paint.shader = gradient.createShader(rect);

    const startAngle = 0.15;
    const sweepAngle = 2 * pi * 0.95;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
