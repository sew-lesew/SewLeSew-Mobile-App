import 'package:flutter/material.dart';

class Zigzagline extends StatelessWidget {
  const Zigzagline(
      {super.key, this.height = 1, this.width = 1, this.color = Colors.black});

  final Color color;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: ZigzagPainter(height: height, color: color),
    );
  }
}

class ZigzagPainter extends CustomPainter {
  ZigzagPainter({required this.height, required this.color});

  final Color color;
  final double height;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    // ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    for (var i = 0; i < size.width; i += 1) {
      path.moveTo(i.toDouble(), 0);
      path.lineTo(i + 1, 1);
      path.lineTo(i + 1, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRebuildSemantics(ZigzagPainter oldDelegate) => false;

  @override
  bool shouldRepaint(ZigzagPainter oldDelegate) => false;
}
