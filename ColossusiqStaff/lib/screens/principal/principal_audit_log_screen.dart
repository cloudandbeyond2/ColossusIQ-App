import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalAuditLogScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const PrincipalAuditLogScreen({super.key, this.onBack});

  @override
  State<PrincipalAuditLogScreen> createState() => _PrincipalAuditLogScreenState();
}

class _PrincipalAuditLogScreenState extends State<PrincipalAuditLogScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "All";

  final List<String> _filterOptions = [
    "All",
    "Security",
    "Configuration",
    "Score Overrides",
    "Authentication",
    "Data Export",
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Breadcrumbs
              _buildBreadcrumbs(),
              const SizedBox(height: 14),

              // 2. Blueprint Hero Banner (Matches Mockup)
              _buildHeroBanner(),
              const SizedBox(height: 20),

              // 3. Search, Filter & Export CSV Card (Matches Mockup)
              _buildFilterCard(),
              const SizedBox(height: 18),

              // 4. Main Blueprint Grid Card with Empty State (Matches Mockup)
              _buildMainGridCard(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. BREADCRUMBS
  // ===========================================================================
  Widget _buildBreadcrumbs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          if (widget.onBack != null) ...[
            InkWell(
              onTap: widget.onBack,
              borderRadius: BorderRadius.circular(6),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Icon(Icons.arrow_back_ios_new_rounded, size: 14, color: Color(0xFF64748B)),
              ),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            "Home",
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF94A3B8)),
          ),
          Text(
            "Platform",
            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Icon(Icons.chevron_right_rounded, size: 14, color: Color(0xFF94A3B8)),
          ),
          Text(
            "Audit Log",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 2. BLUEPRINT HERO BANNER (Matches Image 1)
  // ===========================================================================
  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF0F1E5C), Color(0xFF1E3A8A), Color(0xFF2E3D85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F1E5C).withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Blueprint grid overlay
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintDarkGridPainter(),
              ),
            ),
            // Background watermark icon
            Positioned(
              right: -10,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.receipt_long_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Scroll / Document Icon Container
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: const Icon(
                    Icons.description_rounded,
                    color: Color(0xFFFBBF24),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 16),

                // Title, Badges & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "PLATFORM",
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF059669),
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
                      const SizedBox(height: 6),
                      Text(
                        "Audit Log",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Security-relevant actions, score overrides and configuration changes.",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFFE2E8F0),
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
    );
  }

  // ===========================================================================
  // 3. SEARCH & FILTER CARD (Matches Image 1)
  // ===========================================================================
  Widget _buildFilterCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 640;

          if (isCompact) {
            return Column(
              children: [
                // Search Input
                _buildSearchInput(),
                const SizedBox(height: 10),
                // Filter Dropdown & Export Button
                Row(
                  children: [
                    const Icon(Icons.tune_rounded, size: 18, color: Color(0xFF64748B)),
                    const SizedBox(width: 8),
                    Expanded(child: _buildFilterDropdown()),
                    const SizedBox(width: 10),
                    _buildExportButton(),
                  ],
                ),
              ],
            );
          }

          return Row(
            children: [
              // Search Input on Left
              Expanded(
                child: _buildSearchInput(),
              ),
              const SizedBox(width: 14),

              // Filter Icon
              const Icon(Icons.tune_rounded, size: 18, color: Color(0xFF64748B)),
              const SizedBox(width: 8),

              // Filter Dropdown
              _buildFilterDropdown(),
              const SizedBox(width: 10),

              // Export CSV Button
              _buildExportButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSearchInput() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.poppins(
          fontSize: 13,
          color: const Color(0xFF0F172A),
        ),
        decoration: InputDecoration(
          hintText: "Search audit log...",
          hintStyle: GoogleFonts.poppins(
            fontSize: 13,
            color: const Color(0xFF94A3B8),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            size: 19,
            color: Color(0xFF94A3B8),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildFilterDropdown() {
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
          value: _selectedFilter,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF334155),
          ),
          items: _filterOptions.map((f) {
            return DropdownMenuItem<String>(
              value: f,
              child: Text(f),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() => _selectedFilter = val);
            }
          },
        ),
      ),
    );
  }

  Widget _buildExportButton() {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Exporting Audit Log as CSV...",
              style: GoogleFonts.poppins(fontSize: 12.5),
            ),
            backgroundColor: const Color(0xFF1E293B),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFCBD5E1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.file_download_outlined, size: 17, color: Color(0xFF475569)),
            const SizedBox(width: 6),
            Text(
              "Export CSV",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF475569),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. MAIN BLUEPRINT GRID EMPTY STATE CARD (Matches Image 1)
  // ===========================================================================
  Widget _buildMainGridCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 280),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Faint grid pattern background (Matches blueprint grid in mockup)
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintLightGridPainter(),
              ),
            ),

            // Centered empty state
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "No matching records",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Try a different search or filter.",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
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
class _BlueprintDarkGridPainter extends CustomPainter {
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

class _BlueprintLightGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFEEF2F6)
      ..strokeWidth = 1.0;

    const double step = 24.0;

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

typedef AuditLogScreen = PrincipalAuditLogScreen;
