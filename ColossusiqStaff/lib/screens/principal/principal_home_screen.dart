import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'principal_screens.dart';

// =============================================================================
// PRINCIPAL: COMMAND CENTER / HOME DASHBOARD
// Matches:
// - Image 1: College Command Center Hero Banner, 7 Top KPI Cards,
//            Department Breakdown Bar Chart, Admissions Pipeline Bar Chart,
//            Needs Your Attention Action List
// - Image 2: Academic Departments Snapshot Table, AI Insights (Part 1)
// - Image 3: AI Insights (Part 2 & Footer), Management Modules (8 interactive cards)
// =============================================================================

class PrincipalHomeScreen extends StatelessWidget {
  final Function(Widget, {String? title, Widget? badge}) onOpenSubScreen;
  const PrincipalHomeScreen({super.key, required this.onOpenSubScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas matching screenshot
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 1050;
          final isMedium = constraints.maxWidth >= 720;
          final horizPadding = constraints.maxWidth >= 1100
              ? 32.0
              : constraints.maxWidth >= 600
                  ? 20.0
                  : 14.0;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(horizPadding, 20, horizPadding, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HERO BLUEPRINT BANNER (Image 1)
                _buildHeroBanner(context, isWide),
                const SizedBox(height: 20),

                // 2. 7 KPI METRIC CARDS (Image 1)
                _buildKpiMetrics(isWide, isMedium),
                const SizedBox(height: 24),

                // 3. MIDDLE SECTION (Image 1: Dept Breakdown + Admissions Pipeline + Needs Attention)
                _buildMiddleSection(context, isWide, isMedium),
                const SizedBox(height: 24),

                // 4. ACADEMIC DEPARTMENTS SNAPSHOT TABLE (Image 2)
                _buildAcademicDepartmentsTable(context),
                const SizedBox(height: 24),

                // 5. AI INSIGHTS CARD (Image 2 & Image 3)
                _buildAiInsightsCard(),
                const SizedBox(height: 28),

                // 6. MANAGEMENT MODULES (Image 3)
                _buildManagementModules(isWide, isMedium),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER (Image 1)
  // ===========================================================================
  Widget _buildHeroBanner(BuildContext context, bool isWide) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF131B4D), // Deep Royal Navy
            Color(0xFF1D2866),
            Color(0xFF283685),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B4D).withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Technical Blueprint Grid Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),

            // Decorative Institutional Watermark
            Positioned(
              right: -25,
              top: -25,
              bottom: -25,
              child: Opacity(
                opacity: 0.08,
                child: Container(
                  width: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 32),
                  ),
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges Row
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.account_balance_outlined, color: Colors.white, size: 13),
                            const SizedBox(width: 6),
                            Text(
                              'College Command Center',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildPillTag('Affiliation #1101'),
                      _buildPillTag('Chennai'),
                      _buildPillTag('Engineering'),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Title and Actions Layout
                  isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Anna Institute of Technology — Command Center',
                                    style: GoogleFonts.poppins(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Dr. Lakshmi Sundaram · Live institutional command center with real-time analytics across admissions, faculty, academic departments, courses and readiness.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xFFCBD5E1),
                                      height: 1.45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            _buildHeroActions(),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Anna Institute of Technology — Command Center',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Dr. Lakshmi Sundaram · Live institutional command center with real-time analytics across admissions, faculty, academic departments, courses and readiness.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: const Color(0xFFCBD5E1),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildHeroActions(),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPillTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFE2E8F0),
        ),
      ),
    );
  }

  Widget _buildHeroActions() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        // + New Admission Button
        ElevatedButton.icon(
          onPressed: () {
            onOpenSubScreen(
              const PrincipalStudentAdmissionsScreen(),
              title: 'Student Admissions',
            );
          },
          icon: const Icon(Icons.add_rounded, size: 16, color: Color(0xFF1E293B)),
          label: Text(
            'New Admission',
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE5A93C), // Amber/gold
            foregroundColor: const Color(0xFF1E293B),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),

        // Departments Button
        ElevatedButton(
          onPressed: () {
            onOpenSubScreen(
              const PrincipalDepartmentsScreen(),
              title: 'Departments',
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1A2350), // Navy
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
            ),
          ),
          child: Text(
            'Departments',
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),

        // Staff Roster Button
        ElevatedButton(
          onPressed: () {
            onOpenSubScreen(
              const PrincipalStaffManagementScreen(),
              title: 'Staff Directory',
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E3378), // Purple/Navy
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.white.withValues(alpha: 0.15)),
            ),
          ),
          child: Text(
            'Staff Roster',
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 2. 7 KPI METRIC CARDS (Image 1)
  // ===========================================================================
  Widget _buildKpiMetrics(bool isWide, bool isMedium) {
    final metrics = [
      _KpiData(
        title: 'Students',
        value: '3,258',
        badge: '~ 0% capacity filled',
        accentColor: const Color(0xFF1E2865), // Navy
        icon: Icons.groups_outlined,
        iconBg: const Color(0xFFF1F5F9),
        iconColor: const Color(0xFF475569),
        badgeBg: const Color(0xFFE6F4EA),
        badgeColor: const Color(0xFF047857),
      ),
      _KpiData(
        title: 'Teaching faculty',
        value: '2',
        badge: '~ 4 total staff on record',
        accentColor: const Color(0xFF0D9488), // Teal
        icon: Icons.co_present_outlined,
        iconBg: const Color(0xFFE6FFFA),
        iconColor: const Color(0xFF0D9488),
        badgeBg: const Color(0xFFE6FFFA),
        badgeColor: const Color(0xFF0F766E),
      ),
      _KpiData(
        title: 'Departments',
        value: '8',
        badge: '~ 8 active',
        accentColor: const Color(0xFF2563EB), // Blue
        icon: Icons.domain_rounded,
        iconBg: const Color(0xFFEFF6FF),
        iconColor: const Color(0xFF2563EB),
        badgeBg: const Color(0xFFE0F2FE),
        badgeColor: const Color(0xFF0284C7),
      ),
      _KpiData(
        title: 'Active courses',
        value: '5',
        badge: '~ Curriculum active',
        accentColor: const Color(0xFF0284C7), // Sky Blue
        icon: Icons.menu_book_rounded,
        iconBg: const Color(0xFFE0F2FE),
        iconColor: const Color(0xFF0284C7),
        badgeBg: const Color(0xFFE0F2FE),
        badgeColor: const Color(0xFF0284C7),
      ),
      _KpiData(
        title: 'Admissions pipeline',
        value: '8',
        badge: '~ 1 enrolled',
        accentColor: const Color(0xFFD97706), // Amber
        icon: Icons.trending_up_rounded,
        iconBg: const Color(0xFFFEF3C7),
        iconColor: const Color(0xFFD97706),
        badgeBg: const Color(0xFFD1FAE5),
        badgeColor: const Color(0xFF047857),
      ),
      _KpiData(
        title: 'Placement readiness',
        value: '80%',
        badge: '~ +10% vs target',
        accentColor: const Color(0xFF0D9488), // Emerald / Teal
        icon: Icons.work_outline_rounded,
        iconBg: const Color(0xFFE6FFFA),
        iconColor: const Color(0xFF0D9488),
        badgeBg: const Color(0xFFD1FAE5),
        badgeColor: const Color(0xFF047857),
      ),
      _KpiData(
        title: 'Campus events',
        value: '2',
        badge: '~ 1 draft',
        accentColor: const Color(0xFF2563EB), // Blue
        icon: Icons.apartment_rounded,
        iconBg: const Color(0xFFEFF6FF),
        iconColor: const Color(0xFF2563EB),
        badgeBg: const Color(0xFFE0F2FE),
        badgeColor: const Color(0xFF0284C7),
      ),
    ];

    if (isWide) {
      return Column(
        children: [
          Row(
            children: metrics
                .take(6)
                .map((m) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: _buildMetricCard(m),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 180,
                child: _buildMetricCard(metrics[6]),
              ),
              const Spacer(),
            ],
          ),
        ],
      );
    } else if (isMedium) {
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: metrics.map((m) {
          return SizedBox(
            width: 220,
            child: _buildMetricCard(m),
          );
        }).toList(),
      );
    } else {
      return Column(
        children: metrics.map((m) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _buildMetricCard(m),
          );
        }).toList(),
      );
    }
  }

  Widget _buildMetricCard(_KpiData data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Colored Top Accent Line
            Container(
              height: 3.5,
              color: data.accentColor,
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          data.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: data.iconBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(data.icon, color: data.iconColor, size: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.value,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: data.badgeBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      data.badge,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: data.badgeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. MIDDLE SECTION: 2 Charts + Needs Your Attention (Image 1)
  // ===========================================================================
  Widget _buildMiddleSection(BuildContext context, bool isWide, bool isMedium) {
    if (isWide) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Department breakdown chart
            Expanded(
              flex: 4,
              child: _buildDeptBreakdownCard(),
            ),
            const SizedBox(width: 16),

            // 2. Admissions conversion pipeline chart
            Expanded(
              flex: 4,
              child: _buildAdmissionsPipelineCard(),
            ),
            const SizedBox(width: 16),

            // 3. Needs your attention
            Expanded(
              flex: 3,
              child: _buildNeedsAttentionCard(context),
            ),
          ],
        ),
      );
    } else if (isMedium) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildDeptBreakdownCard()),
              const SizedBox(width: 14),
              Expanded(child: _buildAdmissionsPipelineCard()),
            ],
          ),
          const SizedBox(height: 14),
          _buildNeedsAttentionCard(context),
        ],
      );
    } else {
      return Column(
        children: [
          _buildDeptBreakdownCard(),
          const SizedBox(height: 14),
          _buildAdmissionsPipelineCard(),
          const SizedBox(height: 14),
          _buildNeedsAttentionCard(context),
        ],
      );
    }
  }

  // Card 1: Department breakdown (Students & Faculty)
  Widget _buildDeptBreakdownCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Department breakdown (Students & Faculty)',
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),

          // Custom Bar Chart Area
          SizedBox(
            height: 190,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Y-axis labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    _YLabel('600'),
                    _YLabel('450'),
                    _YLabel('300'),
                    _YLabel('150'),
                    _YLabel('0'),
                  ],
                ),
                const SizedBox(width: 8),

                // Chart Grid & Bars
                Expanded(
                  child: Stack(
                    children: [
                      // Horizontal grid lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          5,
                          (_) => const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFF1F5F9),
                          ),
                        ),
                      ),

                      // Vertical Bars
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            _VerticalBar(ratio: 530 / 600),
                            _VerticalBar(ratio: 442 / 600),
                            _VerticalBar(ratio: 253 / 600),
                            _VerticalBar(ratio: 335 / 600),
                            _VerticalBar(ratio: 465 / 600),
                            _VerticalBar(ratio: 360 / 600),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // X-Axis Labels
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Information Tech.',
                    style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B))),
                Text('Electronics &',
                    style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B))),
                Text('Mechanical Eng.',
                    style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF64748B))),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendDot(const Color(0xFF1E2865), 'Students'),
              const SizedBox(width: 16),
              _buildLegendDot(const Color(0xFFD97706), 'Faculty'),
            ],
          ),
        ],
      ),
    );
  }

  // Card 2: Admissions conversion pipeline
  Widget _buildAdmissionsPipelineCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admissions conversion pipeline',
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),

          // Custom Bar Chart Area
          SizedBox(
            height: 190,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Y-axis labels
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    _YLabel('3'),
                    _YLabel('2.25'),
                    _YLabel('1.5'),
                    _YLabel('0.75'),
                    _YLabel('0'),
                  ],
                ),
                const SizedBox(width: 8),

                // Chart Grid & Bars
                Expanded(
                  child: Stack(
                    children: [
                      // Horizontal grid lines
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          5,
                          (_) => const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFF1F5F9),
                          ),
                        ),
                      ),

                      // Vertical Bars: Enquiry(0), Applied(0), Verified(3.0), Shortlisted(1.0), Fee Paid(0), Enrolled(1.0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            _VerticalBar(ratio: 0.0),
                            _VerticalBar(ratio: 0.0),
                            _VerticalBar(ratio: 1.0), // 3 of 3
                            _VerticalBar(ratio: 0.33), // 1 of 3
                            _VerticalBar(ratio: 0.0),
                            _VerticalBar(ratio: 0.33), // 1 of 3
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // X-Axis Labels
          Padding(
            padding: const EdgeInsets.only(left: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildXAxisLabel('Enquiry'),
                _buildXAxisLabel('Applied'),
                _buildXAxisLabel('Verified'),
                _buildXAxisLabel('Shortlisted'),
                _buildXAxisLabel('Fee Paid'),
                _buildXAxisLabel('Enrolled'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXAxisLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 10,
        color: const Color(0xFF64748B),
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF475569)),
        ),
      ],
    );
  }

  // Card 3: Needs your attention
  Widget _buildNeedsAttentionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Needs your attention',
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '3 actionable items',
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          // Item 1: Publish 1 upcoming campus event
          _buildActionItem(
            accentColor: const Color(0xFF10B981), // Emerald/Green
            title: 'Publish 1 upcoming campus event',
            subtitle: 'Campus calendar & registration',
            onTap: () {
              onOpenSubScreen(
                const PrincipalCampusEventsScreen(),
                title: 'Campus Events',
              );
            },
          ),
          const SizedBox(height: 12),

          // Item 2: Institutional Knowledge Base (RAG)
          _buildActionItem(
            accentColor: const Color(0xFF2563EB), // Blue
            title: 'Institutional Knowledge Base (RAG)',
            subtitle: 'Regulations, handbooks and syllabus',
            onTap: () {
              onOpenSubScreen(
                const PrincipalInstitutionalKnowledgeScreen(),
                title: 'RAG Knowledge Base',
              );
            },
          ),
          const SizedBox(height: 12),

          // Item 3: Review 8 departments
          _buildActionItem(
            accentColor: const Color(0xFF0D9488), // Teal
            title: 'Review 8 departments',
            subtitle: 'Department intelligence and staffing allocation',
            onTap: () {
              onOpenSubScreen(
                const PrincipalDepartmentsScreen(),
                title: 'Departments',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required Color accentColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Row(
          children: [
            Container(
              width: 3.5,
              height: 38,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 16,
              color: Color(0xFF94A3B8),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. ACADEMIC DEPARTMENTS SNAPSHOT TABLE (Image 2)
  // ===========================================================================
  Widget _buildAcademicDepartmentsTable(BuildContext context) {
    final rows = [
      _DeptRow('Computer Science & Engineering', 'Dr. Sneha Reddy', '1', '530', '3', 0.75, '75%'),
      _DeptRow('Information Technology', 'Dr. Vignesh Rao', '0', '442', '2', 0.82, '82%'),
      _DeptRow('Artificial Intelligence & Data Science', 'Dr. Aishwarya Mohan', '0', '253', '2', 0.83, '83%'),
      _DeptRow('Electronics & Communication', 'Dr. Arjun Subramanian', '1', '335', '3', 0.80, '80%'),
      _DeptRow('Electrical & Electronics', 'Dr. Meera Joseph', '0', '465', '1', 0.80, '80%'),
      _DeptRow('Mechanical Engineering', 'Dr. Harish Kumar', '0', '360', '1', 0.75, '75%'),
      _DeptRow('Civil Engineering', 'Dr. Kavya Menon', '0', '346', '2', 0.81, '81%'),
      _DeptRow('Science & Humanities', 'Dr. Nikhil Khan', '0', '527', '3', 0.87, '87%'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table Card Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Academic Departments Snapshot',
                        style: GoogleFonts.poppins(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Live staffing, student enrolment and placement readiness across departments',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    onOpenSubScreen(
                      const PrincipalDepartmentsScreen(),
                      title: 'Departments',
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View all departments',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_rounded, size: 14, color: Color(0xFF0F172A)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // Scrollable Table for responsiveness
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 800),
              child: DataTable(
                columnSpacing: 24,
                horizontalMargin: 20,
                headingRowHeight: 44,
                dataRowMinHeight: 52,
                dataRowMaxHeight: 56,
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
                columns: const [
                  DataColumn(label: Text('DEPARTMENT')),
                  DataColumn(label: Text('HEAD OF DEPARTMENT')),
                  DataColumn(label: Text('FACULTY'), numeric: true),
                  DataColumn(label: Text('STUDENTS'), numeric: true),
                  DataColumn(label: Text('PROGRAMMES'), numeric: true),
                  DataColumn(label: Text('PLACEMENT READINESS')),
                ],
                rows: rows.map((r) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          r.department,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          r.hod,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          r.faculty,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          r.students,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          r.programmes,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 140,
                          child: Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: r.readinessRatio,
                                    minHeight: 6,
                                    backgroundColor: const Color(0xFFF3EFE6), // Soft warm track
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                      Color(0xFF0F766E), // Dark Teal
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                r.readinessText,
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ===========================================================================
  // 5. AI INSIGHTS CARD (Image 2 & Image 3)
  // ===========================================================================
  Widget _buildAiInsightsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.lightbulb_outline_rounded,
                        color: Color(0xFFD97706),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'AI insights',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Text(
                    'Evidence-linked',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // 3 Insight Items
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInsightBullet(
                  title: 'Admissions & Intake Progress',
                  body:
                      '1 of 6600 sanctioned seats enrolled (0% intake). Total pipeline stands at 8 applicants across all quotas.',
                  evidence: 'Evidence: Anna Institute of Technology admissions registry',
                ),
                const SizedBox(height: 16),
                _buildInsightBullet(
                  title: 'Faculty-to-Student Ratio',
                  body:
                      'Current ratio is 1:1629 across 8 academic departments (2 active teaching staff for 3,258 students).',
                  evidence: 'Evidence: Staff records vs department enrolments',
                ),
                const SizedBox(height: 16),
                _buildInsightBullet(
                  title: 'Department Placement Readiness Lead',
                  body:
                      'Science & Humanities leads institutional readiness at 87% with 3 active programmes and 0 teaching staff.',
                  evidence: 'Evidence: Placement readiness analytics',
                ),
              ],
            ),
          ),

          // Footer
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Text(
              'Insights support — not replace — human decisions.',
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: const Color(0xFF94A3B8),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightBullet({
    required String title,
    required String body,
    required String evidence,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 7,
          height: 7,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFB45309), // Amber/Rust bullet dot
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                body,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF475569),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                evidence,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 6. MANAGEMENT MODULES (Image 3)
  // ===========================================================================
  Widget _buildManagementModules(bool isWide, bool isMedium) {
    final modules = [
      _ModuleItem(
        icon: Icons.school_outlined,
        title: 'Admissions',
        description: 'Student application pipeline & enrollment',
        destination: const PrincipalStudentAdmissionsScreen(),
      ),
      _ModuleItem(
        icon: Icons.people_outline_rounded,
        title: 'Staff Directory',
        description: 'Teaching & administrative faculty records',
        destination: const PrincipalStaffManagementScreen(),
      ),
      _ModuleItem(
        icon: Icons.apartment_rounded,
        title: 'Departments',
        description: 'Academic departments & performance',
        destination: const PrincipalDepartmentsScreen(),
      ),
      _ModuleItem(
        icon: Icons.menu_book_rounded,
        title: 'Courses & Curriculum',
        description: 'Active & draft courses across semesters',
        destination: const PrincipalCourseManagementScreen(),
      ),
      _ModuleItem(
        icon: Icons.calendar_month_outlined,
        title: 'Campus Events',
        description: 'Seminars, workshops & campus calendar',
        destination: const PrincipalCampusEventsScreen(),
      ),
      _ModuleItem(
        icon: Icons.person_outline_rounded,
        title: 'User Accounts',
        description: 'Role assignments & security credentials',
        destination: const PrincipalUserManagementScreen(),
      ),
      _ModuleItem(
        icon: Icons.auto_awesome_rounded,
        title: 'RAG Knowledge Base',
        description: 'Institutional guidelines & AI syllabus grounding',
        destination: const PrincipalInstitutionalKnowledgeScreen(),
      ),
      _ModuleItem(
        icon: Icons.description_outlined,
        title: 'Reports & Audits',
        description: 'Accreditation, academic & placement reports',
        destination: const PrincipalReportsScreen(),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Management Modules',
          style: GoogleFonts.poppins(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 14),

        // Grid
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth >= 1050
                ? 4
                : constraints.maxWidth >= 600
                    ? 2
                    : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: modules.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                mainAxisExtent: 140,
              ),
              itemBuilder: (context, index) {
                final m = modules[index];
                return _buildModuleCard(m);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildModuleCard(_ModuleItem item) {
    return InkWell(
      onTap: () {
        onOpenSubScreen(
          item.destination,
          title: item.title,
        );
      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon in rounded grey square
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(item.icon, size: 18, color: const Color(0xFF1E293B)),
            ),
            const SizedBox(height: 10),
            Text(
              item.title,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF64748B),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Text(
                  'Open module',
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E2865),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward_rounded, size: 13, color: Color(0xFF1E2865)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// HELPER MODELS & WIDGETS
// =============================================================================

class _KpiData {
  final String title;
  final String value;
  final String badge;
  final Color accentColor;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final Color badgeBg;
  final Color badgeColor;

  _KpiData({
    required this.title,
    required this.value,
    required this.badge,
    required this.accentColor,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.badgeBg,
    required this.badgeColor,
  });
}

class _DeptRow {
  final String department;
  final String hod;
  final String faculty;
  final String students;
  final String programmes;
  final double readinessRatio;
  final String readinessText;

  _DeptRow(
    this.department,
    this.hod,
    this.faculty,
    this.students,
    this.programmes,
    this.readinessRatio,
    this.readinessText,
  );
}

class _ModuleItem {
  final IconData icon;
  final String title;
  final String description;
  final Widget destination;

  _ModuleItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.destination,
  });
}

class _YLabel extends StatelessWidget {
  final String text;
  const _YLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 10,
        color: const Color(0xFF94A3B8),
      ),
    );
  }
}

class _VerticalBar extends StatelessWidget {
  final double ratio;
  const _VerticalBar({required this.ratio});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: ratio.clamp(0.02, 1.0),
      child: Container(
        width: 22,
        decoration: const BoxDecoration(
          color: Color(0xFF1E2865), // Dark Navy
          borderRadius: BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ),
    );
  }
}

// =============================================================================
// GRID PAINTER
// =============================================================================

class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.0;

    const double step = 28.0;

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
