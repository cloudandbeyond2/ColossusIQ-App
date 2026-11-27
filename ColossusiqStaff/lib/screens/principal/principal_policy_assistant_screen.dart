import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class PrincipalPolicyAssistantScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const PrincipalPolicyAssistantScreen({super.key, this.onBack});

  @override
  State<PrincipalPolicyAssistantScreen> createState() =>
      _PrincipalPolicyAssistantScreenState();
}

class _PrincipalPolicyAssistantScreenState
    extends State<PrincipalPolicyAssistantScreen> {
  static const _navy = Color(0xFF202C68);
  static const _indigo = Color(0xFF4F46A5);
  static const _canvas = Color(0xFFFAF8F3);

  final _questionController = TextEditingController();
  final _searchController = TextEditingController();
  final _questionFocusNode = FocusNode();

  String _selectedCategory = 'All';
  bool _showSources = true;
  _PolicyAnswer? _answer = _PolicyAnswer(
    question: 'What does “Student Code of Conduct” say about ragging?',
    text:
        'The Student Code of Conduct states that ragging in any form is prohibited. Complaints can be made to any faculty member, the Anti-Ragging Committee, or the Principal, and will be investigated promptly. Students found guilty face suspension or expulsion as decided by the committee.',
    source: _documents[0],
    excerpt:
        'Ragging in any form is prohibited. A complaint can be made to any faculty member, the Anti-Ragging Committee or the Principal, and will be investigated promptly. Students found guilty face suspension or expulsion as decided by the committee.',
    matchedPassages: 3,
    matchedDocuments: 1,
  );

  static const List<_PolicyDocument> _documents = [
    _PolicyDocument(
      title:
          'Anna Institute of Technology - Student Code of Conduct & Lab Guidelines',
      category: 'Handbook',
      owner: 'Dean of Students',
      passages: 3,
      question: 'What does the Student Code of Conduct say about ragging?',
      answer:
          'The Student Code of Conduct states that ragging in any form is prohibited. Complaints can be made to any faculty member, the Anti-Ragging Committee, or the Principal, and will be investigated promptly. Students found guilty face suspension or expulsion as decided by the committee.',
      excerpt:
          'Ragging in any form is prohibited. A complaint can be made to any faculty member, the Anti-Ragging Committee or the Principal, and will be investigated promptly. Students found guilty face suspension or expulsion as decided by the committee.',
      keywords: ['ragging', 'conduct', 'student', 'complaint', 'lab'],
    ),
    _PolicyDocument(
      title:
          'Anna Institute of Technology - Faculty Leave, Workload & Duty Policy',
      category: 'Policy',
      owner: 'Principal’s Office',
      passages: 4,
      question: 'What is the process for faculty casual leave?',
      answer:
          'Faculty should submit casual leave requests to their Head of Department for approval before taking leave. Requests are subject to the available leave balance and department coverage requirements.',
      excerpt:
          'Casual leave shall be requested in advance through the department. Approval is subject to leave balance, academic schedule and arrangements for assigned classes.',
      keywords: ['faculty', 'leave', 'casual', 'workload', 'duty'],
    ),
    _PolicyDocument(
      title: 'Anna Institute of Technology - Academic Regulations 2026',
      category: 'Regulation',
      owner: 'Registrar',
      passages: 5,
      question: 'What are the minimum attendance requirements?',
      answer:
          'Students must satisfy the minimum attendance requirement published in the academic regulations to be eligible for semester examinations. Any permitted condonation is subject to the prescribed rules and approval process.',
      excerpt:
          'A student shall meet the minimum attendance prescribed for the semester to become eligible to appear for the end-semester examination. Attendance condonation is governed by the approved institutional rules.',
      keywords: [
        'attendance',
        'minimum',
        'regulation',
        'semester',
        'examination',
      ],
    ),
    _PolicyDocument(
      title: 'Anna Institute of Technology - Internal Assessment Guidelines',
      category: 'Guideline',
      owner: 'Office of the Controller of Examinations',
      passages: 6,
      question: 'How are internal assessment marks calculated?',
      answer:
          'Internal assessment is calculated using the assessment components and weightings published for the course. Refer to the approved course and examination guidelines for the applicable breakdown.',
      excerpt:
          'The internal assessment mark is computed from the prescribed tests, assignments and other course assessment components according to the approved course scheme.',
      keywords: ['internal', 'assessment', 'marks', 'exam', 'calculated'],
    ),
    _PolicyDocument(
      title: 'Anna Institute of Technology - Student Attendance Circular',
      category: 'Circular',
      owner: 'Academic Office',
      passages: 4,
      question: 'Where can I check my attendance?',
      answer:
          'Students can review attendance through the academic portal. Report any discrepancy to the course faculty or department office for verification.',
      excerpt:
          'Attendance records are available through the student academic portal. Discrepancies should be reported to the concerned course faculty within the published review period.',
      keywords: ['attendance', 'portal', 'record', 'student'],
    ),
    _PolicyDocument(
      title: 'Anna Institute of Technology - Examination Handbook',
      category: 'Handbook',
      owner: 'Examination Cell',
      passages: 4,
      question: 'What should I bring to an examination?',
      answer:
          'Students should carry their valid identity card and follow the examination instructions issued by the Examination Cell. Prohibited materials must not be brought into the examination hall.',
      excerpt:
          'Candidates shall display their valid institutional identity card and comply with the instructions of the examination hall staff.',
      keywords: ['examination', 'exam', 'identity', 'hall'],
    ),
    _PolicyDocument(
      title: 'Anna Institute of Technology - Anti-Ragging Committee Procedures',
      category: 'Policy',
      owner: 'Student Welfare Office',
      passages: 4,
      question: 'How do I report a student safety concern?',
      answer:
          'A student safety concern can be reported to a faculty member, the Anti-Ragging Committee, or the Principal. The concern is reviewed through the appropriate institutional process.',
      excerpt:
          'Students may report a concern to any faculty member, the Anti-Ragging Committee or the Principal for review and appropriate action.',
      keywords: ['ragging', 'safety', 'report', 'committee', 'complaint'],
    ),
    _PolicyDocument(
      title: 'Anna Institute of Technology - Library Use Guidelines',
      category: 'Guideline',
      owner: 'Library',
      passages: 4,
      question: 'What are the library borrowing rules?',
      answer:
          'Library members may borrow materials according to their membership category and the library’s current lending period. Renewals and overdue items follow the published library rules.',
      excerpt:
          'Borrowing limits and lending periods are determined by the user category. Renewals are subject to availability and library rules.',
      keywords: ['library', 'borrowing', 'book', 'renewal'],
    ),
  ];

  static const _categories = [
    'All',
    'Regulation',
    'Policy',
    'Handbook',
    'Guideline',
    'Circular',
  ];

  static const _suggestedQuestions = [
    'What is the minimum attendance requirement?',
    'What are the rules for faculty casual leave?',
    'How are internal assessment marks calculated?',
    'What are the library borrowing rules?',
  ];

  List<_PolicyDocument> get _filteredDocuments {
    final query = _searchController.text.trim().toLowerCase();
    return _documents.where((document) {
      final matchesCategory =
          _selectedCategory == 'All' || document.category == _selectedCategory;
      final matchesQuery =
          query.isEmpty ||
          document.title.toLowerCase().contains(query) ||
          document.category.toLowerCase().contains(query) ||
          document.owner.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  int get _passageCount =>
      _documents.fold(0, (total, document) => total + document.passages);

  @override
  void dispose() {
    _questionController.dispose();
    _searchController.dispose();
    _questionFocusNode.dispose();
    super.dispose();
  }

  void _askQuestion([String? suggestion]) {
    final question = (suggestion ?? _questionController.text).trim();
    if (question.isEmpty) return;

    final normalizedQuestion = question.toLowerCase();
    _PolicyDocument? match;
    var bestScore = 0;
    for (final document in _documents) {
      final score = document.keywords.where(normalizedQuestion.contains).length;
      if (score > bestScore) {
        bestScore = score;
        match = document;
      }
    }

    setState(() {
      _answer = match == null
          ? _PolicyAnswer(
              question: question,
              text:
                  'I could not find this topic in the approved documents currently shown. Try a related question or contact the relevant college office.',
              matchedPassages: 0,
              matchedDocuments: 0,
            )
          : _PolicyAnswer(
              question: question,
              text: match.answer,
              source: match,
              excerpt: match.excerpt,
              matchedPassages: match.passages,
              matchedDocuments: 1,
            );
      _questionController.clear();
      _showSources = true;
    });
  }

  void _clearConversation() {
    setState(() {
      _answer = null;
      _questionController.clear();
      _showSources = true;
    });
  }

  Future<void> _copyAnswer() async {
    final answer = _answer;
    if (answer == null) return;
    await Clipboard.setData(ClipboardData(text: answer.text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Answer copied to clipboard'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _selectDocument(_PolicyDocument document) {
    _questionController.text = document.question;
    _questionFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _canvas,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 950;
          final horizontalPadding = constraints.maxWidth >= 1100
              ? 24.0
              : constraints.maxWidth >= 600
              ? 18.0
              : 12.0;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              16,
              horizontalPadding,
              32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroBanner(),
                const SizedBox(height: 16),
                _buildInstitutionStrip(),
                const SizedBox(height: 14),
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 7, child: _buildAssistantCard()),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            _buildDocumentSidebar(),
                            const SizedBox(height: 14),
                            _buildHowAnswersWorkCard(),
                          ],
                        ),
                      ),
                    ],
                  )
                else ...[
                  _buildAssistantCard(),
                  const SizedBox(height: 14),
                  _buildDocumentSidebar(),
                  const SizedBox(height: 14),
                  _buildHowAnswersWorkCard(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF202C68), Color(0xFF344A9C), Color(0xFF5A4A9A)],
        ),
        boxShadow: [
          BoxShadow(
            color: _navy.withValues(alpha: 0.18),
            blurRadius: 22,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _BlueprintGridPainter()),
            ),
            Positioned(
              right: 24,
              bottom: -40,
              child: Icon(
                Icons.description_outlined,
                size: 150,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.onBack != null) ...[
                    InkWell(
                      onTap: widget.onBack,
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.arrow_back_rounded,
                                size: 15,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Home  ›  Institution  ›  Policy Assistant',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.16),
                          ),
                        ),
                        child: const Icon(
                          Icons.policy_outlined,
                          color: Color(0xFFFBBF24),
                          size: 25,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 7,
                              runSpacing: 5,
                              children: [
                                _heroPill('INSTITUTION'),
                                _heroPill(
                                  'MVP',
                                  background: const Color(0xFF0D9488),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Policy Assistant',
                              style: GoogleFonts.poppins(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.4,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Answers strictly from approved institutional documents, with citations.',
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: const Color(0xFFDCE3FF),
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
          ],
        ),
      ),
    );
  }

  Widget _heroPill(String label, {Color? background}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: background ?? Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInstitutionStrip() {
    return _surface(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 520;
          final institution = Wrap(
            spacing: 7,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _smallIconBox(Icons.account_balance_rounded),
              Text(
                'Anna Institute of Technology',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF253047),
                ),
              ),
              _tag('ENGINEERING'),
              _tag('Administration'),
            ],
          );
          final status = Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.circle, size: 7, color: Color(0xFF69B7AA)),
              const SizedBox(width: 6),
              Text(
                'AI Search  ·  ${_documents.length} Docs',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF18877E),
                ),
              ),
            ],
          );

          if (isCompact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [institution, const SizedBox(height: 8), status],
            );
          }
          return Row(
            children: [
              Expanded(child: institution),
              const SizedBox(width: 10),
              status,
            ],
          );
        },
      ),
    );
  }

  Widget _smallIconBox(IconData icon) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2FC),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Icon(icon, size: 14, color: const Color(0xFF5367A5)),
    );
  }

  Widget _tag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F0EC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF5C6472),
        ),
      ),
    );
  }

  Widget _buildAssistantCard() {
    return _surface(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 14, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ask about your college's policies",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF202A3A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Answers come strictly from approved documents with verified citations.',
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          color: const Color(0xFF748096),
                        ),
                      ),
                    ],
                  ),
                ),
                if (_answer != null)
                  TextButton.icon(
                    onPressed: _clearConversation,
                    icon: const Icon(Icons.delete_outline_rounded, size: 14),
                    label: Text(
                      'Clear conversation',
                      style: GoogleFonts.poppins(fontSize: 10.5),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF58627A),
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      minimumSize: const Size(0, 32),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF0EEE8)),
          if (_answer != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
              child: _buildConversation(_answer!),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 24, 18, 18),
              child: Center(
                child: Column(
                  children: [
                    _smallIconBox(Icons.auto_awesome_rounded),
                    const SizedBox(height: 8),
                    Text(
                      'Ask a question about approved documents',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF35415A),
                      ),
                    ),
                    Text(
                      'Answers include references to the passages they come from.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF748096),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const Divider(height: 1, color: Color(0xFFEDE9E0)),
          _buildSuggestedQuestions(),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final askButton = SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    key: const ValueKey('policy-ask-button'),
                    onPressed: _askQuestion,
                    icon: const Icon(Icons.send_rounded, size: 15),
                    label: Text(
                      'Ask',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _indigo,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                );
                final field = TextField(
                  key: const ValueKey('policy-question-input'),
                  controller: _questionController,
                  focusNode: _questionFocusNode,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) => _askQuestion(),
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    color: const Color(0xFF344054),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Ask a question about college policies...',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF9099A8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(color: Color(0xFFE4DFD4)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(color: Color(0xFFE4DFD4)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(
                        color: Color(0xFF8186CC),
                        width: 1.3,
                      ),
                    ),
                  ),
                );

                if (constraints.maxWidth < 420) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      field,
                      const SizedBox(height: 8),
                      Align(alignment: Alignment.centerRight, child: askButton),
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: field),
                    const SizedBox(width: 8),
                    askButton,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversation(_PolicyAnswer answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 520),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
            decoration: BoxDecoration(
              color: _navy,
              borderRadius: BorderRadius.circular(
                14,
              ).copyWith(bottomRight: const Radius.circular(5)),
            ),
            child: Text(
              answer.question,
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xFFE9E5DA)),
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 6,
                runSpacing: 5,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _statusChip(
                    'From approved documents',
                    const Color(0xFFDDF5EF),
                  ),
                  _statusChip(
                    'Grounded in approved sources',
                    const Color(0xFFF3F0E8),
                  ),
                  Text(
                    _timestamp(),
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      color: const Color(0xFF8A929F),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                answer.text,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  height: 1.55,
                  color: const Color(0xFF344054),
                ),
              ),
              if (answer.source != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () =>
                          setState(() => _showSources = !_showSources),
                      icon: Icon(
                        _showSources
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 16,
                      ),
                      label: Text(
                        'Sources (1)',
                        style: GoogleFonts.poppins(fontSize: 10.5),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF53617B),
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        minimumSize: const Size(0, 28),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton.icon(
                      onPressed: _copyAnswer,
                      icon: const Icon(Icons.copy_rounded, size: 12),
                      label: Text(
                        'Copy',
                        style: GoogleFonts.poppins(fontSize: 10.5),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF53617B),
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        minimumSize: const Size(0, 28),
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      child: Text(
                        'Searched ${answer.matchedPassages} passages in ${answer.matchedDocuments} docs',
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          color: const Color(0xFF8992A0),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_showSources)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FC),
                      borderRadius: BorderRadius.circular(11),
                      border: Border.all(color: const Color(0xFFD7DCE9)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '[1] ${answer.source!.title} · used in answer',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF3D4D71),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          answer.excerpt ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 10.5,
                            height: 1.45,
                            color: const Color(0xFF63718A),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _timestamp() {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';
    return 'Today, $hour:$minute $period';
  }

  Widget _statusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 9,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF506273),
        ),
      ),
    );
  }

  Widget _buildSuggestedQuestions() {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(
            Icons.auto_awesome_rounded,
            size: 14,
            color: Color(0xFFC47932),
          ),
          const SizedBox(width: 6),
          Text(
            'Try:',
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF657087),
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _suggestedQuestions.length,
              separatorBuilder: (context, index) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final question = _suggestedQuestions[index];
                return ActionChip(
                  onPressed: () => _askQuestion(question),
                  label: Text(
                    question,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: const Color(0xFF52617A),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFE6E0D4)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  visualDensity: VisualDensity.compact,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentSidebar() {
    return _surface(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What I answer from',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF202A3A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Approved documents of your college only',
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF748096),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _metricBox(_documents.length.toString(), 'Documents'),
              const SizedBox(width: 6),
              _metricBox(_passageCount.toString(), 'Passages'),
              const SizedBox(width: 6),
              _metricBox(
                _documents
                    .map((document) => document.category)
                    .toSet()
                    .length
                    .toString(),
                'Categories',
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            key: const ValueKey('policy-document-search'),
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            style: GoogleFonts.poppins(fontSize: 11),
            decoration: InputDecoration(
              hintText: 'Filter documents...',
              hintStyle: GoogleFonts.poppins(
                fontSize: 10.5,
                color: const Color(0xFF8A93A2),
              ),
              prefixIcon: const Icon(Icons.search_rounded, size: 16),
              prefixIconConstraints: const BoxConstraints(
                minWidth: 34,
                minHeight: 34,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 8,
              ),
              filled: true,
              fillColor: const Color(0xFFF5F2EA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE8E1D4)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFE8E1D4)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF9B9BD1)),
              ),
            ),
          ),
          const SizedBox(height: 7),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: _categories.map((category) {
              final selected = category == _selectedCategory;
              return InkWell(
                onTap: () => setState(() => _selectedCategory = category),
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? _navy : const Color(0xFFF2EFE8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    category,
                    style: GoogleFonts.poppins(
                      fontSize: 9.5,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      color: selected ? Colors.white : const Color(0xFF5E6879),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 8),
          Container(
            constraints: const BoxConstraints(maxHeight: 360),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFEDE8DE))),
            ),
            child: _filteredDocuments.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'No documents match these filters.',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: const Color(0xFF748096),
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    itemCount: _filteredDocuments.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: Color(0xFFEDE8DE)),
                    itemBuilder: (context, index) {
                      final document = _filteredDocuments[index];
                      return _documentRow(document);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _metricBox(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 3),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F4EF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF293143),
              ),
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 9,
                color: const Color(0xFF7C8798),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _documentRow(_PolicyDocument document) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 9),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            document.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              height: 1.4,
              color: const Color(0xFF263144),
            ),
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 6,
            runSpacing: 3,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _tag(document.category),
              Text(
                document.owner,
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  color: const Color(0xFF748096),
                ),
              ),
              Text(
                '${document.passages} passages',
                style: GoogleFonts.poppins(
                  fontSize: 9,
                  color: const Color(0xFF748096),
                ),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: () => _selectDocument(document),
            icon: const Icon(Icons.auto_awesome_rounded, size: 11),
            label: Text(
              'Ask about this document',
              style: GoogleFonts.poppins(fontSize: 9.5),
            ),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF966132),
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 22),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowAnswersWorkCard() {
    return _surface(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.menu_book_outlined,
                size: 17,
                color: Color(0xFF6D75A6),
              ),
              const SizedBox(width: 8),
              Text(
                'How answers work',
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF202A3A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _numberedBullet(
            '1.',
            'Question keywords are matched against topics in the approved documents.',
          ),
          const SizedBox(height: 7),
          _numberedBullet(
            '2.',
            'The matching sample answer is shown with a numbered document citation.',
          ),
          const SizedBox(height: 7),
          _numberedBullet(
            '3.',
            'If documents do not cover the question, the assistant says so instead of guessing.',
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFEDE8DE)),
          const SizedBox(height: 8),
          Text(
            'Demo content is stored locally; no live policy or AI service is connected.',
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: const Color(0xFF8992A0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _numberedBullet(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF59658A),
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              height: 1.45,
              color: const Color(0xFF586477),
            ),
          ),
        ),
      ],
    );
  }

  Widget _surface({
    required Widget child,
    required EdgeInsetsGeometry padding,
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE9E3D8)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x080F172A),
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _PolicyDocument {
  final String title;
  final String category;
  final String owner;
  final int passages;
  final String question;
  final String answer;
  final String excerpt;
  final List<String> keywords;

  const _PolicyDocument({
    required this.title,
    required this.category,
    required this.owner,
    required this.passages,
    required this.question,
    required this.answer,
    required this.excerpt,
    required this.keywords,
  });
}

class _PolicyAnswer {
  final String question;
  final String text;
  final _PolicyDocument? source;
  final String? excerpt;
  final int matchedPassages;
  final int matchedDocuments;

  const _PolicyAnswer({
    required this.question,
    required this.text,
    this.source,
    this.excerpt,
    required this.matchedPassages,
    required this.matchedDocuments,
  });
}

class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.055)
      ..strokeWidth = 1;
    const spacing = 26.0;
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
