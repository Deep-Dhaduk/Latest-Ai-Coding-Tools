import 'dart:ui';
import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  const ProgressRing({
    super.key,
    required this.progress,
    required this.size,
    this.strokeWidth = 14,
    this.backgroundColor,
    this.foregroundColor,
    this.glowColor,
  });

  final double progress; // 0.0 to 1.0
  final double size;
  final double strokeWidth;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? glowColor;

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? Colors.white.withOpacity(0.2);
    final fg = foregroundColor ?? const Color(0xFF5B9BD5);
    final glow = glowColor ?? const Color(0xFF7EC8E3);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              progress: progress.clamp(0.0, 1.0),
              strokeWidth: strokeWidth,
              backgroundColor: bg,
              foregroundColor: fg,
            ),
          ),
          if (progress > 0 && progress < 1)
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: glow.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide / 2) - strokeWidth / 2;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    if (progress > 0) {
      final fgPaint = Paint()
        ..color = foregroundColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      const startAngle = -1.5707963267948966; // -90° (top)
      final sweepAngle = 2 * 3.141592653589793 * progress;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        fgPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
