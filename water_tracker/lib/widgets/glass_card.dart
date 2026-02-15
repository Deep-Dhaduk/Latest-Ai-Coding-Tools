import 'dart:ui';
import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.blur = 10,
    this.opacity = 0.25,
    this.borderWidth = 1,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final double borderRadius;
  final double blur;
  final double opacity;
  final double borderWidth;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white.withOpacity(opacity),
            border: Border.all(
              color: Colors.white.withOpacity(0.4),
              width: borderWidth,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
