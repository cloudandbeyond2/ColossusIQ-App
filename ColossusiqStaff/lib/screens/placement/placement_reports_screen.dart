import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INSTITUTION / PLACEMENT: REPORTS SCREEN
// Exactly matches Screenshots 4 & 5:
// - Blueprint grid hero banner with document watermark, INSTITUTION and Phase 3 badges
// - 4 KPI Metric Cards:
//   1. REPORTS READY: 0, PLACEMENT (badge), All certified, PDF, Excel & CSV available
//   2. SCHEDULED AUTO-RUNS: 0 active crons, Next run: Monday 08:00 AM
//   3. DATA EXPORT VOLUME: 48.2 MB this term, Institutional data warehouse
//   4. ACCREDITATION READY: 100% compliant, NAAC & NBA formats supported
// - Filter & Action Card:
//   * Search input: "Search reports by title, scope or keyword..."
//   * "+ Generate report" primary action button
//   * Type chips: All, Academic, Department, Placement, Faculty, Compliance, Institution
//   * Dropdowns: All Scopes, All Periods
// - Tabs:
//   1. Generated Reports (0)
//   2. Automated Schedules (0)
// - Tab 1 Content: Blueprint empty state with "+ Generate report"
// - Tab 2 Content: Automated Cron Delivery Schedules with "0 Schedules Active" badge
// =============================================================================

class PlacementReportsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PlacementReportsScreen({super.key, this.onBack});

  @override
  State<PlacementReportsScreen> createState() => _PlacementReportsScreenState();
}

class _PlacementReportsScreenState extends State<PlacementReportsScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedTabIndex = 0; // 0: Generated Reports, 1: Automated Schedules
  String _selectedType = 'All';
  String _selectedScope = 'All Scopes';
  String _selectedPeriod = 'All Periods';

  final List<String> _types = [
    'All',
    'Academic',
    'Department',
    'Placement',
    'Faculty',
    'Compliance',
    'Institution',
  ];

  final List<String> _scopes = [
    'All Scopes',
    'Department Level',
    'Institutional',
    'Batch & Cohort',
  ];

  final List<String> _periods = [
    'All Periods',
    'Current Term (2026)',
    'Last 30 Days',
    'Annual 2025-26',
  ];

  final List<Map<String, dynamic>> _reports = [];

  final List<Map<String, dynamic>> _cronSchedules = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredReports() {
    final query = _searchController.text.trim().toLowerCase();
    return _reports.where((r) {
      final matchesQuery = query.isEmpty ||
          (r['title'] as String).toLowerCase().contains(query);
      final matchesType = _selectedType == 'All' || r['type'] == _selectedType;
      return matchesQuery && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredReports = _getFilteredReports();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Hero Banner
              _buildTopHeroBanner(),
              const SizedBox(height: 18),

              // 2. 4 Metric Cards
              _buildMetricCards(),
              const SizedBox(height: 18),

              // 3. Filter & Action Card
              _buildFilterAndActionCard(),
              const SizedBox(height: 18),

              // 4. Tab Bar (Generated Reports / Automated Schedules)
              _buildTabBar(filteredReports.length, _cronSchedules.length),
              const SizedBox(height: 18),

              // 5. Tab Body
              if (_selectedTabIndex == 0)
                _buildGeneratedReportsTab(filteredReports)
              else
                _buildAutomatedSchedulesTab(),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HERO BANNER (Image 4)
  // ===========================================================================
  Widget _buildTopHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF161E4A),
            Color(0xFF222B68),
            Color(0xFF38439E),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            // Watermark document icon
            Positioned(
              right: 15,
              bottom: -20,
              child: Opacity(
                opacity: 0.10,
                child: const Icon(
                  Icons.article_outlined,
                  size: 190,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        if (widget.onBack != null) ...[
                          InkWell(
                            onTap: widget.onBack,
                            borderRadius: BorderRadius.circular(6),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.arrow_back,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                        ],
                        Text(
                          'Home',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('>',
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.5))),
                        const SizedBox(width: 6),
                        Text(
                          'Institution',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text('>',
                            style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.5))),
                        const SizedBox(width: 6),
                        Text(
                          'Reports',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.article_rounded,
                          color: Color(0xFFFBBF24),
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.16),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Text(
                                    'INSTITUTION',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Phase 3',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Reports',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Student, faculty, department, course, skill, placement and institutional reports.',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.85),
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
  }

  // ===========================================================================
  // 2. 4 METRIC CARDS (Image 4)
  // ===========================================================================
  Widget _buildMetricCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int count = 1;
        if (constraints.maxWidth >= 1050) {
          count = 4;
        } else if (constraints.maxWidth >= 680) {
          count = 2;
        }

        final double cardWidth = (constraints.maxWidth - (count - 1) * 14) / count;

        final card1 = Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'REPORTS READY',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const Icon(Icons.description_outlined,
                      size: 16, color: Color(0xFF94A3B8)),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${_reports.length}',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2865),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'PLACEMENT',
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'All certified',
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF16A34A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'PDF, Excel & CSV available',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        );

        final card2 = _buildSimpleKpiCard(
          title: 'SCHEDULED AUTO-RUNS',
          value: '${_cronSchedules.length} active crons',
          subtitle: 'Next run: Monday 08:00 AM',
          icon: Icons.access_time_rounded,
        );

        final card3 = _buildSimpleKpiCard(
          title: 'DATA EXPORT VOLUME',
          value: '48.2 MB this term',
          subtitle: 'Institutional data warehouse',
          icon: Icons.file_download_outlined,
          iconColor: const Color(0xFFD97706),
        );

        final card4 = _buildSimpleKpiCard(
          title: 'ACCREDITATION READY',
          value: '100% compliant',
          valueColor: const Color(0xFF16A34A),
          subtitle: 'NAAC & NBA formats supported',
          icon: Icons.verified_outlined,
          iconColor: const Color(0xFF16A34A),
        );

        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            SizedBox(width: cardWidth, child: card1),
            SizedBox(width: cardWidth, child: card2),
            SizedBox(width: cardWidth, child: card3),
            SizedBox(width: cardWidth, child: card4),
          ],
        );
      },
    );
  }

  Widget _buildSimpleKpiCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    Color? valueColor,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              Icon(icon, size: 16, color: iconColor ?? const Color(0xFF94A3B8)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: valueColor ?? const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. FILTER & ACTION CARD (Image 4) - Fully Responsive
  // ===========================================================================
  Widget _buildFilterAndActionCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 768;
        final isSmallPhone = constraints.maxWidth < 480;

        final searchBar = Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFFAF9F6),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.poppins(fontSize: 12.5),
            decoration: InputDecoration(
              hintText: 'Search reports by title, scope or keyword...',
              hintStyle: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF94A3B8),
              ),
              prefixIcon: const Icon(Icons.search,
                  size: 18, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 10),
            ),
          ),
        );

        final generateBtn = ElevatedButton.icon(
          onPressed: _showGenerateReportDialog,
          icon: const Icon(Icons.add, size: 15),
          label: Text(
            'Generate report',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2865),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 0,
          ),
        );

        final typeChips = SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'TYPE:',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(width: 8),
              ..._types.map((type) {
                final isSelected = _selectedType == type;
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: InkWell(
                    onTap: () => setState(() => _selectedType = type),
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF1E2865)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        type,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );

        final dropdownsDesktop = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 130,
              child: _buildDropdownContainer(
                value: _selectedScope,
                items: _scopes,
                onChanged: (v) => setState(() => _selectedScope = v!),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 140,
              child: _buildDropdownContainer(
                value: _selectedPeriod,
                items: _periods,
                onChanged: (v) => setState(() => _selectedPeriod = v!),
              ),
            ),
          ],
        );

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Row 1: Search + Generate report (Responsive)
              if (isSmallPhone) ...[
                searchBar,
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: generateBtn,
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(child: searchBar),
                    const SizedBox(width: 12),
                    generateBtn,
                  ],
                ),
              ],
              const SizedBox(height: 14),

              // Row 2: Type Chips + Scope & Period Dropdowns (Responsive)
              if (isDesktop) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: typeChips),
                    const SizedBox(width: 12),
                    dropdownsDesktop,
                  ],
                ),
              ] else ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    typeChips,
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdownContainer(
                            value: _selectedScope,
                            items: _scopes,
                            onChanged: (v) =>
                                setState(() => _selectedScope = v!),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildDropdownContainer(
                            value: _selectedPeriod,
                            items: _periods,
                            onChanged: (v) =>
                                setState(() => _selectedPeriod = v!),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildDropdownContainer({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              size: 14, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF334155),
            fontWeight: FontWeight.w500,
          ),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. TAB BAR (Image 4 & 5)
  // ===========================================================================
  Widget _buildTabBar(int reportsCount, int cronCount) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _buildTabItem(
              index: 0,
              icon: Icons.description_outlined,
              label: 'Generated Reports ($reportsCount)',
            ),
            const SizedBox(width: 16),
            _buildTabItem(
              index: 1,
              icon: Icons.access_time_rounded,
              label: 'Automated Schedules ($cronCount)',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedTabIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: isSelected
              ? const Border(
                  bottom: BorderSide(color: Color(0xFF1E2865), width: 2.5),
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: isSelected
                  ? const Color(0xFF1E2865)
                  : const Color(0xFF64748B),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF1E2865)
                    : const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 5A. TAB 1: GENERATED REPORTS CONTENT (Image 4)
  // ===========================================================================
  Widget _buildGeneratedReportsTab(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _BlueprintGridPainter(),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No reports match your filters',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Generate a report using the button above.',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: _showGenerateReportDialog,
                      icon: const Icon(Icons.add, size: 15),
                      label: Text(
                        'Generate report',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2865),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
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

    return Column(
      children: items.map((r) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.picture_as_pdf_rounded,
                    color: Color(0xFF1E2865), size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      r['title'] as String,
                      style: GoogleFonts.poppins(
                          fontSize: 13.5, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${r['type']} · ${r['date']} · ${r['size']}",
                      style: GoogleFonts.poppins(
                          fontSize: 11.5, color: const Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Downloading ${r['title']}..."),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.file_download_outlined,
                    color: Color(0xFF1E2865)),
                tooltip: 'Download report',
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ===========================================================================
  // 5B. TAB 2: AUTOMATED CRON DELIVERY SCHEDULES (Image 5)
  // ===========================================================================
  Widget _buildAutomatedSchedulesTab() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Automated Cron Delivery Schedules',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFCCFBF1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_cronSchedules.length} Schedules Active',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F766E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Configured reports run automatically in the background and deliver PDF/Excel digests to recipient inboxes.',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),

          if (_cronSchedules.isEmpty) ...[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFFFAF9F6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  const Icon(Icons.schedule_rounded,
                      size: 32, color: Color(0xFF94A3B8)),
                  const SizedBox(height: 8),
                  Text(
                    'No automated cron delivery schedules configured.',
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Create automated recurring exports for NIRF audits, NAAC progression and placement reports.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 14),
                  OutlinedButton.icon(
                    onPressed: _showAddCronScheduleDialog,
                    icon: const Icon(Icons.add, size: 14),
                    label: Text('Create Cron Schedule',
                        style: GoogleFonts.poppins(fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1E2865),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            ..._cronSchedules.map((cron) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF9F6),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.alarm_on_rounded,
                        color: Color(0xFF16A34A), size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cron['title'],
                              style: GoogleFonts.poppins(
                                  fontSize: 12.5, fontWeight: FontWeight.w600)),
                          Text(
                              "${cron['frequency']} · Recipient: ${cron['email']}",
                              style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B))),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  // ===========================================================================
  // MODALS: GENERATE REPORT & CRON SCHEDULE
  // ===========================================================================
  void _showGenerateReportDialog() {
    final titleCtrl = TextEditingController(
        text: 'NIRF 2026 Student Placement Audit Report');
    String reportType = 'Placement';

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(builder: (context, setModalState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            title: Text(
              'Generate Institutional Report',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w700),
            ),
            content: SizedBox(
              width: 440,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Report Title',
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: reportType,
                    decoration: const InputDecoration(
                      labelText: 'Report Category',
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'Placement', child: Text('Placement')),
                      DropdownMenuItem(
                          value: 'Academic', child: Text('Academic')),
                      DropdownMenuItem(
                          value: 'Compliance', child: Text('Compliance')),
                      DropdownMenuItem(
                          value: 'Institution', child: Text('Institution')),
                    ],
                    onChanged: (v) {
                      if (v != null) setModalState(() => reportType = v);
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Cancel', style: GoogleFonts.poppins()),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (titleCtrl.text.trim().isNotEmpty) {
                    setState(() {
                      _reports.insert(0, {
                        'title': titleCtrl.text.trim(),
                        'type': reportType,
                        'date': 'Generated Today',
                        'size': '2.4 MB',
                      });
                    });
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            "Report '${titleCtrl.text.trim()}' generated successfully.",
                            style: GoogleFonts.poppins()),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: Text('Generate', style: GoogleFonts.poppins()),
              ),
            ],
          );
        });
      },
    );
  }

  void _showAddCronScheduleDialog() {
    final titleCtrl = TextEditingController(
        text: 'Weekly Placement Summary & NIRF Audit');
    final emailCtrl = TextEditingController(text: 'placement.reports@college.edu');
    String frequency = 'Every Monday at 08:00 AM';

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(builder: (context, setModalState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16)),
            title: Text(
              'New Automated Cron Schedule',
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w700),
            ),
            content: SizedBox(
              width: 440,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Schedule Title',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Delivery Recipient Email',
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    initialValue: frequency,
                    decoration: const InputDecoration(
                      labelText: 'Cron Recurrence',
                    ),
                    items: const [
                      DropdownMenuItem(
                          value: 'Every Monday at 08:00 AM',
                          child: Text('Weekly: Monday at 08:00 AM')),
                      DropdownMenuItem(
                          value: '1st of Every Month',
                          child: Text('Monthly: 1st day at 09:00 AM')),
                      DropdownMenuItem(
                          value: 'Daily at 06:00 PM',
                          child: Text('Daily Digest: 06:00 PM')),
                    ],
                    onChanged: (v) {
                      if (v != null) setModalState(() => frequency = v);
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Cancel', style: GoogleFonts.poppins()),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _cronSchedules.insert(0, {
                      'title': titleCtrl.text.trim(),
                      'email': emailCtrl.text.trim(),
                      'frequency': frequency,
                    });
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Automated cron schedule added.",
                          style: GoogleFonts.poppins()),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Text('Save Schedule', style: GoogleFonts.poppins()),
              ),
            ],
          );
        });
      },
    );
  }
}

// =============================================================================
// BLUEPRINT GRID PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.6)
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
