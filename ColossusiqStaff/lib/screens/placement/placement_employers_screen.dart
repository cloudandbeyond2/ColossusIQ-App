import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// PLACEMENT: EMPLOYERS SCREEN
// Exactly matches Screenshot 1:
// - Blueprint grid hero banner with building watermark, PLACEMENT and MVP badges
// - 5 Metric KPI Cards:
//   1. Total Employers: 8, Registered corporate partners
//   2. Active Partners: 8, Tier-1, Preferred & Active
//   3. Tier-1 Partners: 4, Marquee corporate relationships
//   4. 3-Yr Total Hires: 374, Cumulative students hired
//   5. Average CTC: ₹14.6 LPA, Across hiring partners
// - Filter & Search Bar:
//   * Search input: "Search by company, contact person or location..."
//   * Dropdowns: All Sectors, All Tiers, All MoUs
//   * Actions: Export CSV, + Add employer
// - Employer Cards (TCS, Zoho, Amazon, Google, Microsoft, Cisco, Cognizant, Infosys):
//   * Company name, Preferred Recruiter & Sector badges
//   * Details button, Edit & Delete icons
//   * Location & Website row
//   * SPOC box with person, role, email, phone, LinkedIn
//   * 3-Yr Hires, Avg Package, Highest CTC stats
//   * Active MoU badge with valid date and Last drive date
// =============================================================================

class EmployersScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const EmployersScreen({super.key, this.onBack});

  @override
  State<EmployersScreen> createState() => _EmployersScreenState();
}

class _EmployersScreenState extends State<EmployersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSector = 'All Sectors';
  String _selectedTier = 'All Tiers';
  String _selectedMou = 'All MoUs';

  final List<String> _sectors = [
    'All Sectors',
    'IT & Software',
    'Enterprise SaaS',
    'Cloud & AI',
    'Networking & Security',
  ];

  final List<String> _tiers = [
    'All Tiers',
    'Preferred Recruiter',
    'Tier-1 Partner',
    'Dream Recruiter',
  ];

  final List<String> _mous = [
    'All MoUs',
    'Active MoU',
    'Pending Renewal',
  ];

  late List<Map<String, dynamic>> _employers;

  @override
  void initState() {
    super.initState();
    _employers = [
      {
        'id': 'tcs',
        'name': 'Tata Consultancy Services (TCS)',
        'recruiterType': 'Preferred Recruiter',
        'sector': 'IT & Software',
        'location': 'Chennai, Tamil Nadu',
        'website': 'Website',
        'spocName': 'Suresh Raman',
        'spocRole': 'Regional Head - Campus Hiring',
        'spocEmail': 'suresh.raman@tcs.com',
        'spocPhone': '+91 94440 98765',
        'linkedIn': 'LinkedIn',
        'threeYrHires': '142',
        'avgPackage': '₹8.2 LPA',
        'highestCtc': '₹11 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': 'Valid till 31 Aug 2028',
        'lastDrive': 'Last drive: 15 Sept 2026',
      },
      {
        'id': 'zoho',
        'name': 'Zoho Corporation',
        'recruiterType': 'Preferred Recruiter',
        'sector': 'IT & Software',
        'location': 'Chennai, Tamil Nadu',
        'website': 'Website',
        'spocName': 'Priyadarshini K.',
        'spocRole': 'University Relations Specialist',
        'spocEmail': 'priyadarshini.k@zohocorp.com',
        'spocPhone': '+91 97910 23456',
        'linkedIn': 'LinkedIn',
        'threeYrHires': '68',
        'avgPackage': '₹7.8 LPA',
        'highestCtc': '₹9.5 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': 'Valid till 31 Mar 2028',
        'lastDrive': 'Last drive: 28 Sept 2026',
      },
      {
        'id': 'amazon',
        'name': 'Amazon AWS India',
        'recruiterType': 'Tier-1 Partner',
        'sector': 'Cloud & AI',
        'location': 'Bengaluru, Karnataka',
        'website': 'Website',
        'spocName': 'Pooja V. Nair',
        'spocRole': 'Campus Talent Acquisition Lead',
        'spocEmail': 'pooja-campus@amazon.com',
        'spocPhone': '+91 98401 22334',
        'linkedIn': 'LinkedIn',
        'threeYrHires': '42',
        'avgPackage': '₹22.5 LPA',
        'highestCtc': '₹44 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': 'Valid till 15 Nov 2027',
        'lastDrive': 'Last drive: 18 Oct 2026',
      },
      {
        'id': 'google',
        'name': 'Google India',
        'recruiterType': 'Tier-1 Partner',
        'sector': 'IT & Software',
        'location': 'Hyderabad, Telangana',
        'website': 'Website',
        'spocName': 'Vikramaditya Rao',
        'spocRole': 'University Programs Manager',
        'spocEmail': 'vikramaditya@google.com',
        'spocPhone': '+91 98840 55667',
        'linkedIn': 'LinkedIn',
        'threeYrHires': '18',
        'avgPackage': '₹28.4 LPA',
        'highestCtc': '₹52 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': 'Valid till 30 Jun 2028',
        'lastDrive': 'Last drive: 25 Oct 2026',
      },
      {
        'id': 'microsoft',
        'name': 'Microsoft Corporation',
        'recruiterType': 'Tier-1 Partner',
        'sector': 'Enterprise SaaS',
        'location': 'Bengaluru, Karnataka',
        'website': 'Website',
        'spocName': 'Ananya Deshmukh',
        'spocRole': 'India University Hiring Lead',
        'spocEmail': 'ananya.d@microsoft.com',
        'spocPhone': '+91 97400 88990',
        'linkedIn': 'LinkedIn',
        'threeYrHires': '26',
        'avgPackage': '₹24.0 LPA',
        'highestCtc': '₹48 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': 'Valid till 10 Dec 2027',
        'lastDrive': 'Last drive: 05 Nov 2026',
      },
      {
        'id': 'cisco',
        'name': 'Cisco Systems',
        'recruiterType': 'Tier-1 Partner',
        'sector': 'Networking & Security',
        'location': 'Bengaluru, Karnataka',
        'website': 'Website',
        'spocName': 'Raghavan Iyer',
        'spocRole': 'Director - University Relations',
        'spocEmail': 'riyer@cisco.com',
        'spocPhone': '+91 94441 33221',
        'linkedIn': 'LinkedIn',
        'threeYrHires': '32',
        'avgPackage': '₹15.6 LPA',
        'highestCtc': '₹24 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': 'Valid till 20 Jan 2028',
        'lastDrive': 'Last drive: 12 Aug 2026',
      },
      {
        'id': 'cognizant',
        'name': 'Cognizant Technology Solutions',
        'recruiterType': 'Preferred Recruiter',
        'sector': 'IT & Software',
        'location': 'Chennai, Tamil Nadu',
        'website': 'Website',
        'spocName': 'Karthik Balan',
        'spocRole': 'Campus Engagement Lead',
        'spocEmail': 'karthik.balan@cognizant.com',
        'spocPhone': '+91 98410 77889',
        'linkedIn': 'LinkedIn',
        'threeYrHires': '30',
        'avgPackage': '₹6.8 LPA',
        'highestCtc': '₹10 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': 'Valid till 14 Feb 2028',
        'lastDrive': 'Last drive: 10 Sept 2026',
      },
      {
        'id': 'infosys',
        'name': 'Infosys Limited',
        'recruiterType': 'Preferred Recruiter',
        'sector': 'IT & Software',
        'location': 'Bengaluru, Karnataka',
        'website': 'Website',
        'spocName': 'Sneha Kulkarni',
        'spocRole': 'Associate VP - Campus Hiring',
        'spocEmail': 'sneha.k@infosys.com',
        'spocPhone': '+91 99001 44556',
        'linkedIn': 'LinkedIn',
        'threeYrHires': '16',
        'avgPackage': '₹6.5 LPA',
        'highestCtc': '₹9.5 LPA',
        'mouStatus': 'Active MoU',
        'mouValidTill': 'Valid till 05 May 2028',
        'lastDrive': 'Last drive: 02 Oct 2026',
      },
    ];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getFilteredEmployers() {
    final query = _searchController.text.trim().toLowerCase();
    return _employers.where((emp) {
      final nameMatches = (emp['name'] as String).toLowerCase().contains(query);
      final spocMatches = (emp['spocName'] as String).toLowerCase().contains(query);
      final locMatches = (emp['location'] as String).toLowerCase().contains(query);
      final searchMatches = query.isEmpty || nameMatches || spocMatches || locMatches;

      final sectorMatches = _selectedSector == 'All Sectors' ||
          emp['sector'] == _selectedSector;

      final tierMatches = _selectedTier == 'All Tiers' ||
          emp['recruiterType'] == _selectedTier;

      final mouMatches = _selectedMou == 'All MoUs' ||
          emp['mouStatus'] == _selectedMou;

      return searchMatches && sectorMatches && tierMatches && mouMatches;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _getFilteredEmployers();

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Top Hero Banner
              _buildTopHeroBanner(),
              const SizedBox(height: 18),

              // 2. 5 Metric Cards
              _buildMetricCards(),
              const SizedBox(height: 18),

              // 3. Search & Filter Bar
              _buildSearchAndFilterBar(),
              const SizedBox(height: 18),

              // 4. Employers Grid
              _buildEmployersGrid(filtered),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. TOP HERO BANNER (Image 1)
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
            // Watermark building
            Positioned(
              right: 15,
              bottom: -20,
              child: Opacity(
                opacity: 0.10,
                child: const Icon(
                  Icons.apartment_rounded,
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
                          'Placement',
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
                          'Employers',
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
                          Icons.apartment_rounded,
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
                                    'PLACEMENT',
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
                                    color: const Color(0xFF0D9488),
                                    borderRadius: BorderRadius.circular(12),
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
                            const SizedBox(height: 6),
                            Text(
                              'Employers',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Recruiter relationships, history and hiring outcomes.',
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
  // 2. 5 METRIC CARDS (Image 1)
  // ===========================================================================
  Widget _buildMetricCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int count = 1;
        if (constraints.maxWidth >= 1050) {
          count = 5;
        } else if (constraints.maxWidth >= 700) {
          count = 3;
        } else if (constraints.maxWidth >= 460) {
          count = 2;
        }

        final double cardWidth = (constraints.maxWidth - (count - 1) * 12) / count;

        final cards = [
          _buildStatCard('Total Employers', '8', 'Registered corporate partners',
              Icons.article_outlined),
          _buildStatCard('Active Partners', '8', 'Tier-1, Preferred & Active',
              Icons.handshake_outlined),
          _buildStatCard('Tier-1 Partners', '4', 'Marquee corporate relationships',
              Icons.trending_up_rounded),
          _buildStatCard('3-Yr Total Hires', '374', 'Cumulative students hired',
              Icons.people_outline_rounded),
          _buildStatCard('Average CTC', '₹14.6 LPA', 'Across hiring partners',
              Icons.check_circle_outline_rounded),
        ];

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards.map((c) => SizedBox(width: cardWidth, child: c)).toList(),
        );
      },
    );
  }

  Widget _buildStatCard(
      String title, String value, String subtitle, IconData icon) {
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
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, size: 16, color: const Color(0xFF94A3B8)),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF64748B),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. SEARCH & FILTERS BAR (Image 1)
  // ===========================================================================
  Widget _buildSearchAndFilterBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 900;

        final searchInput = Container(
          height: 42,
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
              hintText: 'Search by company, contact person or location...',
              hintStyle: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF94A3B8),
              ),
              prefixIcon: const Icon(Icons.search,
                  size: 18, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 11),
            ),
          ),
        );

        final sectorDropdown = _buildSmallDropdown(
          value: _selectedSector,
          items: _sectors,
          onChanged: (v) => setState(() => _selectedSector = v!),
        );

        final tierDropdown = _buildSmallDropdown(
          value: _selectedTier,
          items: _tiers,
          onChanged: (v) => setState(() => _selectedTier = v!),
        );

        final mouDropdown = _buildSmallDropdown(
          value: _selectedMou,
          items: _mous,
          onChanged: (v) => setState(() => _selectedMou = v!),
        );

        final exportCsvBtn = OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Exporting employers roster as CSV...',
                    style: GoogleFonts.poppins()),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.file_download_outlined,
              size: 15, color: Color(0xFF334155)),
          label: Text(
            'Export CSV',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        );

        final addEmployerBtn = ElevatedButton.icon(
          onPressed: _showAddEmployerDialog,
          icon: const Icon(Icons.add, size: 16),
          label: Text(
            'Add employer',
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

        if (isNarrow) {
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
                searchInput,
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    sectorDropdown,
                    tierDropdown,
                    mouDropdown,
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    exportCsvBtn,
                    addEmployerBtn,
                  ],
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: searchInput,
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    sectorDropdown,
                    const SizedBox(height: 8),
                    tierDropdown,
                    const SizedBox(height: 8),
                    mouDropdown,
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        exportCsvBtn,
                        const SizedBox(width: 10),
                        addEmployerBtn,
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSmallDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down,
              size: 16, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: const Color(0xFF334155),
            fontWeight: FontWeight.w500,
          ),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. EMPLOYERS GRID (Image 1)
  // ===========================================================================
  Widget _buildEmployersGrid(List<Map<String, dynamic>> items) {
    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        alignment: Alignment.center,
        child: Column(
          children: [
            const Icon(Icons.search_off_rounded,
                size: 40, color: Color(0xFF94A3B8)),
            const SizedBox(height: 10),
            Text(
              'No employers match your search or filter criteria.',
              style: GoogleFonts.poppins(
                  fontSize: 13, color: const Color(0xFF64748B)),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTwoCol = constraints.maxWidth >= 820;
        final cardWidth = isTwoCol
            ? (constraints.maxWidth - 16) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: items
              .map((emp) => SizedBox(
                    width: cardWidth,
                    child: _buildEmployerCard(emp),
                  ))
              .toList(),
        );
      },
    );
  }

  Widget _buildEmployerCard(Map<String, dynamic> emp) {
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
          // Top row: Name, badges, details, edit, delete
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      emp['name'],
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        emp['recruiterType'],
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF15803D),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        emp['sector'],
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
              const SizedBox(width: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () => _showEmployerDetailsDialog(emp),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF0F172A),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      minimumSize: const Size(0, 28),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Text(
                      'Details',
                      style: GoogleFonts.poppins(
                          fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined,
                        size: 16, color: Color(0xFF64748B)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Editing ${emp['name']} profile.",
                              style: GoogleFonts.poppins()),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    tooltip: 'Edit employer',
                  ),
                  const SizedBox(width: 6),
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded,
                        size: 16, color: Color(0xFF64748B)),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Delete confirmation for ${emp['name']}.",
                              style: GoogleFonts.poppins()),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    tooltip: 'Delete employer',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Location & Website
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 13, color: Color(0xFF64748B)),
                  const SizedBox(width: 4),
                  Text(
                    emp['location'],
                    style: GoogleFonts.poppins(
                        fontSize: 11.5, color: const Color(0xFF64748B)),
                  ),
                ],
              ),
              const Text('•',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Opening website for ${emp['name']}",
                          style: GoogleFonts.poppins()),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.language_rounded,
                        size: 13, color: Color(0xFF1E2865)),
                    const SizedBox(width: 4),
                    Text(
                      emp['website'],
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF1E2865),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // SPOC Box (Image 1)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.person_outline_rounded,
                            size: 14, color: Color(0xFF64748B)),
                        const SizedBox(width: 6),
                        Text(
                          emp['spocName'],
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      emp['spocRole'],
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.mail_outline_rounded,
                            size: 13, color: Color(0xFF64748B)),
                        const SizedBox(width: 4),
                        Text(
                          emp['spocEmail'],
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.phone_outlined,
                            size: 13, color: Color(0xFF64748B)),
                        const SizedBox(width: 4),
                        Text(
                          emp['spocPhone'],
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Opening LinkedIn for ${emp['spocName']}",
                                style: GoogleFonts.poppins()),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.open_in_new_rounded,
                              size: 12, color: Color(0xFF1E2865)),
                          const SizedBox(width: 3),
                          Text(
                            emp['linkedIn'],
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF1E2865),
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
          const SizedBox(height: 14),

          // 3-Yr Hires, Avg Package, Highest CTC
          Row(
            children: [
              Expanded(
                child: _buildMetricColumn('3-Yr Hires', emp['threeYrHires']),
              ),
              Expanded(
                child: _buildMetricColumn('Avg Package', emp['avgPackage']),
              ),
              Expanded(
                child: _buildMetricColumn('Highest CTC', emp['highestCtc']),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 10),

          // Footer Row: Active MoU & Last drive
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      emp['mouStatus'],
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF15803D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    emp['mouValidTill'],
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              Text(
                emp['lastDrive'],
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricColumn(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // MODALS: ADD EMPLOYER & DETAILS
  // ===========================================================================
  void _showAddEmployerDialog() {
    final nameCtrl = TextEditingController();
    final sectorCtrl = TextEditingController(text: 'IT & Software');
    final spocCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            'Add New Employer',
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w700),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 440,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Company Name',
                      hintText: 'e.g. Cisco Systems',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: sectorCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Sector / Domain',
                      hintText: 'e.g. IT & Software',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: spocCtrl,
                    decoration: const InputDecoration(
                      labelText: 'SPOC Contact Person',
                      hintText: 'e.g. Rajesh Kumar',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(
                      labelText: 'SPOC Email Address',
                      hintText: 'e.g. rajesh@company.com',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneCtrl,
                    decoration: const InputDecoration(
                      labelText: 'SPOC Phone Number',
                      hintText: 'e.g. +91 98765 43210',
                    ),
                  ),
                ],
              ),
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
                if (nameCtrl.text.trim().isNotEmpty) {
                  setState(() {
                    _employers.insert(0, {
                      'id': DateTime.now().millisecondsSinceEpoch.toString(),
                      'name': nameCtrl.text.trim(),
                      'recruiterType': 'Preferred Recruiter',
                      'sector': sectorCtrl.text.trim().isNotEmpty
                          ? sectorCtrl.text.trim()
                          : 'IT & Software',
                      'location': 'Chennai, Tamil Nadu',
                      'website': 'Website',
                      'spocName': spocCtrl.text.trim().isNotEmpty
                          ? spocCtrl.text.trim()
                          : 'Campus HR',
                      'spocRole': 'Recruiting Manager',
                      'spocEmail': emailCtrl.text.trim().isNotEmpty
                          ? emailCtrl.text.trim()
                          : 'campus@company.com',
                      'spocPhone': phoneCtrl.text.trim().isNotEmpty
                          ? phoneCtrl.text.trim()
                          : '+91 90000 11111',
                      'linkedIn': 'LinkedIn',
                      'threeYrHires': '0',
                      'avgPackage': '₹8.0 LPA',
                      'highestCtc': '₹12 LPA',
                      'mouStatus': 'Active MoU',
                      'mouValidTill': 'Valid till 31 Dec 2028',
                      'lastDrive': 'Upcoming: Nov 2026',
                    });
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "Employer ${nameCtrl.text.trim()} added successfully.",
                          style: GoogleFonts.poppins()),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: Text('Add Employer', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  void _showEmployerDetailsDialog(Map<String, dynamic> emp) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  emp['name'],
                  style: GoogleFonts.poppins(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  emp['recruiterType'],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF15803D),
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              constraints: const BoxConstraints(maxWidth: 460),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _detailRow('Sector', emp['sector']),
                  _detailRow('Headquarters', emp['location']),
                  _detailRow('Campus SPOC', emp['spocName']),
                  _detailRow('Designation', emp['spocRole']),
                  _detailRow('Email', emp['spocEmail']),
                  _detailRow('Phone', emp['spocPhone']),
                  const Divider(height: 20),
                  _detailRow('3-Year Total Hires', '${emp['threeYrHires']} students'),
                  _detailRow('Average Compensation', emp['avgPackage']),
                  _detailRow('Highest Offered CTC', emp['highestCtc']),
                  _detailRow('MoU Status', '${emp['mouStatus']} · ${emp['mouValidTill']}'),
                  _detailRow('Latest Activity', emp['lastDrive']),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Close', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
        ],
      ),
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
