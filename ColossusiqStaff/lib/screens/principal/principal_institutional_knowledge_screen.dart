import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalInstitutionalKnowledgeScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalInstitutionalKnowledgeScreen({super.key, this.onBack});

  @override
  State<PrincipalInstitutionalKnowledgeScreen> createState() =>
      _PrincipalInstitutionalKnowledgeScreenState();
}

class _PrincipalInstitutionalKnowledgeScreenState
    extends State<PrincipalInstitutionalKnowledgeScreen> {
  int _selectedSubTab = 0; // 0: Documents, 1: Ask the knowledge base, 2: Index & AI
  String _selectedType = "All types";
  String _selectedStatus = "All statuses";
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _askController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _askController.dispose();
    super.dispose();
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF2FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.cloud_upload_outlined,
                  color: Color(0xFF283685), size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              "Upload Document",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Upload university regulations, statutes, handbooks, or circulars in PDF/DOCX format to ingest into the RAG vector store.",
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B)),
            ),
            const SizedBox(height: 18),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFCBD5E1), style: BorderStyle.solid),
              ),
              child: Column(
                children: [
                  const Icon(Icons.upload_file_rounded, size: 36, color: Color(0xFF283685)),
                  const SizedBox(height: 8),
                  Text("Drag & drop files here or browse",
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B))),
                  const SizedBox(height: 4),
                  Text("Supports PDF, DOCX up to 50MB",
                      style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF94A3B8))),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Document uploaded and sent to Gemini embedding pipeline."),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E1B4B),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Select & Ingest", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFAF9F5), // Light warm neutral canvas
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 950;
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
                // 1. TOP BLUEPRINT HERO BANNER
                _buildHeroBanner(),
                const SizedBox(height: 20),

                // 2. FOUR KPI STAT CARDS
                _buildKpiCards(constraints.maxWidth),
                const SizedBox(height: 22),

                // 3. SUB-TAB SWITCHER & TOP-LEVEL ACTIONS
                _buildSubTabHeader(constraints.maxWidth),
                const SizedBox(height: 18),

                // 4. ACTIVE SUB-TAB VIEW
                switch (_selectedSubTab) {
                  1 => _buildAskKnowledgeBaseTab(isDesktop),
                  2 => _buildIndexAndAiTab(constraints.maxWidth),
                  _ => _buildDocumentsTab(constraints.maxWidth),
                },
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 1. TOP BLUEPRINT HERO BANNER
  // ===========================================================================
  Widget _buildHeroBanner() {
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
              right: 20,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.dns_rounded,
                  size: 190,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
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
                          "Institution",
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
                          "Institutional Knowledge (RAG)",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Header Row with Icon & Title
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E285F),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.dns_rounded,
                            color: Color(0xFFF59E0B),
                            size: 26,
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "INSTITUTION",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Phase 3",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Institutional Knowledge (RAG)",
                              style: GoogleFonts.poppins(
                                fontSize: 21,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "Syllabus, regulations, handbooks and circulars that ground every AI answer.",
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w400,
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
  // 2. FOUR KPI STAT CARDS
  // ===========================================================================
  Widget _buildKpiCards(double maxWidth) {
    final kpis = [
      {
        "title": "DOCUMENTS",
        "value": "0",
        "subtitle": "0 categories · 0 approved",
        "icon": Icons.description_outlined,
        "iconBg": const Color(0xFFEEF2FF),
        "iconColor": const Color(0xFF4F46E5),
      },
      {
        "title": "INDEXED PASSAGES",
        "value": "0",
        "subtitle": "Upload a document to start",
        "icon": Icons.layers_outlined,
        "iconBg": const Color(0xFFF0FDF4),
        "iconColor": const Color(0xFF0284C7),
      },
      {
        "title": "GROUNDING",
        "value": "0/0",
        "subtitle": "No documents yet",
        "icon": Icons.verified_user_outlined,
        "iconBg": const Color(0xFFECFDF5),
        "iconColor": const Color(0xFF059669),
      },
      {
        "title": "AI SERVICE",
        "value": "On",
        "subtitle": "Gemini · gemini-2.5-flash · gemini-embedding-001",
        "icon": Icons.hub_outlined,
        "iconBg": const Color(0xFFFFFBEB),
        "iconColor": const Color(0xFFD97706),
      },
    ];

    if (maxWidth >= 1000) {
      return Row(
        children: kpis.map((k) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: _buildSingleKpiCard(k),
            ),
          );
        }).toList(),
      );
    } else if (maxWidth >= 600) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildSingleKpiCard(kpis[0])),
              const SizedBox(width: 12),
              Expanded(child: _buildSingleKpiCard(kpis[1])),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildSingleKpiCard(kpis[2])),
              const SizedBox(width: 12),
              Expanded(child: _buildSingleKpiCard(kpis[3])),
            ],
          ),
        ],
      );
    } else {
      return Column(
        children: kpis.map((k) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildSingleKpiCard(k),
          );
        }).toList(),
      );
    }
  }

  Widget _buildSingleKpiCard(Map<String, dynamic> k) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  k["title"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF64748B),
                    letterSpacing: 0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: k["iconBg"] as Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  k["icon"] as IconData,
                  size: 16,
                  color: k["iconColor"] as Color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            k["value"] as String,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            k["subtitle"] as String,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. SUB-TAB HEADER ROW (Pill Tabs on Left + Actions on Right)
  // ===========================================================================
  Widget _buildSubTabHeader(double maxWidth) {
    final subTabs = [
      {"icon": Icons.folder_outlined, "title": "Documents", "badge": "0"},
      {"icon": Icons.auto_awesome_outlined, "title": "Ask the knowledge base"},
      {"icon": Icons.layers_outlined, "title": "Index & AI"},
    ];

    final tabsList = Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(subTabs.length, (index) {
        final t = subTabs[index];
        final isSelected = _selectedSubTab == index;

        return InkWell(
          onTap: () {
            setState(() => _selectedSubTab = index);
          },
          borderRadius: BorderRadius.circular(22),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF131B4D) : Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF131B4D)
                    : const Color(0xFFE2E8F0),
              ),
              boxShadow: [
                if (isSelected)
                  BoxShadow(
                    color: const Color(0xFF131B4D).withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  t["icon"] as IconData,
                  size: 15,
                  color: isSelected ? Colors.white : const Color(0xFF475569),
                ),
                const SizedBox(width: 7),
                Text(
                  t["title"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
                if (t["badge"] != null) ...[
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 1.5),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.2)
                          : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      t["badge"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected ? Colors.white : const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );

    final actionButtons = Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // "Institution" soft pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Text(
            "Institution",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF475569),
            ),
          ),
        ),

        // "Export" button
        OutlinedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Exporting Knowledge Index metadata..."),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          icon: const Icon(Icons.download_rounded, size: 14),
          label: Text(
            "Export",
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF334155),
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFFE2E8F0)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),

        // "+ Upload document" button
        ElevatedButton.icon(
          onPressed: _showUploadDialog,
          icon: const Icon(Icons.add_rounded, size: 16),
          label: Text(
            "Upload document",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF131B4D),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );

    if (maxWidth >= 850) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: tabsList),
          const SizedBox(width: 14),
          actionButtons,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tabsList,
        const SizedBox(height: 12),
        actionButtons,
      ],
    );
  }

  // ===========================================================================
  // 4A. TAB 1: DOCUMENTS
  // ===========================================================================
  Widget _buildDocumentsTab(double maxWidth) {
    return Column(
      children: [
        // Search & Filters Bar
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: LayoutBuilder(
            builder: (context, box) {
              final isNarrow = box.maxWidth < 700;

              final searchInput = Container(
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() {}),
                  style: GoogleFonts.poppins(
                      fontSize: 12, color: const Color(0xFF1E293B)),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search_rounded,
                        size: 18, color: Color(0xFF94A3B8)),
                    hintText: "Search by title, office, type or file name",
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 12, color: const Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 9),
                  ),
                ),
              );

              final dropdownFilters = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Type dropdown
                  Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedType,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            size: 16, color: Color(0xFF64748B)),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1E293B),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: "All types", child: Text("All types")),
                          DropdownMenuItem(
                              value: "Regulation", child: Text("Regulation")),
                          DropdownMenuItem(
                              value: "Curriculum", child: Text("Curriculum")),
                          DropdownMenuItem(
                              value: "Handbook", child: Text("Handbook")),
                        ],
                        onChanged: (val) {
                          if (val != null) setState(() => _selectedType = val);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Status dropdown
                  Container(
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedStatus,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            size: 16, color: Color(0xFF64748B)),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1E293B),
                        ),
                        items: const [
                          DropdownMenuItem(
                              value: "All statuses",
                              child: Text("All statuses")),
                          DropdownMenuItem(
                              value: "Approved", child: Text("Approved")),
                          DropdownMenuItem(
                              value: "Pending", child: Text("Pending")),
                          DropdownMenuItem(
                              value: "Draft", child: Text("Draft")),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _selectedStatus = val);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );

              if (isNarrow) {
                return Column(
                  children: [
                    searchInput,
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: dropdownFilters,
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: searchInput),
                  const SizedBox(width: 12),
                  dropdownFilters,
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),

        // Empty Canvas Grid Area
        Container(
          width: double.infinity,
          height: 320,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(
                    painter: _LightGraphGridPainter(),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No documents yet",
                          style: GoogleFonts.poppins(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Upload your regulations, academic calendar, handbooks and\ncirculars. Approved documents become the only source the AI\nmay answer from.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF64748B),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 18),
                        ElevatedButton.icon(
                          onPressed: _showUploadDialog,
                          icon: const Icon(Icons.upload_file_rounded, size: 16),
                          label: Text(
                            "Upload the first document",
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF131B4D),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4B. TAB 2: ASK THE KNOWLEDGE BASE (Image 3)
  // ===========================================================================
  Widget _buildAskKnowledgeBaseTab(bool isDesktop) {
    final queryBox = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: TextField(
                    controller: _askController,
                    style: GoogleFonts.poppins(
                        fontSize: 12.5, color: const Color(0xFF1E293B)),
                    decoration: InputDecoration(
                      hintText:
                          "Ask something your documents should answer, e.g. minimum attendance for exams",
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 12, color: const Color(0xFF94A3B8)),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  if (_askController.text.trim().isEmpty) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Grounding query against approved documents... No approved documents yet."),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.send_rounded, size: 14),
                label: Text(
                  "Ask",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C8BA1), // Soft periwinkle/slate
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            "Upload and approve a document first. Answers only ever come from approved documents.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 120),
        ],
      ),
    );

    final howAnswersWorkCard = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, size: 16, color: Color(0xFFD97706)),
              const SizedBox(width: 8),
              Text(
                "How answers work",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildNumberedGuideline(
            "1.",
            "Only approved documents are searched.",
            highlight: "approved",
          ),
          const SizedBox(height: 12),
          _buildNumberedGuideline(
            "2.",
            "Your question is matched to passages by meaning and by keywords.",
          ),
          const SizedBox(height: 12),
          _buildNumberedGuideline(
            "3.",
            "The AI writes a short answer using only those passages and cites them.",
          ),
          const SizedBox(height: 12),
          _buildNumberedGuideline(
            "4.",
            "If the documents do not cover it, you are told so rather than given a guess.",
          ),
        ],
      ),
    );

    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 7, child: queryBox),
          const SizedBox(width: 18),
          Expanded(flex: 4, child: howAnswersWorkCard),
        ],
      );
    }

    return Column(
      children: [
        queryBox,
        const SizedBox(height: 16),
        howAnswersWorkCard,
      ],
    );
  }

  Widget _buildNumberedGuideline(String number, String text,
      {String? highlight}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF475569),
                height: 1.45,
              ),
              children: highlight != null
                  ? [
                      const TextSpan(text: "Only "),
                      TextSpan(
                        text: highlight,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      TextSpan(
                        text: text.replaceFirst("Only $highlight", ""),
                      ),
                    ]
                  : [
                      TextSpan(text: text),
                    ],
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // 4C. TAB 3: INDEX & AI (Image 4)
  // ===========================================================================
  Widget _buildIndexAndAiTab(double maxWidth) {
    return Column(
      children: [
        // Top AI Service Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "AI service",
                    style: GoogleFonts.poppins(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCFBF1), // Mint
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "Connected",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F766E),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "Gemini is connected. Passages are embedded with gemini-embedding-001 (768-dimension vectors) and answers are written by Gemini · gemini-2.5-flash.",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, box) {
                  final isTight = box.maxWidth < 650;
                  final metrics = [
                    {
                      "label": "RETRIEVAL",
                      "val": "Hybrid: 70% meaning + 30% keywords"
                    },
                    {
                      "label": "PASSAGES USED PER ANSWER",
                      "val": "Top 6"
                    },
                    {
                      "label": "DOCUMENTS THAT NEED RE-INDEXING",
                      "val": "0"
                    },
                  ];

                  if (isTight) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: metrics.map((m) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                m["label"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF64748B),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                m["val"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E293B),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }

                  return Row(
                    children: metrics.map((m) {
                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              m["label"]!,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF64748B),
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              m["val"]!,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Bottom Index Health Card
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
                child: Text(
                  "Index health by document",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              Container(
                width: double.infinity,
                height: 220,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _LightGraphGridPainter(),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Nothing indexed yet",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Upload a document to see how it is indexed.",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
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

    const spacing = 28.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// LIGHT GRAPH PAPER GRID PAINTER
// =============================================================================
class _LightGraphGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE2E8F0).withValues(alpha: 0.5)
      ..strokeWidth = 0.8;

    const spacing = 24.0;
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
