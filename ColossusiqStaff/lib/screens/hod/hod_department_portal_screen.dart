import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// DEPARTMENT: DEPARTMENT PORTAL SCREEN (HOD)
// Exactly matches Screenshot 1:
// - Blueprint hero banner with "DEPARTMENT" + "Phase 2" badges & layers watermark
// - Department filter pill bar (All 6, CSE 1, AI&DS 1, ECE 1, EEE 1, MECH 1, CIVIL 1)
// - Search labs & practicals input field
// - 6 Department-specific Lab Cards with colored tags and "Active" badges:
//     * Coding Lab
//     * AI & Data Science Lab
//     * Circuits & VLSI Lab
//     * Power & Machines Lab
//     * CAD & Design Lab
//     * Structural GIS Lab
// =============================================================================

class HodDepartmentPortalScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const HodDepartmentPortalScreen({super.key, this.onBack});

  @override
  State<HodDepartmentPortalScreen> createState() =>
      _HodDepartmentPortalScreenState();
}

class _HodDepartmentPortalScreenState extends State<HodDepartmentPortalScreen> {
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _labs = [
    {
      'title': 'Coding Lab',
      'dept': 'Computer Science & Engineering',
      'deptTagBg': Color(0xFFEEF2FF),
      'deptTagColor': Color(0xFF4338CA),
      'desc': 'Practice problems, contests and auto-graded labs',
      'status': 'Active',
    },
    {
      'title': 'AI & Data Science Lab',
      'dept': 'AI & Data Science',
      'deptTagBg': Color(0xFFE0F2FE),
      'deptTagColor': Color(0xFF0369A1),
      'desc': 'Notebooks, datasets and GPU queue',
      'status': 'Active',
    },
    {
      'title': 'Circuits & VLSI Lab',
      'dept': 'Electronics & Communication',
      'deptTagBg': Color(0xFFCCFBF1),
      'deptTagColor': Color(0xFF0F766E),
      'desc': 'Simulations and PCB project templates',
      'status': 'Active',
    },
    {
      'title': 'Power & Machines Lab',
      'dept': 'Electrical & Electronics',
      'deptTagBg': Color(0xFFFEF3C7),
      'deptTagColor': Color(0xFFB45309),
      'desc': 'Grid simulation and drive testing',
      'status': 'Active',
    },
    {
      'title': 'CAD & Design Lab',
      'dept': 'Mechanical Engineering',
      'deptTagBg': Color(0xFFFFEDD5),
      'deptTagColor': Color(0xFFC2410C),
      'desc': 'Guided modelling exercises',
      'status': 'Active',
    },
    {
      'title': 'Structural GIS Lab',
      'dept': 'Civil Engineering',
      'deptTagBg': Color(0xFFFEE2E2),
      'deptTagColor': Color(0xFFB91C1C),
      'desc': 'Estimation, planning and site safety modules',
      'status': 'Active',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredLabs {
    return _labs.where((lab) {
      final matchesFilter =
          _selectedFilter == 'All' || lab['dept'] == _selectedFilter;
      final q = _searchController.text.trim().toLowerCase();
      final matchesQuery = q.isEmpty ||
          lab['title'].toString().toLowerCase().contains(q) ||
          lab['dept'].toString().toLowerCase().contains(q) ||
          lab['desc'].toString().toLowerCase().contains(q);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopHeroBanner(),
              const SizedBox(height: 18),
              _buildFilterBar(),
              const SizedBox(height: 20),
              _buildLabsGrid(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Screenshot 1)
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
            // Watermark layers/stack on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.layers_rounded,
                  size: 190,
                  color: Colors.white,
                ),
              ),
            ),
            // Banner Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            'Home',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '\u203A',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Department',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '\u203A',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Department Portal',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
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
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.layers_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E2548),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          Colors.white.withValues(alpha: 0.15),
                                    ),
                                  ),
                                  child: Text(
                                    'DEPARTMENT',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: const Color(0xFF93C5FD),
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
                                    'Phase 2',
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
                              'Department Portal',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Department-specific labs and modules \u2014 coding lab, CAD, circuits, GIS, case studies.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
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
  // FILTER BAR CARD (Screenshot 1)
  // ===========================================================================
  Widget _buildFilterBar() {
    final filters = [
      {'label': 'All', 'count': '6', 'val': 'All'},
      {
        'label': 'Computer Science & Engineering',
        'count': '1',
        'val': 'Computer Science & Engineering'
      },
      {'label': 'AI & Data Science', 'count': '1', 'val': 'AI & Data Science'},
      {
        'label': 'Electronics & Communication',
        'count': '1',
        'val': 'Electronics & Communication'
      },
      {
        'label': 'Electrical & Electronics',
        'count': '1',
        'val': 'Electrical & Electronics'
      },
      {
        'label': 'Mechanical Engineering',
        'count': '1',
        'val': 'Mechanical Engineering'
      },
      {'label': 'Civil Engineering', 'count': '1', 'val': 'Civil Engineering'},
    ];

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
          LayoutBuilder(
            builder: (context, constraints) {
              final isDesktop = constraints.maxWidth >= 900;
              return Row(
                children: [
                  const Icon(Icons.filter_alt_outlined,
                      size: 16, color: Color(0xFF64748B)),
                  const SizedBox(width: 6),
                  Text(
                    'Department:',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  if (isDesktop) ...[
                    const Spacer(),
                    SizedBox(
                      width: 240,
                      height: 36,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search_rounded,
                              size: 16, color: Color(0xFF94A3B8)),
                          hintText: 'Search labs & practicals..',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF94A3B8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          filled: true,
                          fillColor: const Color(0xFFF8FAFC),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFE2E8F0)),
                          ),
                          isDense: true,
                        ),
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: filters.map((f) {
              final isSelected = _selectedFilter == f['val'];
              return InkWell(
                onTap: () => setState(() => _selectedFilter = f['val']!),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF161E4A)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF161E4A)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        f['label']!,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : const Color(0xFF475569),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.2)
                              : const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          f['count']!,
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF64748B),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 6 LABS GRID (Screenshot 1)
  // ===========================================================================
  Widget _buildLabsGrid() {
    final list = _filteredLabs;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 960;
        final isTablet = constraints.maxWidth >= 600;

        if (isDesktop) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (list.isNotEmpty) Expanded(child: _buildLabCard(list[0])),
                  const SizedBox(width: 16),
                  if (list.length > 1)
                    Expanded(child: _buildLabCard(list[1]))
                  else
                    const Expanded(child: SizedBox()),
                  const SizedBox(width: 16),
                  if (list.length > 2)
                    Expanded(child: _buildLabCard(list[2]))
                  else
                    const Expanded(child: SizedBox()),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (list.length > 3)
                    Expanded(child: _buildLabCard(list[3]))
                  else
                    const Expanded(child: SizedBox()),
                  const SizedBox(width: 16),
                  if (list.length > 4)
                    Expanded(child: _buildLabCard(list[4]))
                  else
                    const Expanded(child: SizedBox()),
                  const SizedBox(width: 16),
                  if (list.length > 5)
                    Expanded(child: _buildLabCard(list[5]))
                  else
                    const Expanded(child: SizedBox()),
                ],
              ),
            ],
          );
        } else if (isTablet) {
          final rows = <Widget>[];
          for (int i = 0; i < list.length; i += 2) {
            rows.add(
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildLabCard(list[i])),
                  const SizedBox(width: 14),
                  if (i + 1 < list.length)
                    Expanded(child: _buildLabCard(list[i + 1]))
                  else
                    const Expanded(child: SizedBox()),
                ],
              ),
            );
            if (i + 2 < list.length) {
              rows.add(const SizedBox(height: 14));
            }
          }
          return Column(children: rows);
        } else {
          return Column(
            children: list.map((lab) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _buildLabCard(lab),
              );
            }).toList(),
          );
        }
      },
    );
  }

  Widget _buildLabCard(Map<String, dynamic> lab) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: lab['deptTagBg'] as Color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    lab['dept'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: lab['deptTagColor'] as Color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  lab['status'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF15803D),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            lab['title'] as String,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            lab['desc'] as String,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT GRID BACKGROUND PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.0;

    const step = 28.0;
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
