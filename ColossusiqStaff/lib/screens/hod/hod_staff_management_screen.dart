import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// STAFF & USERS: STAFF MANAGEMENT SCREEN (HOD / PRINCIPAL)
// Exactly matches Screenshot 4:
// - Blueprint grid hero banner with user badge watermark, STAFF & USERS, MVP badges, and View only lock chip
// - Filter pills: All 4, Active 3, On leave 1, Resigned 0, Retired 0
// - Table card with search input, 4 records indicator
// - Table columns: ID, FULL NAME, DEPARTMENT, DESIGNATION, STAFF TYPE, STATUS, UPDATED, ACTIONS
// - Exact staff rows with styled chips and eye details icon
// - Pagination footer: Page 1 of 1 with Prev / Next buttons
// =============================================================================

class HodStaffManagementScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const HodStaffManagementScreen({super.key, this.onBack});

  @override
  State<HodStaffManagementScreen> createState() =>
      _HodStaffManagementScreenState();
}

class _HodStaffManagementScreenState extends State<HodStaffManagementScreen> {
  int _selectedFilterIndex = 0;
  String _searchQuery = '';

  final List<String> _filters = [
    'All 4',
    'Active 3',
    'On leave 1',
    'Resigned 0',
    'Retired 0',
  ];

  final List<Map<String, dynamic>> _staffList = [
    {
      'id': 'EMP-1004',
      'name': 'Ms. Harish Kumar',
      'dept': 'Administration',
      'designation': 'Accountant',
      'staffType': 'Administrative',
      'status': 'Active',
      'updated': '18 Sept 2026',
    },
    {
      'id': 'EMP-1003',
      'name': 'Prof. Meera Joseph',
      'dept': 'Electronics & Communication',
      'designation': 'Associate Professor',
      'staffType': 'Teaching',
      'status': 'Active',
      'updated': '17 Sept 2026',
    },
    {
      'id': 'EMP-1002',
      'name': 'Dr. Arjun Subramanian',
      'dept': 'Computer Science & Engineering',
      'designation': 'Associate Professor',
      'staffType': 'Teaching',
      'status': 'Active',
      'updated': '16 Sept 2026',
    },
    {
      'id': 'EMP-1001',
      'name': 'Dr. Aishwarya Mohan',
      'dept': 'Science & Humanities',
      'designation': 'Associate Professor',
      'staffType': 'Teaching',
      'status': 'On leave',
      'updated': '15 Sept 2026',
    },
  ];

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
              const SizedBox(height: 16),
              _buildFilterPills(),
              const SizedBox(height: 16),
              _buildStaffTableCard(),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Screenshot 4)
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
            // Watermark user outline
            Positioned(
              right: -15,
              bottom: -25,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.badge_outlined,
                  size: 200,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Breadcrumb and View only badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Breadcrumb
                      Expanded(
                        child: SingleChildScrollView(
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
                                'Staff & Users',
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
                                'Staff Management',
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // View only button
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.lock_outline_rounded,
                                size: 12, color: Colors.white),
                            const SizedBox(width: 5),
                            Text(
                              'View only',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge Icon
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.badge_outlined,
                            color: Color(0xFFFBBF24),
                            size: 24,
                          ),
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
                                      color:
                                          Colors.white.withValues(alpha: 0.3),
                                    ),
                                  ),
                                  child: Text(
                                    'STAFF & USERS',
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
                              'Staff Management',
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Teaching and non-teaching staff records — department, designation, employment and status.',
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
  // FILTER PILLS (Screenshot 4)
  // ===========================================================================
  Widget _buildFilterPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_filters.length, (index) {
          final isSelected = _selectedFilterIndex == index;
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => setState(() => _selectedFilterIndex = index),
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1E2865)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1E2865)
                        : const Color(0xFFE2E8F0),
                  ),
                  boxShadow: [
                    if (!isSelected)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                  ],
                ),
                child: Text(
                  _filters[index],
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===========================================================================
  // STAFF TABLE CARD (Screenshot 4)
  // ===========================================================================
  Widget _buildStaffTableCard() {
    final filtered = _staffList.where((s) {
      final name = (s['name'] as String).toLowerCase();
      final id = (s['id'] as String).toLowerCase();
      final dept = (s['dept'] as String).toLowerCase();
      final q = _searchQuery.toLowerCase();
      if (q.isNotEmpty &&
          !name.contains(q) &&
          !id.contains(q) &&
          !dept.contains(q)) {
        return false;
      }
      if (_selectedFilterIndex == 1 && s['status'] != 'Active') return false;
      if (_selectedFilterIndex == 2 && s['status'] != 'On leave') return false;
      if (_selectedFilterIndex == 3 && s['status'] != 'Resigned') return false;
      if (_selectedFilterIndex == 4 && s['status'] != 'Retired') return false;
      return true;
    }).toList();

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Search & Records Count Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: TextField(
                      onChanged: (v) => setState(() => _searchQuery = v),
                      style: GoogleFonts.poppins(fontSize: 12),
                      decoration: InputDecoration(
                        hintText: 'Search by name, ID or department...',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF94A3B8),
                        ),
                        prefixIcon: const Icon(Icons.search,
                            size: 16, color: Color(0xFF94A3B8)),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${filtered.length} records',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor:
                  WidgetStateProperty.all(const Color(0xFFFAF9F6)),
              dataRowMinHeight: 56,
              dataRowMaxHeight: 64,
              horizontalMargin: 20,
              columnSpacing: 26,
              columns: [
                DataColumn(
                  label: Text('ID',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('FULL NAME',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('DEPARTMENT',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('DESIGNATION',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('STAFF TYPE',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('STATUS',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('UPDATED',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
                DataColumn(
                  label: Text('ACTIONS',
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF64748B))),
                ),
              ],
              rows: filtered.map((s) {
                final isActive = s['status'] == 'Active';

                return DataRow(
                  cells: [
                    // ID
                    DataCell(
                      Text(
                        s['id'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    // Full Name (Bold)
                    DataCell(
                      Text(
                        s['name'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    // Department
                    DataCell(
                      Text(
                        s['dept'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF334155),
                        ),
                      ),
                    ),
                    // Designation
                    DataCell(
                      Text(
                        s['designation'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                    // Staff Type Pill
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          s['staffType'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2563EB),
                          ),
                        ),
                      ),
                    ),
                    // Status Pill
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(
                          color: isActive
                              ? const Color(0xFFCCFBF1)
                              : const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          s['status'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: isActive
                                ? const Color(0xFF0F766E)
                                : const Color(0xFFD97706),
                          ),
                        ),
                      ),
                    ),
                    // Updated
                    DataCell(
                      Text(
                        s['updated'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ),
                    // Action: View Icon
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.visibility_outlined,
                            size: 16, color: Color(0xFF64748B)),
                        onPressed: () {
                          _showStaffDetailsDialog(s);
                        },
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),

          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Pagination Footer (Screenshot 4)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Page 1 of 1',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: null, // Disabled on page 1
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text('< Prev',
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: const Color(0xFF94A3B8))),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: null, // Disabled on page 1
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text('Next >',
                          style: GoogleFonts.poppins(
                              fontSize: 11, color: const Color(0xFF94A3B8))),
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

  void _showStaffDetailsDialog(Map<String, dynamic> s) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          s['name'] as String,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Employee ID', s['id'] as String),
            _buildDetailRow('Department', s['dept'] as String),
            _buildDetailRow('Designation', s['designation'] as String),
            _buildDetailRow('Staff Type', s['staffType'] as String),
            _buildDetailRow('Status', s['status'] as String),
            _buildDetailRow('Last Updated', s['updated'] as String),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Close',
                style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 12, color: const Color(0xFF64748B))),
          Text(value,
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0F172A))),
        ],
      ),
    );
  }
}

// Background painter for blueprint grid in top banner
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.0;

    const double step = 28.0;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
