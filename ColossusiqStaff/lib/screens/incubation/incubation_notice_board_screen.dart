import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INCUBATION HEAD: NOTICE BOARD SCREEN (Matches Image 2)
// - Blueprint Hero Banner: "Home > Overview > Notice Board", badges OVERVIEW, MVP
// - Navigation Pill Tabs: Notices, New notice, Sent by me
// - Left Sidebar: Search, Status filters (All notices, Unread, Important & urgent, To acknowledge)
//   and Category chips (All, Academic, Examination, Event, Placement, Holiday, Fees, Hostel & Transport, General)
// - Right Panel: Technical blueprint grid background with centered empty state ("No notices yet")
// =============================================================================

class IncubationNoticeBoardScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const IncubationNoticeBoardScreen({super.key, this.onBack});

  @override
  State<IncubationNoticeBoardScreen> createState() =>
      _IncubationNoticeBoardScreenState();
}

class _IncubationNoticeBoardScreenState extends State<IncubationNoticeBoardScreen> {
  int _activePillTab = 0; // 0: Notices, 1: New notice, 2: Sent by me
  int _activeStatusFilter = 0; // 0: All notices, 1: Unread, 2: Important & urgent, 3: To acknowledge
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'Academic',
    'Examination',
    'Event',
    'Placement',
    'Holiday',
    'Fees',
    'Hostel & Transport',
    'General',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 950;
          final horizPadding = constraints.maxWidth >= 1100
              ? 32.0
              : constraints.maxWidth >= 600
                  ? 20.0
                  : 14.0;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(horizPadding, 20, horizPadding, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HERO BLUEPRINT BANNER (Image 2)
                _buildHeroBanner(context),
                const SizedBox(height: 20),

                // 2. TOP PILL TABS: Notices, New notice, Sent by me
                _buildTopPillTabs(),
                const SizedBox(height: 20),

                // 3. MAIN CONTENT: Left Sidebar + Right Grid Empty State
                if (isDesktop)
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          width: 250,
                          child: _buildSidebar(),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildMainContentPanel(),
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildSidebar(),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 380,
                        child: _buildMainContentPanel(),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER
  // ===========================================================================
  Widget _buildHeroBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF131B4D), Color(0xFF1D2866), Color(0xFF273680)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B4D).withValues(alpha: 0.25),
            blurRadius: 16,
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

            // Subtle decorative rounded shape on right (Image 2)
            Positioned(
              right: -30,
              top: -30,
              bottom: -30,
              child: Container(
                width: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                    width: 38,
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
                  // Breadcrumbs & Back button
                  Row(
                    children: [
                      if (widget.onBack != null) ...[
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        'Home',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(Icons.chevron_right_rounded,
                            size: 14, color: Color(0xFF94A3B8)),
                      ),
                      Text(
                        'Overview',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(Icons.chevron_right_rounded,
                            size: 14, color: Color(0xFF94A3B8)),
                      ),
                      Text(
                        'Notice Board',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Badges: OVERVIEW, MVP
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          'OVERVIEW',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D9488),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'MVP',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Icon + Title & Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E3B7D),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: const Icon(
                          Icons.notifications_active_rounded,
                          color: Color(0xFFFBBF24), // Yellow Bell (Image 2)
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Notice Board',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Important announcements from your faculty, HOD, Principal and the University, with read and acknowledgement tracking.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFFCBD5E1),
                                height: 1.4,
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
  // 2. TOP PILL TABS (Image 2)
  // ===========================================================================
  Widget _buildTopPillTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildPillTabItem(
            index: 0,
            icon: Icons.notifications_none_rounded,
            label: 'Notices',
          ),
          const SizedBox(width: 8),
          _buildPillTabItem(
            index: 1,
            icon: Icons.campaign_outlined,
            label: 'New notice',
          ),
          const SizedBox(width: 8),
          _buildPillTabItem(
            index: 2,
            icon: Icons.send_outlined,
            label: 'Sent by me',
          ),
        ],
      ),
    );
  }

  Widget _buildPillTabItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _activePillTab == index;
    return InkWell(
      onTap: () {
        setState(() => _activePillTab = index);
        if (index != 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label view selected', style: GoogleFonts.poppins()),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E2865) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFE2E8F0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: isSelected ? Colors.white : const Color(0xFF475569),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF334155),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. LEFT SIDEBAR (Filters & Categories)
  // ===========================================================================
  Widget _buildSidebar() {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // Search input
          Container(
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.poppins(fontSize: 12.5),
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                prefixIcon: Icon(Icons.search_rounded, size: 16, color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Status Filter Items
          _buildSidebarFilterItem(0, 'All notices', 0),
          _buildSidebarFilterItem(1, 'Unread', 0),
          _buildSidebarFilterItem(2, 'Important & urgent', 0),
          _buildSidebarFilterItem(3, 'To acknowledge', 0),

          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 14),

          // Category Header
          Text(
            'CATEGORY',
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 10),

          // Category Chips
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: _categories.map((cat) {
              final isCatSelected = _selectedCategory == cat;
              return InkWell(
                onTap: () => setState(() => _selectedCategory = cat),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isCatSelected ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isCatSelected
                          ? const Color(0xFF0F172A)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Text(
                    cat,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: isCatSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isCatSelected ? Colors.white : const Color(0xFF475569),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarFilterItem(int index, String label, int count) {
    final isSelected = _activeStatusFilter == index;
    return InkWell(
      onTap: () => setState(() => _activeStatusFilter = index),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? const Color(0xFF1E2865) : const Color(0xFF475569),
              ),
            ),
            Text(
              '$count',
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? const Color(0xFF1E2865) : const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. MAIN CONTENT PANEL (Blueprint grid patterned empty state)
  // ===========================================================================
  Widget _buildMainContentPanel() {
    return Container(
      constraints: const BoxConstraints(minHeight: 320),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            // Faint blueprint technical grid background (Image 2)
            Positioned.fill(
              child: CustomPaint(
                painter: _LightGridPainter(),
              ),
            ),

            // Centered empty state text
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'No notices yet',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Announcements from your college and the university will appear here.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// GRID PAINTERS
// =============================================================================

class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
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

class _LightGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.5)
      ..strokeWidth = 0.8;

    const double step = 26.0;

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
