import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INCUBATION HEAD: INCUBATION PIPELINE SCREEN (Matches Images 3, 4 & 5)
// - Image 3: Main Screen:
//   * Blueprint Hero Banner: Home > Incubation > Incubation Pipeline (INCUBATION, Phase 2)
//   * 5 KPI Cards:
//       1. Total Ventures: 2 (In active 2026 Innovation Cohort)
//       2. In Panel Review: 0 (Scheduled for decision)
//       3. Incubated: 0 (Admitted into cell)
//       4. Seed Grants: ₹0 (Disbursed & approved)
//       5. Active Mentors: 2 (Faculty & industry network)
//   * Incubation Stage Progression (6 phases clickable filter):
//       - Phase 1: Idea (1)
//       - Phase 2: Validation (0)
//       - Phase 3: Business Model & MVP (0)
//       - Phase 4: Prototyping & Mentorship (1)
//       - Phase 5: Incubation Review (0)
//       - Phase 6: Incubated (0)
//   * Filter & Action Bar:
//       - "2026 Innovation Cohort" dropdown
//       - "All Domains" dropdown
//       - "Search ventures, founders..."
//       - Board / Table view toggle
//       - "Export CSV" button
//       - "+ Add Venture" primary button
//   * Kanban Board (6 stage columns):
//       - Idea (1): AgriDrone Dynamics (AgriTech, 0% ready, Karthik Raman +2, CSE, Mentor: Dr. S. Meenakshi)
//       - Validation (0): empty dashed state
//       - Business Model & MVP (0): empty dashed state
//       - Prototyping & Mentorship (1): SolPulse Robotics (CleanTech & IoT, 0% ready, Priya Sundaram +1, MECH, Mentor: Prof. R. Venkatesh)
//       - Incubation Review (0): empty dashed state
//       - Incubated (0): empty dashed state
// - Image 4: "Register New Venture" modal dialog
// - Image 5: "Incubation Panel Evaluation" modal dialog
// =============================================================================

class IncubationPipelineScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const IncubationPipelineScreen({super.key, this.onBack});

  @override
  State<IncubationPipelineScreen> createState() =>
      _IncubationPipelineScreenState();
}

class _IncubationPipelineScreenState extends State<IncubationPipelineScreen> {
  // State variables
  String _selectedCohort = '2026 Innovation Cohort';
  String _selectedDomain = 'All Domains';
  String _selectedPhaseFilter = 'All Phases';
  final TextEditingController _searchController = TextEditingController();
  bool _isTableView = false; // false = Board view, true = Table view

  final List<String> _cohorts = [
    '2026 Innovation Cohort',
    '2025 Innovation Cohort',
    'All Cohorts',
  ];

  final List<String> _domains = [
    'All Domains',
    'AgriTech',
    'CleanTech & IoT',
    'HealthTech',
    'EdTech',
    'FinTech',
    'AI & SaaS',
    'DeepTech',
  ];

  final List<Map<String, String>> _phaseDefinitions = [
    {
      'phase': 'PHASE 1',
      'name': 'Idea',
      'desc': 'Idea submission, initial screening &...',
    },
    {
      'phase': 'PHASE 2',
      'name': 'Validation',
      'desc': 'Customer discovery, market...',
    },
    {
      'phase': 'PHASE 3',
      'name': 'Business Model & MVP',
      'desc': 'Unit economics, revenue...',
    },
    {
      'phase': 'PHASE 4',
      'name': 'Prototyping & Mentorship',
      'desc': 'Functional prototype testing with...',
    },
    {
      'phase': 'PHASE 5',
      'name': 'Incubation Review',
      'desc': 'Formal presentation before Colleg...',
    },
    {
      'phase': 'PHASE 6',
      'name': 'Incubated',
      'desc': 'Admitted into campus incubator...',
    },
  ];

  // Initial ventures from Image 3
  late List<Map<String, dynamic>> _ventures;

  @override
  void initState() {
    super.initState();
    _ventures = [
      {
        'id': 'v-1',
        'name': 'AgriDrone Dynamics',
        'tagline':
            'AI-powered drone survey and multispectral crop disease diagnostics',
        'domain': 'AgriTech',
        'stage': 'Idea',
        'leadFounder': 'Karthik Raman',
        'teamSummary': 'Karthik Raman +2',
        'leadEmail': 'karthik.r@ait.edu.in',
        'department': 'Computer Science & Engineering',
        'mentor': 'Dr. S. Meenakshi',
        'readiness': 0,
        'coFounders': 'Divya M., Arun S.',
        'pitchDeck': 'https://drive.google.com/deck/agridrone',
        'demoUrl': 'https://prototype.ait.edu.in/agridrone',
        'cohort': '2026 Innovation Cohort',
        'seedGrant': '—',
        'panelVerdict': 'Pending Review',
        'panelRemarks': '',
      },
      {
        'id': 'v-2',
        'name': 'SolPulse Robotics',
        'tagline':
            'Autonomous waterless cleaning robots for commercial solar panel farms',
        'domain': 'CleanTech & IoT',
        'stage': 'Prototyping & Mentorship',
        'leadFounder': 'Priya Sundaram',
        'teamSummary': 'Priya Sundaram +1',
        'leadEmail': 'priya.s@ait.edu.in',
        'department': 'Mechanical Engineering',
        'mentor': 'Prof. R. Venkatesh',
        'readiness': 0,
        'coFounders': 'Manoj K.',
        'pitchDeck': 'https://drive.google.com/deck/solpulse',
        'demoUrl': 'https://prototype.ait.edu.in/solpulse',
        'cohort': '2026 Innovation Cohort',
        'seedGrant': '—',
        'panelVerdict': 'In Mentorship',
        'panelRemarks': '',
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filtered ventures
  List<Map<String, dynamic>> get _filteredVentures {
    final query = _searchController.text.trim().toLowerCase();
    return _ventures.where((v) {
      if (_selectedCohort != 'All Cohorts' && v['cohort'] != _selectedCohort) {
        return false;
      }
      if (_selectedDomain != 'All Domains' && v['domain'] != _selectedDomain) {
        return false;
      }
      if (_selectedPhaseFilter != 'All Phases' &&
          v['stage'] != _selectedPhaseFilter) {
        return false;
      }
      if (query.isNotEmpty) {
        final nameMatch = (v['name'] as String).toLowerCase().contains(query);
        final founderMatch =
            (v['leadFounder'] as String).toLowerCase().contains(query);
        final deptMatch =
            (v['department'] as String).toLowerCase().contains(query);
        final tagMatch =
            (v['tagline'] as String).toLowerCase().contains(query);
        if (!nameMatch && !founderMatch && !deptMatch && !tagMatch) {
          return false;
        }
      }
      return true;
    }).toList();
  }

  int _countForStage(String stageName) {
    return _ventures.where((v) => v['stage'] == stageName).length;
  }

  int get _inPanelReviewCount {
    return _ventures.where((v) => v['stage'] == 'Incubation Review').length;
  }

  int get _incubatedCount {
    return _ventures.where((v) => v['stage'] == 'Incubated').length;
  }

  int get _activeMentorsCount {
    final mentors = _ventures
        .map((v) => v['mentor'] as String)
        .where((m) => m.isNotEmpty && m != '—')
        .toSet();
    return mentors.isEmpty ? 2 : mentors.length;
  }

  int get _totalGrantAmount {
    int total = 0;
    for (final v in _ventures) {
      final grant = v['seedGrant'] as String? ?? '';
      if (grant.contains('₹')) {
        final clean =
            grant.replaceAll('₹', '').replaceAll(',', '').replaceAll(' ', '');
        total += int.tryParse(clean) ?? 0;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double horizPadding = constraints.maxWidth < 640 ? 14.0 : 22.0;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizPadding,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Top Blueprint Hero Banner (Image 3)
                  _buildTopHeroBanner(),
                  const SizedBox(height: 18),

                  // 2. 5 KPI Stat Cards (Image 3)
                  _buildKpiCardsRow(constraints.maxWidth),
                  const SizedBox(height: 18),

                  // 3. Incubation Stage Progression Section Card (Image 3)
                  _buildStageProgressionCard(constraints.maxWidth),
                  const SizedBox(height: 18),

                  // 4. Filter & Action Row (Image 3)
                  _buildFilterAndActionBar(constraints.maxWidth),
                  const SizedBox(height: 18),

                  // 5. Main Content: Kanban Board or Data Table (Image 3)
                  if (_isTableView)
                    _buildTableView()
                  else
                    _buildKanbanBoard(constraints.maxWidth),

                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. HERO BLUEPRINT BANNER (Image 3)
  // ===========================================================================
  Widget _buildTopHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2865),
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A2255),
            Color(0xFF263380),
            Color(0xFF2D3C99),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2865).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background Grid Overlay
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            // Watermark Rocket Icon
            Positioned(
              right: 18,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb Row
                  Row(
                    children: [
                      if (widget.onBack != null) ...[
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.arrow_back,
                                size: 16, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                      Text(
                        'Home  ›  Incubation  ›  Incubation Pipeline',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: Colors.white.withValues(alpha: 0.72),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Category & Phase Badges
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2865),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.25)),
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
                            horizontal: 9, vertical: 3.5),
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
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Title with Rocket Icon Box
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.white.withValues(alpha: 0.18)),
                        ),
                        child: const Icon(
                          Icons.rocket_launch_rounded,
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
                              'Incubation Pipeline',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Idea -> validation -> market -> business model -> MVP -> pitch -> incubation review.',
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: Colors.white.withValues(alpha: 0.88),
                                fontWeight: FontWeight.w400,
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
  // 2. 5 KPI CARDS (Image 3)
  // ===========================================================================
  Widget _buildKpiCardsRow(double maxWidth) {
    final List<Widget> cards = [
      _buildStatCard(
        title: 'TOTAL VENTURES',
        value: '${_ventures.length}',
        subtitle: 'In active 2026 Innovation Cohort',
        icon: Icons.rocket_launch_outlined,
        iconBg: const Color(0xFFEDE9FE),
        iconColor: const Color(0xFF7C3AED),
      ),
      _buildStatCard(
        title: 'IN PANEL REVIEW',
        value: '$_inPanelReviewCount',
        subtitle: 'Scheduled for decision',
        subtitleColor: _inPanelReviewCount > 0 ? const Color(0xFFDC2626) : const Color(0xFFDC2626),
        icon: Icons.local_fire_department_outlined,
        iconBg: const Color(0xFFFEE2E2),
        iconColor: const Color(0xFFDC2626),
      ),
      _buildStatCard(
        title: 'INCUBATED',
        value: '$_incubatedCount',
        subtitle: 'Admitted into cell',
        icon: Icons.military_tech_outlined,
        iconBg: const Color(0xFFCCFBF1),
        iconColor: const Color(0xFF0D9488),
      ),
      _buildStatCard(
        title: 'SEED GRANTS',
        value: _totalGrantAmount == 0 ? '₹0' : '₹$_totalGrantAmount',
        subtitle: 'Disbursed & approved',
        icon: Icons.trending_up_rounded,
        iconBg: const Color(0xFFFEF3C7),
        iconColor: const Color(0xFFD97706),
      ),
      _buildStatCard(
        title: 'ACTIVE MENTORS',
        value: '$_activeMentorsCount',
        subtitle: 'Faculty & industry network',
        icon: Icons.people_outline_rounded,
        iconBg: const Color(0xFFEFF6FF),
        iconColor: const Color(0xFF2563EB),
      ),
    ];

    if (maxWidth < 1080) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: cards
              .map((c) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(width: 210, child: c),
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
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    Color? subtitleColor,
  }) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF64748B),
                    letterSpacing: 0.6,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
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
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
              height: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: subtitleColor ?? const Color(0xFF94A3B8),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. INCUBATION STAGE PROGRESSION CARD (Image 3)
  // ===========================================================================
  Widget _buildStageProgressionCard(double maxWidth) {
    return Container(
      padding: const EdgeInsets.all(18),
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
          Text(
            'Incubation Stage Progression',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Tap any phase to filter the pipeline',
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),

          // 6 Stage horizontal cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: _phaseDefinitions.map((def) {
                final stageName = def['name']!;
                final phaseTag = def['phase']!;
                final desc = def['desc']!;
                final count = _countForStage(stageName);
                final isSelected = _selectedPhaseFilter == stageName;

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (_selectedPhaseFilter == stageName) {
                          _selectedPhaseFilter = 'All Phases';
                        } else {
                          _selectedPhaseFilter = stageName;
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 175,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFF0F4FF)
                            : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF1E2865)
                              : const Color(0xFFE2E8F0),
                          width: isSelected ? 1.5 : 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                phaseTag,
                                style: GoogleFonts.poppins(
                                  fontSize: 9.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF64748B),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 1.5),
                                decoration: BoxDecoration(
                                  color: count > 0
                                      ? const Color(0xFFEFF6FF)
                                      : const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  '$count',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: count > 0
                                        ? const Color(0xFF2563EB)
                                        : const Color(0xFF64748B),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            stageName,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            desc,
                            style: GoogleFonts.poppins(
                              fontSize: 9.5,
                              color: const Color(0xFF94A3B8),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. FILTER & ACTION ROW (Image 3)
  // ===========================================================================
  Widget _buildFilterAndActionBar(double maxWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
        builder: (context, c) {
          final isNarrow = c.maxWidth < 920;

          final cohortDropdown = Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCohort,
                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                    size: 16, color: Color(0xFF64748B)),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A),
                ),
                items: _cohorts
                    .map((co) => DropdownMenuItem(value: co, child: Text(co)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCohort = val);
                },
              ),
            ),
          );

          final domainDropdown = Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedDomain,
                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                    size: 16, color: Color(0xFF64748B)),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A),
                ),
                items: _domains
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedDomain = val);
                },
              ),
            ),
          );

          final searchInput = Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded,
                    size: 16, color: Color(0xFF94A3B8)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    style: GoogleFonts.poppins(fontSize: 12),
                    decoration: InputDecoration(
                      hintText: 'Search ventures, founders...',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF94A3B8),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      setState(() {});
                    },
                    child: const Icon(Icons.close_rounded,
                        size: 14, color: Color(0xFF94A3B8)),
                  ),
              ],
            ),
          );

          // Board & Table toggle
          final viewToggle = Container(
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => setState(() => _isTableView = false),
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: !_isTableView ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: !_isTableView
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
                          Icons.view_column_outlined,
                          size: 15,
                          color: !_isTableView
                              ? const Color(0xFF1E2865)
                              : const Color(0xFF64748B),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Board',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: !_isTableView
                                ? const Color(0xFF1E2865)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => setState(() => _isTableView = true),
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: _isTableView ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: _isTableView
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
                          Icons.table_chart_outlined,
                          size: 15,
                          color: _isTableView
                              ? const Color(0xFF1E2865)
                              : const Color(0xFF64748B),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Table',
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: _isTableView
                                ? const Color(0xFF1E2865)
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );

          final exportBtn = OutlinedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Exporting Incubation Pipeline dataset (CSV)...',
                    style: GoogleFonts.poppins(),
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.download_rounded, size: 15),
            label: Text(
              'Export CSV',
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF334155),
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          );

          final addVentureBtn = ElevatedButton.icon(
            onPressed: _showRegisterVentureDialog,
            icon: const Icon(Icons.add, size: 16),
            label: Text(
              'Add Venture',
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2865),
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchInput,
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    cohortDropdown,
                    domainDropdown,
                    viewToggle,
                    exportBtn,
                    addVentureBtn,
                  ],
                ),
              ],
            );
          }

          return Row(
            children: [
              cohortDropdown,
              const SizedBox(width: 8),
              domainDropdown,
              const SizedBox(width: 8),
              Expanded(child: searchInput),
              const SizedBox(width: 10),
              viewToggle,
              const SizedBox(width: 8),
              exportBtn,
              const SizedBox(width: 8),
              addVentureBtn,
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 5. KANBAN BOARD (Image 3)
  // ===========================================================================
  Widget _buildKanbanBoard(double maxWidth) {
    final stages = [
      'Idea',
      'Validation',
      'Business Model & MVP',
      'Prototyping & Mentorship',
      'Incubation Review',
      'Incubated',
    ];

    // Filter stages if a specific phase is selected
    final displayedStages = _selectedPhaseFilter == 'All Phases'
        ? stages
        : stages.where((s) => s == _selectedPhaseFilter).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: displayedStages.map((stage) {
          final stageVentures =
              _filteredVentures.where((v) => v['stage'] == stage).toList();

          return Container(
            width: 275,
            margin: const EdgeInsets.only(right: 14),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Column Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        stage,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: stageVentures.isNotEmpty
                            ? const Color(0xFF1E2865)
                            : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${stageVentures.length}',
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: stageVentures.isNotEmpty
                              ? Colors.white
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Ventures in this stage
                if (stageVentures.isEmpty)
                  _buildEmptyStageBox()
                else
                  ...stageVentures.map((v) => _buildVentureCard(v)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEmptyStageBox() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFCBD5E1),
          style: BorderStyle.solid,
          width: 0.9,
        ),
      ),
      child: Center(
        child: Text(
          'No ventures at this stage',
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            color: const Color(0xFF94A3B8),
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // VENTURE CARD (Image 3)
  // ===========================================================================
  Widget _buildVentureCard(Map<String, dynamic> v) {
    final domain = v['domain'] as String? ?? 'General';
    final isAgri = domain.contains('Agri');
    final domainBg = isAgri ? const Color(0xFFDCFCE7) : const Color(0xFFEFF6FF);
    final domainColor =
        isAgri ? const Color(0xFF15803D) : const Color(0xFF2563EB);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showPanelEvaluationDialog(v),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Domain Pill + Readiness
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: domainBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        domain,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: domainColor,
                        ),
                      ),
                    ),
                    Text(
                      '${v['readiness'] ?? 0}% ready',
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Venture Name
                Text(
                  v['name'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),

                // Tagline
                Text(
                  v['tagline'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                    height: 1.35,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Founder info
                Row(
                  children: [
                    const Icon(Icons.person_outline_rounded,
                        size: 13, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        v['teamSummary'] ?? v['leadFounder'],
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
                const SizedBox(height: 3),

                // Department
                Text(
                  v['department'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    color: const Color(0xFF94A3B8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Mentor
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.school_outlined,
                          size: 12, color: Color(0xFF64748B)),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          v['mentor'] != null && (v['mentor'] as String).isNotEmpty
                              ? 'Mentor: ${v['mentor']}'
                              : 'No mentor assigned',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF475569),
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
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 6. TABLE VIEW (Alternate View)
  // ===========================================================================
  Widget _buildTableView() {
    return Container(
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 850),
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(const Color(0xFFFAFAFA)),
            headingTextStyle: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: const Color(0xFF64748B),
            ),
            columns: const [
              DataColumn(label: Text('VENTURE')),
              DataColumn(label: Text('DOMAIN')),
              DataColumn(label: Text('STAGE')),
              DataColumn(label: Text('LEAD FOUNDER & DEPT')),
              DataColumn(label: Text('MENTOR')),
              DataColumn(label: Text('READINESS')),
              DataColumn(label: Text('ACTION')),
            ],
            rows: _filteredVentures.map((v) {
              return DataRow(
                cells: [
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          v['name'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          v['tagline'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: const Color(0xFF64748B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        v['domain'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2563EB),
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        v['stage'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          v['leadFounder'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          v['department'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DataCell(
                    Text(
                      v['mentor'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      '${v['readiness']}%',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0D9488),
                      ),
                    ),
                  ),
                  DataCell(
                    ElevatedButton(
                      onPressed: () => _showPanelEvaluationDialog(v),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2865),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        minimumSize: const Size(0, 28),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        elevation: 0,
                      ),
                      child: Text(
                        'Evaluate',
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 7. REGISTER NEW VENTURE MODAL DIALOG (Image 4)
  // ===========================================================================
  void _showRegisterVentureDialog() {
    final nameCtrl = TextEditingController();
    final taglineCtrl = TextEditingController();
    String domain = 'AgriTech';
    String initialStage = 'Idea';
    final founderCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final deptCtrl = TextEditingController();
    final mentorCtrl = TextEditingController();
    final coFoundersCtrl = TextEditingController();
    final pitchDeckCtrl = TextEditingController();
    final demoUrlCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Register New Venture',
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                'Add a venture into the incubation pipeline',
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
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
                          height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 18),

                      // Venture Name *
                      _buildFieldLabel('Venture Name *'),
                      const SizedBox(height: 6),
                      _buildInputField(
                        controller: nameCtrl,
                        hintText: 'e.g. TerraScan Drone Mapping',
                      ),
                      const SizedBox(height: 14),

                      // One-line Tagline / Value Proposition *
                      _buildFieldLabel(
                          'One-line Tagline / Value Proposition *'),
                      const SizedBox(height: 6),
                      _buildInputField(
                        controller: taglineCtrl,
                        hintText:
                            'Autonomous LiDAR thermal survey for solar plant degradation',
                      ),
                      const SizedBox(height: 14),

                      // 2-Col: Domain Sector * & Initial Pipeline Stage
                      _buildResponsiveRow(
                        left: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Domain Sector *'),
                            const SizedBox(height: 6),
                            _buildDropdown(
                              value: domain,
                              items: _domains
                                  .where((d) => d != 'All Domains')
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setModalState(() => domain = val);
                                }
                              },
                            ),
                          ],
                        ),
                        right: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Initial Pipeline Stage'),
                            const SizedBox(height: 6),
                            _buildDropdown(
                              value: initialStage,
                              items: const [
                                'Idea',
                                'Validation',
                                'Business Model & MVP',
                                'Prototyping & Mentorship',
                                'Incubation Review',
                                'Incubated',
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  setModalState(() => initialStage = val);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // 2-Col: Lead Founder * & Lead Email *
                      _buildResponsiveRow(
                        left: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Lead Founder *'),
                            const SizedBox(height: 6),
                            _buildInputField(
                              controller: founderCtrl,
                              hintText: 'Student founder name',
                            ),
                          ],
                        ),
                        right: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Lead Email *'),
                            const SizedBox(height: 6),
                            _buildInputField(
                              controller: emailCtrl,
                              hintText: 'student@ait.edu.in',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // 2-Col: Department * & Assigned Mentor
                      _buildResponsiveRow(
                        left: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Department *'),
                            const SizedBox(height: 6),
                            _buildInputField(
                              controller: deptCtrl,
                              hintText: 'e.g. Computer Science & Engineering',
                            ),
                          ],
                        ),
                        right: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Assigned Mentor'),
                            const SizedBox(height: 6),
                            _buildInputField(
                              controller: mentorCtrl,
                              hintText: 'Faculty or Industry Mentor',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Co-Founders (comma separated)
                      _buildFieldLabel('Co-Founders (comma separated)'),
                      const SizedBox(height: 6),
                      _buildInputField(
                        controller: coFoundersCtrl,
                        hintText: 'Karthik R., Divya M., Arun S.',
                      ),
                      const SizedBox(height: 14),

                      // 2-Col: Pitch Deck URL & Demo / Prototype URL
                      _buildResponsiveRow(
                        left: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Pitch Deck URL'),
                            const SizedBox(height: 6),
                            _buildInputField(
                              controller: pitchDeckCtrl,
                              hintText: 'https://drive.google.com/...',
                            ),
                          ],
                        ),
                        right: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Demo / Prototype URL'),
                            const SizedBox(height: 6),
                            _buildInputField(
                              controller: demoUrlCtrl,
                              hintText: 'https://prototype.ait.edu.in',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Bottom Action Buttons
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
                              'Cancel',
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              final name = nameCtrl.text.trim();
                              final tagline = taglineCtrl.text.trim();
                              final founder = founderCtrl.text.trim();
                              if (name.isEmpty ||
                                  tagline.isEmpty ||
                                  founder.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please fill in Venture Name, Tagline and Lead Founder.',
                                      style: GoogleFonts.poppins(),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                return;
                              }

                              final newV = {
                                'id': 'v-${DateTime.now().millisecondsSinceEpoch}',
                                'name': name,
                                'tagline': tagline,
                                'domain': domain,
                                'stage': initialStage,
                                'leadFounder': founder,
                                'teamSummary': coFoundersCtrl.text.trim().isNotEmpty
                                    ? '$founder +${coFoundersCtrl.text.trim().split(',').length}'
                                    : founder,
                                'leadEmail': emailCtrl.text.trim().isNotEmpty
                                    ? emailCtrl.text.trim()
                                    : 'student@ait.edu.in',
                                'department': deptCtrl.text.trim().isNotEmpty
                                    ? deptCtrl.text.trim()
                                    : 'Computer Science & Engineering',
                                'mentor': mentorCtrl.text.trim().isNotEmpty
                                    ? mentorCtrl.text.trim()
                                    : '—',
                                'readiness': 0,
                                'coFounders': coFoundersCtrl.text.trim(),
                                'pitchDeck': pitchDeckCtrl.text.trim(),
                                'demoUrl': demoUrlCtrl.text.trim(),
                                'cohort': _selectedCohort,
                                'seedGrant': '—',
                                'panelVerdict': 'Registered',
                                'panelRemarks': '',
                              };

                              setState(() {
                                _ventures.insert(0, newV);
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
                                        '$name added to Incubation Pipeline ($initialStage)!',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.5),
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
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                            ),
                            child: Text(
                              'Add to Pipeline',
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
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
  // 8. INCUBATION PANEL EVALUATION MODAL DIALOG (Image 5)
  // ===========================================================================
  void _showPanelEvaluationDialog(Map<String, dynamic> v) {
    String panelVerdict = 'Approved for Incubation (Admit to Cell)';
    double readinessScore =
        (v['readiness'] as int? ?? 0) == 0 ? 85.0 : (v['readiness'] as int).toDouble();
    final grantCtrl =
        TextEditingController(text: v['seedGrant'] == '—' ? '—' : v['seedGrant']);
    final mentorCtrl = TextEditingController(text: v['mentor'] ?? '');
    final remarksCtrl =
        TextEditingController(text: v['panelRemarks'] ?? '');

    showDialog(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Incubation Panel Evaluation',
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              Text(
                                'Reviewing: ${v['name']}',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
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
                      const SizedBox(height: 16),

                      // Card (beige background)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBF8F2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFF0ECE1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              v['tagline'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Founder: ${v['leadFounder']} · Dept: ${v['department']} · Current: ${v['stage']}',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Panel Verdict *
                      _buildFieldLabel('Panel Verdict *'),
                      const SizedBox(height: 6),
                      _buildDropdown(
                        value: panelVerdict,
                        items: const [
                          'Approved for Incubation (Admit to Cell)',
                          'Advance to Next Stage',
                          'Recommend Seed Grant',
                          'Needs Revision / Pivot',
                          'Rejected',
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() => panelVerdict = val);
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Readiness / Evaluation Score (0–100) Slider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildFieldLabel(
                              'Readiness / Evaluation Score (0–100)'),
                          Text(
                            '${readinessScore.toInt()}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1E2865),
                            ),
                          ),
                        ],
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: const Color(0xFF1E2865),
                          inactiveTrackColor: const Color(0xFFE2E8F0),
                          thumbColor: const Color(0xFF1E2865),
                          overlayColor:
                              const Color(0xFF1E2865).withValues(alpha: 0.12),
                          trackHeight: 4,
                        ),
                        child: Slider(
                          value: readinessScore,
                          min: 0,
                          max: 100,
                          divisions: 100,
                          onChanged: (val) {
                            setModalState(() => readinessScore = val);
                          },
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 2-Col: Grant Allocation (if approved) & Assigned Mentor
                      _buildResponsiveRow(
                        left: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Grant Allocation (if approved)'),
                            const SizedBox(height: 6),
                            _buildInputField(
                              controller: grantCtrl,
                              hintText: '—',
                            ),
                          ],
                        ),
                        right: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFieldLabel('Assigned Mentor'),
                            const SizedBox(height: 6),
                            _buildInputField(
                              controller: mentorCtrl,
                              hintText: 'Dr. S. Meenakshi',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Panel Remarks & Next Steps *
                      _buildFieldLabel('Panel Remarks & Next Steps *'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: remarksCtrl,
                        maxLines: 4,
                        style: GoogleFonts.poppins(fontSize: 12.5),
                        decoration: InputDecoration(
                          hintText:
                              'Key strengths, milestone targets before grant disbursement, customer validation requirements...',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFF1E2865)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Action Buttons
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
                              'Cancel',
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                v['readiness'] = readinessScore.toInt();
                                v['panelVerdict'] = panelVerdict;
                                v['seedGrant'] = grantCtrl.text.trim().isNotEmpty
                                    ? grantCtrl.text.trim()
                                    : '—';
                                if (mentorCtrl.text.trim().isNotEmpty) {
                                  v['mentor'] = mentorCtrl.text.trim();
                                }
                                v['panelRemarks'] = remarksCtrl.text.trim();

                                // If verdict is Approved for Incubation -> move to Incubated
                                if (panelVerdict ==
                                    'Approved for Incubation (Admit to Cell)') {
                                  v['stage'] = 'Incubated';
                                } else if (panelVerdict ==
                                    'Advance to Next Stage') {
                                  final currentIdx = _phaseDefinitions
                                      .indexWhere((p) => p['name'] == v['stage']);
                                  if (currentIdx >= 0 &&
                                      currentIdx < _phaseDefinitions.length - 1) {
                                    v['stage'] =
                                        _phaseDefinitions[currentIdx + 1]['name'];
                                  }
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
                                        'Panel evaluation saved for ${v['name']}. Stage: ${v['stage']}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 12.5),
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
                              backgroundColor: const Color(0xFF2E3A8C),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                            ),
                            child: Text(
                              'Save Panel Evaluation',
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
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
  // HELPER WIDGETS
  // ===========================================================================
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF334155),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      style: GoogleFonts.poppins(fontSize: 12.5),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          fontSize: 12,
          color: const Color(0xFF94A3B8),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1E2865)),
        ),
        isDense: true,
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(
            fontSize: 12.5,
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
    );
  }

  Widget _buildResponsiveRow({
    required Widget left,
    required Widget right,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 480) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              left,
              const SizedBox(height: 12),
              right,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: left),
            const SizedBox(width: 12),
            Expanded(child: right),
          ],
        );
      },
    );
  }
}

class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1.0;

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
