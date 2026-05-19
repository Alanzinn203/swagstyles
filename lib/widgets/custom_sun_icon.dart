import 'package:flutter/material.dart';
import 'dart:math';

class CustomSunIcon extends StatelessWidget {
  final double size;
  const CustomSunIcon({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: _SunPainter());
  }
}

class _SunPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final linePaint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.09;

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Círculo central
    canvas.drawCircle(center, size.width * 0.16, fillPaint);

    // Raios
    for (int i = 0; i < 8; i++) {
      final angle = i * (pi / 4);
      final isLongRay = i % 2 == 0;

      final innerRadius = size.width * 0.28;
      final outerRadius = isLongRay ? size.width * 0.45 : size.width * 0.35;

      final startPoint = Offset(
        center.dx + innerRadius * cos(angle),
        center.dy + innerRadius * sin(angle),
      );
      final endPoint = Offset(
        center.dx + outerRadius * cos(angle),
        center.dy + outerRadius * sin(angle),
      );

      canvas.drawLine(startPoint, endPoint, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}