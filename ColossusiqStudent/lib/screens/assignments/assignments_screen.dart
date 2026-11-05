import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../data/models/placement_model.dart';

class AssignmentsScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const AssignmentsScreen({super.key, this.onBack});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  String _activeTab = "To do"; // "To do", "Handed in", "All"

  void _showSubmitModal(BuildContext context, AssignmentItem asg) {
    PlatformFile? selectedFile;
    int selectedFileSize = 0;
    bool isPicking = false;
    String? uploadError;

    String formatFileSize(int bytes) {
      if (bytes < 1024) return "$bytes B";
      if (bytes < 1024 * 1024) return "${(bytes / 1024).toStringAsFixed(1)} KB";
      return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (sheetCtx, setModalState) {
          Future<void> pickRealFile() async {
            try {
              setModalState(() {
                isPicking = true;
                uploadError = null;
              });

              final PlatformFile? file = await FilePicker.pickFile(
                type: FileType.custom,
                allowedExtensions: ['pdf', 'zip', 'docx', 'doc'],
              );

              if (file != null) {
                final size = file.lengthSync() ?? (await file.length()) ?? 0;
                // 200MB size limit check (200 * 1024 * 1024 bytes)
                if (size > 200 * 1024 * 1024) {
                  setModalState(() {
                    uploadError = "File exceeds 200MB limit (${formatFileSize(size)}). Please choose a smaller file.";
                    isPicking = false;
                  });
                } else {
                  setModalState(() {
                    selectedFile = file;
                    selectedFileSize = size;
                    uploadError = null;
                    isPicking = false;
                  });
                }
              } else {
                setModalState(() {
                  isPicking = false;
                });
              }
            } catch (e) {
              setModalState(() {
                uploadError = "Failed to select file: $e";
                isPicking = false;
              });
            }
          }

          final isPdf = selectedFile?.extension?.toLowerCase() == 'pdf';

          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 16,
              bottom: MediaQuery.of(sheetCtx).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCBD5E1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E3A94).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.upload_file_rounded, color: Color(0xFF2E3A94), size: 22),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Submit Assignment",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF94A3B8)),
                      onPressed: () => Navigator.pop(sheetCtx),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  asg.title,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ink2,
                  ),
                ),
                const SizedBox(height: 14),

                // Upload container or selected file info
                if (selectedFile == null)
                  InkWell(
                    onTap: isPicking ? null : pickRealFile,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: uploadError != null ? const Color(0xFFEF4444) : AppColors.line,
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: isPicking
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    width: 28,
                                    height: 28,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation(Color(0xFF2E3A94)),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Opening mobile file picker...",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.ink2,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2E3A94).withValues(alpha: 0.08),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.cloud_upload_outlined,
                                      size: 32,
                                      color: Color(0xFF2E3A94),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Upload PDF, ZIP or DOCX",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.ink,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    "Tap to choose real file from mobile (Max 200MB)",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.ink3,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFF86EFAC), width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: isPdf ? const Color(0xFFFEE2E2) : const Color(0xFFDBEAFE),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            isPdf ? Icons.picture_as_pdf_rounded : Icons.insert_drive_file_rounded,
                            color: isPdf ? const Color(0xFFDC2626) : const Color(0xFF2563EB),
                            size: 26,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedFile!.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    formatFileSize(selectedFileSize),
                                    style: GoogleFonts.jetBrainsMono(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF475569),
                                    ),
                                  ),
                                  const Text(" · ", style: TextStyle(color: Color(0xFF94A3B8))),
                                  Text(
                                    "Ready to hand in",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF16A34A),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: "Remove file",
                          icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFF64748B)),
                          onPressed: () {
                            setModalState(() {
                              selectedFile = null;
                              uploadError = null;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                if (uploadError != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFECACA)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline_rounded, color: Color(0xFFDC2626), size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            uploadError!,
                            style: GoogleFonts.poppins(
                              fontSize: 11.5,
                              color: const Color(0xFFB91C1C),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (selectedFile == null) {
                        setModalState(() {
                          uploadError = "Please tap above to choose a PDF or document first.";
                        });
                        pickRealFile();
                        return;
                      }

                      final fileName = selectedFile!.name;
                      final fileSize = selectedFileSize;

                      final index = MockData.assignments.indexWhere((a) => a.id == asg.id);
                      if (index != -1) {
                        MockData.assignments[index] = asg.copyWith(
                          status: "Submitted",
                          submittedCount: asg.submittedCount + 1,
                          submittedFileName: fileName,
                          submittedFileSize: fileSize,
                        );
                      }

                      setState(() {});
                      Navigator.pop(sheetCtx);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Handed in '$fileName' for '${asg.title}'!",
                                  style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: const Color(0xFF059669),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                    icon: const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 18),
                    label: Text(
                      selectedFile == null ? "Select File & Hand In" : "Confirm & Hand In",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E3A94),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAssignmentDetailsDialog(BuildContext context, AssignmentItem asg) {
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
              child: const Icon(Icons.assignment_outlined, color: Color(0xFF2563EB), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(asg.title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700)),
                  Text(asg.course, style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B))),
                ],
              ),
            ),
          ],
        ),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Status", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text(asg.status, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A))),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("Marks", style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B))),
                          const SizedBox(height: 2),
                          Text(asg.score != null ? "${asg.score}/${asg.totalMarks}" : "Max ${asg.totalMarks}",
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF059669))),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    const Icon(Icons.event_outlined, size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 6),
                    Text("Due Date: ${asg.dueDate}", style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155), fontWeight: FontWeight.w500)),
                  ],
                ),
                if (asg.submittedFileName != null) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.attach_file_rounded, size: 16, color: Color(0xFF2563EB)),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text("Attached: ${asg.submittedFileName}",
                            style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF2563EB), fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                const Divider(height: 1, color: Color(0xFFE2E8F0)),
                const SizedBox(height: 12),
                Text("Instructions & Submission Rubric", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF94A3B8))),
                const SizedBox(height: 4),
                Text(
                  "Submit source code, design architecture diagram, and analytical report. Plagiarism above 15% will lead to mark deduction.",
                  style: GoogleFonts.poppins(fontSize: 12.5, height: 1.45, color: const Color(0xFF475569)),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Close", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(ctx);
              _showEditAssignmentDialog(context, asg);
            },
            icon: const Icon(Icons.edit_outlined, size: 14),
            label: const Text("Edit"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF141938),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditAssignmentDialog(BuildContext context, AssignmentItem asg) {
    final titleCtrl = TextEditingController(text: asg.title);
    final courseCtrl = TextEditingController(text: asg.course);
    final dueCtrl = TextEditingController(text: asg.dueDate);
    final marksCtrl = TextEditingController(text: asg.totalMarks.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Edit Assignment Info", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxWidth: 440),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: "Assignment Title", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: courseCtrl,
                  decoration: const InputDecoration(labelText: "Course / Subject", border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: dueCtrl,
                        decoration: const InputDecoration(labelText: "Due Date", border: OutlineInputBorder()),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: marksCtrl,
                        decoration: const InputDecoration(labelText: "Max Marks", border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text("Cancel", style: GoogleFonts.poppins(color: const Color(0xFF64748B))),
          ),
          ElevatedButton(
            onPressed: () {
              final newMarks = int.tryParse(marksCtrl.text.trim()) ?? asg.totalMarks;
              final idx = MockData.assignments.indexOf(asg);
              if (idx != -1) {
                final updated = asg.copyWith(
                  title: titleCtrl.text.trim(),
                  course: courseCtrl.text.trim(),
                  dueDate: dueCtrl.text.trim(),
                  totalMarks: newMarks,
                );
                MockData.assignments[idx] = updated;
                setState(() {});
              }
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Assignment '${titleCtrl.text}' updated!"),
                  backgroundColor: const Color(0xFF15803D),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF141938),
              foregroundColor: Colors.white,
            ),
            child: Text("Save Changes", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = MockData.assignments;
    final todoList = list.where((a) => a.status != "Graded" && a.status != "Submitted").toList();
    final handedInList = list.where((a) => a.status == "Graded" || a.status == "Submitted").toList();

    List<AssignmentItem> currentList;
    if (_activeTab == "To do") {
      currentList = todoList;
    } else if (_activeTab == "Handed in") {
      currentList = handedInList;
    } else {
      currentList = list;
    }

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

                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth >= 640) {
                            return Row(
                              children: [
                                Expanded(
                                  child: _kpiCard(
                                    title: "To do",
                                    value: "${todoList.length}",
                                    subtitle: todoList.isEmpty
                                        ? "You are all caught up"
                                        : "${todoList.length} pending",
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: _kpiCard(
                                    title: "Handed in",
                                    value: "${handedInList.length}",
                                    subtitle: "${handedInList.length} marked",
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: _kpiCard(
                                    title: "Average so far",
                                    value: handedInList.isEmpty ? "—" : "88%",
                                    subtitle: handedInList.isEmpty
                                        ? "Nothing marked yet"
                                        : "Average grade",
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _kpiCard(
                                  title: "To do",
                                  value: "${todoList.length}",
                                  subtitle: todoList.isEmpty
                                      ? "You are all caught up"
                                      : "${todoList.length} pending",
                                ),
                                const SizedBox(height: 12),
                                _kpiCard(
                                  title: "Handed in",
                                  value: "${handedInList.length}",
                                  subtitle: "${handedInList.length} marked",
                                ),
                                const SizedBox(height: 12),
                                _kpiCard(
                                  title: "Average so far",
                                  value: handedInList.isEmpty ? "—" : "88%",
                                  subtitle: handedInList.isEmpty
                                      ? "Nothing marked yet"
                                      : "Average grade",
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 24),

                      // Tabs row
                      _buildTabsRow(
                        todoCount: todoList.length,
                        handedInCount: handedInList.length,
                        allCount: list.length,
                      ),
                      const Divider(color: Color(0xFFE5E7EB), height: 1),
                      const SizedBox(height: 20),

                      // Content list or empty state
                      if (currentList.isEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 48),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.checklist_rounded,
                                  size: 48,
                                  color: Color(0xFF94A3B8),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "No assignments to show",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "You are completely up to date with your coursework.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
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
                          itemCount: currentList.length,
                          separatorBuilder: (_, index) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            final asg = currentList[index];
                            final isGraded = asg.status == "Graded";
                            final isSubmitted = asg.status == "Submitted";

                            Color badgeBg = const Color(0xFFFEF3C7);
                            Color badgeTextColor = const Color(0xFFD97706);
                            if (isGraded) {
                              badgeBg = const Color(0xFFECFDF5);
                              badgeTextColor = const Color(0xFF059669);
                            } else if (isSubmitted) {
                              badgeBg = const Color(0xFFEFF6FF);
                              badgeTextColor = const Color(0xFF2563EB);
                            }

                            return Container(
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: const Color(0xFFE5E7EB)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.02),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3.5),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEFF6FF),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          asg.course,
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF2563EB),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 3.5),
                                        decoration: BoxDecoration(
                                          color: badgeBg,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          asg.status,
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: badgeTextColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    asg.title,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF1E293B),
                                    ),
                                  ),
                                  if (asg.submittedFileName != null) ...[
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: const Color(0xFFE2E8F0)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.picture_as_pdf_rounded, size: 15, color: Color(0xFFDC2626)),
                                          const SizedBox(width: 6),
                                          Flexible(
                                            child: Text(
                                              asg.submittedFileName!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.jetBrainsMono(
                                                fontSize: 11.5,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF334155),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      OutlinedButton.icon(
                                        onPressed: () => _showAssignmentDetailsDialog(context, asg),
                                        icon: const Icon(Icons.visibility_outlined, size: 13),
                                        label: const Text("View Details"),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          minimumSize: Size.zero,
                                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                                          foregroundColor: const Color(0xFF0F766E),
                                          textStyle: GoogleFonts.poppins(fontSize: 11),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      OutlinedButton.icon(
                                        onPressed: () => _showEditAssignmentDialog(context, asg),
                                        icon: const Icon(Icons.edit_outlined, size: 13),
                                        label: const Text("Edit"),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          minimumSize: Size.zero,
                                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                                          foregroundColor: const Color(0xFF4338CA),
                                          textStyle: GoogleFonts.poppins(fontSize: 11),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.event_outlined,
                                          size: 14, color: Color(0xFF64748B)),
                                      const SizedBox(width: 4),
                                      Text(
                                        "Due: ${asg.dueDate}",
                                        style: GoogleFonts.jetBrainsMono(
                                          fontSize: 11.5,
                                          color: const Color(0xFF64748B),
                                        ),
                                      ),
                                      const Spacer(),
                                      if (!isGraded && !isSubmitted)
                                        ElevatedButton(
                                          onPressed: () =>
                                              _showSubmitModal(context, asg),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF2E3A94),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 8),
                                          ),
                                          child: Text(
                                            "Submit →",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      else if (isSubmitted)
                                        OutlinedButton.icon(
                                          onPressed: () =>
                                              _showSubmitModal(context, asg),
                                          icon: const Icon(Icons.check_circle_rounded, size: 14, color: Color(0xFF16A34A)),
                                          label: Text(
                                            "Resubmit",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF2E3A94),
                                            ),
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(color: Color(0xFFCBD5E1)),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          ),
                                        )
                                      else if (isGraded)
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFECFDF5),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            "${asg.score ?? 0}/${asg.totalMarks} Marks",
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF059669),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
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
            Positioned.fill(
              child: CustomPaint(
                painter: _AssignmentsGridPainter(),
              ),
            ),
            Positioned(
              right: -10,
              bottom: -20,
              child: Icon(
                Icons.assignment_rounded,
                size: isMobile ? 110 : 155,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 28,
                vertical: isMobile ? 18 : 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          "Academics",
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
                          "Assignments",
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                            Icons.assignment_rounded,
                            size: isMobile ? 22 : 26,
                            color: const Color(0xFFFBBF24),
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
                                      horizontal: 7, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.14),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "ACADEMICS",
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
                                    color: const Color(0xFF059669),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "MVP",
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
                              "Assignments",
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 21 : 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Create, distribute and track assignments and lab submissions.",
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

  Widget _kpiCard({
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E286D),
            ),
          ),
          const SizedBox(height: 4),
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

  Widget _buildTabsRow({
    required int todoCount,
    required int handedInCount,
    required int allCount,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _tabItem("To do", "To do $todoCount"),
          const SizedBox(width: 24),
          _tabItem("Handed in", "Handed in $handedInCount"),
          const SizedBox(width: 24),
          _tabItem("All", "All $allCount"),
        ],
      ),
    );
  }

  Widget _tabItem(String key, String label) {
    final isSelected = _activeTab == key;

    return InkWell(
      onTap: () => setState(() => _activeTab = key),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xFF1E286D) : Colors.transparent,
              width: 2.5,
            ),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected
                ? const Color(0xFF1E286D)
                : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }
}

class _AssignmentsGridPainter extends CustomPainter {
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
