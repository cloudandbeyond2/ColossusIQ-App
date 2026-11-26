import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalAnalyticsBiScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalAnalyticsBiScreen({super.key, this.onBack});

  @override
  State<PrincipalAnalyticsBiScreen> createState() =>
      _PrincipalAnalyticsBiScreenState();
}

class _PrincipalAnalyticsBiScreenState
    extends State<PrincipalAnalyticsBiScreen> {
  int _selectedTab = 0;

  void _refresh() {
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Analytics refreshed'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final horizontal = constraints.maxWidth >= 1100
              ? 32.0
              : constraints.maxWidth >= 600
              ? 20.0
              : 14.0;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(horizontal, 20, horizontal, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHero(),
                const SizedBox(height: 18),
                _buildTitleRow(),
                const SizedBox(height: 14),
                _buildTabs(),
                const SizedBox(height: 16),
                switch (_selectedTab) {
                  1 => _buildEmployability(constraints.maxWidth),
                  2 => _buildEngagement(constraints.maxWidth),
                  3 => _buildFaculty(constraints.maxWidth),
                  _ => _buildAcademic(constraints.maxWidth),
                },
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHero() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 430;
        return Container(
          height: compact ? 210 : 154,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF172554), Color(0xFF25308A), Color(0xFF5B21B6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                Positioned.fill(child: CustomPaint(painter: _GridPainter())),
                Positioned(
                  right: 24,
                  child: Icon(
                    Icons.insights_rounded,
                    size: 154,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: widget.onBack,
                              borderRadius: BorderRadius.circular(8),
                              child: Text(
                                'Home',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFFC8D3EC),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 14,
                              color: Color(0xFFB7C3DF),
                            ),
                            Text(
                              'Institution',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFFC8D3EC),
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              size: 14,
                              color: Color(0xFFB7C3DF),
                            ),
                            Text(
                              'Analytics & BI',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF26368F),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.insights_rounded,
                              color: Color(0xFFFBBF24),
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _heroTag('INSTITUTION'),
                                    const SizedBox(width: 8),
                                    _heroTag(
                                      'Phase 3',
                                      color: const Color(0xFFD97706),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Analytics & BI',
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Academic, employability, engagement and faculty KPIs.',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFFC8D3EC),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _heroTag(String text, {Color color = const Color(0xFF3A4A91)}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      children: [
        const Icon(Icons.bar_chart_rounded, size: 18, color: Color(0xFF4F46E5)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Analytics & BI',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF151C2F),
                ),
              ),
              Text(
                'Live academic, employability, engagement and faculty KPIs across your institution.',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF9AA7B8),
                ),
              ),
            ],
          ),
        ),
        TextButton.icon(
          onPressed: _refresh,
          icon: const Icon(Icons.refresh, size: 16),
          label: Text(
            'Refresh',
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    final tabs = [
      (Icons.menu_book_outlined, 'Academic'),
      (Icons.business_center_outlined, 'Employability'),
      (Icons.groups_outlined, 'Engagement'),
      (Icons.person_outline, 'Faculty'),
    ];

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(tabs.length, (index) {
            final selected = _selectedTab == index;
            return Padding(
              padding: const EdgeInsets.only(right: 28),
              child: InkWell(
                onTap: () => setState(() => _selectedTab = index),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: selected
                            ? const Color(0xFF202A7A)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        tabs[index].$1,
                        size: 16,
                        color: selected
                            ? const Color(0xFF202A7A)
                            : const Color(0xFF8DA0B8),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        tabs[index].$2,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: selected
                              ? const Color(0xFF202A7A)
                              : const Color(0xFF7F91A8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildAcademic(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _summaryCard([
          _gaugeItem('7', 'Enrolled students', 0.06, const Color(0xFF6965F5)),
          _gaugeItem(
            '14',
            'Active curriculum',
            0.085,
            const Color(0xFF22AEEA),
            unit: 'courses',
          ),
        ]),
        const SizedBox(height: 18),
        _trendsTitle(),
        const SizedBox(height: 12),
        _chartGrid(width, [
          _chartCard(
            'Weekly academic engagement',
            SizedBox(
              width: double.infinity,
              height: 190,
              child: CustomPaint(painter: _LineChartPainter()),
            ),
            legend: const [
              (Color(0xFF1E2A78), 'Students'),
              (Color(0xFFE9A41A), 'Faculty'),
            ],
          ),
          _chartCard(
            'Curriculum delivery modes',
            SizedBox(
              width: double.infinity,
              height: 190,
              child: CustomPaint(painter: _DonutPainter()),
            ),
            legend: const [
              (Color(0xFF1E2A78), 'Theory'),
              (Color(0xFFE9A41A), 'Theory + Lab'),
            ],
          ),
        ]),
        const SizedBox(height: 18),
        _insights(),
      ],
    );
  }

  Widget _buildEmployability(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _summaryCard([
          _gaugeItem(
            '20%',
            'Placement readiness',
            0.125,
            const Color(0xFF12B8A6),
          ),
        ]),
        const SizedBox(height: 18),
        _trendsTitle(),
        const SizedBox(height: 12),
        _chartGrid(width, [
          _chartCard(
            'Placement readiness by department',
            SizedBox(
              width: double.infinity,
              height: 200,
              child: CustomPaint(painter: _PlacementBarPainter()),
            ),
          ),
          _chartCard(
            'Career & placement status',
            SizedBox(
              width: double.infinity,
              height: 200,
              child: CustomPaint(painter: _PlacementDonutPainter()),
            ),
            legend: const [
              (Color(0xFF1E2A78), 'Offers received'),
              (Color(0xFFE9A41A), 'Active internship'),
              (Color(0xFF119C91), 'Upskilling / In Prep'),
            ],
          ),
        ]),
        const SizedBox(height: 18),
        _insights(),
      ],
    );
  }

  Widget _buildEngagement(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _summaryCard([
          _gaugeItem(
            '14',
            'Active curriculum',
            0.085,
            const Color(0xFF22AEEA),
            unit: 'courses',
          ),
        ]),
        const SizedBox(height: 18),
        _trendsTitle(),
        const SizedBox(height: 12),
        _chartGrid(width, [
          _chartCard(
            'Weekly academic engagement',
            SizedBox(
              width: double.infinity,
              height: 190,
              child: CustomPaint(painter: _LineChartPainter()),
            ),
            legend: const [
              (Color(0xFF1E2A78), 'Students'),
              (Color(0xFFE9A41A), 'Faculty'),
            ],
          ),
        ]),
        const SizedBox(height: 18),
        _insights(),
      ],
    );
  }

  Widget _buildFaculty(double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _summaryCard([
          _gaugeItem('4', 'Teaching faculty', 0.04, const Color(0xFF12B8A6)),
        ]),
        const SizedBox(height: 18),
        _trendsTitle(),
        const SizedBox(height: 12),
        _chartGrid(width, [
          _chartCard(
            'Department capacity & staffing',
            SizedBox(
              width: double.infinity,
              height: 200,
              child: CustomPaint(painter: _FacultyBarPainter()),
            ),
            legend: const [
              (Color(0xFF1E2A78), 'Courses'),
              (Color(0xFFE9A41A), 'Faculty'),
            ],
          ),
        ]),
        const SizedBox(height: 18),
        _insights(),
      ],
    );
  }

  Widget _summaryCard(List<Widget> items) {
    return Container(
      height: 148,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5EAF0)),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 500 && items.length > 1;
          return Row(
            mainAxisAlignment: items.length == 1
                ? MainAxisAlignment.center
                : compact
                ? MainAxisAlignment.spaceEvenly
                : MainAxisAlignment.start,
            children: [
              for (var i = 0; i < items.length; i++) ...[
                if (!compact && i > 0) const SizedBox(width: 220),
                if (compact)
                  Expanded(child: Center(child: items[i]))
                else
                  items[i],
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _gaugeItem(
    String value,
    String label,
    double progress,
    Color color, {
    String? unit,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: CustomPaint(
            painter: _GaugePainter(progress, color),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    value,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF16213A),
                      height: 1.05,
                    ),
                  ),
                  if (unit != null)
                    Text(
                      unit,
                      style: GoogleFonts.poppins(
                        fontSize: 7,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF8A9AAF),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: const Color(0xFF8A9AAF),
          ),
        ),
      ],
    );
  }

  Widget _trendsTitle() {
    return Text(
      'TRENDS',
      style: GoogleFonts.poppins(
        fontSize: 9,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: const Color(0xFF7D8EA3),
      ),
    );
  }

  Widget _chartGrid(double width, List<Widget> cards) {
    if (width < 760) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            SizedBox(width: double.infinity, child: cards[i]),
            if (i != cards.length - 1) const SizedBox(height: 16),
          ],
        ],
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = cards.length == 1
            ? constraints.maxWidth
            : (constraints.maxWidth - 16) / 2;
        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: cards
              .map((card) => SizedBox(width: cardWidth, child: card))
              .toList(),
        );
      },
    );
  }

  Widget _chartCard(
    String title,
    Widget chart, {
    List<(Color, String)>? legend,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF202A3A),
            ),
          ),
          const SizedBox(height: 8),
          chart,
          if (legend != null) ...[
            const SizedBox(height: 4),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 4,
              children: [
                for (final item in legend)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: item.$1,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        item.$2,
                        style: GoogleFonts.poppins(fontSize: 9, color: item.$1),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _insights() {
    final insights = [
      (
        const Color(0xFFD97706),
        'Enrollment capacity buffer',
        'Current intake is at 0% of capacity. There are 6,593 seats open for subsequent rounds.',
      ),
      (
        const Color(0xFF10B7A5),
        'Student-to-faculty ratio compliant',
        'The current student-to-faculty ratio is 2:1 across 4 teaching staff, meeting regulatory recommendations.',
      ),
      (
        const Color(0xFF9B7CFF),
        'Course syllabus awaiting publishing',
        '2 course(s) are currently in Draft status. Publish them to make lessons accessible to students for the upcoming term.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'INSIGHTS',
          style: GoogleFonts.poppins(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: const Color(0xFF7D8EA3),
          ),
        ),
        const SizedBox(height: 10),
        for (var i = 0; i < insights.length; i++) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: i == 0
                  ? Colors.white
                  : i == 1
                  ? const Color(0xFFEAFDFC)
                  : const Color(0xFFF1F4FF),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: i == 0
                    ? const Color(0xFF334155)
                    : insights[i].$1.withValues(alpha: 0.38),
                width: i == 0 ? 1 : 1,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lightbulb_outline, size: 16, color: insights[i].$1),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insights[i].$2,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF202A3A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        insights[i].$3,
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          color: const Color(0xFF66778F),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (i != insights.length - 1) const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.035)
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 26) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y < size.height; y += 26) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final Color color;

  _GaugePainter(this.progress, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    final base = Paint()
      ..color = const Color(0xFFE9EEF4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.butt;
    final active = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.butt;
    canvas.drawCircle(center, radius, base);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 2 * progress,
      false,
      active,
    );
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) =>
      progress != oldDelegate.progress || color != oldDelegate.color;
}

class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const left = 38.0;
    const right = 8.0;
    const top = 12.0;
    const bottom = 28.0;
    final chartWidth = size.width - left - right;
    final chartHeight = size.height - top - bottom;

    final grid = Paint()
      ..color = const Color(0xFFEEF2F6)
      ..strokeWidth = 1;
    final textStyle = TextStyle(
      fontFamily: GoogleFonts.poppins().fontFamily,
      fontSize: 9,
      color: const Color(0xFF8DA0B8),
    );
    for (var i = 0; i <= 4; i++) {
      final y = top + chartHeight * i / 4;
      canvas.drawLine(Offset(left, y), Offset(size.width - right, y), grid);
      final tp = TextPainter(
        text: TextSpan(text: '${8 - i * 2}', style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(10, y - tp.height / 2));
    }
    final labels = ['W1', 'W2', 'W3', 'W4', 'W5', 'W6'];
    for (var i = 0; i < labels.length; i++) {
      final x = left + chartWidth * i / (labels.length - 1);
      final tp = TextPainter(
        text: TextSpan(text: labels[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(x - tp.width / 2, size.height - 18));
    }

    void drawLine(List<double> values, Color color, {Color? fill}) {
      final paint = Paint()
        ..color = color
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;
      final path = Path();
      final points = <Offset>[];
      for (var i = 0; i < values.length; i++) {
        final x = left + chartWidth * i / (values.length - 1);
        final y = top + chartHeight * (1 - values[i] / 8);
        points.add(Offset(x, y));
      }
      path.moveTo(points.first.dx, points.first.dy);
      for (var i = 0; i < points.length - 1; i++) {
        final midpoint = (points[i].dx + points[i + 1].dx) / 2;
        path.quadraticBezierTo(
          midpoint,
          points[i].dy,
          midpoint,
          (points[i].dy + points[i + 1].dy) / 2,
        );
      }
      path.lineTo(points.last.dx, points.last.dy);

      if (fill != null) {
        final fillPath = Path.from(path)
          ..lineTo(points.last.dx, top + chartHeight)
          ..lineTo(points.first.dx, top + chartHeight)
          ..close();
        canvas.drawPath(
          fillPath,
          Paint()
            ..color = fill
            ..style = PaintingStyle.fill,
        );
      }
      canvas.drawPath(path, paint);
    }

    drawLine(
      [5, 5, 6, 6, 6, 6],
      const Color(0xFF1E2A78),
      fill: const Color(0x281E2A78),
    );
    drawLine(
      [3, 4, 4, 4, 4, 4],
      const Color(0xFFE9A41A),
      fill: const Color(0x28E9A41A),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 4);
    final radius = math.min(size.width, size.height) * 0.36;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 28;

    paint.color = const Color(0xFF1E2A78);
    canvas.drawArc(rect, -math.pi / 2, math.pi * 1.86, false, paint);
    paint.color = const Color(0xFFE9A41A);
    canvas.drawArc(rect, math.pi * 1.37, math.pi * 0.13, false, paint);
    paint.color = Colors.white;
    canvas.drawArc(rect, math.pi * 1.49, math.pi * 0.03, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PlacementDonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 - 8);
    final radius = math.min(size.width, size.height) * 0.34;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 27;
    paint.color = const Color(0xFF1E2A78);
    canvas.drawArc(rect, -math.pi / 2, math.pi * 1.08, false, paint);
    paint.color = const Color(0xFFE9A41A);
    canvas.drawArc(rect, math.pi * 0.61, math.pi * 0.50, false, paint);
    paint.color = const Color(0xFF119C91);
    canvas.drawArc(rect, math.pi * 1.13, math.pi * 0.32, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PlacementBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawBarChart(
      canvas,
      size,
      [77, 0, 86],
      ['Artificial Intel...', 'Electrical & Ele...', 'Civil Engineering'],
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FacultyBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawDualBarChart(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _drawBarChart(
  Canvas canvas,
  Size size,
  List<double> values,
  List<String> labels,
) {
  const left = 38.0;
  const right = 10.0;
  const top = 12.0;
  const bottom = 38.0;
  final chartHeight = size.height - top - bottom;
  final chartWidth = size.width - left - right;

  final grid = Paint()
    ..color = const Color(0xFFE7EDF3)
    ..strokeWidth = 1;
  final textStyle = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 9,
    color: const Color(0xFF8DA0B8),
  );
  for (var i = 0; i <= 4; i++) {
    final y = top + chartHeight * i / 4;
    canvas.drawLine(Offset(left, y), Offset(size.width - right, y), grid);
    final tp = TextPainter(
      text: TextSpan(text: '${100 - i * 25}', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(8, y - tp.height / 2));
  }

  final barWidth = chartWidth / values.length * 0.24;
  for (var i = 0; i < values.length; i++) {
    final x = left + chartWidth * (i + 0.5) / values.length - barWidth / 2;
    final barHeight = chartHeight * values[i] / 100;
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(x, top + chartHeight - barHeight, barWidth, barHeight),
      const Radius.circular(4),
    );
    canvas.drawRRect(
      rect,
      Paint()
        ..color = i == 2 ? const Color(0xFF1E2A78) : const Color(0xFF243D7A),
    );
    final tp = TextPainter(
      text: TextSpan(text: labels[i], style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(
      canvas,
      Offset(
        left + chartWidth * (i + 0.5) / values.length - tp.width / 2,
        size.height - 26,
      ),
    );
  }
}

void _drawDualBarChart(Canvas canvas, Size size) {
  const left = 38.0;
  const right = 10.0;
  const top = 12.0;
  const bottom = 38.0;
  final chartHeight = size.height - top - bottom;
  final chartWidth = size.width - left - right;
  final grid = Paint()
    ..color = const Color(0xFFE7EDF3)
    ..strokeWidth = 1;
  final textStyle = TextStyle(
    fontFamily: GoogleFonts.poppins().fontFamily,
    fontSize: 9,
    color: const Color(0xFF8DA0B8),
  );
  for (var i = 0; i <= 4; i++) {
    final y = top + chartHeight * i / 4;
    canvas.drawLine(Offset(left, y), Offset(size.width - right, y), grid);
    final tp = TextPainter(
      text: TextSpan(text: '${16 - i * 4}', style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(8, y - tp.height / 2));
  }

  final labels = [
    'Artificial Intel...',
    'Electrical & Ele...',
    'Civil Engineering',
  ];
  final courses = [13, 2, 1];
  final faculty = [3, 0, 0];
  for (var i = 0; i < labels.length; i++) {
    final centerX = left + chartWidth * (i + 0.5) / labels.length;
    final courseHeight = chartHeight * courses[i] / 16;
    final facultyHeight = chartHeight * faculty[i] / 16;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          centerX - 25,
          top + chartHeight - courseHeight,
          18,
          courseHeight,
        ),
        const Radius.circular(3),
      ),
      Paint()..color = const Color(0xFF1E2A78),
    );
    if (facultyHeight > 0) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            centerX - 4,
            top + chartHeight - facultyHeight,
            18,
            facultyHeight,
          ),
          const Radius.circular(3),
        ),
        Paint()..color = const Color(0xFFE9A41A),
      );
    }
    final tp = TextPainter(
      text: TextSpan(text: labels[i], style: textStyle),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(centerX - tp.width / 2, size.height - 26));
  }
}
