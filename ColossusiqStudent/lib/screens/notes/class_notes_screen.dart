import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

/// Class Notes Screen matching the web portal blueprint design:
/// - List View: Timeline with date, department, badges, takeaways, and 'Open notes →'
/// - Detail View: What was covered, homework, next class, resources, and Infographic Lesson
class ClassNotesScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const ClassNotesScreen({super.key, this.onBack});

  @override
  State<ClassNotesScreen> createState() => _ClassNotesScreenState();
}

class _ClassNotesScreenState extends State<ClassNotesScreen> {
  String _selectedDept = "All";
  Map<String, dynamic>? _selectedNote;
  bool _quickCheckRevealed = false;

  void _showNoteDetailsDialog(Map<String, dynamic> note) {
    final points = (note["points"] as List<dynamic>?) ?? [];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.menu_book_rounded, color: Color(0xFF2563EB), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(note["title"] as String, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text("${note["department"]} · ${note["date"]}", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
              onPressed: () => Navigator.pop(ctx),
              splashRadius: 20,
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 460),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (note["author"] != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text("Faculty: ${note["author"]}", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF334155))),
                  ),
                Text("Key Lecture Takeaways:", style: GoogleFonts.poppins(fontSize: 11.5, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 6),
                for (final p in points)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFF059669)),
                        const SizedBox(width: 6),
                        Expanded(child: Text(p.toString(), style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF1E293B)))),
                      ],
                    ),
                  ),
                if (note["homework"] != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.edit_note_rounded, size: 16, color: Color(0xFFB45309)),
                        const SizedBox(width: 6),
                        Expanded(child: Text("Homework: ${note["homework"]}", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF92400E)))),
                      ],
                    ),
                  ),
                ],
                if (note["nextClass"] != null) ...[
                  const SizedBox(height: 8),
                  Text("Next Class: ${note["nextClass"]}", style: GoogleFonts.poppins(fontSize: 11.5, fontStyle: FontStyle.italic, color: const Color(0xFF64748B))),
                ],
              ],
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        actions: [
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
                child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B), fontWeight: FontWeight.w500, fontSize: 13)),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  _showEditNoteDialog(note);
                },
                icon: const Icon(Icons.edit_outlined, size: 14),
                label: Text("Edit", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF141938),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  setState(() {
                    _selectedNote = note;
                    _quickCheckRevealed = false;
                  });
                },
                icon: const Icon(Icons.menu_book_rounded, size: 15),
                label: Text("Open Full Notes", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF141938),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditNoteDialog(Map<String, dynamic> note) {
    final titleCtrl = TextEditingController(text: note["title"] as String);
    final courseCtrl = TextEditingController(text: note["courseTitle"] as String? ?? "");
    final homeworkCtrl = TextEditingController(text: note["homework"] as String? ?? "");
    final nextClassCtrl = TextEditingController(text: note["nextClass"] as String? ?? "");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Note / Personal Annotations", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: "Note Title", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: courseCtrl,
                  decoration: const InputDecoration(labelText: "Course / Topic", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: homeworkCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: "Homework / Action Items", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: nextClassCtrl,
                  decoration: const InputDecoration(labelText: "Next Class Prep", border: OutlineInputBorder()),
                ),
              ],
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        actions: [
          Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
                child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B), fontWeight: FontWeight.w500, fontSize: 13)),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    note["title"] = titleCtrl.text.trim();
                    note["courseTitle"] = courseCtrl.text.trim();
                    note["homework"] = homeworkCtrl.text.trim();
                    note["nextClass"] = nextClassCtrl.text.trim();
                  });
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Class note '${note["title"]}' updated successfully!"),
                      backgroundColor: const Color(0xFF15803D),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.check_rounded, size: 15),
                label: Text("Save Changes", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF141938),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final List<Map<String, dynamic>> _notesData = [
    {
      "id": "CN-01",
      "date": "WED, 7 OCT",
      "department": "COMPUTER SCIENCE & ENGINEERING",
      "courseTitle": "Database Management Systems",
      "title": "Class summary — Normalization (1NF–BCNF)",
      "author": "Dr. Meena Raghavan",
      "isNew": false,
      "hasInfographic": true,
      "points": [
        "2NF removes partial dependencies of non-key attributes on part of a composite key.",
        "3NF removes transitive dependencies of non-key attributes.",
        "In BCNF every determinant of a non-trivial dependency is a superkey.",
      ],
      "homework": "Why might a designer stop at 3NF instead of BCNF?",
      "nextClass": "Transaction Management, ACID Properties & Concurrency Control",
      "resources": [
        {
          "label": "NPTEL lectures: Normalization (1NF–BCNF)",
          "source": "YouTube",
          "isPlay": true,
        },
        {
          "label": "Read more: Normalization (1NF–BCNF)",
          "source": "Wikipedia",
          "isPlay": false,
        },
      ],
      "infographic": {
        "what":
            "Normalization splits tables step by step through the normal forms to remove redundancy and update anomalies.",
        "orbitPoints": [
          "2NF removes partial dependencies of non-key attributes on part of a composite key.",
          "3NF removes transitive dependencies of non-key attributes.",
          "In BCNF every determinant of a non-trivial dependency is a superkey.",
        ],
        "terms": [
          {
            "term": "Partial dependency",
            "meaning": "A non-key attribute that depends on only part of a composite key.",
            "color": AppColors.primaryBlue,
          },
          {
            "term": "Transitive dependency",
            "meaning": "A non-key attribute that depends on another non-key attribute.",
            "color": AppColors.warning,
          },
          {
            "term": "Update anomaly",
            "meaning": "An inconsistency caused by having to change the same fact in many rows.",
            "color": AppColors.info,
          },
        ],
        "mistakes": [
          "Decomposing without checking that the join is lossless.",
          "Assuming 3NF always equals BCNF — they differ when a non-key attribute determines part of a key.",
        ],
        "question": {
          "q": "What must hold for a table to be in 1NF?",
          "a":
              "Each column must contain atomic (indivisible) values, and each record must have a unique identifier with no repeating groups.",
        },
      },
    },
    {
      "id": "CN-02",
      "date": "WED, 7 OCT",
      "department": "COMPUTER SCIENCE & ENGINEERING",
      "courseTitle": "Database Management Systems",
      "title": "Class summary — Normalization (1NF–BCNF)",
      "author": "Dr. Meena Raghavan",
      "isNew": true,
      "hasInfographic": true,
      "points": [
        "2NF removes partial dependencies of non-key attributes on part of a composite key.",
        "3NF removes transitive dependencies of non-key attributes.",
        "In BCNF every determinant of a non-trivial dependency is a superkey.",
      ],
      "homework": "Why might a designer stop at 3NF instead of BCNF?",
      "nextClass": "Transaction Management, ACID Properties & Concurrency Control",
      "resources": [
        {
          "label": "NPTEL lectures: Normalization (1NF–BCNF)",
          "source": "YouTube",
          "isPlay": true,
        },
      ],
      "infographic": {
        "what":
            "Normalization splits tables step by step through the normal forms to remove redundancy and update anomalies.",
        "orbitPoints": [
          "2NF removes partial dependencies of non-key attributes on part of a composite key.",
          "3NF removes transitive dependencies of non-key attributes.",
          "In BCNF every determinant of a non-trivial dependency is a superkey.",
        ],
        "terms": [
          {
            "term": "Partial dependency",
            "meaning": "A non-key attribute that depends on only part of a composite key.",
            "color": AppColors.primaryBlue,
          },
        ],
        "mistakes": [
          "Decomposing without checking that the join is lossless.",
        ],
        "question": {
          "q": "What must hold for a table to be in 1NF?",
          "a":
              "Each column must contain atomic (indivisible) values, and each record must have a unique identifier with no repeating groups.",
        },
      },
    },
    {
      "id": "CN-03",
      "date": "MON, 28 SEPT",
      "department": "COMPUTER SCIENCE & ENGINEERING",
      "courseTitle": "Mathematics for Computing",
      "title": "Integration class summary",
      "author": "Prof. K. Ramesh",
      "isNew": false,
      "hasInfographic": false,
      "points": [
        "Definite and indefinite integrals.",
        "Integration by parts and substitution method.",
        "Applications in area under curve.",
      ],
      "homework": "Solve problem set 4 on integration by parts.",
      "nextClass": "Differential Equations & Initial Value Problems",
      "resources": [
        {
          "label": "NPTEL Calculus Series: Integration",
          "source": "YouTube",
          "isPlay": true,
        },
      ],
      "infographic": null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Class Notes",
      category: "Academics",
      onBack: _selectedNote != null
          ? () => setState(() {
                _selectedNote = null;
                _quickCheckRevealed = false;
              })
          : widget.onBack,
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Academics  ›  Class Notes",
          category: "ACADEMICS",
          phase: "MVP",
          isMvp: true,
          icon: Icons.menu_book_rounded,
          title: "Class Notes",
          subtitle:
              "Class summaries, homework, resources and infographic handouts shared by your faculty after each class.",
          watermarkIcon: Icons.assignment_outlined,
        ),
        const SizedBox(height: 20),

        // 2. Either Note Detail View OR Timeline List View
        if (_selectedNote != null)
          _buildDetailView(_selectedNote!)
        else
          _buildListView(),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // 1. LIST VIEW (Image 1)
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildListView() {
    final depts = ["All", "Computer Science & Engineering", "Civil Engineering"];
    final filtered = _selectedDept == "All"
        ? _notesData
        : _notesData.where((n) => n["department"].toString().toLowerCase().contains(_selectedDept.toLowerCase())).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        // Department filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: depts.map((d) {
              final isSel = _selectedDept == d;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(d),
                  selected: isSel,
                  onSelected: (_) => setState(() => _selectedDept = d),
                  backgroundColor: Colors.white,
                  selectedColor: AppColors.primaryBlue,
                  side: BorderSide(
                    color: isSel ? AppColors.primaryBlue : AppColors.border,
                  ),
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: isSel ? FontWeight.w600 : FontWeight.w500,
                    color: isSel ? Colors.white : AppColors.textSecondary,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),

        // Timeline items
        for (int i = 0; i < filtered.length; i++)
          _buildTimelineCard(filtered[i], isLast: i == filtered.length - 1),
      ],
    );
  }

  Widget _buildTimelineCard(Map<String, dynamic> note, {required bool isLast}) {
    final bool isNew = note["isNew"] == true;
    final bool hasInfographic = note["hasInfographic"] == true;
    final List<dynamic> points = note["points"] as List<dynamic>;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator (dot + vertical line)
          SizedBox(
            width: 24,
            child: Column(
              children: [
                const SizedBox(height: 22),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: isNew ? AppColors.primaryBlue : AppColors.border,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: AppColors.border,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Main Card
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row: Date & Department + Badges
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      Text(
                        "${note['date']} · ${note['department']}".toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          if (isNew)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                              decoration: BoxDecoration(
                                color: AppColors.lightBlue,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "New",
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                            ),
                          if (hasInfographic)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
                              decoration: BoxDecoration(
                                color: AppColors.warningSoft,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.image_outlined, size: 12, color: AppColors.warning),
                                  const SizedBox(width: 3),
                                  Text(
                                    "Infographic",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.warning,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Title
                  Text(
                    note["title"] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Subtitle
                  Text(
                    "by ${note['author']}",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Checkmark Points
                  for (final p in points)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check, size: 15, color: AppColors.success),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              p.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: AppColors.textPrimary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 14),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedNote = note;
                            _quickCheckRevealed = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Open notes",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_forward_rounded, size: 13, color: Colors.white),
                          ],
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => _showNoteDetailsDialog(note),
                        icon: const Icon(Icons.visibility_outlined, size: 13),
                        label: const Text("View Details"),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          foregroundColor: const Color(0xFF0F766E),
                          textStyle: GoogleFonts.poppins(fontSize: 11.5),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => _showEditNoteDialog(note),
                        icon: const Icon(Icons.edit_outlined, size: 13),
                        label: const Text("Edit"),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          foregroundColor: const Color(0xFF4338CA),
                          textStyle: GoogleFonts.poppins(fontSize: 11.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // 2. DETAIL VIEW (Images 2, 3, 4)
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildDetailView(Map<String, dynamic> note) {
    final List<dynamic> points = note["points"] as List<dynamic>;
    final List<dynamic> resources = note["resources"] as List<dynamic>;
    final Map<String, dynamic>? infographic = note["infographic"] as Map<String, dynamic>?;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back Button
        InkWell(
          onTap: () {
            setState(() {
              _selectedNote = null;
              _quickCheckRevealed = false;
            });
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_back_rounded, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 6),
                Text(
                  "All class notes",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Card 1: What We Covered & Side Panels (Image 2)
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header tag
              Text(
                "${note['date']} · ${note['department']}".toUpperCase(),
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 6),

              // Title
              Text(
                note["title"] as String,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),

              // Subtitle
              Text(
                "Shared by ${note['author']}",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 22),

              // Two Column Content (Responsive)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 680;
                  final leftCol = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WHAT WE COVERED",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (int i = 0; i < points.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${i + 1}",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.warning,
                                  height: 1.1,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  points[i].toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 13.5,
                                    color: AppColors.textPrimary,
                                    height: 1.45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );

                  final rightCol = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Homework Box
                      if (note["homework"] != null)
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlue,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.15)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.edit_outlined, size: 14, color: AppColors.primaryBlue),
                                  const SizedBox(width: 6),
                                  Text(
                                    "HOMEWORK",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                      color: AppColors.primaryBlue,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                note["homework"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  color: AppColors.textPrimary,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 12),

                      // Next Class Box
                      if (note["nextClass"] != null)
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.veryLightBlue,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "NEXT CLASS",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.6,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                note["nextClass"] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  color: AppColors.textPrimary,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 14),

                      // Resources
                      if (resources.isNotEmpty) ...[
                        Text(
                          "RESOURCES",
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        for (final r in resources)
                          Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  r["isPlay"] == true ? Icons.play_circle_outline : Icons.language_rounded,
                                  size: 16,
                                  color: AppColors.primaryBlue,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    r["label"] as String,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  r["source"] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: AppColors.textDisabled,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ],
                  );

                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 6, child: leftCol),
                        const SizedBox(width: 24),
                        Expanded(flex: 5, child: rightCol),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      leftCol,
                      const SizedBox(height: 20),
                      rightCol,
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // 3. Infographic Lesson Poster (Images 3 & 4)
        if (infographic != null) ...[
          // Header Bar with Print Button
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              Text(
                "INFOGRAPHIC LESSON",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: AppColors.textSecondary,
                ),
              ),
              OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Preparing infographic PDF for export...")),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.border),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                icon: Icon(Icons.print_outlined, size: 14, color: AppColors.textPrimary),
                label: Text(
                  "Print / save as PDF",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Main Infographic Poster Card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top Gradient Banner
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.darkBlue, AppColors.primaryBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (note["department"] as String).toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                  color: Colors.white.withValues(alpha: 0.85),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Normalization (1NF–BCNF)",
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "INFOGRAPHIC LESSON",
                            style: GoogleFonts.poppins(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Poster Body
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // In Plain Words Section
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.warningSoft,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(Icons.lightbulb_outline, color: AppColors.warning, size: 22),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "IN PLAIN WORDS",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.6,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    infographic["what"] as String,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: AppColors.textPrimary,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // The Idea in One Picture Section (Image 3)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.veryLightBlue,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "THE IDEA IN ONE PICTURE",
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.6,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 18),

                              // Orbiting diagram layout
                              _buildCircularDiagram(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Words to Know & Watch Out / Quick Check (Image 4)
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isWide = constraints.maxWidth > 680;
                            final termsList = infographic["terms"] as List<dynamic>;
                            final mistakesList = infographic["mistakes"] as List<dynamic>;
                            final question = infographic["question"] as Map<String, dynamic>?;

                            final wordsToKnow = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "WORDS TO KNOW",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.6,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                for (final t in termsList)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: AppColors.border),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: (t["color"] as Color?) ?? AppColors.primaryBlue,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                t["term"] as String,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                t["meaning"] as String,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: AppColors.textSecondary,
                                                  height: 1.4,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            );

                            final rightSide = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Watch out
                                Text(
                                  "WATCH OUT",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.6,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                for (final m in mistakesList)
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: AppColors.warningSoft,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: AppColors.warning,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "!",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            m.toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 12.5,
                                              color: AppColors.textPrimary,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                const SizedBox(height: 14),

                                // Quick check with dashed border
                                if (question != null)
                                  CustomPaint(
                                    painter: _DashedBorderPainter(
                                      color: AppColors.primaryBlue,
                                      radius: 12,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "QUICK CHECK",
                                            style: GoogleFonts.poppins(
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.6,
                                              color: AppColors.primaryBlue,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            question["q"] as String,
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          if (_quickCheckRevealed)
                                            Text(
                                              question["a"] as String,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12.5,
                                                color: AppColors.primaryBlue,
                                                height: 1.4,
                                              ),
                                            )
                                          else
                                            InkWell(
                                              onTap: () => setState(() => _quickCheckRevealed = true),
                                              child: Text(
                                                "Show answer",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.primaryBlue,
                                                  decoration: TextDecoration.underline,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            );

                            if (isWide) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(flex: 5, child: wordsToKnow),
                                  const SizedBox(width: 20),
                                  Expanded(flex: 5, child: rightSide),
                                ],
                              );
                            }
                            return Column(
                              children: [
                                wordsToKnow,
                                const SizedBox(height: 20),
                                rightSide,
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // Footer Bar
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.veryLightBlue,
                      border: Border(top: BorderSide(color: AppColors.border)),
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      runAlignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        Text(
                          "Shared by ${note['author']} · ${note['date']}",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          "AI-assisted · reviewed by your faculty",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: AppColors.textDisabled,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ],
    );
  }

  // Circular Diagram for "The idea in one picture" (Image 3)
  Widget _buildCircularDiagram() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 620;

        if (isCompact) {
          // Responsive clean vertical stack for small screens
          return Column(
            children: [
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.darkBlue, AppColors.primaryBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Normalization\n(1NF–BCNF)",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildStepCard(
                "1",
                "2NF removes partial dependencies of non-key attributes on part of a composite key.",
                AppColors.primaryBlue,
              ),
              const SizedBox(height: 8),
              _buildStepCard(
                "2",
                "3NF removes transitive dependencies of non-key attributes.",
                AppColors.info,
              ),
              const SizedBox(height: 8),
              _buildStepCard(
                "3",
                "In BCNF every determinant of a non-trivial dependency is a superkey.",
                AppColors.primaryBlue,
              ),
            ],
          );
        }

        // Circular Orbital Layout for wider screens (matching Image 3)
        return SizedBox(
          height: 380,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Dashed Orbit Circle Track
              CustomPaint(
                size: const Size(280, 280),
                painter: _DashedCirclePainter(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
              ),

              // Center Circle
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.darkBlue, AppColors.primaryBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.3),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Normalization\n(1NF–BCNF)",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                ),
              ),

              // Card 1: Top
              Positioned(
                top: 10,
                child: _buildStepCard(
                  "1",
                  "2NF removes partial dependencies of non-key\nattributes on part of a composite key.",
                  AppColors.primaryBlue,
                  width: 250,
                ),
              ),

              // Card 2: Bottom Right
              Positioned(
                bottom: 15,
                right: 20,
                child: _buildStepCard(
                  "2",
                  "3NF removes transitive dependencies\nof non-key attributes.",
                  AppColors.info,
                  width: 220,
                ),
              ),

              // Card 3: Bottom Left
              Positioned(
                bottom: 15,
                left: 20,
                child: _buildStepCard(
                  "3",
                  "In BCNF every determinant of a\nnon-trivial dependency is a superkey.",
                  AppColors.primaryBlue,
                  width: 220,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStepCard(String step, String text, Color color, {double? width}) {
    return Container(
      width: width ?? double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                color: AppColors.textPrimary,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Custom Painters for Orbit & Dashed Border
// ─────────────────────────────────────────────────────────────────────────────
class _DashedCirclePainter extends CustomPainter {
  final Color color;
  _DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    const dashAngle = 0.08;
    const spaceAngle = 0.05;
    double start = 0;
    while (start < 2 * 3.14159265) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start,
        dashAngle,
        false,
        paint,
      );
      start += dashAngle + spaceAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    this.radius = 14,
  });

  static const double _strokeWidth = 1.5;
  static const double _dashWidth = 5.0;
  static const double _dashSpace = 3.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + _dashWidth;
        final extract = metric.extractPath(distance, next > metric.length ? metric.length : next);
        canvas.drawPath(extract, paint);
        distance += _dashWidth + _dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
