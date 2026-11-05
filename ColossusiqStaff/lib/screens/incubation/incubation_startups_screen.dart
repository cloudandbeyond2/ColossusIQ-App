import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// INCUBATION HEAD: STARTUPS SCREEN (Matches Image 2)
// - Blueprint Hero Banner: "Home > Incubation > Startups", badges INCUBATION, Phase 2
// - Filter & Action Row: Search input, All filter dropdown, Export CSV, "Add venture" button
// - Grid Blueprint Pattern Container: Centered empty state "No matching records", "Try a different search or filter."
// =============================================================================

class StartupsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const StartupsScreen({super.key, this.onBack});

  @override
  State<StartupsScreen> createState() => _StartupsScreenState();
}

class _StartupsScreenState extends State<StartupsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

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
                // 1. HERO BLUEPRINT BANNER (Image 2)
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. FILTER & ACTION ROW (Image 2)
                _buildFilterAndActionRow(constraints.maxWidth),
                const SizedBox(height: 16),

                // 3. MAIN GRID BLUEPRINT EMPTY STATE (Image 2)
                _buildEmptyStatePanel(),
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
  Widget _buildHeroBanner() {
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

            // Lightbulb watermark on right (Image 2)
            Positioned(
              right: 18,
              top: 6,
              bottom: 6,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.lightbulb_outline_rounded,
                  size: 96,
                  color: Colors.white,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs & Back
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
                        'Incubation',
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
                        'Startups',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Badges: INCUBATION, Phase 2
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
                          'INCUBATION',
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
                          color: const Color(0xFFD97706),
                          borderRadius: BorderRadius.circular(6),
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
                          Icons.lightbulb_outline_rounded,
                          color: Color(0xFFFBBF24), // Gold Bulb (Image 2)
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
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Student ventures, stage, mentors and funding readiness.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: const Color(0xFFCBD5E1),
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
  // 2. FILTER & ACTION ROW (Image 2)
  // ===========================================================================
  Widget _buildFilterAndActionRow(double screenWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 10,
        children: [
          // Search box
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth >= 640 ? 380 : double.infinity,
            ),
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFCBD5E1)),
              ),
              child: TextField(
                controller: _searchController,
                style: GoogleFonts.poppins(fontSize: 12.5),
                decoration: const InputDecoration(
                  hintText: 'Search startups...',
                  hintStyle: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                  prefixIcon: Icon(Icons.search_rounded,
                      size: 16, color: Color(0xFF94A3B8)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ),

          // Right Controls: All dropdown, Export CSV, Add venture
          Wrap(
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // All Filter Dropdown
              Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.filter_list_rounded,
                        size: 15, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedFilter,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF334155),
                          fontWeight: FontWeight.w500,
                        ),
                        items: ['All', 'Idea', 'MVP', 'Seed Funded', 'Active']
                            .map((f) =>
                                DropdownMenuItem(value: f, child: Text(f)))
                            .toList(),
                        onChanged: (v) => setState(() => _selectedFilter = v!),
                      ),
                    ),
                  ],
                ),
              ),

              // Export CSV
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Exporting startups directory to CSV...',
                          style: GoogleFonts.poppins()),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.download_rounded, size: 14),
                label: Text(
                  'Export CSV',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF334155),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  minimumSize: const Size(0, 38),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              // Add venture button (Image 2)
              ElevatedButton(
                onPressed: () => _showAddVentureDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865), // Navy
                  foregroundColor: Colors.white,
                  elevation: 0,
                  minimumSize: const Size(0, 38),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Add venture',
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
    );
  }

  // ===========================================================================
  // 3. MAIN GRID BLUEPRINT EMPTY STATE (Image 2)
  // ===========================================================================
  Widget _buildEmptyStatePanel() {
    return Container(
      constraints: const BoxConstraints(minHeight: 280),
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
            // Technical faint grid background (Image 2)
            Positioned.fill(
              child: CustomPaint(
                painter: _LightGridPainter(),
              ),
            ),

            // Centered empty state
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'No matching records',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Try a different search or filter.',
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

  // ===========================================================================
  // DIALOG: ADD VENTURE
  // ===========================================================================
  void _showAddVentureDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final founderCtrl = TextEditingController();
    final sectorCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.rocket_launch_outlined,
                    color: Color(0xFF1E2865), size: 18),
              ),
              const SizedBox(width: 10),
              Text(
                'Add Student Venture',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Venture / Startup Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: founderCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Founders / Student Roll Numbers',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: sectorCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Sector / Domain (e.g. AgriTech, AI)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Venture ${nameCtrl.text.isNotEmpty ? nameCtrl.text : "New Venture"} registered successfully!',
                      style: GoogleFonts.poppins(),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E2865),
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit Venture'),
            ),
          ],
        );
      },
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
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.45)
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
