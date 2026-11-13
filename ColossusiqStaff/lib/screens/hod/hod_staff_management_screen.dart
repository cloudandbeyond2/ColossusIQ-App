import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// STAFF & USERS: HEAD OF DEPARTMENT (HOD) STAFF MANAGEMENT SCREEN
// Matches Image 1, 2, 3, 4, 5:
// - Hero banner: Home > Staff & Users > Staff Management, STAFF & USERS, MVP badges
// - 3 Stat Cards: Total Staff (6), Active (6), On Leave (0)
// - Search bar: "Search by name, ID, department..."
// - Dropdown filters: All Roles (Image 4), All Status (Image 5)
// - Action Button: "+ Add Staff" (Navy solid with add user icon)
// - Table: MEMBER | ROLE | CONTACT | QUALIFICATIONS | STATUS | ACTIONS
// - Edit icon button -> Pre-filled Edit Staff Member modal (Image 3)
// - Delete icon button -> Delete confirmation dialog
// - "+ Add Staff" button -> Add Staff Member modal with Auto-generated sequential ID (Image 2)
// =============================================================================

class HodStaffManagementScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const HodStaffManagementScreen({super.key, this.onBack});

  @override
  State<HodStaffManagementScreen> createState() =>
      _HodStaffManagementScreenState();
}

class _HodStaffManagementScreenState extends State<HodStaffManagementScreen> {
  final TextEditingController _searchCtrl = TextEditingController();
  String _selectedRole = 'All Roles';
  String _selectedStatus = 'All Status';
  int _nextStaffSequence = 1074;

  final List<String> _roleOptions = [
    'All Roles',
    'HOD',
    'Faculty',
    'Lab Assistant',
    'Admin Staff',
    'Librarian',
    'Counselor',
    'Placement Officer',
    'Other',
  ];

  final List<String> _statusOptions = [
    'All Status',
    'Active',
    'On Leave',
    'Inactive',
  ];

  // Initial staff list exactly matching Images 1, 2, 3
  late List<Map<String, dynamic>> _staffList;

  @override
  void initState() {
    super.initState();
    _staffList = [
      {
        'id': 'EMP-1073',
        'name': 'Mr. Arjun Iyer',
        'dept': 'Information Technology',
        'role': 'Faculty',
        'email': 'staff.incubation@ait.edu.in',
        'phone': '9840192834',
        'qualifications': 'M.Tech, Ph.D',
        'status': 'Active',
        'dateJoined': '06/01/2018',
      },
      {
        'id': 'EMP-1071',
        'name': 'far',
        'dept': 'Computer Science & Engineering',
        'role': 'Faculty',
        'email': 'farosekhan449@gmail.com',
        'phone': '6383103257',
        'qualifications': 'Ph.D',
        'status': 'Active',
        'dateJoined': '08/15/2019',
      },
      {
        'id': 'EMP-1004',
        'name': 'Mr. R. Karthikeyan',
        'dept': 'Administration',
        'role': 'Admin Staff',
        'email': 'placement@ait.edu.in',
        'phone': '9444123456',
        'qualifications': 'M.B.A (HR & Operations)',
        'status': 'Active',
        'dateJoined': '03/10/2017',
      },
      {
        'id': 'EMP-1003',
        'name': 'Dr. Meena Raghavan',
        'dept': 'Computer Science & Engineering',
        'role': 'Faculty',
        'email': 'faculty@ait.edu.in',
        'phone': '9790123456',
        'qualifications': 'Ph.D in Information Systems',
        'status': 'Active',
        'dateJoined': '07/20/2016',
      },
      {
        'id': 'EMP-1002',
        'name': 'Dr. S. Venkatesh',
        'dept': 'Computer Science & Engineering',
        'role': 'Faculty',
        'email': 'hod@ait.edu.in',
        'phone': '9840123456',
        'qualifications': 'Ph.D in Computer Science',
        'status': 'Active',
        'dateJoined': '01/05/2015',
      },
      {
        'id': 'EMP-1001',
        'name': 'Dr. Aishwarya Mohan',
        'dept': 'Computer Science & Engineering',
        'role': 'Faculty',
        'email': 'aishwarya.cse@ait.edu.in',
        'phone': '9840112233',
        'qualifications': 'Ph.D in Machine Learning',
        'status': 'Active',
        'dateJoined': '11/12/2018',
      },
    ];
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredStaff {
    final q = _searchCtrl.text.trim().toLowerCase();
    return _staffList.where((s) {
      // Role filter
      if (_selectedRole != 'All Roles') {
        if ((s['role'] as String).toLowerCase() != _selectedRole.toLowerCase()) {
          return false;
        }
      }

      // Status filter
      if (_selectedStatus != 'All Status') {
        final currentStatus = (s['status'] as String).toLowerCase();
        final targetStatus = _selectedStatus.toLowerCase();
        if (targetStatus == 'on leave') {
          if (currentStatus != 'on leave' && currentStatus != 'onleave') {
            return false;
          }
        } else if (currentStatus != targetStatus) {
          return false;
        }
      }

      // Search query
      if (q.isNotEmpty) {
        final name = (s['name'] as String).toLowerCase();
        final id = (s['id'] as String).toLowerCase();
        final dept = (s['dept'] as String).toLowerCase();
        final email = (s['email'] as String).toLowerCase();
        final phone = (s['phone'] as String).toLowerCase();
        final quals = (s['qualifications'] as String).toLowerCase();

        return name.contains(q) ||
            id.contains(q) ||
            dept.contains(q) ||
            email.contains(q) ||
            phone.contains(q) ||
            quals.contains(q);
      }

      return true;
    }).toList();
  }

  int get _totalStaffCount => _staffList.length;
  int get _activeStaffCount =>
      _staffList.where((s) => (s['status'] as String).toLowerCase() == 'active').length;
  int get _onLeaveStaffCount => _staffList
      .where((s) =>
          (s['status'] as String).toLowerCase().contains('leave'))
      .length;

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredStaff;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopHeroBanner(),
              const SizedBox(height: 20),
              _buildStatCardsRow(),
              const SizedBox(height: 20),
              _buildControlsArea(),
              const SizedBox(height: 20),
              _buildStaffTableCard(filtered),
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
            // Watermark suitcase outline
            Positioned(
              right: -20,
              bottom: -30,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.badge_outlined,
                  size: 210,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumbs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
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
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge Icon
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.contact_emergency_rounded,
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
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Teaching and non-teaching staff records — department, designation, employment and status.',
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
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
  // 2. 3 STAT CARDS ROW (Image 1: Total Staff 6, Active 6, On Leave 0)
  // ===========================================================================
  Widget _buildStatCardsRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 680;

        final cardTotal = _buildStatCard(
          label: 'Total Staff',
          value: '$_totalStaffCount',
          icon: Icons.people_outline_rounded,
          iconColor: const Color(0xFF2563EB),
          iconBg: const Color(0xFFEFF6FF),
        );

        final cardActive = _buildStatCard(
          label: 'Active',
          value: '$_activeStaffCount',
          icon: Icons.check_circle_outline_rounded,
          iconColor: const Color(0xFF10B981),
          iconBg: const Color(0xFFECFDF5),
        );

        final cardOnLeave = _buildStatCard(
          label: 'On Leave',
          value: '$_onLeaveStaffCount',
          icon: Icons.shield_outlined,
          iconColor: const Color(0xFFF59E0B),
          iconBg: const Color(0xFFFFFBEB),
        );

        if (isMobile) {
          return Column(
            children: [
              cardTotal,
              const SizedBox(height: 12),
              cardActive,
              const SizedBox(height: 12),
              cardOnLeave,
            ],
          );
        }

        return Row(
          children: [
            Expanded(child: cardTotal),
            const SizedBox(width: 14),
            Expanded(child: cardActive),
            const SizedBox(width: 14),
            Expanded(child: cardOnLeave),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. CONTROLS AREA (Search, Dropdown Filters, Add Staff Button)
  // ===========================================================================
  Widget _buildControlsArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search Input
        TextField(
          controller: _searchCtrl,
          onChanged: (_) => setState(() {}),
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF0F172A)),
          decoration: InputDecoration(
            hintText: 'Search by name, ID, department...',
            hintStyle: GoogleFonts.poppins(
                fontSize: 13, color: const Color(0xFF94A3B8)),
            prefixIcon: const Icon(Icons.search_rounded,
                size: 20, color: Color(0xFF64748B)),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Filter Dropdowns
        Column(
          children: [
            // Dropdown 1: All Roles (Image 4)
            _buildDropdownFilter(
              value: _selectedRole,
              items: _roleOptions,
              onChanged: (val) {
                if (val != null) setState(() => _selectedRole = val);
              },
            ),
            const SizedBox(height: 10),

            // Dropdown 2: All Status (Image 5)
            _buildDropdownFilter(
              value: _selectedStatus,
              items: _statusOptions,
              onChanged: (val) {
                if (val != null) setState(() => _selectedStatus = val);
              },
            ),
          ],
        ),
        const SizedBox(height: 14),

        // "+ Add Staff" Button
        ElevatedButton.icon(
          onPressed: _showAddStaffDialog,
          icon: const Icon(Icons.person_add_alt_1_rounded, size: 18),
          label: Text(
            '+ Add Staff',
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2865),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownFilter({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF475569)),
          style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF0F172A)),
          items: items.map((opt) {
            return DropdownMenuItem<String>(
              value: opt,
              child: Text(opt, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // ===========================================================================
  // 4. STAFF RECORDS TABLE (Image 1)
  // ===========================================================================
  Widget _buildStaffTableCard(List<Map<String, dynamic>> filtered) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 1100,
                child: Column(
                  children: [
                    // Header Row
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFBFBF9),
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFE2E8F0)),
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildHeaderCol('MEMBER', 240),
                          _buildHeaderCol('ROLE', 120),
                          _buildHeaderCol('CONTACT', 250),
                          _buildHeaderCol('QUALIFICATIONS', 180),
                          _buildHeaderCol('STATUS', 120),
                          const SizedBox(
                            width: 100,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'ACTIONS',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.6,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Table Body
                    if (filtered.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 20),
                        child: Center(
                          child: Text(
                            "No staff members found matching your search or filters.",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filtered.length,
                        separatorBuilder: (_, index) => const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF1F5F9),
                        ),
                        itemBuilder: (context, i) {
                          final staff = filtered[i];
                          return _buildStaffRow(staff);
                        },
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

  Widget _buildHeaderCol(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: const Color(0xFF64748B),
        ),
      ),
    );
  }

  Widget _buildStaffRow(Map<String, dynamic> s) {
    final status = (s['status'] as String?) ?? 'Active';
    final isActive = status.toLowerCase() == 'active';
    final isOnLeave = status.toLowerCase().contains('leave');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          // MEMBER: Name + EMP ID · Department
          SizedBox(
            width: 240,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s['name'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  "${s['id']} · ${s['dept']}",
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // ROLE: Light Blue Badge
          SizedBox(
            width: 120,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFDBEAFE)),
                ),
                child: Text(
                  s['role'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1D4ED8),
                  ),
                ),
              ),
            ),
          ),

          // CONTACT: Email with mail icon & Phone with phone icon
          SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.mail_outline_rounded,
                        size: 13, color: Color(0xFF64748B)),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        s['email'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF334155),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.phone_outlined,
                        size: 13, color: Color(0xFF64748B)),
                    const SizedBox(width: 5),
                    Text(
                      s['phone'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // QUALIFICATIONS:
          SizedBox(
            width: 180,
            child: Text(
              s['qualifications'] as String,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF475569),
              ),
            ),
          ),

          // STATUS: Green (Active) or Amber (On Leave)
          SizedBox(
            width: 120,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFF0FDF4)
                      : isOnLeave
                          ? const Color(0xFFFFFBEB)
                          : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isActive
                        ? const Color(0xFFDCFCE7)
                        : isOnLeave
                            ? const Color(0xFFFEF3C7)
                            : const Color(0xFFE2E8F0),
                  ),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: isActive
                        ? const Color(0xFF16A34A)
                        : isOnLeave
                            ? const Color(0xFFD97706)
                            : const Color(0xFF64748B),
                  ),
                ),
              ),
            ),
          ),

          // ACTIONS: Edit + Delete icons
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => _showEditStaffDialog(s),
                  borderRadius: BorderRadius.circular(6),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.edit_outlined,
                        size: 18, color: Color(0xFF64748B)),
                  ),
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () => _confirmDeleteStaff(s),
                  borderRadius: BorderRadius.circular(6),
                  child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.delete_outline_rounded,
                        size: 18, color: Color(0xFF64748B)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 5. MODAL: ADD STAFF MEMBER (Image 2)
  // ===========================================================================
  void _showAddStaffDialog() {
    final nameCtrl = TextEditingController();
    final autoStaffId = "STF$_nextStaffSequence";
    String selectedRole = 'Faculty';
    final deptCtrl = TextEditingController(text: 'CSE');
    final emailCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    String selectedStatus = 'Active';
    final dateCtrl = TextEditingController();
    final qualsCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add Staff Member',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(ctx),
                            icon: const Icon(Icons.close_rounded,
                                size: 20, color: Color(0xFF64748B)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Row 1: Full Name * & Staff ID *
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Full Name *'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: nameCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: _modalInputDec(hint: 'Dr. Name'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Staff ID *'),
                                const SizedBox(height: 6),
                                Container(
                                  height: 44,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF8FAFC),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: const Color(0xFFCBD5E1)),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        autoStaffId,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF0F172A),
                                        ),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE2E8F0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          'Auto',
                                          style: GoogleFonts.poppins(
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF475569),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Auto-generated sequentially',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 2: Role * & Department
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Role *'),
                                const SizedBox(height: 6),
                                _buildModalDropdown(
                                  value: selectedRole,
                                  items: _roleOptions
                                      .where((r) => r != 'All Roles')
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setModalState(() => selectedRole = val);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Department'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: deptCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: _modalInputDec(hint: 'CSE'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 3: Email & Phone
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Email'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: emailCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: _modalInputDec(
                                      hint: 'staff@college.edu'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Phone'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: phoneCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration:
                                      _modalInputDec(hint: '9876543210'),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '10-digit mobile number',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 4: Status & Date Joined
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Status'),
                                const SizedBox(height: 6),
                                _buildModalDropdown(
                                  value: selectedStatus,
                                  items: _statusOptions
                                      .where((s) => s != 'All Status')
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setModalState(() => selectedStatus = val);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Date Joined'),
                                const SizedBox(height: 6),
                                InkWell(
                                  onTap: () async {
                                    final now = DateTime.now();
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: now,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2030),
                                    );
                                    if (picked != null) {
                                      final str =
                                          "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
                                      setModalState(() => dateCtrl.text = str);
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: TextField(
                                      controller: dateCtrl,
                                      style: GoogleFonts.poppins(fontSize: 13),
                                      decoration: _modalInputDec(
                                        hint: 'mm/dd/yyyy',
                                        suffixIcon: const Icon(
                                            Icons.calendar_today_outlined,
                                            size: 16,
                                            color: Color(0xFF64748B)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 5: Qualifications
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('Qualifications'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: qualsCtrl,
                            style: GoogleFonts.poppins(fontSize: 13),
                            decoration:
                                _modalInputDec(hint: 'PhD, M.Tech...'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Footer Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              final name = nameCtrl.text.trim();
                              if (name.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please enter the staff member name'),
                                    backgroundColor: Color(0xFFDC2626),
                                  ),
                                );
                                return;
                              }

                              setState(() {
                                _staffList.insert(0, {
                                  'id': autoStaffId,
                                  'name': name,
                                  'dept': deptCtrl.text.trim().isEmpty
                                      ? 'CSE'
                                      : deptCtrl.text.trim(),
                                  'role': selectedRole,
                                  'email': emailCtrl.text.trim().isEmpty
                                      ? 'staff@college.edu'
                                      : emailCtrl.text.trim(),
                                  'phone': phoneCtrl.text.trim().isEmpty
                                      ? '9876543210'
                                      : phoneCtrl.text.trim(),
                                  'qualifications':
                                      qualsCtrl.text.trim().isEmpty
                                      ? 'M.Tech, Ph.D'
                                      : qualsCtrl.text.trim(),
                                  'status': selectedStatus,
                                  'dateJoined': dateCtrl.text.trim().isEmpty
                                      ? '11/13/2026'
                                      : dateCtrl.text.trim(),
                                });
                                _nextStaffSequence++;
                              });

                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Added staff member '$name' ($autoStaffId) successfully!",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  backgroundColor: const Color(0xFF1E2865),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E2A72),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Add Member',
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
  // 6. MODAL: EDIT STAFF MEMBER (Image 3)
  // ===========================================================================
  void _showEditStaffDialog(Map<String, dynamic> staff) {
    final nameCtrl = TextEditingController(text: staff['name'] as String);
    final idCtrl = TextEditingController(text: staff['id'] as String);
    String selectedRole = staff['role'] as String;
    final deptCtrl = TextEditingController(text: staff['dept'] as String);
    final emailCtrl = TextEditingController(text: staff['email'] as String);
    final phoneCtrl = TextEditingController(text: staff['phone'] as String);
    String selectedStatus = staff['status'] as String;
    final dateCtrl =
        TextEditingController(text: staff['dateJoined'] as String? ?? '06/01/2018');
    final qualsCtrl =
        TextEditingController(text: staff['qualifications'] as String);

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Staff Member',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(ctx),
                            icon: const Icon(Icons.close_rounded,
                                size: 20, color: Color(0xFF64748B)),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Row 1: Full Name * & Staff ID *
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Full Name *'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: nameCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: _modalInputDec(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Staff ID *'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: idCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: _modalInputDec(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 2: Role * & Department
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Role *'),
                                const SizedBox(height: 6),
                                _buildModalDropdown(
                                  value: selectedRole,
                                  items: _roleOptions
                                      .where((r) => r != 'All Roles')
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setModalState(() => selectedRole = val);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Department'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: deptCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: _modalInputDec(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 3: Email & Phone
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Email'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: emailCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: _modalInputDec(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Phone'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: phoneCtrl,
                                  style: GoogleFonts.poppins(fontSize: 13),
                                  decoration: _modalInputDec(),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '10-digit mobile number',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 4: Status & Date Joined
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Status'),
                                const SizedBox(height: 6),
                                _buildModalDropdown(
                                  value: selectedStatus,
                                  items: _statusOptions
                                      .where((s) => s != 'All Status')
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setModalState(() => selectedStatus = val);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Date Joined'),
                                const SizedBox(height: 6),
                                InkWell(
                                  onTap: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2030),
                                    );
                                    if (picked != null) {
                                      final str =
                                          "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
                                      setModalState(() => dateCtrl.text = str);
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: TextField(
                                      controller: dateCtrl,
                                      style: GoogleFonts.poppins(fontSize: 13),
                                      decoration: _modalInputDec(
                                        suffixIcon: const Icon(
                                            Icons.calendar_today_outlined,
                                            size: 16,
                                            color: Color(0xFF64748B)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 5: Qualifications
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel('Qualifications'),
                          const SizedBox(height: 6),
                          TextField(
                            controller: qualsCtrl,
                            style: GoogleFonts.poppins(fontSize: 13),
                            decoration: _modalInputDec(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Footer Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: Text(
                              'Cancel',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              final name = nameCtrl.text.trim();
                              if (name.isEmpty) return;

                              setState(() {
                                staff['name'] = name;
                                staff['id'] = idCtrl.text.trim();
                                staff['role'] = selectedRole;
                                staff['dept'] = deptCtrl.text.trim();
                                staff['email'] = emailCtrl.text.trim();
                                staff['phone'] = phoneCtrl.text.trim();
                                staff['status'] = selectedStatus;
                                staff['dateJoined'] = dateCtrl.text.trim();
                                staff['qualifications'] = qualsCtrl.text.trim();
                              });

                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Saved changes for '${staff['name']}'!",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  backgroundColor: const Color(0xFF1E2865),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2E2A72),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 22, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Save Changes',
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
  // 7. CONFIRM DELETE ACTION
  // ===========================================================================
  void _confirmDeleteStaff(Map<String, dynamic> staff) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Staff Member',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        content: Text(
          "Are you sure you want to remove '${staff['name']}' (${staff['id']}) from staff management?",
          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF475569)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                  color: const Color(0xFF64748B), fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final name = staff['name'];
              setState(() {
                _staffList.remove(staff);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    "Removed '$name' from staff records.",
                    style: GoogleFonts.poppins(),
                  ),
                  backgroundColor: const Color(0xFFDC2626),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF0F172A),
      ),
    );
  }

  InputDecoration _modalInputDec({String? hint, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF94A3B8)),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF1E2865), width: 1.5),
      ),
    );
  }

  Widget _buildModalDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFCBD5E1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : items.first,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
          items: items.map((it) {
            return DropdownMenuItem<String>(
              value: it,
              child: Text(it, overflow: TextOverflow.ellipsis),
            );
          }).toList(),
          onChanged: onChanged,
        ),
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
