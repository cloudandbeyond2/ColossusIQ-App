import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INCUBATION HEAD: MENTOR NETWORK SCREEN
// Matches Images 1, 2, 3, 4 & 5:
// - Top Blueprint Hero Banner: "Home > Incubation > Mentor Network", INCUBATION, Phase 2
// - 5 KPI Metric Cards:
//     1. TOTAL MENTORS: 1 (Empanelled advisors)
//     2. AVAILABLE NOW: 1 (Ready for new ventures)
//     3. ACTIVE PAIRINGS: 0 (Ventures being guided)
//     4. SESSIONS LOGGED: 0 (1:1 advisory meetings)
//     5. MENTOR RATING: ★ — (Founder satisfaction score)
// - Filter & Search Bar:
//     - Dropdowns: All Categories, All Availability
//     - Search: "Search mentors, company, skill"
//     - Toggle: Grid / Table
//     - Export CSV button
//     - "+ Invite Mentor" button
// - Grid View (Image 1):
//     - Mentor card: Star bala, VP Product, rental, AI tag, Assigned Ventures box with "+ Pair Venture",
//       contact & sessions info, status dropdown, "Log Session" button, share/delete actions.
// - Table View (Image 4):
//     - 9 Columns: Mentor, Category, Organization, Expertise Domains, Status, Assigned Ventures,
//       Sessions, Rating, Actions (Pair, Log, Delete).
// - Invite New Mentor Modal Dialog (Image 2)
// - Log 1:1 Advisory Session Modal Dialog (Image 3)
// - Pair Mentor with Venture Modal Dialog (Image 5)
// =============================================================================

class IncubationMentorNetworkScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const IncubationMentorNetworkScreen({super.key, this.onBack});

  @override
  State<IncubationMentorNetworkScreen> createState() =>
      _IncubationMentorNetworkScreenState();
}

class _IncubationMentorNetworkScreenState
    extends State<IncubationMentorNetworkScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedCategory = "All Categories";
  String _selectedAvailability = "All Availability";
  bool _isTableView = false;

  late List<Map<String, dynamic>> _mentors;
  late List<String> _incubationVentures;

  @override
  void initState() {
    super.initState();
    _incubationVentures = [
      'ColossusIQ (EdTech · MVP Live)',
      'NeuralDrone AI (DeepTech · Prototype)',
      'BioSynthetica (HealthTech · Ideation)',
    ];

    _mentors = [
      {
        'id': 'mentor-star-bala',
        'name': 'Star bala',
        'role': 'VP Product',
        'company': 'rental',
        'category': 'Industry Founder',
        'availability': 'Available',
        'rating': '—',
        'domains': ['AI'],
        'assignedVentures': <String>[],
        'email': 'bala@gmail.com',
        'phone': '+91 98401 23456',
        'linkedIn': 'https://linkedin.com/in/starbala',
        'sessionsCount': 0,
        'sessions': <Map<String, dynamic>>[],
      },
    ];
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredMentors {
    final q = _searchCtrl.text.trim().toLowerCase();
    return _mentors.where((m) {
      if (_selectedCategory != "All Categories" &&
          m['category'] != _selectedCategory) {
        return false;
      }
      if (_selectedAvailability != "All Availability" &&
          m['availability'] != _selectedAvailability) {
        return false;
      }
      if (q.isNotEmpty) {
        final name = (m['name'] as String).toLowerCase();
        final comp = (m['company'] as String).toLowerCase();
        final role = (m['role'] as String).toLowerCase();
        final email = (m['email'] as String).toLowerCase();
        final domains = ((m['domains'] as List?) ?? [])
            .map((e) => e.toString().toLowerCase())
            .join(' ');
        if (!name.contains(q) &&
            !comp.contains(q) &&
            !role.contains(q) &&
            !email.contains(q) &&
            !domains.contains(q)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  int get _totalAvailable =>
      _mentors.where((m) => m['availability'] == 'Available').length;

  int get _totalPairings => _mentors.fold(
      0, (sum, m) => sum + ((m['assignedVentures'] as List?)?.length ?? 0));

  int get _totalSessions => _mentors.fold(
      0, (sum, m) => sum + ((m['sessionsCount'] as num?)?.toInt() ?? 0));

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredMentors;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Top Blueprint Hero Banner (Image 1)
              _buildTopHeroBanner(),
              const SizedBox(height: 20),

              // 2. 5 KPI Stat Cards (Image 1)
              _buildKpiRow(),
              const SizedBox(height: 20),

              // 3. Search & Filter Bar with Grid/Table toggle & Actions (Image 1 & 4)
              _buildFilterAndActionBar(),
              const SizedBox(height: 20),

              // 4. Startups Content: Grid (Image 1) or Table (Image 4)
              if (filtered.isEmpty)
                _buildEmptyState()
              else if (_isTableView)
                _buildTableView(filtered)
              else
                _buildGridView(filtered),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HERO BLUEPRINT BANNER (Matches Image 1)
  // ===========================================================================
  Widget _buildTopHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2865),
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E2865), Color(0xFF2E3A8C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2865).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -30,
            child: Icon(
              Icons.handshake_outlined,
              size: 200,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (widget.onBack != null) ...[
                      IconButton(
                        onPressed: widget.onBack,
                        icon: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 12),
                    ],
                    Expanded(
                      child: Text(
                        'Home  ›  Incubation  ›  Mentor Network',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: Colors.white.withValues(alpha: 0.7),
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131838),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        'INCUBATION',
                        style: GoogleFonts.poppins(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD97706),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Phase 2',
                        style: GoogleFonts.poppins(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: const Color(0xFFF59E0B)
                                .withValues(alpha: 0.4)),
                      ),
                      child: const Icon(
                        Icons.handshake_outlined,
                        color: Color(0xFFFBBF24),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mentor Network',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Industry, alumni and startup mentors with assignments.',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white.withValues(alpha: 0.8),
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
    );
  }

  // ===========================================================================
  // 2. 5 KPI METRIC CARDS (Matches Image 1)
  // ===========================================================================
  Widget _buildKpiRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        final cards = [
          _buildKpiCard(
            title: "TOTAL MENTORS",
            value: "${_mentors.length}",
            sub: "Empanelled advisors",
            icon: Icons.people_outline_rounded,
            iconBg: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF2563EB),
          ),
          _buildKpiCard(
            title: "AVAILABLE NOW",
            value: "$_totalAvailable",
            sub: "Ready for new ventures",
            subColor: const Color(0xFF059669),
            icon: Icons.person_search_outlined,
            iconBg: const Color(0xFFF0FDF4),
            iconColor: const Color(0xFF16A34A),
          ),
          _buildKpiCard(
            title: "ACTIVE PAIRINGS",
            value: "$_totalPairings",
            sub: "Ventures being guided",
            icon: Icons.handshake_outlined,
            iconBg: const Color(0xFFF5F3FF),
            iconColor: const Color(0xFF7C3AED),
          ),
          _buildKpiCard(
            title: "SESSIONS LOGGED",
            value: "$_totalSessions",
            sub: "1:1 advisory meetings",
            icon: Icons.calendar_month_outlined,
            iconBg: const Color(0xFFFFF7ED),
            iconColor: const Color(0xFFEA580C),
          ),
          _buildKpiCard(
            title: "MENTOR RATING",
            value: "★ —",
            sub: "Founder satisfaction score",
            icon: Icons.star_rounded,
            iconBg: const Color(0xFFFFFBEB),
            iconColor: const Color(0xFFD97706),
          ),
        ];

        if (isMobile) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: cards
                  .map((c) => Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SizedBox(width: 175, child: c),
                      ))
                  .toList(),
            ),
          );
        }

        return Row(
          children: cards
              .map((c) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: c,
                    ),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required String sub,
    Color? subColor,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
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
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64748B),
                    letterSpacing: 0.4,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 15, color: iconColor),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            sub,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: subColor != null ? FontWeight.w600 : FontWeight.w400,
              color: subColor ?? const Color(0xFF94A3B8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. FILTER & ACTION BAR (Matches Image 1 & 4)
  // ===========================================================================
  Widget _buildFilterAndActionBar() {
    final categories = [
      "All Categories",
      "Industry Founder",
      "Alumni Entrepreneur",
      "Faculty Expert",
      "Investor / VC",
    ];

    final availabilities = [
      "All Availability",
      "Available",
      "Busy",
      "Away",
    ];

    return Container(
      padding: const EdgeInsets.all(12),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 980;

          final searchField = Container(
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Icon(Icons.search_rounded,
                    size: 17, color: Color(0xFF94A3B8)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (_) => setState(() {}),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF0F172A),
                    ),
                    decoration: InputDecoration(
                      hintText: "Search mentors, company, skill",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF94A3B8),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                if (_searchCtrl.text.isNotEmpty)
                  GestureDetector(
                    onTap: () => setState(() => _searchCtrl.clear()),
                    child: const Icon(Icons.close_rounded,
                        size: 15, color: Color(0xFF94A3B8)),
                  ),
              ],
            ),
          );

          final dropdownsWrap = Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _buildFilterDropdown(
                value: _selectedCategory,
                items: categories,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCategory = val);
                },
              ),
              _buildFilterDropdown(
                value: _selectedAvailability,
                items: availabilities,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedAvailability = val);
                },
              ),
              // View Toggle: Grid / Table
              Container(
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildToggleBtn(
                      title: "Grid",
                      icon: Icons.grid_view_rounded,
                      isActive: !_isTableView,
                      onTap: () => setState(() => _isTableView = false),
                    ),
                    _buildToggleBtn(
                      title: "Table",
                      icon: Icons.table_chart_outlined,
                      isActive: _isTableView,
                      onTap: () => setState(() => _isTableView = true),
                    ),
                  ],
                ),
              ),
              // Export CSV Button
              OutlinedButton.icon(
                onPressed: _exportCsv,
                icon: const Icon(Icons.file_download_outlined, size: 15),
                label: Text(
                  "Export CSV",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF475569),
                  side: const BorderSide(color: Color(0xFFE2E8F0)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              // + Invite Mentor Button
              ElevatedButton.icon(
                onPressed: () => _openInviteMentorDialog(),
                icon: const Icon(Icons.person_add_alt_1_rounded, size: 16),
                label: Text(
                  "Invite Mentor",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
              ),
            ],
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchField,
                const SizedBox(height: 10),
                dropdownsWrap,
              ],
            );
          }

          return Row(
            children: [
              _buildFilterDropdown(
                value: _selectedCategory,
                items: categories,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCategory = val);
                },
              ),
              const SizedBox(width: 8),
              _buildFilterDropdown(
                value: _selectedAvailability,
                items: availabilities,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedAvailability = val);
                },
              ),
              const SizedBox(width: 12),
              Expanded(child: searchField),
              const SizedBox(width: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildToggleBtn(
                          title: "Grid",
                          icon: Icons.grid_view_rounded,
                          isActive: !_isTableView,
                          onTap: () => setState(() => _isTableView = false),
                        ),
                        _buildToggleBtn(
                          title: "Table",
                          icon: Icons.table_chart_outlined,
                          isActive: _isTableView,
                          onTap: () => setState(() => _isTableView = true),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _exportCsv,
                    icon: const Icon(Icons.file_download_outlined, size: 15),
                    label: Text(
                      "Export CSV",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF475569),
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _openInviteMentorDialog(),
                    icon: const Icon(Icons.person_add_alt_1_rounded, size: 16),
                    label: Text(
                      "Invite Mentor",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E2865),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF334155),
          ),
          selectedItemBuilder: (context) => items
              .map((it) => ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 130),
                    child: Text(
                      it,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ))
              .toList(),
          items: items
              .map((it) => DropdownMenuItem(
                    value: it,
                    child: Text(it, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildToggleBtn({
    required String title,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 14,
              color: isActive ? const Color(0xFF1E2865) : const Color(0xFF64748B),
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive
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
  // 4. GRID VIEW (Matches Image 1)
  // ===========================================================================
  Widget _buildGridView(List<Map<String, dynamic>> mentors) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMultiColumn = constraints.maxWidth >= 860;
        if (isMultiColumn) {
          final cardWidth = (constraints.maxWidth - 16) / 2;
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: mentors
                .map((m) => SizedBox(
                      width: cardWidth,
                      child: _buildMentorCard(m),
                    ))
                .toList(),
          );
        }

        return Column(
          children: mentors
              .map((m) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildMentorCard(m),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildMentorCard(Map<String, dynamic> m) {
    final assignedVentures =
        (m['assignedVentures'] as List?)?.cast<String>() ?? [];
    final domains = (m['domains'] as List?)?.cast<String>() ?? [];
    final availability = m['availability'] ?? 'Available';
    final isAvail = availability == 'Available';

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // Top Row: Category pill (light purple), Availability (teal with dot), Rating (★ —)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3E8FF),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE9D5FF)),
                      ),
                      child: Text(
                        m['category'] ?? 'Industry Founder',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF7E22CE),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(
                        color: isAvail
                            ? const Color(0xFFECFDF5)
                            : const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isAvail
                              ? const Color(0xFFA7F3D0)
                              : const Color(0xFFFDE68A),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: isAvail
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFF59E0B),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            availability,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: isAvail
                                  ? const Color(0xFF047857)
                                  : const Color(0xFFB45309),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star_rounded,
                      size: 16, color: Color(0xFFF59E0B)),
                  const SizedBox(width: 3),
                  Text(
                    m['rating'] ?? '—',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Mentor Name, Role & Company
          Text(
            m['name'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            m['role'] ?? '',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.apartment_rounded,
                  size: 14, color: Color(0xFF64748B)),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  m['company'] ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Domain pills
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: domains
                .map((d) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Text(
                        d,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),

          // Assigned Ventures Container (beige)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBF8),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF2ECE1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "ASSIGNED VENTURES (${assignedVentures.length})",
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B),
                          letterSpacing: 0.4,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    InkWell(
                      onTap: () => _openPairVentureDialog(m),
                      borderRadius: BorderRadius.circular(6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: Text(
                          "+ Pair Venture",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E2865),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                if (assignedVentures.isEmpty)
                  Text(
                    "No ventures currently assigned",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontStyle: FontStyle.italic,
                      color: const Color(0xFF94A3B8),
                    ),
                  )
                else
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: assignedVentures
                        .map((v) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border:
                                    Border.all(color: const Color(0xFFE2E8F0)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    v,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        assignedVentures.remove(v);
                                      });
                                    },
                                    child: const Icon(Icons.close_rounded,
                                        size: 13, color: Color(0xFF94A3B8)),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Contact & Sessions Count Row
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.email_outlined,
                        size: 14, color: Color(0xFF64748B)),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        m['email'],
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.description_outlined,
                      size: 14, color: Color(0xFF64748B)),
                  const SizedBox(width: 4),
                  Text(
                    "${m['sessionsCount']} sessions logged",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Bottom Action Row: Availability Dropdown, Log Session button, share, delete
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Availability status dropdown inside card
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: m['availability'] ?? 'Available',
                    isDense: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                        size: 16, color: Color(0xFF64748B)),
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                    items: ['Available', 'Busy', 'Away']
                        .map((st) => DropdownMenuItem(
                              value: st,
                              child: Text(st),
                            ))
                        .toList(),
                    onChanged: (newSt) {
                      if (newSt != null) {
                        setState(() => m['availability'] = newSt);
                      }
                    },
                  ),
                ),
              ),
              // Log Session Button
              OutlinedButton.icon(
                onPressed: () => _openLogSessionDialog(m),
                icon: const Icon(Icons.schedule_rounded, size: 14),
                label: Text(
                  "Log Session",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F172A),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
              // Share / External Profile
              IconButton(
                onPressed: () {
                  final link = m['linkedIn'] ?? '';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Opening mentor profile: $link"),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.open_in_new_rounded,
                    size: 17, color: Color(0xFF64748B)),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                tooltip: "View LinkedIn profile",
              ),
              // Delete Mentor
              IconButton(
                onPressed: () => _confirmDeleteMentor(m),
                icon: const Icon(Icons.delete_outline_rounded,
                    size: 18, color: Color(0xFFEF4444)),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                tooltip: "Remove mentor",
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 5. TABLE VIEW (Matches Image 4)
  // ===========================================================================
  Widget _buildTableView(List<Map<String, dynamic>> mentors) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowHeight: 44,
          dataRowMinHeight: 64,
          dataRowMaxHeight: 76,
          headingRowColor:
              WidgetStateProperty.all(const Color(0xFFF8FAFC)),
          columns: [
            DataColumn(
              label: Text(
                'Mentor',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Category',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Organization',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Expertise Domains',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Status',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Assigned Ventures',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Sessions',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Rating',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Actions',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
          ],
          rows: mentors.map((m) {
            final assigned = (m['assignedVentures'] as List?) ?? [];
            final domains = (m['domains'] as List?) ?? [];

            return DataRow(
              cells: [
                // Mentor (Name & Email)
                DataCell(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        m['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        m['email'],
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                // Category
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E8FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      m['category'] ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF7E22CE),
                      ),
                    ),
                  ),
                ),
                // Organization (Role & Company)
                DataCell(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        m['role'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        m['company'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                // Expertise Domains
                DataCell(
                  Wrap(
                    spacing: 4,
                    children: domains
                        .map((d) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "$d",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF334155),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                // Status Dropdown
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 1),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: m['availability'] ?? 'Available',
                        isDense: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            size: 16),
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                        items: ['Available', 'Busy', 'Away']
                            .map((st) => DropdownMenuItem(
                                  value: st,
                                  child: Text(st),
                                ))
                            .toList(),
                        onChanged: (newSt) {
                          if (newSt != null) {
                            setState(() => m['availability'] = newSt);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                // Assigned Ventures
                DataCell(
                  Text(
                    assigned.isEmpty ? "None" : assigned.join(', '),
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: assigned.isEmpty
                          ? const Color(0xFF94A3B8)
                          : const Color(0xFF0F172A),
                    ),
                  ),
                ),
                // Sessions
                DataCell(
                  Text(
                    "${m['sessionsCount'] ?? 0}",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
                // Rating
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded,
                          size: 15, color: Color(0xFFF59E0B)),
                      const SizedBox(width: 3),
                      Text(
                        m['rating'] ?? '—',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
                // Actions
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton(
                        onPressed: () => _openPairVentureDialog(m),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF0F172A),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Text(
                          "Pair",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      OutlinedButton(
                        onPressed: () => _openLogSessionDialog(m),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF0F172A),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Text(
                          "Log",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        onPressed: () => _confirmDeleteMentor(m),
                        icon: const Icon(Icons.delete_outline_rounded,
                            size: 16, color: Color(0xFFEF4444)),
                        padding: EdgeInsets.zero,
                        constraints:
                            const BoxConstraints(minWidth: 28, minHeight: 28),
                        tooltip: "Delete mentor",
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  // ===========================================================================
  // 6. EMPTY STATE
  // ===========================================================================
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(48),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.person_search_outlined,
                size: 40, color: Color(0xFF94A3B8)),
            const SizedBox(height: 12),
            Text(
              "No mentors match the search or filter.",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Try adjusting your search query, category or availability filter.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 7. INVITE NEW MENTOR MODAL DIALOG (Matches Image 2)
  // ===========================================================================
  void _openInviteMentorDialog() {
    final nameCtrl = TextEditingController();
    final roleCtrl = TextEditingController();
    final compCtrl = TextEditingController();
    String category = "Industry Founder";
    String availability = "Available";
    final domainsCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final linkedInCtrl = TextEditingController();

    final categoriesList = [
      "Industry Founder",
      "Alumni Entrepreneur",
      "Faculty Expert",
      "Investor / VC",
    ];

    final availabilityList = [
      "Available",
      "Busy",
      "Away",
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Invite New Mentor",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "Empanel an industry founder, alumnus, or faculty expert",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            icon: const Icon(Icons.close_rounded,
                                size: 20, color: Color(0xFF64748B)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Divider(
                          height: 1, thickness: 0.8, color: Color(0xFFE2E8F0)),
                      const SizedBox(height: 18),

                      // Mentor Full Name *
                      _buildFormField(
                        label: "Mentor Full Name *",
                        hint: "e.g. Dr. Anandhi Subramanian",
                        controller: nameCtrl,
                      ),
                      const SizedBox(height: 14),

                      // 2-Col: Designation / Role * & Organization / Company *
                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                              label: "Designation / Role *",
                              hint: "VP Product / Founder & CEO",
                              controller: roleCtrl,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildFormField(
                              label: "Organization / Company *",
                              hint: "Zoho, Google, IIT-M, etc.",
                              controller: compCtrl,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // 2-Col: Category * & Initial Availability
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdownField(
                              label: "Category *",
                              value: category,
                              items: categoriesList,
                              onChanged: (v) {
                                if (v != null) {
                                  setDialogState(() => category = v);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildDropdownField(
                              label: "Initial Availability",
                              value: availability,
                              items: availabilityList,
                              onChanged: (v) {
                                if (v != null) {
                                  setDialogState(() => availability = v);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Expertise & Domains (comma separated) *
                      _buildFormField(
                        label: "Expertise & Domains (comma separated) *",
                        hint: "AI/ML, HealthTech, Patent Filing, Scale",
                        controller: domainsCtrl,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Quick suggestions: AgriTech, HealthTech, CleanTech & IoT, AI & DeepTech, Embedded Systems",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // 2-Col: Email Address * & Phone / WhatsApp
                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                              label: "Email Address *",
                              hint: "mentor@company.com",
                              controller: emailCtrl,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildFormField(
                              label: "Phone / WhatsApp",
                              hint: "+91 98401 23456",
                              controller: phoneCtrl,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // LinkedIn Profile URL
                      _buildFormField(
                        label: "LinkedIn Profile URL",
                        hint: "https://linkedin.com/in/...",
                        controller: linkedInCtrl,
                      ),
                      const SizedBox(height: 22),

                      // Buttons: Cancel & Invite to Cell
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              final name = nameCtrl.text.trim();
                              final role = roleCtrl.text.trim();
                              final comp = compCtrl.text.trim();
                              final email = emailCtrl.text.trim();
                              if (name.isEmpty || email.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Please enter Mentor Full Name and Email Address.",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }

                              final rawDomains = domainsCtrl.text.trim();
                              final domainsList = rawDomains.isNotEmpty
                                  ? rawDomains
                                      .split(',')
                                      .map((e) => e.trim())
                                      .where((e) => e.isNotEmpty)
                                      .toList()
                                  : ['General'];

                              setState(() {
                                _mentors.insert(0, {
                                  'id':
                                      'mentor-${DateTime.now().millisecondsSinceEpoch}',
                                  'name': name,
                                  'role': role.isNotEmpty
                                      ? role
                                      : 'Advisory Mentor',
                                  'company':
                                      comp.isNotEmpty ? comp : 'Independent',
                                  'category': category,
                                  'availability': availability,
                                  'rating': '—',
                                  'domains': domainsList,
                                  'assignedVentures': <String>[],
                                  'email': email,
                                  'phone': phoneCtrl.text.trim().isNotEmpty
                                      ? phoneCtrl.text.trim()
                                      : '+91 98401 23456',
                                  'linkedIn': linkedInCtrl.text.trim().isNotEmpty
                                      ? linkedInCtrl.text.trim()
                                      : 'https://linkedin.com',
                                  'sessionsCount': 0,
                                  'sessions': <Map<String, dynamic>>[],
                                });
                              });

                              Navigator.pop(dialogCtx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(Icons.check_circle_rounded,
                                          color: Color(0xFF10B981), size: 18),
                                      const SizedBox(width: 8),
                                      Text(
                                        "$name empanelled to incubator cell.",
                                        style:
                                            GoogleFonts.poppins(fontSize: 12.5),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: const Color(0xFF0F172A),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E2865),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                            ),
                            child: Text(
                              "Invite to Cell",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ===========================================================================
  // 8. LOG 1:1 ADVISORY SESSION MODAL DIALOG (Matches Image 3)
  // ===========================================================================
  void _openLogSessionDialog(Map<String, dynamic> mentor) {
    String selectedVenture = _incubationVentures.first;
    final topicCtrl = TextEditingController();
    String duration = "60 minutes (1 hour)";
    final feedbackCtrl = TextEditingController();

    final durations = [
      "30 minutes",
      "45 minutes",
      "60 minutes (1 hour)",
      "90 minutes",
      "120 minutes (2 hours)",
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Log 1:1 Advisory Session",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "Advisor: ${mentor['name']}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            icon: const Icon(Icons.close_rounded,
                                size: 20, color: Color(0xFF64748B)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Divider(
                          height: 1, thickness: 0.8, color: Color(0xFFE2E8F0)),
                      const SizedBox(height: 18),

                      // Venture Advised *
                      _buildDropdownField(
                        label: "Venture Advised *",
                        value: selectedVenture,
                        items: _incubationVentures,
                        onChanged: (v) {
                          if (v != null) {
                            setDialogState(() => selectedVenture = v);
                          }
                        },
                      ),
                      const SizedBox(height: 14),

                      // Session Topic / Milestone Reviewed *
                      _buildFormField(
                        label: "Session Topic / Milestone Reviewed *",
                        hint:
                            "e.g. Unit Economics & Customer Discovery Rehearsal",
                        controller: topicCtrl,
                      ),
                      const SizedBox(height: 14),

                      // Duration (minutes)
                      _buildDropdownField(
                        label: "Duration (minutes)",
                        value: duration,
                        items: durations,
                        onChanged: (v) {
                          if (v != null) {
                            setDialogState(() => duration = v);
                          }
                        },
                      ),
                      const SizedBox(height: 14),

                      // Action Items & Advisory Feedback *
                      _buildFormField(
                        label: "Action Items & Advisory Feedback *",
                        hint:
                            "Key guidance provided, customer validation homework, next checkpoint date...",
                        controller: feedbackCtrl,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 22),

                      // Buttons: Cancel & Log Session
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              final topic = topicCtrl.text.trim();
                              final feedback = feedbackCtrl.text.trim();
                              if (topic.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Please enter the Session Topic / Milestone.",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                mentor['sessionsCount'] =
                                    (mentor['sessionsCount'] as int? ?? 0) + 1;
                                (mentor['sessions'] as List).add({
                                  'venture': selectedVenture,
                                  'topic': topic,
                                  'duration': duration,
                                  'feedback': feedback,
                                  'date': DateTime.now().toString(),
                                });
                              });

                              Navigator.pop(dialogCtx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(Icons.check_circle_rounded,
                                          color: Color(0xFF10B981), size: 18),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Advisory session logged for ${mentor['name']}.",
                                        style:
                                            GoogleFonts.poppins(fontSize: 12.5),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: const Color(0xFF0F172A),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E2865),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                            ),
                            child: Text(
                              "Log Session",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ===========================================================================
  // 9. PAIR MENTOR WITH VENTURE MODAL DIALOG (Matches Image 5)
  // ===========================================================================
  void _openPairVentureDialog(Map<String, dynamic> mentor) {
    String selectedVenture = _incubationVentures.first;
    final domains = (mentor['domains'] as List?)?.cast<String>() ?? ['AI'];
    final assigned =
        (mentor['assignedVentures'] as List?)?.cast<String>() ?? [];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pair Mentor with Venture",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "Assigning: ${mentor['name']}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            icon: const Icon(Icons.close_rounded,
                                size: 20, color: Color(0xFF64748B)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Divider(
                          height: 1, thickness: 0.8, color: Color(0xFFE2E8F0)),
                      const SizedBox(height: 18),

                      // Select Incubation Venture *
                      _buildDropdownField(
                        label: "Select Incubation Venture *",
                        value: selectedVenture,
                        items: _incubationVentures,
                        onChanged: (v) {
                          if (v != null) {
                            setDialogState(() => selectedVenture = v);
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Mentor Specializations Box (beige)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBFBF8),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFF2ECE1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mentor Specializations:",
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF475569),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: domains
                                  .map((d) => Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color: const Color(0xFFE2E8F0)),
                                        ),
                                        child: Text(
                                          d,
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF0F172A),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),

                      // Buttons: Cancel & Confirm Pairing
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFCBD5E1)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              final ventureShortName =
                                  selectedVenture.split(' (').first;
                              if (!assigned.contains(ventureShortName)) {
                                setState(() {
                                  assigned.add(ventureShortName);
                                });
                              }

                              Navigator.pop(dialogCtx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(Icons.check_circle_rounded,
                                          color: Color(0xFF10B981), size: 18),
                                      const SizedBox(width: 8),
                                      Text(
                                        "${mentor['name']} paired with $ventureShortName.",
                                        style:
                                            GoogleFonts.poppins(fontSize: 12.5),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: const Color(0xFF0F172A),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E2865),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                            ),
                            child: Text(
                              "Confirm Pairing",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFormField({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF0F172A),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF94A3B8),
            ),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.5),
            ),
            isDense: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF334155),
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              isDense: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 18, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF0F172A),
              ),
              items: items
                  .map((it) => DropdownMenuItem(
                        value: it,
                        child: Text(it, overflow: TextOverflow.ellipsis),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  void _confirmDeleteMentor(Map<String, dynamic> m) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          "Remove Mentor",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        content: Text(
          "Are you sure you want to remove '${m['name']}' from the active mentor network?",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF475569),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                _mentors.removeWhere((item) => item['id'] == m['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "'${m['name']}' removed from mentor network.",
                    style: GoogleFonts.poppins(fontSize: 12.5),
                  ),
                  backgroundColor: const Color(0xFFEF4444),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              "Remove",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _exportCsv() {
    final buffer = StringBuffer();
    buffer.writeln(
        "Mentor Name,Category,Designation,Organization,Email,Availability,Rating,Assigned Ventures,Sessions Count");
    for (final m in _filteredMentors) {
      final assigned =
          ((m['assignedVentures'] as List?) ?? []).join('; ');
      buffer.writeln(
          '"${m['name']}","${m['category']}","${m['role']}","${m['company']}","${m['email']}","${m['availability']}","${m['rating']}","$assigned","${m['sessionsCount']}"');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Exported ${_filteredMentors.length} mentors to CSV successfully.",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
