import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INCUBATION HEAD: STARTUPS SCREEN
// Matches Images 3, 4 & 5:
// - Blueprint Hero Banner: "Home > Incubation > Startups", badges INCUBATION, Phase 2
// - 5 Metric KPI Cards:
//     1. Total Startups: 1 (Incubated)
//     2. DPIIT Recognized: 0 (Govt Accredited)
//     3. Funding Mobilized: ₹0
//     4. Active Pilots: 0 (Deployments)
//     5. Patents Filed: 0 (IP Protected)
// - Search & Filter Row: Search textfield, Domain, Stage, Legal Structure dropdowns,
//   Grid / Table toggle buttons, Export CSV button, "+ Register Startup" button.
// - Grid View (Image 3): Startup Cards with EdTech badge, MVP Live pill, Legal Box,
//   Investment Readiness progress bar, 2x2 stats box, Founder & Mentor info, Deck/Demo/Web links,
//   Update and Delete buttons.
// - Table View (Image 4): Responsive table with 9 columns.
// - Register Campus Startup Modal (Image 5): 14 Form fields.
// =============================================================================

class StartupsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const StartupsScreen({super.key, this.onBack});

  @override
  State<StartupsScreen> createState() => _StartupsScreenState();
}

class _StartupsScreenState extends State<StartupsScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedDomain = "All Domains";
  String _selectedStage = "All Stages";
  String _selectedLegal = "All Legal Structures";
  bool _isTableView = false;

  late List<Map<String, dynamic>> _startups;

  @override
  void initState() {
    super.initState();
    _startups = [
      {
        'id': 'startup-colossusiq',
        'name': 'ColossusIQ',
        'domain': 'EdTech',
        'tagline':
            'AI-powered college learning platform providing digital education, student management, career guidance and institutional automation.',
        'stage': 'MVP Live',
        'legalStructure': 'Registered Private Limited',
        'regNumber': 'CIN-U72900TN2026PTC123456',
        'incubationStatus': 'Incubation in progress',
        'readiness': 60,
        'fundingMobilized': 'Bootstrapped',
        'fundingAmount': 0.0,
        'revenueArr': 'Pre-revenue',
        'commercialPilots': 0,
        'patentStatus': 'Not Applicable',
        'leadFounder': 'Bala Subramanian',
        'founderEmail': 'bala@colossusiq.com',
        'department': 'Computer Applications',
        'cohort': '2026',
        'mentor': 'Unassigned',
        'isDpiit': false,
        'deckUrl': 'https://colossusiq.com/deck',
        'demoUrl': 'https://colossusiq.com/demo',
        'webUrl': 'https://colossusiq.com',
      },
    ];
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredStartups {
    final q = _searchCtrl.text.trim().toLowerCase();
    return _startups.where((s) {
      if (_selectedDomain != "All Domains" && s['domain'] != _selectedDomain) {
        return false;
      }
      if (_selectedStage != "All Stages" && s['stage'] != _selectedStage) {
        return false;
      }
      if (_selectedLegal != "All Legal Structures" &&
          s['legalStructure'] != _selectedLegal) {
        return false;
      }
      if (q.isNotEmpty) {
        final name = (s['name'] as String).toLowerCase();
        final founder = (s['leadFounder'] as String).toLowerCase();
        final mentor = (s['mentor'] as String).toLowerCase();
        final reg = (s['regNumber'] as String? ?? '').toLowerCase();
        if (!name.contains(q) &&
            !founder.contains(q) &&
            !mentor.contains(q) &&
            !reg.contains(q)) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  int get _totalDpiit => _startups.where((s) => s['isDpiit'] == true).length;
  double get _totalFunding => _startups.fold(
      0.0, (sum, s) => sum + ((s['fundingAmount'] as num?)?.toDouble() ?? 0.0));
  int get _totalPilots => _startups.fold(
      0, (sum, s) => sum + ((s['commercialPilots'] as num?)?.toInt() ?? 0));
  int get _totalPatents => _startups
      .where((s) =>
          s['patentStatus'] != null &&
          s['patentStatus'] != 'Not Applicable' &&
          s['patentStatus'] != 'None')
      .length;

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredStartups;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Top Blueprint Hero Banner
              _buildTopHeroBanner(),
              const SizedBox(height: 20),

              // 2. 5 KPI Stat Cards
              _buildKpiRow(),
              const SizedBox(height: 20),

              // 3. Search & Filter Bar with Grid/Table toggle & Actions
              _buildFilterAndActionBar(),
              const SizedBox(height: 20),

              // 4. Startups Content: Grid or Table
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
  // 1. TOP HERO BLUEPRINT BANNER
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
              Icons.lightbulb_outline_rounded,
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
                        'Home  ›  Incubation  ›  Startups',
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
                        Icons.lightbulb_outline_rounded,
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
                            'Startups',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Student ventures, stage, mentors and funding readiness.',
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
  // 2. 5 KPI METRIC CARDS
  // ===========================================================================
  Widget _buildKpiRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        final cards = [
          _buildKpiCard(
            title: "TOTAL STARTUPS",
            value: "${_startups.length}",
            sub: "Incubated",
            icon: Icons.rocket_launch_outlined,
            iconBg: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF2563EB),
          ),
          _buildKpiCard(
            title: "DPIIT RECOGNIZED",
            value: "$_totalDpiit",
            sub: "Govt Accredited",
            icon: Icons.verified_outlined,
            iconBg: const Color(0xFFF0FDF4),
            iconColor: const Color(0xFF16A34A),
          ),
          _buildKpiCard(
            title: "FUNDING MOBILIZED",
            value: _totalFunding > 0 ? "₹${_totalFunding.toStringAsFixed(1)}L" : "₹0",
            sub: "Grants & Equity",
            icon: Icons.currency_rupee_rounded,
            iconBg: const Color(0xFFFFFBEB),
            iconColor: const Color(0xFFD97706),
          ),
          _buildKpiCard(
            title: "ACTIVE PILOTS",
            value: "$_totalPilots",
            sub: "Deployments",
            icon: Icons.storefront_outlined,
            iconBg: const Color(0xFFF5F3FF),
            iconColor: const Color(0xFF7C3AED),
          ),
          _buildKpiCard(
            title: "PATENTS FILED",
            value: "$_totalPatents",
            sub: "IP Protected",
            icon: Icons.policy_outlined,
            iconBg: const Color(0xFFF0FDFA),
            iconColor: const Color(0xFF0D9488),
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
              color: const Color(0xFF94A3B8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. FILTER & ACTION BAR
  // ===========================================================================
  Widget _buildFilterAndActionBar() {
    final domains = [
      "All Domains",
      "EdTech",
      "HealthTech",
      "FinTech",
      "Agritech",
      "AI/ML",
      "CleanTech",
      "DeepTech",
      "Other",
    ];

    final stages = [
      "All Stages",
      "Ideation",
      "Prototype",
      "MVP Live",
      "Early Traction",
      "Scaling",
    ];

    final legalStructures = [
      "All Legal Structures",
      "Registered Private Limited",
      "LLP",
      "Partnership",
      "Sole Proprietorship",
      "Unregistered",
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
                      hintText:
                          "Search startup name, founder, mentor, reg no...",
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
                value: _selectedDomain,
                items: domains,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedDomain = val);
                },
              ),
              _buildFilterDropdown(
                value: _selectedStage,
                items: stages,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedStage = val);
                },
              ),
              _buildFilterDropdown(
                value: _selectedLegal,
                items: legalStructures,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedLegal = val);
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
                  "Export",
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
              // + Register Startup Button
              ElevatedButton.icon(
                onPressed: () => _openStartupDialog(),
                icon: const Icon(Icons.add_rounded, size: 16),
                label: Text(
                  "Register Startup",
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
              Expanded(child: searchField),
              const SizedBox(width: 12),
              dropdownsWrap,
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
  // 4. GRID VIEW (Matches Image 3)
  // ===========================================================================
  Widget _buildGridView(List<Map<String, dynamic>> startups) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMultiColumn = constraints.maxWidth >= 860;
        if (isMultiColumn) {
          final cardWidth = (constraints.maxWidth - 16) / 2;
          return Wrap(
            spacing: 16,
            runSpacing: 16,
            children: startups
                .map((s) => SizedBox(
                      width: cardWidth,
                      child: _buildStartupCard(s),
                    ))
                .toList(),
          );
        }

        return Column(
          children: startups
              .map((s) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildStartupCard(s),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildStartupCard(Map<String, dynamic> s) {
    final readiness = (s['readiness'] as num?)?.toInt() ?? 50;

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
          // Top Row: Domain pill (peach) & Stage badge (blue pill with live dot)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFFFEDD5)),
                ),
                child: Text(
                  s['domain'] ?? 'Technology',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFC2410C),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFDBEAFE)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      s['stage'] ?? 'MVP Live',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1D4ED8),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Startup Title & Tagline
          Text(
            s['name'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            s['tagline'] ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF475569),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),

          // Legal Structure Box (beige)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBF8),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFF2ECE1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    s['legalStructure'] ?? 'Unregistered',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  s['incubationStatus'] ?? 'Incubation in progress',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF059669),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Investment Readiness Progress Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Investment Readiness",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                "$readiness%",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: readiness / 100,
              minHeight: 6,
              backgroundColor: const Color(0xFFE2E8F0),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1E2865)),
            ),
          ),
          const SizedBox(height: 12),

          // 2x2 Stats Box
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildMiniStat(
                        "FUNDING MOBILIZED",
                        s['fundingMobilized'] ?? 'Bootstrapped',
                        const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildMiniStat(
                        "REVENUE (ARR)",
                        s['revenueArr'] ?? 'Pre-revenue',
                        const Color(0xFF059669),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildMiniStat(
                        "COMMERCIAL PILOTS",
                        "${s['commercialPilots'] ?? 0} Pilots",
                        const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildMiniStat(
                        "PATENT / IP",
                        s['patentStatus'] ?? 'Not Applicable',
                        const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Founder & Mentor Row
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.person_outline_rounded,
                        size: 15, color: Color(0xFF64748B)),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        "${s['leadFounder']} (${s['department']})",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Row(
                  children: [
                    const Icon(Icons.school_outlined,
                        size: 15, color: Color(0xFF64748B)),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        "Mentor: ${s['mentor']} (${s['cohort']})",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Footer: Links (Deck, Demo, Web), Update, Delete buttons
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    if (s['deckUrl'] != null)
                      _buildTextLink("🔗 Deck", s['deckUrl']),
                    if (s['demoUrl'] != null)
                      _buildTextLink("🔗 Demo", s['demoUrl']),
                    if (s['webUrl'] != null)
                      _buildTextLink("🔗 Web", s['webUrl']),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () => _openStartupDialog(initialStartup: s),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF0F172A),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(
                  "Update",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              IconButton(
                onPressed: () => _confirmDeleteStartup(s),
                icon: const Icon(Icons.delete_outline_rounded,
                    size: 18, color: Color(0xFFEF4444)),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                tooltip: "Delete startup",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String label, String value, Color valColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF94A3B8),
            letterSpacing: 0.3,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: valColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildTextLink(String label, String url) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Opening $label: $url"),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF2563EB),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. TABLE VIEW (Matches Image 4)
  // ===========================================================================
  Widget _buildTableView(List<Map<String, dynamic>> startups) {
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
                'STARTUP & DOMAIN',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'STAGE',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'LEGAL & REG NO',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'FOUNDERS & DEPT',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'FUNDING & ARR',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'PILOTS',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'PATENT STATUS',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'ASSIGNED MENTOR',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'ACTIONS',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                ),
              ),
            ),
          ],
          rows: startups.map((s) {
            return DataRow(
              cells: [
                // STARTUP & DOMAIN
                DataCell(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        s['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF7ED),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          s['domain'] ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFC2410C),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // STAGE
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      s['stage'] ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1D4ED8),
                      ),
                    ),
                  ),
                ),
                // LEGAL & REG NO
                DataCell(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        s['legalStructure'] ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        s['regNumber'] ?? 'N/A',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ),
                // FOUNDERS & DEPT
                DataCell(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        s['leadFounder'],
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                      Text(
                        s['department'],
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                // FUNDING & ARR
                DataCell(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        s['fundingMobilized'] ?? 'Bootstrapped',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        s['revenueArr'] ?? 'Pre-revenue',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color(0xFF059669),
                        ),
                      ),
                    ],
                  ),
                ),
                // PILOTS
                DataCell(
                  Text(
                    "${s['commercialPilots'] ?? 0}",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
                // PATENT STATUS
                DataCell(
                  Text(
                    s['patentStatus'] ?? 'None',
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
                // ASSIGNED MENTOR
                DataCell(
                  Text(
                    s['mentor'] ?? 'Unassigned',
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF334155),
                    ),
                  ),
                ),
                // ACTIONS
                DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton(
                        onPressed: () => _openStartupDialog(initialStartup: s),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF0F172A),
                          side: const BorderSide(color: Color(0xFFCBD5E1)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: Text(
                          "Update",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      IconButton(
                        onPressed: () => _confirmDeleteStartup(s),
                        icon: const Icon(Icons.delete_outline_rounded,
                            size: 16, color: Color(0xFFEF4444)),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
                        tooltip: "Delete startup",
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
            const Icon(Icons.rocket_outlined,
                size: 40, color: Color(0xFF94A3B8)),
            const SizedBox(height: 12),
            Text(
              "No startups match the search or filter.",
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Try clearing your search term or domain/stage filter.",
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
  // 7. REGISTER CAMPUS STARTUP MODAL DIALOG (Matches Image 5)
  // ===========================================================================
  void _openStartupDialog({Map<String, dynamic>? initialStartup}) {
    final isEditing = initialStartup != null;

    final nameCtrl = TextEditingController(text: initialStartup?['name'] ?? '');
    String domain = initialStartup?['domain'] ?? 'EdTech';
    final taglineCtrl =
        TextEditingController(text: initialStartup?['tagline'] ?? '');
    String legalStructure =
        initialStartup?['legalStructure'] ?? 'Registered Private Limited';
    String stage = initialStartup?['stage'] ?? 'MVP Live';
    final regNoCtrl =
        TextEditingController(text: initialStartup?['regNumber'] ?? '');
    String patentStatus =
        initialStartup?['patentStatus'] ?? 'Not Applicable';
    final founderNameCtrl =
        TextEditingController(text: initialStartup?['leadFounder'] ?? '');
    final founderEmailCtrl =
        TextEditingController(text: initialStartup?['founderEmail'] ?? '');
    final deptCtrl =
        TextEditingController(text: initialStartup?['department'] ?? 'Computer Applications');
    final cohortCtrl =
        TextEditingController(text: initialStartup?['cohort'] ?? '2026');
    final mentorCtrl =
        TextEditingController(text: initialStartup?['mentor'] ?? 'Unassigned');
    final readinessCtrl = TextEditingController(
        text: (initialStartup?['readiness'] ?? 60).toString());

    final fundingCtrl = TextEditingController(
        text: initialStartup?['fundingMobilized'] ?? 'Bootstrapped');
    final revenueCtrl = TextEditingController(
        text: initialStartup?['revenueArr'] ?? 'Pre-revenue');
    final pilotsCtrl = TextEditingController(
        text: (initialStartup?['commercialPilots'] ?? 0).toString());

    final deckCtrl =
        TextEditingController(text: initialStartup?['deckUrl'] ?? '');
    final demoCtrl =
        TextEditingController(text: initialStartup?['demoUrl'] ?? '');
    final webCtrl =
        TextEditingController(text: initialStartup?['webUrl'] ?? '');

    final domainsList = [
      "EdTech",
      "HealthTech",
      "FinTech",
      "Agritech",
      "AI/ML",
      "CleanTech",
      "DeepTech",
      "Other",
    ];

    final stagesList = [
      "Ideation",
      "Prototype",
      "MVP Live",
      "Early Traction",
      "Scaling",
    ];

    final legalList = [
      "Registered Private Limited",
      "LLP",
      "Partnership",
      "Sole Proprietorship",
      "Unregistered",
    ];

    final patentList = [
      "Not Applicable",
      "Provisional Patent Filed",
      "Complete Patent Published",
      "Patent Granted",
      "Copyright / Trademark Only",
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
                constraints: const BoxConstraints(maxWidth: 720),
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
                                  isEditing
                                      ? "Update Campus Startup"
                                      : "Register Campus Startup",
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "Admit a student or faculty venture into the incubator portfolio",
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

                      // Row 1: Startup Name * & Domain *
                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                              label: "Startup Name *",
                              hint: "e.g. NeuralDrone AI",
                              controller: nameCtrl,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _buildDropdownField(
                              label: "Domain *",
                              value: domain,
                              items: domainsList,
                              onChanged: (v) {
                                if (v != null) setDialogState(() => domain = v);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 2: Venture Tagline & Solution *
                      _buildFormField(
                        label: "Venture Tagline & Solution *",
                        hint: "Short pitch explaining the innovation, target market and product",
                        controller: taglineCtrl,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 14),

                      // Row 3: Incorporation Status * & Current Stage *
                      Row(
                        children: [
                          Expanded(
                            child: _buildDropdownField(
                              label: "Incorporation Status *",
                              value: legalStructure,
                              items: legalList,
                              onChanged: (v) {
                                if (v != null) {
                                  setDialogState(() => legalStructure = v);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _buildDropdownField(
                              label: "Current Stage *",
                              value: stage,
                              items: stagesList,
                              onChanged: (v) {
                                if (v != null) setDialogState(() => stage = v);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 4: Registration / DPIIT Number & Patent / IP Status
                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                              label: "Registration / DPIIT Number",
                              hint: "e.g. DIPP-12849 or CIN",
                              controller: regNoCtrl,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _buildDropdownField(
                              label: "Patent / IP Status",
                              value: patentStatus,
                              items: patentList,
                              onChanged: (v) {
                                if (v != null) {
                                  setDialogState(() => patentStatus = v);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 5: Lead Founder Name * & Lead Founder Email *
                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                              label: "Lead Founder Name *",
                              hint: "e.g. Bala Subramanian",
                              controller: founderNameCtrl,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _buildFormField(
                              label: "Lead Founder Email *",
                              hint: "founder@domain.com",
                              controller: founderEmailCtrl,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 6: Academic Department * & Cohort
                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                              label: "Academic Department *",
                              hint: "e.g. Computer Applications",
                              controller: deptCtrl,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _buildFormField(
                              label: "Cohort",
                              hint: "e.g. 2026",
                              controller: cohortCtrl,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 7: Assigned Domain Mentor & Readiness Score (0 - 100)
                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                              label: "Assigned Domain Mentor",
                              hint: "e.g. Unassigned or Dr. K. Ramesh",
                              controller: mentorCtrl,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _buildFormField(
                              label: "Readiness Score (0 - 100)",
                              hint: "60",
                              controller: readinessCtrl,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // 3-Col Stats: Funding Mobilized, Revenue (ARR), Active Pilots Count
                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                              label: "Funding Mobilized",
                              hint: "e.g. Bootstrapped / ₹10L",
                              controller: fundingCtrl,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildFormField(
                              label: "Revenue (ARR)",
                              hint: "e.g. Pre-revenue",
                              controller: revenueCtrl,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildFormField(
                              label: "Active Pilots Count",
                              hint: "0",
                              controller: pilotsCtrl,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // 3-Col URLs: Pitch Deck URL, Live Demo URL, Website URL
                      Row(
                        children: [
                          Expanded(
                            child: _buildFormField(
                              label: "Pitch Deck URL",
                              hint: "https://drive.google.com/...",
                              controller: deckCtrl,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildFormField(
                              label: "Live Demo URL",
                              hint: "https://demo.app",
                              controller: demoCtrl,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildFormField(
                              label: "Website URL",
                              hint: "https://startup.com",
                              controller: webCtrl,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),

                      // Action Buttons: Cancel & Register Startup
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
                              final founder = founderNameCtrl.text.trim();
                              if (name.isEmpty || founder.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Please enter Startup Name and Lead Founder Name.",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }

                              final readScore =
                                  int.tryParse(readinessCtrl.text.trim()) ?? 60;
                              final pilotsCount =
                                  int.tryParse(pilotsCtrl.text.trim()) ?? 0;
                              final regNo = regNoCtrl.text.trim();
                              final isDpiitVal = regNo.toUpperCase().contains('DPIIT') ||
                                  regNo.toUpperCase().contains('DIPP');

                              setState(() {
                                if (isEditing) {
                                  initialStartup['name'] = name;
                                  initialStartup['domain'] = domain;
                                  initialStartup['tagline'] = taglineCtrl.text.trim();
                                  initialStartup['legalStructure'] = legalStructure;
                                  initialStartup['stage'] = stage;
                                  initialStartup['regNumber'] = regNo;
                                  initialStartup['patentStatus'] = patentStatus;
                                  initialStartup['leadFounder'] = founder;
                                  initialStartup['founderEmail'] = founderEmailCtrl.text.trim();
                                  initialStartup['department'] = deptCtrl.text.trim();
                                  initialStartup['cohort'] = cohortCtrl.text.trim();
                                  initialStartup['mentor'] = mentorCtrl.text.trim();
                                  initialStartup['readiness'] = readScore;
                                  initialStartup['fundingMobilized'] = fundingCtrl.text.trim();
                                  initialStartup['revenueArr'] = revenueCtrl.text.trim();
                                  initialStartup['commercialPilots'] = pilotsCount;
                                  initialStartup['isDpiit'] = isDpiitVal;
                                  initialStartup['deckUrl'] = deckCtrl.text.trim().isNotEmpty ? deckCtrl.text.trim() : null;
                                  initialStartup['demoUrl'] = demoCtrl.text.trim().isNotEmpty ? demoCtrl.text.trim() : null;
                                  initialStartup['webUrl'] = webCtrl.text.trim().isNotEmpty ? webCtrl.text.trim() : null;
                                } else {
                                  _startups.insert(0, {
                                    'id': 'startup-${DateTime.now().millisecondsSinceEpoch}',
                                    'name': name,
                                    'domain': domain,
                                    'tagline': taglineCtrl.text.trim().isNotEmpty
                                        ? taglineCtrl.text.trim()
                                        : 'Student campus innovation admitted into incubation portfolio.',
                                    'stage': stage,
                                    'legalStructure': legalStructure,
                                    'regNumber': regNo,
                                    'incubationStatus': 'Incubation in progress',
                                    'readiness': readScore,
                                    'fundingMobilized': fundingCtrl.text.trim().isNotEmpty ? fundingCtrl.text.trim() : 'Bootstrapped',
                                    'fundingAmount': 0.0,
                                    'revenueArr': revenueCtrl.text.trim().isNotEmpty ? revenueCtrl.text.trim() : 'Pre-revenue',
                                    'commercialPilots': pilotsCount,
                                    'patentStatus': patentStatus,
                                    'leadFounder': founder,
                                    'founderEmail': founderEmailCtrl.text.trim(),
                                    'department': deptCtrl.text.trim(),
                                    'cohort': cohortCtrl.text.trim().isNotEmpty ? cohortCtrl.text.trim() : '2026',
                                    'mentor': mentorCtrl.text.trim().isNotEmpty ? mentorCtrl.text.trim() : 'Unassigned',
                                    'isDpiit': isDpiitVal,
                                    'deckUrl': deckCtrl.text.trim().isNotEmpty ? deckCtrl.text.trim() : null,
                                    'demoUrl': demoCtrl.text.trim().isNotEmpty ? demoCtrl.text.trim() : null,
                                    'webUrl': webCtrl.text.trim().isNotEmpty ? webCtrl.text.trim() : null,
                                  });
                                }
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
                                        isEditing
                                            ? "$name updated successfully."
                                            : "$name registered into incubator portfolio.",
                                        style: GoogleFonts.poppins(fontSize: 12.5),
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
                              isEditing ? "Save changes" : "Register Startup",
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
    TextInputType keyboardType = TextInputType.text,
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
          keyboardType: keyboardType,
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

  void _confirmDeleteStartup(Map<String, dynamic> s) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Text(
          "Delete Startup",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
        content: Text(
          "Are you sure you want to remove '${s['name']}' from the incubator portfolio?",
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
                _startups.removeWhere((item) => item['id'] == s['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "'${s['name']}' removed from incubator portfolio.",
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
              "Delete",
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
        "Startup Name,Domain,Stage,Legal Structure,Reg No,Founder,Department,Funding,ARR,Pilots,Patent Status,Mentor");
    for (final s in _filteredStartups) {
      buffer.writeln(
          '"${s['name']}","${s['domain']}","${s['stage']}","${s['legalStructure']}","${s['regNumber'] ?? ''}","${s['leadFounder']}","${s['department']}","${s['fundingMobilized']}","${s['revenueArr']}","${s['commercialPilots']}","${s['patentStatus']}","${s['mentor']}"');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Exported ${_filteredStartups.length} startups to CSV successfully.",
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
