import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// DEPARTMENT: FACULTY SCREEN (HOD PORTAL)
// Exactly matches Image 5:
// - Blueprint grid hero banner with watermark & badges (DEPARTMENT, MVP)
// - 4 KPI Stat Cards: Total Faculty, Avg. Load (hrs/wk), Avg. Skill Dev., High AI Adoption
// - Filter & Search Toolbar with All designations, All AI levels & "+ Add faculty" button
// - Faculty Directory Table with Teaching Load, Skill Dev progress & AI Adoption badge
// =============================================================================

class HodFacultyDirectoryScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const HodFacultyDirectoryScreen({super.key, this.onBack});

  @override
  State<HodFacultyDirectoryScreen> createState() =>
      _HodFacultyDirectoryScreenState();
}

class _HodFacultyDirectoryScreenState extends State<HodFacultyDirectoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedDesignation = "All designations";
  String _selectedAiLevel = "All AI levels";

  final List<Map<String, dynamic>> _facultyList = [
    {
      "name": "Dr. Joseph Kumar",
      "email": "joseph.k@campus.edu",
      "designation": "Professor",
      "load": "18",
      "skillDev": 0.95,
      "skillText": "95%",
      "aiAdoption": "Medium",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddFacultyDialog() {
    final nameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final loadCtrl = TextEditingController(text: "16");
    String designation = "Assistant Professor";

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text(
                "Add New Faculty",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Faculty Name",
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: nameCtrl,
                      decoration: InputDecoration(
                        hintText: "e.g. Dr. K. Senthil Kumar",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text("Official Email",
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: emailCtrl,
                      decoration: InputDecoration(
                        hintText: "e.g. senthil.k@campus.edu",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text("Designation",
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      initialValue: designation,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                      ),
                      items: [
                        "Professor",
                        "Associate Professor",
                        "Assistant Professor",
                        "Dean / HoD",
                      ]
                          .map((d) => DropdownMenuItem(
                                value: d,
                                child: Text(d,
                                    style: GoogleFonts.poppins(fontSize: 12)),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setDialogState(() => designation = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    Text("Teaching Load (hrs/week)",
                        style: GoogleFonts.poppins(
                            fontSize: 12, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    TextField(
                      controller: loadCtrl,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameCtrl.text.trim().isNotEmpty) {
                      setState(() {
                        _facultyList.add({
                          "name": nameCtrl.text.trim(),
                          "email": emailCtrl.text.trim().isEmpty
                              ? "faculty@campus.edu"
                              : emailCtrl.text.trim(),
                          "designation": designation,
                          "load": loadCtrl.text.trim().isEmpty
                              ? "16"
                              : loadCtrl.text.trim(),
                          "skillDev": 0.88,
                          "skillText": "88%",
                          "aiAdoption": "Medium",
                        });
                      });
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Faculty member added successfully!")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF141938),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Save Faculty"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 900;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. 4 Top Metric KPI Cards
              if (isNarrow)
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildKpiCard(
                            label: "Total Faculty",
                            value: "${_facultyList.length}",
                            icon: Icons.people_outline_rounded,
                            iconBg: const Color(0xFF1E2865),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildKpiCard(
                            label: "Avg. Load (hrs/wk)",
                            value: "18",
                            icon: Icons.menu_book_rounded,
                            iconBg: const Color(0xFF4F46E5),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildKpiCard(
                            label: "Avg. Skill Dev.",
                            value: "95%",
                            icon: Icons.trending_up_rounded,
                            iconBg: const Color(0xFF10B981),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildKpiCard(
                            label: "High AI Adoption",
                            value: "0",
                            icon: Icons.bolt_rounded,
                            iconBg: const Color(0xFFF59E0B),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    Expanded(
                      child: _buildKpiCard(
                        label: "Total Faculty",
                        value: "${_facultyList.length}",
                        icon: Icons.people_outline_rounded,
                        iconBg: const Color(0xFF1E2865),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildKpiCard(
                        label: "Avg. Load (hrs/wk)",
                        value: "18",
                        icon: Icons.menu_book_rounded,
                        iconBg: const Color(0xFF4F46E5),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildKpiCard(
                        label: "Avg. Skill Dev.",
                        value: "95%",
                        icon: Icons.trending_up_rounded,
                        iconBg: const Color(0xFF10B981),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _buildKpiCard(
                        label: "High AI Adoption",
                        value: "0",
                        icon: Icons.bolt_rounded,
                        iconBg: const Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 18),

              // 3. Search & Filter Bar
              _buildFilterToolbar(isNarrow),
              const SizedBox(height: 16),

              // 4. Faculty Table Card
              _buildFacultyTableCard(),
            ],
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
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF141A46),
            Color(0xFF1E2865),
            Color(0xFF283685),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF141A46).withValues(alpha: 0.18),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.groups_rounded,
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            "Home",
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFFC7D2FE),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Department",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: const Color(0xFFC7D2FE),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.chevron_right_rounded,
                          size: 14,
                          color: Color(0xFF818CF8),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "Faculty",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
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
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.groups_rounded,
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
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildPillBadge(
                                  "DEPARTMENT",
                                  backgroundColor: const Color(0xFF1E2958),
                                  textColor: const Color(0xFF93C5FD),
                                ),
                                _buildPillBadge(
                                  "MVP",
                                  backgroundColor: const Color(0xFF0F766E),
                                  textColor: const Color(0xFFCCFBF1),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Faculty",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Faculty load, development progress and AI adoption.",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFFCBD5E1),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPillBadge(
    String label, {
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2.5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: textColor,
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. TOP METRIC KPI CARDS
  // ===========================================================================
  Widget _buildKpiCard({
    required String label,
    required String value,
    required IconData icon,
    required Color iconBg,
  }) {
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
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(icon, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
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
  // 3. SEARCH & FILTER TOOLBAR
  // ===========================================================================
  Widget _buildFilterToolbar(bool isNarrow) {
    if (isNarrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search faculty...",
              hintStyle: GoogleFonts.poppins(fontSize: 12),
              prefixIcon: const Icon(Icons.search, size: 18),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (val) => setState(() {}),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedDesignation,
                      items: [
                        "All designations",
                        "Professor",
                        "Associate Professor",
                        "Assistant Professor",
                      ]
                          .map((d) => DropdownMenuItem(
                                value: d,
                                child: Text(d, style: GoogleFonts.poppins(fontSize: 11.5)),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedDesignation = val);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: _selectedAiLevel,
                      items: [
                        "All AI levels",
                        "High",
                        "Medium",
                        "Low",
                      ]
                          .map((l) => DropdownMenuItem(
                                value: l,
                                child: Text(l, style: GoogleFonts.poppins(fontSize: 11.5)),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedAiLevel = val);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: _showAddFacultyDialog,
            icon: const Icon(Icons.person_add_outlined, size: 16),
            label: const Text("Add faculty"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF141938),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        // Search Input
        Expanded(
          flex: 2,
          child: Container(
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search faculty name or email...",
                hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                prefixIcon: const Icon(Icons.search, size: 18, color: Color(0xFF94A3B8)),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 11),
              ),
              onChanged: (val) => setState(() {}),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Designations Dropdown
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.filter_list_rounded, size: 16, color: Color(0xFF64748B)),
              const SizedBox(width: 6),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedDesignation,
                  items: [
                    "All designations",
                    "Professor",
                    "Associate Professor",
                    "Assistant Professor",
                  ]
                      .map((d) => DropdownMenuItem(
                            value: d,
                            child: Text(d, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155))),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedDesignation = val);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),

        // AI Levels Dropdown
        Container(
          height: 42,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedAiLevel,
              items: [
                "All AI levels",
                "High",
                "Medium",
                "Low",
              ]
                  .map((l) => DropdownMenuItem(
                        value: l,
                        child: Text(l, style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF334155))),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedAiLevel = val);
              },
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Add Faculty Button
        ElevatedButton.icon(
          onPressed: _showAddFacultyDialog,
          icon: const Icon(Icons.person_add_outlined, size: 16),
          label: Text(
            "Add faculty",
            style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF141938),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4. FACULTY TABLE CARD
  // ===========================================================================
  Widget _buildFacultyTableCard() {
    final query = _searchController.text.trim().toLowerCase();
    final filtered = _facultyList.where((f) {
      final nameMatches = f["name"].toString().toLowerCase().contains(query);
      final emailMatches = f["email"].toString().toLowerCase().contains(query);
      final desigMatches = _selectedDesignation == "All designations" ||
          f["designation"] == _selectedDesignation;
      final aiMatches = _selectedAiLevel == "All AI levels" ||
          f["aiAdoption"] == _selectedAiLevel;
      return (nameMatches || emailMatches) && desigMatches && aiMatches;
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Scrollable Table for responsive support
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 800),
              child: DataTable(
                headingRowHeight: 46,
                dataRowMinHeight: 64,
                dataRowMaxHeight: 64,
                horizontalMargin: 20,
                columnSpacing: 28,
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFFBFBFD)),
                columns: [
                  DataColumn(
                    label: Text(
                      "FACULTY",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "DESIGNATION",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "TEACHING LOAD (HRS/WK)",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "SKILL DEVELOPMENT",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "AI ADOPTION",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "ACTIONS",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
                rows: filtered.map((f) {
                  return DataRow(
                    cells: [
                      // Faculty Name & Email
                      DataCell(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              f["name"],
                              style: GoogleFonts.poppins(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            Text(
                              f["email"],
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Designation
                      DataCell(
                        Text(
                          f["designation"],
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            color: const Color(0xFF334155),
                          ),
                        ),
                      ),

                      // Teaching Load
                      DataCell(
                        Text(
                          f["load"],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ),

                      // Skill Development (Progress bar + %)
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 90,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: f["skillDev"] as double,
                                  minHeight: 6,
                                  backgroundColor: const Color(0xFFE2E8F0),
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                      Color(0xFF10B981)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              f["skillText"],
                              style: GoogleFonts.poppins(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // AI Adoption
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            f["aiAdoption"],
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFD97706),
                            ),
                          ),
                        ),
                      ),

                      // Actions
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit_outlined,
                                  size: 16, color: Color(0xFF64748B)),
                              onPressed: () {},
                              tooltip: "Edit Faculty",
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline_rounded,
                                  size: 16, color: Color(0xFF64748B)),
                              onPressed: () {
                                setState(() {
                                  _facultyList.remove(f);
                                });
                              },
                              tooltip: "Delete",
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

          // Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Text(
              "Showing ${filtered.length} of ${_facultyList.length} faculty member${_facultyList.length == 1 ? '' : 's'}",
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 26.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPaperPainter oldDelegate) {
    return oldDelegate.gridColor != gridColor || oldDelegate.step != step;
  }
}
