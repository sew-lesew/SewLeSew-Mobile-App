import 'package:flutter/material.dart';

import '../../../../config/theme/colors.dart';

class ZigzagLine extends StatelessWidget {
  final double height; // Height of each zigzag wave
  final double width; // Total width of the zigzag line
  final Color color; // Color of the zigzag line

  const ZigzagLine({
    super.key,
    this.height = 10.0,
    this.width = 200.0,
    this.color = AppColors.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height), // Size of the canvas
      painter: ZigzagPainter(
        height: height,
        color: color,
      ),
    );
  }
}

class ZigzagPainter extends CustomPainter {
  final double height; // Height of each zigzag wave
  final Color color; // Color of the zigzag line

  ZigzagPainter({
    required this.height,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0 // Regular line thickness
      ..style = PaintingStyle.stroke;

    final path = Path();

    // Start from the top-left corner
    path.moveTo(0, 0);

    // Draw the zigzag pattern
    for (double x = 0; x <= size.width; x += height) {
      final double y = x % (2 * height) == 0 ? height : 0;
      path.lineTo(x, y);
    }

    // Draw the zigzag path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // No need to repaint if no changes
  }
}
