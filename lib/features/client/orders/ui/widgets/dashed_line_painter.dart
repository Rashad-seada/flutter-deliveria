import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double animationValue;

  DashedLinePainter({required this.color, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    const dashHeight = 6.0;
    const dashSpace = 7.0;
    double startY = 0;

    
    final animationOffset = animationValue * (dashHeight + dashSpace);

    while (startY < size.height) {
      final adjustedStartY =
          (startY + animationOffset) % (size.height + dashHeight + dashSpace);

      if (adjustedStartY >= 0 && adjustedStartY < size.height) {
        canvas.drawLine(
          Offset(size.width / 2, adjustedStartY),
          Offset(
            size.width / 2,
            (adjustedStartY + dashHeight).clamp(0, size.height),
          ),
          paint,
        );
      }

      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
