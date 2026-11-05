import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DigitalStudentPassportScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const DigitalStudentPassportScreen({super.key, this.onBack});

  @override
  State<DigitalStudentPassportScreen> createState() =>
      _DigitalStudentPassportScreenState();
}

class _DigitalStudentPassportScreenState
    extends State<DigitalStudentPassportScreen> {
  String _selectedFilter = "All";
  String _searchQuery = "";

  final List<Map<String, dynamic>> _filters = const [
    {"label": "All", "count": 6},
    {"label": "Exam Cell Verified", "count": 1},
    {"label": "Skill Graph", "count": 1},
    {"label": "Project Hub", "count": 1},
    {"label": "Certificates", "count": 1},
    {"label": "Campus Life", "count": 1},
    {"label": "Career", "count": 1},
  ];

  final List<Map<String, dynamic>> _passportCards = const [
    {
      "category": "Exam Cell Verified",
      "categoryColor": Color(0xFFF1F5F9),
      "categoryTextColor": Color(0xFF475569),
      "status": "Roll: 21CS1014",
      "statusBg": Color(0xFFE0F2FE),
      "statusTextColor": Color(0xFF0369A1),
      "statusBorder": Color(0xFFBAE6FD),
      "title": "Academic Transcript",
      "description":
          "CGPA 0.00 · 0 of 21 credits earned · Enrolled in Semester 5",
      "filterCategory": "Exam Cell Verified",
    },
    {
      "category": "Skill Graph",
      "categoryColor": Color(0xFFF1F5F9),
      "categoryTextColor": Color(0xFF475569),
      "status": "0 skills tracked",
      "statusBg": Color(0xFFECFDF5),
      "statusTextColor": Color(0xFF059669),
      "statusBorder": Color(0xFFA7F3D0),
      "title": "Verified Skill Profile",
      "description":
          "DBMS, OS, CN, ML, Algorithms, Python & practical laboratory competencies",
      "filterCategory": "Skill Graph",
    },
    {
      "category": "Project Hub",
      "categoryColor": Color(0xFFFEF3C7),
      "categoryTextColor": Color(0xFFD97706),
      "status": "Not started",
      "statusBg": Color(0xFFECFDF5),
      "statusTextColor": Color(0xFF059669),
      "statusBorder": Color(0xFFA7F3D0),
      "title": "Department Project",
      "description":
          "Capstones and innovative project submissions will be recorded here",
      "filterCategory": "Project Hub",
    },
    {
      "category": "Certificates",
      "categoryColor": Color(0xFFEFF6FF),
      "categoryTextColor": Color(0xFF2563EB),
      "status": "0 verified certs",
      "statusBg": Color(0xFFECFDF5),
      "statusTextColor": Color(0xFF059669),
      "statusBorder": Color(0xFFA7F3D0),
      "title": "Verified Certifications",
      "description":
          "HMAC Cryptographically signed certifications in core subjects",
      "filterCategory": "Certificates",
    },
    {
      "category": "Campus Life",
      "categoryColor": Color(0xFFECFDF5),
      "categoryTextColor": Color(0xFF059669),
      "status": "New member",
      "statusBg": Color(0xFFECFDF5),
      "statusTextColor": Color(0xFF059669),
      "statusBorder": Color(0xFFA7F3D0),
      "title": "Campus Leadership & Clubs",
      "description": "Coding Club Lead & NSS Campus Volunteer",
      "filterCategory": "Campus Life",
    },
    {
      "category": "Career",
      "categoryColor": Color(0xFFFFF7ED),
      "categoryTextColor": Color(0xFFEA580C),
      "status": "Readiness: 0/100",
      "statusBg": Color(0xFFECFDF5),
      "statusTextColor": Color(0xFF059669),
      "statusBorder": Color(0xFFA7F3D0),
      "title": "Placement Readiness",
      "description":
          "Quiz performance, certifications, aptitude, and AI mock interview",
      "filterCategory": "Career",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _passportCards.where((c) {
      final matchesFilter =
          _selectedFilter == "All" || c["filterCategory"] == _selectedFilter;
      final matchesSearch = _searchQuery.isEmpty ||
          (c["title"] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          (c["description"] as String)
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      return matchesFilter && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, screenConstraints) {
            final isMobile = screenConstraints.maxWidth < 640;
            final horizPadding = isMobile ? 14.0 : 24.0;
            final vertPadding = isMobile ? 14.0 : 20.0;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizPadding,
                vertical: vertPadding,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1320),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Top Hero Banner
                      _buildHeroBanner(isMobile: isMobile),
                      SizedBox(height: isMobile ? 16 : 24),

                      // Filter & Search Bar
                      _buildFilterAndSearchBar(isMobile: isMobile),
                      SizedBox(height: isMobile ? 16 : 22),

                      // 6 Passport Cards Grid
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final double width = constraints.maxWidth;
                          final int crossAxisCount = width >= 1040
                              ? 3
                              : width >= 640
                                  ? 2
                                  : 1;

                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filtered.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 18,
                              mainAxisSpacing: 18,
                              mainAxisExtent: isMobile ? 160 : 170,
                            ),
                            itemBuilder: (context, index) {
                              return _buildPassportCard(filtered[index]);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeroBanner({required bool isMobile}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF131838),
            Color(0xFF1B2358),
            Color(0xFF232D6E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B2358).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isMobile ? 16 : 20),
        child: Stack(
          children: [
            // Grid background pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _PassportGridPainter(),
              ),
            ),

            // Giant badge watermark on bottom right
            Positioned(
              right: -10,
              bottom: -20,
              child: Icon(
                Icons.badge_rounded,
                size: isMobile ? 110 : 155,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),

            // Banner content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 28,
                vertical: isMobile ? 18 : 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb row (horizontal scroll to prevent overflow)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        if (widget.onBack != null || Navigator.canPop(context)) ...[
                          InkWell(
                            onTap: widget.onBack ?? () => Navigator.pop(context),
                            borderRadius: BorderRadius.circular(6),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 13,
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ),
                        ],
                        Text(
                          "Home",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            "›",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                        Text(
                          "Student Success",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            "›",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
                          ),
                        ),
                        Text(
                          "Digital Student Passport",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isMobile ? 14 : 18),

                  // Hero Title & Badges
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Badge squircle icon
                      Container(
                        width: isMobile ? 44 : 50,
                        height: isMobile ? 44 : 50,
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
                            Icons.badge_rounded,
                            size: isMobile ? 22 : 26,
                            color: const Color(0xFFFBBF24),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Text column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.14),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "STUDENT SUCCESS",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Phase 3",
                                    style: GoogleFonts.poppins(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Digital Student Passport",
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 21 : 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Your verified employability profile: academics, skills, projects, activities and achievements.",
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 12 : 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.82),
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

  Widget _buildFilterAndSearchBar({required bool isMobile}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isMobile ? 12 : 16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 16,
        vertical: isMobile ? 10 : 12,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;

          final filterPills = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.filter_alt_outlined,
                      size: 15,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Department:",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                ..._filters.map((f) {
                  final label = f["label"] as String;
                  final count = f["count"] as int;
                  final isSelected = _selectedFilter == label;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedFilter = label;
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF1E286D)
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF1E286D)
                                : const Color(0xFFE2E8F0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              label,
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF334155),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 1),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white.withValues(alpha: 0.22)
                                    : const Color(0xFFE2E8F0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "$count",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          );

          final searchInput = SizedBox(
            width: isWide ? 240 : double.infinity,
            height: 38,
            child: TextField(
              onChanged: (v) {
                setState(() {
                  _searchQuery = v;
                });
              },
              decoration: InputDecoration(
                hintText: "Search labs & practicals...",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF94A3B8),
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  size: 16,
                  color: Color(0xFF94A3B8),
                ),
                filled: true,
                fillColor: const Color(0xFFF8FAFC),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFF2563EB)),
                ),
              ),
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF1E293B),
              ),
            ),
          );

          if (isWide) {
            return Row(
              children: [
                Expanded(child: filterPills),
                const SizedBox(width: 14),
                searchInput,
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                searchInput,
                const SizedBox(height: 10),
                filterPills,
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildPassportCard(Map<String, dynamic> card) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Badges Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                decoration: BoxDecoration(
                  color: card["categoryColor"] as Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  card["category"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: card["categoryTextColor"] as Color,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: card["statusBg"] as Color,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: card["statusBorder"] as Color),
                  ),
                  child: Text(
                    card["status"] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: card["statusTextColor"] as Color,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Title
          Text(
            card["title"] as String,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 5),

          // Description
          Expanded(
            child: Text(
              card["description"] as String,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 12,
                height: 1.4,
                color: const Color(0xFF64748B),
              ),
            ),
          ),

          // Bottom soft horizontal placeholder bar
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _PassportGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..strokeWidth = 1;

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
