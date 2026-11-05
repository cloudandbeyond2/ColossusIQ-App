import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalPhotoGalleryScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalPhotoGalleryScreen({super.key, this.onBack});

  @override
  State<PrincipalPhotoGalleryScreen> createState() =>
      _PrincipalPhotoGalleryScreenState();
}

class _PrincipalPhotoGalleryScreenState
    extends State<PrincipalPhotoGalleryScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterIndex = 0;

  final List<Map<String, dynamic>> _filterPills = [
    {"label": "All", "count": 7},
    {"label": "Published", "count": 6},
    {"label": "Draft", "count": 1},
  ];

  final List<Map<String, dynamic>> _galleryRecords = [
    {
      "id": "GAL-1007",
      "title": "Graduation day 2025",
      "category": "Convocation",
      "status": "Draft",
      "statusType": "draft",
      "updated": "26 Sept 2026",
      "icon": Icons.school_rounded,
      "thumbColor": Color(0xFFFEF3C7),
      "iconColor": Color(0xFFD97706),
    },
    {
      "id": "GAL-1006",
      "title": "Annual cultural fest",
      "category": "Cultural",
      "status": "Published",
      "statusType": "published",
      "updated": "25 Sept 2026",
      "icon": Icons.celebration_rounded,
      "thumbColor": Color(0xFFFFE4E6),
      "iconColor": Color(0xFFE11D48),
    },
    {
      "id": "GAL-1005",
      "title": "Sports ground",
      "category": "Sports",
      "status": "Published",
      "statusType": "published",
      "updated": "24 Sept 2026",
      "icon": Icons.sports_cricket_rounded,
      "thumbColor": Color(0xFFDCFCE7),
      "iconColor": Color(0xFF16A34A),
    },
    {
      "id": "GAL-1004",
      "title": "Central library",
      "category": "Labs & Library",
      "status": "Published",
      "statusType": "published",
      "updated": "23 Sept 2026",
      "icon": Icons.local_library_rounded,
      "thumbColor": Color(0xFFFEF9C3),
      "iconColor": Color(0xFFCA8A04),
    },
    {
      "id": "GAL-1003",
      "title": "Main campus",
      "category": "Campus",
      "status": "Published",
      "statusType": "published",
      "updated": "22 Sept 2026",
      "icon": Icons.account_balance_rounded,
      "thumbColor": Color(0xFFE0F2FE),
      "iconColor": Color(0xFF0284C7),
    },
    {
      "id": "GAL-1002",
      "title": "Smart classroom",
      "category": "Academics",
      "status": "Published",
      "statusType": "published",
      "updated": "21 Sept 2026",
      "icon": Icons.cast_for_education_rounded,
      "thumbColor": Color(0xFFEDE9FE),
      "iconColor": Color(0xFF7C3AED),
    },
    {
      "id": "GAL-1001",
      "title": "Computing & electronics lab",
      "category": "Labs & Library",
      "status": "Published",
      "statusType": "published",
      "updated": "20 Sept 2026",
      "icon": Icons.memory_rounded,
      "thumbColor": Color(0xFFCCFBF1),
      "iconColor": Color(0xFF0D9488),
    },
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
                // 1. HERO BLUEPRINT BANNER (Image 5)
                _buildHeroBanner(constraints.maxWidth),
                const SizedBox(height: 16),

                // 2. FILTER PILLS (Image 5)
                _buildFilterPills(),
                const SizedBox(height: 16),

                // 3. TABLE CARD WITH SEARCH (Image 5)
                _buildTableCard(),
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
  Widget _buildHeroBanner(double maxWidth) {
    final isCompact = maxWidth < 680;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF131B4D), Color(0xFF1D2866), Color(0xFF283685)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF131B4D).withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            Positioned(
              right: 18,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.image_outlined,
                  size: 180,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
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
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.arrow_back_rounded,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          "Home",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF94A3B8),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14, color: Color(0xFF94A3B8)),
                        ),
                        Text(
                          "College Website",
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
                          "Photo Gallery",
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

                  // Badges: COLLEGE WEBSITE, MVP
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
                          "COLLEGE WEBSITE",
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
                          "MVP",
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

                  // Title + Action button
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
                        child: const Center(
                          child: Icon(
                            Icons.file_upload_outlined,
                            color: Color(0xFFFBBF24),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Photo Gallery",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Upload and publish campus photos shown on the public college website.",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFFCBD5E1),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!isCompact) ...[
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.add_rounded,
                              size: 16, color: Colors.black87),
                          label: Text(
                            "Add photo",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFBBF24),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (isCompact) ...[
                    const SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_rounded,
                          size: 16, color: Colors.black87),
                      label: Text(
                        "Add photo",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFBBF24),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. FILTER PILLS (Image 5)
  // ===========================================================================
  Widget _buildFilterPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(_filterPills.length, (index) {
          final isSelected = _selectedFilterIndex == index;
          final pill = _filterPills[index];

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => setState(() => _selectedFilterIndex = index),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1E2865) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1E2865)
                        : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      pill["label"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color:
                            isSelected ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${pill["count"]}",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? const Color(0xFF93C5FD)
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // 3. TABLE CARD WITH SEARCH (Image 5)
  // ===========================================================================
  Widget _buildTableCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search row
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.poppins(fontSize: 12),
                      decoration: const InputDecoration(
                        hintText: "Search by name, ID or title...",
                        hintStyle: TextStyle(
                            fontSize: 11.5, color: Color(0xFF94A3B8)),
                        prefixIcon: Icon(Icons.search_rounded,
                            size: 16, color: Color(0xFF94A3B8)),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  "7 records",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // DataTable
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 950),
              child: DataTable(
                columnSpacing: 18,
                horizontalMargin: 16,
                headingRowHeight: 44,
                dataRowMinHeight: 60,
                dataRowMaxHeight: 68,
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                columns: const [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("IMAGE")),
                  DataColumn(label: Text("TITLE")),
                  DataColumn(label: Text("CATEGORY")),
                  DataColumn(label: Text("STATUS")),
                  DataColumn(label: Text("UPDATED")),
                  DataColumn(label: Text("ACTIONS")),
                ],
                rows: _galleryRecords.map((g) {
                  final statusType = g["statusType"] as String;
                  final isPublished = statusType == "published";

                  return DataRow(
                    cells: [
                      // ID
                      DataCell(
                        Text(
                          g["id"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      // Thumbnail image preview
                      DataCell(
                        Container(
                          width: 48,
                          height: 34,
                          decoration: BoxDecoration(
                            color: g["thumbColor"] as Color,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: (g["iconColor"] as Color)
                                  .withValues(alpha: 0.25),
                            ),
                          ),
                          child: Icon(
                            g["icon"] as IconData,
                            size: 18,
                            color: g["iconColor"] as Color,
                          ),
                        ),
                      ),
                      // Title
                      DataCell(
                        Text(
                          g["title"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),
                      // Category
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            g["category"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF4F46E5),
                            ),
                          ),
                        ),
                      ),
                      // Status
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: isPublished
                                ? const Color(0xFFCCFBF1)
                                : const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            g["status"] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: isPublished
                                  ? const Color(0xFF0D9488)
                                  : const Color(0xFFD97706),
                            ),
                          ),
                        ),
                      ),
                      // Updated
                      DataCell(
                        Text(
                          g["updated"] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF64748B),
                          ),
                        ),
                      ),
                      // Actions
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.visibility_outlined,
                                  size: 15, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 26, minHeight: 26),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit_outlined,
                                  size: 15, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 26, minHeight: 26),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete_outline_rounded,
                                  size: 15, color: Color(0xFF64748B)),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 26, minHeight: 26),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
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
      ..color = Colors.white.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    const double step = 28;
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
