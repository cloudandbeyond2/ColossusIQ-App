import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
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
  int _selectedSubTab =
      0; // 0: Documents, 1: Ask the knowledge base, 2: Index & AI
  String _selectedType = "All types";
  String _selectedStatus = "All statuses";
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _askController = TextEditingController();
  String? _lastQuestion;
  List<_KnowledgeDocument> _answerSources = [];

  final List<_KnowledgeDocument> _documents = [
    _KnowledgeDocument(
      id: 'KB-1009',
      title:
          'Anna Institute of Technology - Campus Directory & Emergency Services',
      type: 'Circular',
      office: 'Administrative Office',
      added: '6 Nov 2026',
      passages: 2,
      status: 'Archived',
      needsReindex: true,
      content:
          'The campus directory lists administrative contacts and emergency services. For campus emergencies, contact the security office or the central administration desk.',
    ),
    _KnowledgeDocument(
      id: 'KB-1008',
      title:
          'Anna Institute of Technology - Student Code of Conduct & Lab Guidelines',
      type: 'Handbook',
      office: 'Dean of Students',
      added: '6 Nov 2026',
      passages: 3,
      status: 'Approved',
      needsReindex: true,
      content:
          'Students must follow the code of conduct, wear required protective equipment in laboratories, and use equipment only with faculty supervision. Academic integrity is required in all coursework.',
    ),
    _KnowledgeDocument(
      id: 'KB-1007',
      title:
          'Anna Institute of Technology - Faculty Leave, Workload & Duty Policy',
      type: 'Policy',
      office: "Principal's Office",
      added: '6 Nov 2026',
      passages: 4,
      status: 'Approved',
      needsReindex: true,
      content:
          'Faculty leave requests must be submitted to the department head in advance. Teaching workload and duty assignments are approved by the Principal’s Office and recorded by the department.',
    ),
    _KnowledgeDocument(
      id: 'KB-1006',
      title: 'Anna Institute of Technology - Academic Regulations 2026',
      type: 'Regulation',
      office: 'Registrar',
      added: '6 Nov 2026',
      passages: 5,
      status: 'Approved',
      needsReindex: true,
      content:
          'Students must maintain at least 75% attendance to be eligible for end-semester examinations. Internal assessment marks are published before the examination period. Students may apply for an approved condonation under university rules.',
    ),
    _KnowledgeDocument(
      id: 'KB-1005',
      title: 'Hostel Rules (draft)',
      type: 'Handbook',
      office: 'Dean of Students',
      added: '5 Nov 2026',
      passages: 2,
      status: 'Approved',
      semantic: true,
      content:
          'Hostel residents must observe the published curfew, register overnight leave with the warden, and follow visitor and safety procedures.',
    ),
    _KnowledgeDocument(
      id: 'KB-1004',
      title: 'Student Code of Conduct',
      type: 'Handbook',
      office: 'Dean of Students',
      added: '5 Nov 2026',
      passages: 4,
      status: 'Approved',
      needsReindex: true,
      content:
          'Students are expected to maintain respectful conduct, avoid plagiarism, and comply with campus policies. Report safety concerns to the Dean of Students.',
    ),
    _KnowledgeDocument(
      id: 'KB-1003',
      title: 'Faculty Leave and Duty Policy',
      type: 'Policy',
      office: "Principal's Office",
      added: '4 Nov 2026',
      passages: 5,
      status: 'Approved',
      needsReindex: true,
      content:
          'Leave and duty changes require approval from the department head. Faculty should arrange class coverage and update the official attendance register.',
    ),
    _KnowledgeDocument(
      id: 'KB-1002',
      title: 'Examination Fee Circular 2026-27',
      type: 'Circular',
      office: 'Registrar',
      added: '3 Nov 2026',
      passages: 4,
      status: 'Approved',
      needsReindex: true,
      content:
          'Examination fees must be paid by the due date in the academic calendar. Late fee requests should be submitted to the Registrar with supporting documents.',
    ),
    _KnowledgeDocument(
      id: 'KB-1001',
      title: 'Academic Calendar 2026-27',
      type: 'Regulation',
      office: 'Registrar',
      added: '2 Nov 2026',
      passages: 7,
      status: 'Approved',
      semantic: true,
      content:
          'The academic calendar lists teaching weeks, holidays, assessment dates, and end-semester examination periods for the 2026-27 academic year.',
    ),
  ];

  int get _approvedDocumentCount =>
      _documents.where((document) => document.status == 'Approved').length;

  int get _passageCount =>
      _documents.fold(0, (total, document) => total + document.passages);

  int get _semanticDocumentCount =>
      _documents.where((document) => document.semantic).length;

  int get _documentsNeedingReindex =>
      _documents.where((document) => document.needsReindex).length;

  List<_KnowledgeDocument> get _filteredDocuments {
    final query = _searchController.text.trim().toLowerCase();
    return _documents.where((document) {
      final matchesQuery =
          query.isEmpty ||
          '${document.title} ${document.office} ${document.type} ${document.id} ${document.description} ${document.fileName ?? ''}'
              .toLowerCase()
              .contains(query);
      final matchesType =
          _selectedType == 'All types' || document.type == _selectedType;
      final matchesStatus =
          _selectedStatus == 'All statuses' ||
          document.status == _selectedStatus;
      return matchesQuery && matchesType && matchesStatus;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _askController.dispose();
    super.dispose();
  }

  Future<void> _showUploadDialog() async {
    final titleController = TextEditingController();
    final officeController = TextEditingController(text: 'Registrar');
    final descriptionController = TextEditingController();
    final contentController = TextEditingController();
    var type = 'Policy';
    var audience = 'Institution-wide';
    var passageSize = '512 tokens';
    var approveNow = true;
    var errorMessage = '';
    PlatformFile? selectedFile;

    Future<void> pickDocument(
      BuildContext dialogContext,
      StateSetter setDialogState,
    ) async {
      try {
        final file = await FilePicker.pickFile(
          type: FileType.custom,
          allowedExtensions: const ['pdf', 'txt', 'md', 'csv'],
        );
        if (file == null) return;
        final fileSize = await file.length();
        if (fileSize != null && fileSize > 5 * 1024 * 1024) {
          setDialogState(
            () => errorMessage = 'Select a file no larger than 5 MB.',
          );
          return;
        }
        selectedFile = file;
        if (titleController.text.trim().isEmpty) {
          titleController.text = file.name.replaceFirst(
            RegExp(r'\.[^.]+$'),
            '',
          );
        }
        final extension = file.extension?.toLowerCase();
        if (const {'txt', 'md', 'csv'}.contains(extension)) {
          final bytes = await file.readAsBytes();
          contentController.text = utf8.decode(bytes, allowMalformed: true);
        }
        setDialogState(() => errorMessage = '');
      } catch (error) {
        setDialogState(
          () => errorMessage = 'Could not open the selected file: $error',
        );
      }
    }

    final newDocument = await showDialog<_KnowledgeDocument>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          titlePadding: const EdgeInsets.fromLTRB(20, 18, 18, 8),
          contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 4),
          actionsPadding: const EdgeInsets.fromLTRB(16, 8, 18, 14),
          title: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upload a document',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF172033),
                      ),
                    ),
                    Text(
                      'It is split into passages and indexed so answers can cite it.',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Close',
                onPressed: () => Navigator.pop(dialogContext),
                icon: const Icon(Icons.close, size: 18),
              ),
            ],
          ),
          content: SizedBox(
            width: 540,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _formLabel('Title'),
                  _knowledgeTextField(
                    controller: titleController,
                    hint: 'e.g. Regulations 2026 – B.E./B.Tech',
                  ),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final narrow = constraints.maxWidth < 430;
                      final typeField = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _formLabel('Type'),
                          _knowledgeDropdown(
                            value: type,
                            options: const [
                              'Policy',
                              'Regulation',
                              'Handbook',
                              'Circular',
                              'Curriculum',
                            ],
                            onChanged: (value) =>
                                setDialogState(() => type = value),
                          ),
                        ],
                      );
                      final officeField = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _formLabel('Issuing office'),
                          _knowledgeTextField(
                            controller: officeController,
                            hint: 'Registrar',
                          ),
                        ],
                      );
                      if (narrow) {
                        return Column(
                          children: [
                            typeField,
                            const SizedBox(height: 10),
                            officeField,
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: typeField),
                          const SizedBox(width: 12),
                          Expanded(child: officeField),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final narrow = constraints.maxWidth < 430;
                      final audienceField = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _formLabel('Audience'),
                          _knowledgeDropdown(
                            value: audience,
                            options: const [
                              'Institution-wide',
                              'Students',
                              'Faculty',
                              'Staff',
                            ],
                            onChanged: (value) =>
                                setDialogState(() => audience = value),
                          ),
                        ],
                      );
                      final sizeField = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _formLabel('Passage size'),
                          _knowledgeDropdown(
                            value: passageSize,
                            options: const [
                              '256 tokens',
                              '512 tokens',
                              '1024 tokens',
                            ],
                            onChanged: (value) =>
                                setDialogState(() => passageSize = value),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Smaller passages answer precisely; larger ones keep more context.',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              height: 1.3,
                              color: const Color(0xFF778399),
                            ),
                          ),
                        ],
                      );
                      if (narrow) {
                        return Column(
                          children: [
                            audienceField,
                            const SizedBox(height: 10),
                            sizeField,
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: audienceField),
                          const SizedBox(width: 12),
                          Expanded(child: sizeField),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _formLabel('Description (optional)'),
                  _knowledgeTextField(
                    controller: descriptionController,
                    hint: '',
                  ),
                  const SizedBox(height: 12),
                  _formLabel('File'),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () =>
                            pickDocument(dialogContext, setDialogState),
                        icon: const Icon(Icons.upload_file, size: 16),
                        label: const Text('Choose file'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          selectedFile?.name ?? 'No file chosen',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: const Color(0xFF6D7A90),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'PDF, .txt, .md or .csv, up to 5 MB. Scanned PDFs require OCR.',
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: const Color(0xFF778399),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _formLabel('...or paste the text'),
                  _knowledgeTextField(
                    controller: contentController,
                    hint:
                        'Paste the document text here. Headings keep passages organised.',
                    maxLines: 5,
                  ),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                    value: approveNow,
                    onChanged: (value) =>
                        setDialogState(() => approveNow = value ?? false),
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      'Approve now. Approved documents are used to answer questions; leave unchecked to review it first.',
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        color: const Color(0xFF66738A),
                        height: 1.35,
                      ),
                    ),
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        errorMessage,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFFB91C1C),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                final text = contentController.text.trim();
                final title = titleController.text.trim();
                if (title.isEmpty) {
                  setDialogState(
                    () => errorMessage = 'Enter a document title.',
                  );
                  return;
                }
                if (text.isEmpty) {
                  setDialogState(
                    () => errorMessage = selectedFile?.extension == 'pdf'
                        ? 'PDF text extraction is not configured. Paste extracted text to index this file.'
                        : 'Choose a text file or paste document text before indexing.',
                  );
                  return;
                }
                final tokensPerPassage = int.parse(
                  passageSize.split(' ').first,
                );
                final charsPerPassage = tokensPerPassage * 4;
                final passages = (text.length / charsPerPassage).ceil().clamp(
                  1,
                  999,
                );
                Navigator.pop(
                  dialogContext,
                  _KnowledgeDocument(
                    id: 'KB-${1000 + _documents.length + 1}',
                    title: title,
                    type: type,
                    office: officeController.text.trim().isEmpty
                        ? 'Institution'
                        : officeController.text.trim(),
                    added: _todayLabel(),
                    passages: passages,
                    status: approveNow ? 'Approved' : 'Pending',
                    content: text,
                    fileName: selectedFile?.name,
                    description: descriptionController.text.trim(),
                    audience: audience,
                    passageSize: passageSize,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF27347E),
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.upload_file, size: 15),
              label: const Text('Upload & index'),
            ),
          ],
        ),
      ),
    );

    titleController.dispose();
    officeController.dispose();
    descriptionController.dispose();
    contentController.dispose();
    if (newDocument == null || !mounted) return;
    setState(() {
      _documents.insert(0, newDocument);
      _selectedSubTab = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          newDocument.status == 'Approved'
              ? 'Document uploaded, indexed, and approved.'
              : 'Document uploaded and queued for review.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _formLabel(String label) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF202A3A),
      ),
    ),
  );

  Widget _knowledgeTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF253247)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
          fontSize: 11.5,
          color: const Color(0xFF8A96A9),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: Color(0xFFE2DDD2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: Color(0xFFE2DDD2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: Color(0xFF27347E)),
        ),
      ),
    );
  }

  Widget _knowledgeDropdown({
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: Color(0xFFE2DDD2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(color: Color(0xFFE2DDD2)),
        ),
      ),
      items: options
          .map(
            (option) => DropdownMenuItem(
              value: option,
              child: Text(
                option,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(fontSize: 11.5),
              ),
            ),
          )
          .toList(),
      onChanged: (next) {
        if (next != null) onChanged(next);
      },
    );
  }

  String _todayLabel() {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final today = DateTime.now();
    return '${today.day} ${months[today.month - 1]} ${today.year}';
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
              child: CustomPaint(painter: _BlueprintGridPainter()),
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
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 14,
                            color: Color(0xFF94A3B8),
                          ),
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
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 14,
                            color: Color(0xFF94A3B8),
                          ),
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
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
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
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
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
        "value": _documents.length.toString(),
        "subtitle":
            "${_documents.map((document) => document.type).toSet().length} categories · $_approvedDocumentCount approved",
        "icon": Icons.description_outlined,
        "iconBg": const Color(0xFFEEF2FF),
        "iconColor": const Color(0xFF4F46E5),
      },
      {
        "title": "INDEXED PASSAGES",
        "value": _passageCount.toString(),
        "subtitle": "$_semanticDocumentCount searchable by meaning",
        "icon": Icons.layers_outlined,
        "iconBg": const Color(0xFFF0FDF4),
        "iconColor": const Color(0xFF0284C7),
      },
      {
        "title": "GROUNDING",
        "value": "$_approvedDocumentCount/${_documents.length}",
        "subtitle": "Approved documents reviewed",
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
    final isCompact = maxWidth < 360;
    final subTabs = [
      {
        "icon": Icons.folder_outlined,
        "title": "Documents",
        "badge": _documents.length.toString(),
      },
      {"icon": Icons.auto_awesome_outlined, "title": "Ask the knowledge base"},
      {"icon": Icons.layers_outlined, "title": "Index & AI"},
    ];

    final tabsList = Wrap(
      spacing: isCompact ? 6 : 8,
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
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 8 : 10,
              vertical: 8,
            ),
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
                SizedBox(width: isCompact ? 5 : 6),
                Text(
                  t["title"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: isCompact ? 11 : 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
                if (t["badge"] != null) ...[
                  SizedBox(width: isCompact ? 4 : 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 1.5,
                    ),
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
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF64748B),
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
          onPressed: _exportDocuments,
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
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
      children: [tabsList, const SizedBox(height: 12), actionButtons],
    );
  }

  // ===========================================================================
  // 4A. TAB 1: DOCUMENTS
  // ===========================================================================
  Widget _buildDocumentsTab(double maxWidth) {
    final documents = _filteredDocuments;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: LayoutBuilder(
            builder: (context, box) {
              final searchInput = Container(
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF1E293B),
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 18,
                      color: Color(0xFF94A3B8),
                    ),
                    hintText: 'Search by title, office, type or file name',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF94A3B8),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 9),
                  ),
                ),
              );
              final filters = Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _filterDropdown(
                    value: _selectedType,
                    options: const [
                      'All types',
                      'Circular',
                      'Handbook',
                      'Policy',
                      'Regulation',
                      'Curriculum',
                    ],
                    onChanged: (value) => setState(() => _selectedType = value),
                  ),
                  _filterDropdown(
                    value: _selectedStatus,
                    options: const [
                      'All statuses',
                      'Approved',
                      'Archived',
                      'Pending',
                      'Draft',
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedStatus = value),
                  ),
                ],
              );
              if (box.maxWidth < 760) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [searchInput, const SizedBox(height: 10), filters],
                );
              }
              return Row(
                children: [
                  Expanded(child: searchInput),
                  const SizedBox(width: 12),
                  filters,
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        if (documents.isEmpty)
          _emptyDocumentsState()
        else
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: const WidgetStatePropertyAll(
                    Color(0xFFFAF9F6),
                  ),
                  headingRowHeight: 40,
                  dataRowMinHeight: 64,
                  dataRowMaxHeight: 80,
                  horizontalMargin: 14,
                  columnSpacing: 22,
                  columns: const [
                    DataColumn(label: Text('DOCUMENT')),
                    DataColumn(label: Text('TYPE')),
                    DataColumn(label: Text('OFFICE')),
                    DataColumn(label: Text('ADDED')),
                    DataColumn(label: Text('PASSAGES')),
                    DataColumn(label: Text('STATUS')),
                    DataColumn(label: Text('ACTIONS')),
                  ],
                  rows: documents.map((document) {
                    return DataRow(
                      cells: [
                        DataCell(
                          SizedBox(
                            width: 360,
                            child: Row(
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F1EA),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: const Icon(
                                    Icons.description_outlined,
                                    size: 15,
                                    color: Color(0xFF66738A),
                                  ),
                                ),
                                const SizedBox(width: 9),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        document.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF263247),
                                        ),
                                      ),
                                      Text(
                                        document.description.isEmpty
                                            ? 'Official institutional document'
                                            : document.description,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: 9.5,
                                          color: const Color(0xFF8693A6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataCell(_typeBadge(document.type)),
                        DataCell(
                          Text(
                            document.office,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF5F6F84),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            document.added,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: const Color(0xFF718096),
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            '${document.passages}',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF263247),
                            ),
                          ),
                        ),
                        DataCell(_statusBadge(document.status)),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (document.status == 'Archived')
                                OutlinedButton.icon(
                                  onPressed: () =>
                                      _setDocumentStatus(document, 'Approved'),
                                  icon: const Icon(
                                    Icons.check_circle_outline,
                                    size: 14,
                                  ),
                                  label: const Text('Approve'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF29336D),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 7,
                                    ),
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    side: const BorderSide(
                                      color: Color(0xFFE4DFD4),
                                    ),
                                  ),
                                )
                              else
                                TextButton(
                                  onPressed: () =>
                                      _setDocumentStatus(document, 'Archived'),
                                  child: Text(
                                    document.status == 'Approved'
                                        ? 'Archive'
                                        : 'Approve',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10.5,
                                      color: const Color(0xFF4A5870),
                                    ),
                                  ),
                                ),
                              IconButton(
                                tooltip: 'Delete document',
                                onPressed: () => _confirmDelete(document),
                                icon: const Icon(
                                  Icons.delete_outline,
                                  size: 17,
                                  color: Color(0xFFDC2626),
                                ),
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
          ),
      ],
    );
  }

  Widget _filterDropdown({
    required String value,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2DDD2)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 16,
            color: Color(0xFF64748B),
          ),
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1E293B),
          ),
          items: options
              .map(
                (option) =>
                    DropdownMenuItem(value: option, child: Text(option)),
              )
              .toList(),
          onChanged: (next) {
            if (next != null) onChanged(next);
          },
        ),
      ),
    );
  }

  Widget _typeBadge(String type) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFE9ECF7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        type,
        style: GoogleFonts.poppins(
          fontSize: 9.5,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF34436F),
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    final approved = status == 'Approved';
    final color = approved
        ? const Color(0xFF0D9488)
        : status == 'Archived'
        ? const Color(0xFF667085)
        : const Color(0xFFD97706);
    final background = approved
        ? const Color(0xFFDDF4F0)
        : status == 'Archived'
        ? const Color(0xFFF2F0EA)
        : const Color(0xFFFFF2D8);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          fontSize: 9.5,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  Widget _emptyDocumentsState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Text(
            _documents.isEmpty ? 'No documents yet' : 'No matching documents',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF172033),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _documents.isEmpty
                ? 'Upload an institutional document to add it to the knowledge base.'
                : 'Try a different search term or update the filters.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF718096),
            ),
          ),
          if (_documents.isEmpty) ...[
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: _showUploadDialog,
              icon: const Icon(Icons.upload_file, size: 16),
              label: const Text('Upload the first document'),
            ),
          ],
        ],
      ),
    );
  }

  void _setDocumentStatus(_KnowledgeDocument document, String status) {
    setState(() => document.status = status);
  }

  Future<void> _exportDocuments() async {
    String quote(String value) => '"${value.replaceAll('"', '""')}"';
    final csv = StringBuffer(
      'ID,Document,Type,Issuing office,Added,Passages,Status\r\n',
    );
    for (final document in _documents) {
      csv.writeln(
        [
          document.id,
          document.title,
          document.type,
          document.office,
          document.added,
          document.passages,
          document.status,
        ].map((value) => quote(value.toString())).join(','),
      );
    }

    try {
      final savedFile = await FilePicker.saveFile(
        fileName: 'institutional-knowledge.csv',
        bytes: Uint8List.fromList(utf8.encode(csv.toString())),
        mimeType: 'text/csv',
        dialogTitle: 'Export institutional knowledge',
      );
      if (savedFile == null || !mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Knowledge base exported as CSV.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not export the knowledge base: $error'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _confirmDelete(_KnowledgeDocument document) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete document?'),
        content: Text('Remove "${document.title}" from this knowledge base?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFB91C1C),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _documents.remove(document));
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
                    onSubmitted: (_) => _answerQuestion(),
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF1E293B),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Ask a question about approved documents',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF94A3B8),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: _answerQuestion,
                icon: const Icon(Icons.send_rounded, size: 14),
                label: Text(
                  "Ask",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF7C8BA1,
                  ), // Soft periwinkle/slate
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _suggestedQuestion(
                'Summarise the key rules in “Student Code of Conduct & Lab Guidelines”',
              ),
              _suggestedQuestion(
                'Summarise the key rules in “Faculty Leave, Workload & Duty Policy”',
              ),
              _suggestedQuestion(
                'Summarise the key rules in “Academic Regulations 2026”',
              ),
            ],
          ),
          if (_lastQuestion != null) ...[
            const SizedBox(height: 18),
            _buildAnswerResult(),
          ],
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
              const Icon(
                Icons.auto_awesome,
                size: 16,
                color: Color(0xFFD97706),
              ),
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
            "Your question is matched against approved passage text by keywords.",
          ),
          const SizedBox(height: 12),
          _buildNumberedGuideline(
            "3.",
            "Answers cite the matching passage and document title.",
          ),
          const SizedBox(height: 12),
          _buildNumberedGuideline(
            "4.",
            "If no approved document matches, the portal says so rather than guessing.",
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
      children: [queryBox, const SizedBox(height: 16), howAnswersWorkCard],
    );
  }

  Widget _suggestedQuestion(String question) {
    return ActionChip(
      onPressed: () {
        _askController.text = question;
        _answerQuestion();
      },
      label: Text(
        question,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          color: const Color(0xFF52627A),
        ),
      ),
      backgroundColor: const Color(0xFFF5F2EB),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
    );
  }

  void _answerQuestion() {
    final question = _askController.text.trim();
    if (question.isEmpty) return;

    const ignoredTerms = {
      'about',
      'and',
      'are',
      'for',
      'from',
      'into',
      'key',
      'rules',
      'summarise',
      'the',
      'what',
      'when',
      'where',
      'with',
    };
    final terms = RegExp(r'[a-z0-9]{3,}')
        .allMatches(question.toLowerCase())
        .map((match) => match.group(0)!)
        .where((term) => !ignoredTerms.contains(term))
        .toSet();

    final matches =
        _documents
            .where((document) => document.status == 'Approved')
            .map((document) {
              final searchable = '${document.title} ${document.content}'
                  .toLowerCase();
              final score = terms.where(searchable.contains).length;
              return (document: document, score: score);
            })
            .where((match) => match.score > 0)
            .toList()
          ..sort((a, b) => b.score.compareTo(a.score));

    setState(() {
      _lastQuestion = question;
      _answerSources = matches.take(3).map((match) => match.document).toList();
    });
  }

  Widget _buildAnswerResult() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF9F6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE9E3D8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _answerSources.isEmpty
                ? 'No matching approved passages'
                : 'Matching approved passages',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          if (_answerSources.isEmpty)
            Text(
              'No approved document matched “$_lastQuestion”. Try another question or approve a relevant document.',
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF5F6F84),
                height: 1.45,
              ),
            )
          else
            for (final document in _answerSources) ...[
              Text(
                document.content,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF4F5D73),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Source: ${document.title} · ${document.id}',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF283685),
                ),
              ),
              if (document != _answerSources.last) const Divider(height: 18),
            ],
        ],
      ),
    );
  }

  Widget _buildNumberedGuideline(
    String number,
    String text, {
    String? highlight,
  }) {
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
                      TextSpan(text: text.replaceFirst("Only $highlight", "")),
                    ]
                  : [TextSpan(text: text)],
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
                      horizontal: 10,
                      vertical: 3,
                    ),
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
                      "val": "Hybrid: 70% meaning + 30% keywords",
                    },
                    {"label": "PASSAGES USED PER ANSWER", "val": "Top 6"},
                    {
                      "label": "DOCUMENTS THAT NEED RE-INDEXING",
                      "val": _documentsNeedingReindex.toString(),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: const WidgetStatePropertyAll(
                    Color(0xFFFAF9F6),
                  ),
                  headingRowHeight: 40,
                  dataRowMinHeight: 54,
                  dataRowMaxHeight: 66,
                  horizontalMargin: 16,
                  columnSpacing: 30,
                  columns: const [
                    DataColumn(label: Text('DOCUMENT')),
                    DataColumn(label: Text('INDEX')),
                    DataColumn(label: Text('PASSAGES')),
                    DataColumn(label: Text('SEMANTIC')),
                    DataColumn(label: Text('MODEL')),
                    DataColumn(label: Text('ACTION')),
                  ],
                  rows: _documents.map((document) {
                    return DataRow(
                      cells: [
                        DataCell(
                          SizedBox(
                            width: 430,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  document.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF263247),
                                  ),
                                ),
                                Text(
                                  '${document.id} · ${document.status}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 9.5,
                                    color: const Color(0xFF8693A6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        DataCell(
                          _indexTypeBadge(
                            document.semantic ? 'Semantic' : 'Keyword only',
                          ),
                        ),
                        DataCell(Text('${document.passages}')),
                        DataCell(
                          Text(
                            document.semantic ? '${document.passages}' : '0',
                            style: GoogleFonts.poppins(fontSize: 11),
                          ),
                        ),
                        DataCell(
                          Text(
                            document.semantic
                                ? 'gemini-embedding-001 · 768-dim'
                                : '—',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: const Color(0xFF61718A),
                            ),
                          ),
                        ),
                        DataCell(
                          document.needsReindex
                              ? OutlinedButton.icon(
                                  onPressed: () => _reindexDocument(document),
                                  icon: const Icon(Icons.refresh, size: 14),
                                  label: const Text('Re-index'),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF334155),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 7,
                                    ),
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    side: const BorderSide(
                                      color: Color(0xFFE2DDD2),
                                    ),
                                  ),
                                )
                              : Text(
                                  'Healthy',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: const Color(0xFF0D9488),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _indexTypeBadge(String label) {
    final semantic = label == 'Semantic';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: semantic ? const Color(0xFFDDF4F0) : const Color(0xFFF3F0E8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 9.5,
          fontWeight: FontWeight.w500,
          color: semantic ? const Color(0xFF0D9488) : const Color(0xFF59677E),
        ),
      ),
    );
  }

  void _reindexDocument(_KnowledgeDocument document) {
    setState(() {
      document.needsReindex = false;
      document.semantic = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Re-indexed "${document.title}".'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _KnowledgeDocument {
  final String id;
  final String title;
  final String type;
  final String office;
  final String added;
  final int passages;
  final String content;
  final String description;
  final String? fileName;
  final String audience;
  final String passageSize;
  String status;
  bool needsReindex;
  bool semantic;

  _KnowledgeDocument({
    required this.id,
    required this.title,
    required this.type,
    required this.office,
    required this.added,
    required this.passages,
    required this.status,
    required this.content,
    this.description = '',
    this.fileName,
    this.audience = 'Institution-wide',
    this.passageSize = '512 tokens',
    this.needsReindex = false,
    this.semantic = false,
  });
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
