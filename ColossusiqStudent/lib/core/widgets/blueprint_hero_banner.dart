import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// Professional Blue Hero Banner for College & Portal modules
class BlueprintHeroBanner extends StatelessWidget {
  final String breadcrumb;
  final String category;
  final String phase;
  final bool isMvp;
  final IconData icon;
  final String title;
  final String subtitle;
  final IconData watermarkIcon;
  final Widget? action;

  const BlueprintHeroBanner({
    super.key,
    required this.breadcrumb,
    required this.category,
    required this.phase,
    this.isMvp = false,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.watermarkIcon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF131838),
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF131838),
            Color(0xFF1B2358),
            Color(0xFF232D6E),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131838).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Subtle Grid overlay pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),

            // Large watermark icon on right
            Positioned(
              right: 12,
              bottom: -20,
              child: Opacity(
                opacity: 0.08,
                child: Icon(
                  watermarkIcon,
                  size: 150,
                  color: Colors.white,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 640;

                  final categoryBadge = Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      category.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  );

                  final phaseBadge = Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                      color: isMvp
                          ? AppColors.success.withValues(alpha: 0.9)
                          : AppColors.warning.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      phase,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  );

                  final iconBox = Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.18),
                        width: 1.2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        color: const Color(0xFFFBBF24),
                        size: 24,
                      ),
                    ),
                  );

                  if (isNarrow) {
                    // Mobile / Narrow layout: vertical stacking
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Breadcrumb
                        Text(
                          breadcrumb,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Header row: Icon Box + Badges
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            iconBox,
                            const SizedBox(width: 10),
                            Expanded(
                              child: Wrap(
                                spacing: 6,
                                runSpacing: 4,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  categoryBadge,
                                  phaseBadge,
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Main Title
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Subtitle
                        Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.9),
                            height: 1.45,
                          ),
                        ),

                        if (action != null) ...[
                          const SizedBox(height: 14),
                          action!,
                        ],
                      ],
                    );
                  }

                  // Desktop / Tablet layout (>= 640px)
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Breadcrumb
                      Text(
                        breadcrumb,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: Colors.white.withValues(alpha: 0.8),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          iconBox,
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 6,
                                  runSpacing: 4,
                                  children: [
                                    categoryBadge,
                                    phaseBadge,
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  subtitle,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white.withValues(alpha: 0.88),
                                    height: 1.45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (action != null) ...[
                            const SizedBox(width: 12),
                            action!,
                          ],
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.055)
      ..strokeWidth = 1;

    const step = 20.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
