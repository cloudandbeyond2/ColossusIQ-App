import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

class AssignmentsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const AssignmentsScreen({super.key, this.onBack});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  String _activeTab = "To do"; // "To do", "Handed in", "All"
  int _perPage = 5;
  int _currentPage = 1;
  final Set<String> _expandedInstructions = {};

  final List<Map<String, dynamic>> _assignments = [
    {
      "id": "ASG-01",
      "title": "CNN Image Classification on CIFAR-10 Dataset",
      "course": "AI & Data Science",
      "faculty": "Dr. Meena Raghavan",
      "totalMarks": 10,
      "dueDate": "16 Oct, 10:00 am",
      "instructions":
          "1. Build and train a Convolutional Neural Network (CNN) using PyTorch or TensorFlow to classify CIFAR-10 images into 10 categories.\n"
          "2. Implement Dropout and Batch Normalization to prevent overfitting and achieve at least 75% test accuracy.\n"
          "3. Submit your completed Jupyter Notebook (.ipynb) with training/validation loss plots and a confusion matrix.",
      "status": "Marked",
      "submissionDate": "Handed in Oct 12, 1:30 PM",
      "submissionText":
          "ASSIGNMENT REPORT: CNN Image Classification on CIFAR-10 Dataset\n"
          "Course: AI & Data Science\n"
          "Author: Anand Kumar | Reg No: 21CS0101\n"
          "--",
      "submissionLink": "https://github.com/anandkumar/cifar10-cnn-classifier",
      "marksScored": 9,
      "feedback": "Good work",
    },
    {
      "id": "ASG-02",
      "title": "Cyber Security",
      "course": "Cyber Security and Ethical Hacking",
      "faculty": "Dr. Meena Raghavan",
      "totalMarks": 10,
      "dueDate": "16 Oct, 5:00 pm",
      "instructions":
          "1. Read each lesson carefully before attempting the questions.\n"
          "2. Complete all assigned activities and practice questions.\n"
          "3. Learn basic concepts such as cyber threats, passwords, authentication, malware, and network security.",
      "status": "Marked",
      "submissionDate": "Handed in Oct 7, 10:53 AM",
      "submissionText":
          "Cybersecurity is the practice of protecting computers, networks, applications, and data from unauthorized access, attacks, and damage. Students should use strong and unique passwords, enable multi-factor authentication, keep software updated, and be careful with suspicious links and attachments. Common cyber threats include phishing, malware, ransomware, and identity theft. Regular data backups and encryption can also help protect important information.",
      "submissionLink": "https://github.com/Anand/cyber-security-project",
      "marksScored": 8,
      "feedback": "Good Work",
    },
    {
      "id": "ASG-03",
      "title": "OS",
      "course": "OS",
      "faculty": "Dr. Meena Raghavan",
      "totalMarks": 10,
      "dueDate": "7 Oct, 5:00 pm",
      "instructions": "submit it tomorrow",
      "status": "Marked",
      "submissionDate": "Handed in Oct 6, 12:56 PM",
      "submissionText": "gdfgdg",
      "submissionLink": "https://github.com",
      "marksScored": 10,
      "feedback": "good",
    },
    {
      "id": "ASG-04",
      "title": "Scheduler simulation",
      "course": "CN",
      "faculty": "Faculty Member",
      "totalMarks": 10,
      "dueDate": "Oct 8",
      "instructions": "",
      "status": "Closed · not handed in",
      "submissionDate": null,
      "submissionText": null,
      "submissionLink": null,
      "marksScored": null,
      "feedback": null,
    },
    {
      "id": "ASG-05",
      "title": "Subnetting problems",
      "course": "DBMS",
      "faculty": "Faculty Member",
      "totalMarks": 10,
      "dueDate": "Oct 11 · Due Oct 11",
      "instructions": "",
      "status": "To do",
      "submissionDate": null,
      "submissionText": null,
      "submissionLink": null,
      "marksScored": null,
      "feedback": null,
    },
    {
      "id": "ASG-06",
      "title": "Linear regression notebook",
      "course": "OS",
      "faculty": "Faculty Member",
      "totalMarks": 10,
      "dueDate": "Oct 14 · Due Oct 14",
      "instructions": "",
      "status": "To do",
      "submissionDate": null,
      "submissionText": null,
      "submissionLink": null,
      "marksScored": null,
      "feedback": null,
    },
    {
      "id": "ASG-07",
      "title": "Normalization case study",
      "course": "DBMS",
      "faculty": "Faculty Member",
      "totalMarks": 10,
      "dueDate": "Oct 17 · Due Oct 17",
      "instructions": "",
      "status": "To do",
      "submissionDate": null,
      "submissionText": null,
      "submissionLink": null,
      "marksScored": null,
      "feedback": null,
    },
    {
      "id": "ASG-08",
      "title": "Process Scheduling Simulation",
      "course": "OS",
      "faculty": "Faculty Member",
      "totalMarks": 10,
      "dueDate": "Oct 20 · Due Oct 20",
      "instructions": "",
      "status": "To do",
      "submissionDate": null,
      "submissionText": null,
      "submissionLink": null,
      "marksScored": null,
      "feedback": null,
    },
    {
      "id": "ASG-09",
      "title": "Database Indexing Benchmarks",
      "course": "DBMS",
      "faculty": "Faculty Member",
      "totalMarks": 10,
      "dueDate": "Oct 5",
      "instructions": "",
      "status": "Closed · not handed in",
      "submissionDate": null,
      "submissionText": null,
      "submissionLink": null,
      "marksScored": null,
      "feedback": null,
    },
  ];

  void _showHandInModal(Map<String, dynamic> asg) {
    final answerCtrl = TextEditingController(text: asg["submissionText"] ?? "");
    final linkCtrl = TextEditingController(text: asg["submissionLink"] ?? "");
    int charCount = answerCtrl.text.length;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (dialogCtx, setModalState) {
          return Dialog(
            backgroundColor: Colors.white,
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 540),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "Hand in · ${asg["title"]}",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                          onPressed: () => Navigator.pop(ctx),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          splashRadius: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Due ${asg["dueDate"]}. You can replace your work until your teacher marks it.",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF64748B),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Label: Your answer
                    Text(
                      "Your answer",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: answerCtrl,
                      minLines: 5,
                      maxLines: 8,
                      maxLength: 8000,
                      buildCounter: (
                        context, {
                        required currentLength,
                        required isFocused,
                        maxLength,
                      }) =>
                          null, // Custom counter below
                      onChanged: (val) {
                        setModalState(() {
                          charCount = val.length;
                        });
                      },
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF0F172A),
                      ),
                      decoration: InputDecoration(
                        hintText: "Type or paste your answer here",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF94A3B8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.all(14),
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
                          borderSide: const BorderSide(color: Color(0xFF2E3A8C), width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$charCount / 8000",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Label: Link to your work (optional)
                    Text(
                      "Link to your work (optional)",
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: linkCtrl,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: const Color(0xFF0F172A),
                      ),
                      decoration: InputDecoration(
                        hintText: "https://",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 13,
                          color: const Color(0xFF94A3B8),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
                          borderSide: const BorderSide(color: Color(0xFF2E3A8C), width: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "A shared document, repository or video.",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Navigator.pop(ctx),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            final ans = answerCtrl.text.trim();
                            final link = linkCtrl.text.trim();
                            if (ans.isEmpty && link.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please provide your answer or a project link."),
                                  backgroundColor: Color(0xFFDC2626),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }

                            setState(() {
                              asg["status"] = "Submitted";
                              asg["submissionDate"] = "Handed in Nov 5, 11:15 AM";
                              asg["submissionText"] = ans.isNotEmpty ? ans : null;
                              asg["submissionLink"] = link.isNotEmpty ? link : null;
                            });

                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Assignment '${asg["title"]}' handed in successfully!"),
                                backgroundColor: const Color(0xFF15803D),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.send_rounded, size: 14, color: Colors.white),
                          label: Text(
                            "Hand in",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E3A8C),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stat counts
    final todoList = _assignments.where((a) => a["status"] == "To do").toList();
    final handedInList = _assignments
        .where((a) => a["status"] == "Marked" || a["status"] == "Submitted")
        .toList();
    final allList = _assignments;

    // Marked list for grade calculation
    final markedList = _assignments.where((a) => a["status"] == "Marked" && a["marksScored"] != null).toList();
    int totalScored = 0;
    int totalPossible = 0;
    for (final a in markedList) {
      totalScored += (a["marksScored"] as int);
      totalPossible += (a["totalMarks"] as int);
    }
    final int avgPercentage = totalPossible > 0 ? ((totalScored / totalPossible) * 100).round() : 90;

    // Active tab list
    List<Map<String, dynamic>> activeList;
    if (_activeTab == "To do") {
      activeList = todoList;
    } else if (_activeTab == "Handed in") {
      activeList = handedInList;
    } else {
      activeList = allList;
    }

    // Pagination calculations
    final int totalCount = activeList.length;
    final int totalPages = max(1, (totalCount / _perPage).ceil());
    if (_currentPage > totalPages) {
      _currentPage = totalPages;
    }
    final int startIndex = (_currentPage - 1) * _perPage;
    final int endIndex = min(startIndex + _perPage, totalCount);
    final List<Map<String, dynamic>> paginatedList =
        startIndex < totalCount ? activeList.sublist(startIndex, endIndex) : [];

    return PortalPageBody(
      title: "Assignments",
      category: "Academics",
      onBack: widget.onBack,
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Academics  ›  Assignments",
          category: "ACADEMICS",
          phase: "MVP",
          isMvp: true,
          icon: Icons.checklist_rounded,
          title: "Assignments",
          subtitle: "Create, distribute and track assignments and lab submissions.",
          watermarkIcon: Icons.assignment_outlined,
        ),
        const SizedBox(height: 20),

        // 2. Three KPI Metric Cards
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 640;
            if (isWide) {
              return Row(
                children: [
                  Expanded(
                    child: _buildKpiCard(
                      title: "To do",
                      value: "${todoList.length}",
                      valueColor: const Color(0xFF0F172A),
                      subtitle: "Hand in before the deadline",
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildKpiCard(
                      title: "Handed in",
                      value: "${handedInList.length}",
                      valueColor: const Color(0xFF0F766E),
                      subtitle: "${markedList.length} marked",
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildKpiCard(
                      title: "Average so far",
                      value: "$avgPercentage%",
                      valueColor: const Color(0xFFB45309),
                      subtitle: "across ${markedList.length} marked",
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  _buildKpiCard(
                    title: "To do",
                    value: "${todoList.length}",
                    valueColor: const Color(0xFF0F172A),
                    subtitle: "Hand in before the deadline",
                  ),
                  const SizedBox(height: 12),
                  _buildKpiCard(
                    title: "Handed in",
                    value: "${handedInList.length}",
                    valueColor: const Color(0xFF0F766E),
                    subtitle: "${markedList.length} marked",
                  ),
                  const SizedBox(height: 12),
                  _buildKpiCard(
                    title: "Average so far",
                    value: "$avgPercentage%",
                    valueColor: const Color(0xFFB45309),
                    subtitle: "across ${markedList.length} marked",
                  ),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 22),

        // 3. Tab Bar (To do, Handed in, All)
        _buildTabsRow(
          todoCount: todoList.length,
          handedInCount: handedInList.length,
          allCount: allList.length,
        ),
        const Divider(color: Color(0xFFE2E8F0), height: 1, thickness: 1),
        const SizedBox(height: 18),

        // 4. Assignments List
        if (paginatedList.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Center(
              child: Column(
                children: [
                  const Icon(Icons.assignment_turned_in_outlined, size: 44, color: Color(0xFF94A3B8)),
                  const SizedBox(height: 12),
                  Text(
                    "No assignments in this tab",
                    style: GoogleFonts.poppins(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "You're all caught up with your submissions.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: paginatedList.length,
            separatorBuilder: (_, index) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              return _buildAssignmentCard(paginatedList[index]);
            },
          ),

        // 5. Pagination Bar (shown in Image 5)
        const SizedBox(height: 20),
        _buildPaginationBar(
          totalCount: totalCount,
          totalPages: totalPages,
          startIndex: startIndex,
          endIndex: endIndex,
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // KPI Metric Card (Images 1, 3, 4)
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildKpiCard({
    required String title,
    required String value,
    required Color valueColor,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: valueColor,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Tabs Row (Images 1, 3, 4)
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildTabsRow({
    required int todoCount,
    required int handedInCount,
    required int allCount,
  }) {
    final tabs = [
      {"name": "To do", "count": todoCount},
      {"name": "Handed in", "count": handedInCount},
      {"name": "All", "count": allCount},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tabs.map((t) {
          final name = t["name"] as String;
          final count = t["count"] as int;
          final isSelected = _activeTab == name;

          return InkWell(
            onTap: () {
              setState(() {
                _activeTab = name;
                _currentPage = 1;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? const Color(0xFF1E293B) : Colors.transparent,
                    width: 2.2,
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "$count",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Assignment Card
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildAssignmentCard(Map<String, dynamic> asg) {
    final String status = asg["status"] as String;
    final bool isMarked = status == "Marked";
    final bool isSubmitted = status == "Submitted";
    final bool isClosed = status == "Closed · not handed in";
    final bool isTodo = status == "To do";
    final String id = asg["id"] as String;
    final bool isExpanded = _expandedInstructions.contains(id);

    final String instructions = (asg["instructions"] as String?) ?? "";
    final bool hasLongInstructions = instructions.length > 140;

    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Title + badges + [Hand in button on desktop]
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    Text(
                      asg["title"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    // Course tag badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        asg["course"] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2563EB),
                        ),
                      ),
                    ),
                    // Status Badge (Marked, Closed, Submitted)
                    if (isMarked)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Marked",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF059669),
                          ),
                        ),
                      )
                    else if (isClosed)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Closed · not handed in",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFDC2626),
                          ),
                        ),
                      )
                    else if (isSubmitted)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          "Submitted",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2563EB),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Hand in button if "To do"
              if (isTodo) ...[
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () => _showHandInModal(asg),
                  icon: const Icon(Icons.send_rounded, size: 13, color: Colors.white),
                  label: Text(
                    "Hand in",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E3A8C),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 5),

          // Faculty member, marks, and due date meta
          Text(
            "${asg["faculty"]} · ${asg["totalMarks"]} marks · due ${asg["dueDate"]}",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),

          const SizedBox(height: 8),

          // Instructions text (with Read more / Read less toggle if long)
          if (instructions.isEmpty)
            Text(
              "No instructions were added.",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF94A3B8),
              ),
            )
          else ...[
            Text(
              hasLongInstructions && !isExpanded
                  ? "${instructions.substring(0, min(140, instructions.length))}..."
                  : instructions,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                color: const Color(0xFF475569),
                height: 1.5,
              ),
            ),
            if (hasLongInstructions) ...[
              const SizedBox(height: 4),
              InkWell(
                onTap: () {
                  setState(() {
                    if (isExpanded) {
                      _expandedInstructions.remove(id);
                    } else {
                      _expandedInstructions.add(id);
                    }
                  });
                },
                child: Text(
                  isExpanded ? "Read less" : "Read more",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ],

          // ── Submissions box (Marked or Submitted) ─────────────────────────
          if (isMarked || isSubmitted) ...[
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handed in status row
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        size: 16,
                        color: Color(0xFF059669),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        asg["submissionDate"] as String? ?? "Handed in",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),

                  // Submitted answer text
                  if (asg["submissionText"] != null && (asg["submissionText"] as String).isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      asg["submissionText"] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        color: const Color(0xFF334155),
                        height: 1.5,
                      ),
                    ),
                  ],

                  // Submitted link
                  if (asg["submissionLink"] != null && (asg["submissionLink"] as String).isNotEmpty) ...[
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Opening ${asg["submissionLink"]}..."),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.open_in_new_rounded, size: 14, color: Color(0xFF2563EB)),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              asg["submissionLink"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFF2563EB),
                                decoration: TextDecoration.underline,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Marks and feedback (if marked)
                  if (isMarked && asg["marksScored"] != null) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Divider(color: Color(0xFFE2E8F0), height: 1, thickness: 1),
                    ),
                    Row(
                      children: [
                        Text(
                          "Your marks: ",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          "${asg["marksScored"]} / ${asg["totalMarks"]}",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    if (asg["feedback"] != null && (asg["feedback"] as String).isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        "\"${asg["feedback"]}\"",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Pagination Bar (Image 5)
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildPaginationBar({
    required int totalCount,
    required int totalPages,
    required int startIndex,
    required int endIndex,
  }) {
    final int displayStart = totalCount == 0 ? 0 : startIndex + 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 640;

        final infoWidget = Text(
          "Showing $displayStart–$endIndex of $totalCount assignments",
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            color: const Color(0xFF64748B),
          ),
        );

        final perPageDropdown = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Per page: ",
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B)),
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFCBD5E1)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: _perPage,
                  isDense: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: Color(0xFF64748B)),
                  items: [5, 10, 20].map((v) {
                    return DropdownMenuItem<int>(
                      value: v,
                      child: Text(
                        "$v",
                        style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    if (newVal != null) {
                      setState(() {
                        _perPage = newVal;
                        _currentPage = 1;
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        );

        final paginationControls = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Page $_currentPage of $totalPages",
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B)),
            ),
            const SizedBox(width: 10),
            OutlinedButton(
              onPressed: _currentPage > 1
                  ? () {
                      setState(() {
                        _currentPage--;
                      });
                    }
                  : null,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: _currentPage > 1 ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                minimumSize: Size.zero,
              ),
              child: Text(
                "< Prev",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _currentPage > 1 ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
                ),
              ),
            ),
            const SizedBox(width: 6),
            OutlinedButton(
              onPressed: _currentPage < totalPages
                  ? () {
                      setState(() {
                        _currentPage++;
                      });
                    }
                  : null,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: _currentPage < totalPages ? const Color(0xFFCBD5E1) : const Color(0xFFE2E8F0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                minimumSize: Size.zero,
              ),
              child: Text(
                "Next >",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: _currentPage < totalPages ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
                ),
              ),
            ),
          ],
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  infoWidget,
                  perPageDropdown,
                ],
              ),
              const SizedBox(height: 12),
              paginationControls,
            ],
          );
        }

        return Row(
          children: [
            infoWidget,
            const SizedBox(width: 16),
            perPageDropdown,
            const Spacer(),
            paginationControls,
          ],
        );
      },
    );
  }
}
