import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// Unified Linear Progress indicator with optional label and percentage
class AppLinearProgress extends StatelessWidget {
  final double value; // 0.0 to 1.0 or 0 to 100
  final Color? color;
  final Color? backgroundColor;
  final double height;
  final BorderRadiusGeometry? borderRadius;
  final String? label;
  final bool showPercentage;

  const AppLinearProgress({
    super.key,
    required this.value,
    this.color,
    this.backgroundColor,
    this.height = 6,
    this.borderRadius,
    this.label,
    this.showPercentage = false,
  });

  @override
  Widget build(BuildContext context) {
    final normalized = (value > 1.0 ? value / 100 : value).clamp(0.0, 1.0);
    final fill = color ?? AppColors.primaryBlue;
    final bg = backgroundColor ?? AppColors.lightBlue;
    final percentInt = (normalized * 100).round();

    final bar = ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(height / 2),
      child: Container(
        height: height,
        color: bg,
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: normalized,
          child: Container(
            color: fill,
          ),
        ),
      ),
    );

    if (label == null && !showPercentage) {
      return bar;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null || showPercentage) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              if (showPercentage)
                Text(
                  "$percentInt%",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryBlue,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
        ],
        bar,
      ],
    );
  }
}

/// Circular score/readiness ring indicator with academic styling
class CircularScoreRing extends StatelessWidget {
  final int score; // 0 to 100
  final double size;
  final double strokeWidth;
  final String label;

  const CircularScoreRing({
    super.key,
    required this.score,
    this.size = 120,
    this.strokeWidth = 10,
    this.label = "out of 100",
  });

  @override
  Widget build(BuildContext context) {
    final color = score >= 75
        ? AppColors.primaryBlue
        : score >= 50
            ? AppColors.warning
            : AppColors.error;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              progress: (score / 100).clamp(0.0, 1.0),
              color: color,
              backgroundColor: AppColors.lightBlue,
              strokeWidth: strokeWidth,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$score',
                style: GoogleFonts.poppins(
                  fontSize: size * 0.28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.1,
                ),
              ),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: size * 0.1,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Track
    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Active arc
    final activePaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      activePaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
