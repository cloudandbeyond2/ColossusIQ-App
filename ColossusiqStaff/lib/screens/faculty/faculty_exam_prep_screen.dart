import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// DATA MODELS: QUESTION SET & STUDY NOTES
// =============================================================================
class QuestionItem {
  String questionText;
  List<String> options;
  int correctOptionIndex;
  String explanation;

  late final TextEditingController questionCtrl;
  late final List<TextEditingController> optionCtrls;
  late final TextEditingController explanationCtrl;

  QuestionItem({
    this.questionText = '',
    List<String>? options,
    this.correctOptionIndex = 0,
    this.explanation = '',
  }) : options = options ?? ['', '', '', ''] {
    questionCtrl = TextEditingController(text: questionText);
    optionCtrls = List.generate(4, (i) => TextEditingController(text: this.options[i]));
    explanationCtrl = TextEditingController(text: explanation);

    questionCtrl.addListener(() => questionText = questionCtrl.text);
    for (int i = 0; i < 4; i++) {
      final idx = i;
      optionCtrls[idx].addListener(() => this.options[idx] = optionCtrls[idx].text);
    }
    explanationCtrl.addListener(() => explanation = explanationCtrl.text);
  }

  void syncControllers() {
    if (questionCtrl.text != questionText) {
      questionCtrl.text = questionText;
    }
    for (int i = 0; i < 4; i++) {
      if (optionCtrls[i].text != options[i]) {
        optionCtrls[i].text = options[i];
      }
    }
    if (explanationCtrl.text != explanation) {
      explanationCtrl.text = explanation;
    }
  }

  void dispose() {
    questionCtrl.dispose();
    for (final c in optionCtrls) {
      c.dispose();
    }
    explanationCtrl.dispose();
  }
}

class QuestionSetItem {
  String id;
  String title;
  String topic;
  int questionsCount;
  String? exam;
  String author;
  String status;
  List<QuestionItem> questions;

  QuestionSetItem({
    required this.id,
    required this.title,
    required this.topic,
    required this.questionsCount,
    this.exam,
    this.author = 'Dr. Lakshmi Sundaram',
    this.status = 'Published',
    this.questions = const [],
  });
}

class StudyNoteItem {
  String id;
  String title;
  bool isAiGenerated;
  bool isReviewed;
  String status;
  int keyPointsCount;
  String? author;
  String description;
  String keyPoints;
  String formulasRules;
  String workedProblem;
  String workedSolution;
  String commonMistakes;
  String examTips;
  bool publishToStudents;

  StudyNoteItem({
    required this.id,
    required this.title,
    this.isAiGenerated = false,
    this.isReviewed = true,
    this.status = 'Published',
    required this.keyPointsCount,
    this.author,
    required this.description,
    this.keyPoints = '',
    this.formulasRules = '',
    this.workedProblem = '',
    this.workedSolution = '',
    this.commonMistakes = '',
    this.examTips = '',
    this.publishToStudents = true,
  });
}

// =============================================================================
// ASSESSMENT: EXAM PREP STUDIO SCREEN
// Matches Screenshot 1, 2, 3:
// 1. Hero blueprint banner with ASSESSMENT & MVP badges
// 2. Amber disclaimer alert banner
// 3. 3 KPI metric tiles (Published question sets 7, Topic notes 4, AI notes to review 1)
// 4. Pill segmented tabs (Question sets / Study notes)
// 5. Question sets tab with "+ New set" action & list of published sets
// 6. "New question set" editor view with topic, exam chips, AI draft generator & interactive questions
// 7. Study notes tab with "Write notes for a topic" and faculty/AI review cards
// =============================================================================
class FacultyExamPrepScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final String portalRole;
  final bool startEmpty;

  const FacultyExamPrepScreen({
    super.key,
    this.onBack,
    this.portalRole = 'Faculty',
    this.startEmpty = false,
  });

  @override
  State<FacultyExamPrepScreen> createState() => _FacultyExamPrepScreenState();
}

class _FacultyExamPrepScreenState extends State<FacultyExamPrepScreen> {
  int _activeTab = 0; // 0 = Question sets, 1 = Study notes
  bool _isCreatingQuestionSet = false;

  // Study Notes Editor Form State (Matching Screenshot 2 exactly)
  StudyNoteItem? _editingStudyNote;
  final TextEditingController _noteOverviewCtrl = TextEditingController();
  final TextEditingController _noteKeyPointsCtrl = TextEditingController();
  final TextEditingController _noteFormulasCtrl = TextEditingController();
  final TextEditingController _noteWorkedProblemCtrl = TextEditingController();
  final TextEditingController _noteWorkedSolutionCtrl = TextEditingController();
  final TextEditingController _noteMistakesCtrl = TextEditingController();
  final TextEditingController _noteTipsCtrl = TextEditingController();
  bool _notePublishToStudents = true;

  // New Question Set Form State
  String? _selectedTopic;
  final TextEditingController _setTitleController = TextEditingController();
  String? _selectedExamSection;
  final Set<String> _selectedExams = {"SSC CGL"};
  final TextEditingController _draftCountController = TextEditingController(text: "10");
  bool _publishToStudents = true;
  final List<QuestionItem> _formQuestions = [];

  // Study Notes Form State
  String? _selectedStudyNoteTopic;

  final List<String> _topicsList = [
    "Civil engineering core",
    "Letter & number series",
    "Number series",
    "Time & work",
    "Data Structures & Asymptotic Analysis",
    "Indian Polity & Constitution",
    "Operating Systems & Deadlocks",
    "Direction sense",
    "Coding-decoding",
    "Simple & compound interest",
    "Ranking & order",
    "Computer Networks",
    "Database Management Systems",
  ];

  final List<String> _examSections = [
    "Pick an exam first",
    "General Awareness",
    "Quantitative Aptitude",
    "Reasoning & General Intelligence",
    "Core Engineering & Technical",
    "English Language & Comprehension",
  ];

  final List<String> _availableExams = [
    "JEE Main", "GATE", "UPSC CSE", "SSC CGL", "SSC CHSL", "SSC MTS",
    "TNPSC Group 1", "TNPSC Group 2", "TNPSC Group 4", "IBPS PO", "IBPS Clerk",
    "SBI PO", "RBI Grade B", "RRB NTPC", "RRB Group D", "NDA", "CDS",
    "AFCAT", "CTET", "TNTET", "UGC-NET", "TN SET", "NEET-UG", "CUET-UG",
    "CLAT UG", "CAT", "CUET-PG", "TANCET", "NEET-PG", "INI-CET", "FMGE",
    "NExT Step 1", "IIT JAM",
  ];

  // Question Sets & Study Notes State
  late List<QuestionSetItem> _questionSets;
  late List<StudyNoteItem> _studyNotes;

  List<QuestionSetItem> _getInitialQuestionSets() => [
    QuestionSetItem(
      id: "qs_1",
      title: "Civil engineering core — Mock Test & Solutions",
      topic: "Civil engineering core",
      questionsCount: 3,
      author: "Dr. Lakshmi Sundaram",
      status: "Published",
      questions: [
        QuestionItem(
          questionText: "What is the primary factor influencing the workability of fresh concrete?",
          options: ["Water-cement ratio", "Type of cement", "Size of aggregate", "Method of curing"],
          correctOptionIndex: 0,
          explanation: "The water-cement ratio is the most significant factor affecting workability and compressive strength.",
        ),
        QuestionItem(
          questionText: "In soil mechanics, Darcy's law is valid for which type of flow?",
          options: ["Laminar flow", "Turbulent flow", "Both laminar and turbulent", "Unsteady flow only"],
          correctOptionIndex: 0,
          explanation: "Darcy's law is applicable strictly to laminar flow conditions in saturated soils with low Reynolds numbers.",
        ),
        QuestionItem(
          questionText: "Which test is conducted to determine the consistency of standard cement paste?",
          options: ["Vicat apparatus test", "Slump test", "Le Chatelier test", "Soundness test"],
          correctOptionIndex: 0,
          explanation: "Vicat apparatus test measures standard consistency using a 10mm diameter plunger.",
        ),
      ],
    ),
    QuestionSetItem(
      id: "qs_2",
      title: "Letter & number series — Mock Test & Solutions",
      topic: "Letter & number series",
      questionsCount: 10,
      exam: "SSC CGL",
      author: "Dr. Lakshmi Sundaram",
      status: "Published",
    ),
    QuestionSetItem(
      id: "qs_3",
      title: "TNPSC Group 4 · Number series Practice",
      topic: "Number series",
      questionsCount: 10,
      exam: "TNPSC Group 4",
      author: "Dr. Lakshmi Sundaram",
      status: "Published",
    ),
    QuestionSetItem(
      id: "qs_4",
      title: "IBPS PO · Time & work Practice",
      topic: "Time & work",
      questionsCount: 10,
      exam: "IBPS PO",
      author: "Dr. Lakshmi Sundaram",
      status: "Published",
    ),
    QuestionSetItem(
      id: "qs_5",
      title: "UPSC CSE · Indian Polity & Constitution Drill",
      topic: "Indian Polity & Constitution",
      questionsCount: 10,
      exam: "UPSC CSE",
      author: "Dr. Meena Raghavan",
      status: "Published",
    ),
    QuestionSetItem(
      id: "qs_6",
      title: "GATE CSE · Operating Systems & Deadlocks Practice",
      topic: "Operating Systems & Deadlocks",
      questionsCount: 10,
      exam: "GATE",
      author: "Dr. Lakshmi Sundaram",
      status: "Published",
    ),
    QuestionSetItem(
      id: "qs_7",
      title: "Reasoning Ability · Coding-Decoding Mock",
      topic: "Coding-decoding",
      questionsCount: 10,
      exam: "SBI PO",
      author: "Dr. Meena Raghavan",
      status: "Published",
    ),
  ];

  List<StudyNoteItem> _getInitialStudyNotes() => [
    StudyNoteItem(
      id: "sn_1",
      title: "Data Structures & Asymptotic Analysis",
      isAiGenerated: false,
      isReviewed: true,
      status: "Published",
      keyPointsCount: 15,
      author: "Dr. Lakshmi Sundaram",
      description: "Your faculty added Data Structures & Asymptotic Analysis to the syllabus. These key facts come from their questions.",
      keyPoints: "Which of the following data structures is typically used to implement a Last-In, First-Out (LIFO) behavior: Stack.\nWhat is the primary advantage of using a hash table over a sorted array for searching: Average O(1) search time.",
      formulasRules: "",
      workedProblem: "",
      workedSolution: "",
      commonMistakes: "",
      examTips: "Revise these facts again the day after you study them, and once more a week later.",
      publishToStudents: true,
    ),
    StudyNoteItem(
      id: "sn_2",
      title: "Direction sense",
      isAiGenerated: true,
      isReviewed: false,
      status: "Published",
      keyPointsCount: 8,
      description: "Direction sense is a reasoning topic that tests a candidate's ability to determine the final position and direction of a person or object relative to a starting point after a series of movements. Problems typically involve cardinal and intermediate directions, distances, and turns. Exams assess spatial reasoning and the ability...",
    ),
    StudyNoteItem(
      id: "sn_3",
      title: "Coding-decoding",
      isAiGenerated: false,
      isReviewed: true,
      status: "Published",
      keyPointsCount: 8,
      author: "Dr. Meena Raghavan",
      description: "Coding-decoding is a reasoning topic where words, numbers, or symbols are transformed into a coded form based on a specific rule or pattern. Students need to identify this underlying logic from a given example and then apply it to decode or encode new inputs. Exams test observation skills, logical reasoning, and familiarity...",
    ),
    StudyNoteItem(
      id: "sn_4",
      title: "Simple & compound interest",
      isAiGenerated: false,
      isReviewed: true,
      status: "Published",
      keyPointsCount: 8,
      author: "Dr. Lakshmi Sundaram",
      description: "Simple Interest (SI) is calculated solely on the initial principal amount, remaining constant over the investment period. Compound Interest (CI), however, is calculated on the principal plus any accumulated interest from previous periods, leading to exponential growth. Competitive exams frequently test the calculation of principal...",
    ),
    StudyNoteItem(
      id: "sn_5",
      title: "Ranking & order",
      isAiGenerated: false,
      isReviewed: true,
      status: "Published",
      keyPointsCount: 6,
      author: "Dr. Meena Raghavan",
      description: "Ranking and order arrangements test the sequential placement of entities based on position, height, marks, or age. Quick deduction formulas determine total elements from known ranks.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.startEmpty) {
      _questionSets = [];
      _studyNotes = [];
    } else {
      _questionSets = _getInitialQuestionSets();
      _studyNotes = _getInitialStudyNotes();
    }
    _resetNewQuestionSetForm();
    _noteOverviewCtrl.addListener(() {
      if (mounted) setState(() {});
    });
  }

  void _loadSampleQuestionSets() {
    setState(() {
      _questionSets = _getInitialQuestionSets();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Loaded 7 sample question sets (63 questions)"),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _loadSampleStudyNotes() {
    setState(() {
      _studyNotes = _getInitialStudyNotes();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Loaded sample faculty and AI study notes"),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _resetNewQuestionSetForm() {
    _selectedTopic = null;
    _setTitleController.clear();
    _selectedExamSection = _examSections.first;
    _selectedExams.clear();
    _selectedExams.add("SSC CGL");
    _draftCountController.text = "10";
    _publishToStudents = true;
    _formQuestions.clear();
    _formQuestions.add(QuestionItem());
  }

  @override
  void dispose() {
    _setTitleController.dispose();
    _draftCountController.dispose();
    _noteOverviewCtrl.dispose();
    _noteKeyPointsCtrl.dispose();
    _noteFormulasCtrl.dispose();
    _noteWorkedProblemCtrl.dispose();
    _noteWorkedSolutionCtrl.dispose();
    _noteMistakesCtrl.dispose();
    _noteTipsCtrl.dispose();
    super.dispose();
  }

  // ===========================================================================
  // AI DRAFT GENERATOR FOR NEW QUESTION SET
  // ===========================================================================
  void _draftWithAi() {
    final topic = _selectedTopic ?? "Indian Polity & Constitution";
    final count = int.tryParse(_draftCountController.text.trim()) ?? 10;
    final targetCount = count.clamp(1, 20);

    List<QuestionItem> generated = [];

    if (topic.contains("Polity") || topic.contains("Constitution")) {
      final bank = [
        QuestionItem(
          questionText: "Which Article of the Indian Constitution empowers the Supreme Court to issue writs for the enforcement of Fundamental Rights?",
          options: ["Article 32", "Article 226", "Article 131", "Article 143"],
          correctOptionIndex: 0,
          explanation: "Article 32 confers the right to move the Supreme Court for enforcement of Fundamental Rights. Dr. B.R. Ambedkar called it the 'Heart and Soul' of the Constitution.",
        ),
        QuestionItem(
          questionText: "The landmark doctrine of 'Basic Structure' of the Constitution was propounded by the Supreme Court in:",
          options: ["Kesavananda Bharati v. State of Kerala (1973)", "Golaknath v. State of Punjab (1967)", "Minerva Mills v. Union of India (1980)", "Maneka Gandhi v. Union of India (1978)"],
          correctOptionIndex: 0,
          explanation: "In the 1973 Kesavananda Bharati case, a 13-judge bench held that Parliament's constituent power does not permit altering the basic structure.",
        ),
        QuestionItem(
          questionText: "The 73rd Constitutional Amendment Act, 1992 added which Schedule to the Constitution of India?",
          options: ["Eleventh Schedule", "Twelfth Schedule", "Ninth Schedule", "Tenth Schedule"],
          correctOptionIndex: 0,
          explanation: "The 11th Schedule contains 29 functional items pertaining to the powers and responsibilities of Panchayats.",
        ),
        QuestionItem(
          questionText: "Under which Article can the President of India proclaim National Emergency on grounds of war, external aggression, or armed rebellion?",
          options: ["Article 352", "Article 356", "Article 360", "Article 365"],
          correctOptionIndex: 0,
          explanation: "Article 352 deals with proclamation of National Emergency upon written advice of the Union Cabinet.",
        ),
        QuestionItem(
          questionText: "Which constitutional body is constituted under Article 280 to recommend the distribution of net tax proceeds between Union and States?",
          options: ["Finance Commission", "NITI Aayog", "GST Council", "Inter-State Council"],
          correctOptionIndex: 0,
          explanation: "Article 280 mandates the President to constitute a Finance Commission every 5 years.",
        ),
        QuestionItem(
          questionText: "The Anti-Defection Law was introduced in the Indian Constitution by which Amendment Act?",
          options: ["52nd Amendment Act, 1985", "42nd Amendment Act, 1976", "44th Amendment Act, 1978", "61st Amendment Act, 1989"],
          correctOptionIndex: 0,
          explanation: "The 52nd Amendment Act added the Tenth Schedule laying down criteria for disqualification on grounds of defection.",
        ),
        QuestionItem(
          questionText: "Who acts as the ex-officio Chairman of the Council of States (Rajya Sabha)?",
          options: ["Vice-President of India", "Prime Minister", "Speaker of Lok Sabha", "Chief Justice of India"],
          correctOptionIndex: 0,
          explanation: "Article 64 states that the Vice-President of India shall be ex-officio Chairman of the Rajya Sabha.",
        ),
        QuestionItem(
          questionText: "Which Fundamental Right is suspended automatically during a National Emergency proclaimed on grounds of war or external aggression?",
          options: ["Six freedoms under Article 19", "Right to Life under Article 21", "Right to Equality under Article 14", "Freedom of Religion under Article 25"],
          correctOptionIndex: 0,
          explanation: "Under Article 358, the freedoms guaranteed by Article 19 are suspended automatically during an external emergency.",
        ),
        QuestionItem(
          questionText: "The Comptroller and Auditor General of India (CAG) is appointed by the President under which Article?",
          options: ["Article 148", "Article 149", "Article 76", "Article 124"],
          correctOptionIndex: 0,
          explanation: "Article 148 establishes the office of the Comptroller and Auditor General of India.",
        ),
        QuestionItem(
          questionText: "Which prerogative writ translates to 'We Command' and is issued to compel a public authority to perform an obligatory public duty?",
          options: ["Mandamus", "Habeas Corpus", "Quo-Warranto", "Certiorari"],
          correctOptionIndex: 0,
          explanation: "Mandamus is issued by high courts or the Supreme Court to command a public officer or body to perform an act falling under their duty.",
        ),
      ];
      generated = bank.take(targetCount).toList();
    } else if (topic.contains("Data Structures")) {
      final bank = [
        QuestionItem(
          questionText: "What is the worst-case time complexity of searching an element in a balanced Binary Search Tree (AVL / Red-Black)?",
          options: ["O(log n)", "O(n)", "O(1)", "O(n log n)"],
          correctOptionIndex: 0,
          explanation: "Due to height balance invariants, maximum tree depth is bounded by O(log n).",
        ),
        QuestionItem(
          questionText: "Which data structure is naturally utilized in Breadth-First Search (BFS) graph traversal?",
          options: ["Queue", "Stack", "Priority Queue", "Deque"],
          correctOptionIndex: 0,
          explanation: "BFS explores vertex frontiers in FIFO order using a Queue.",
        ),
        QuestionItem(
          questionText: "What is the average time complexity of insertion in a Hash Table with good hash distribution?",
          options: ["O(1)", "O(log n)", "O(n)", "O(n^2)"],
          correctOptionIndex: 0,
          explanation: "Under uniform hashing assumption, expected collision chain length is constant O(1).",
        ),
        QuestionItem(
          questionText: "In a min-heap of size n, extracting the minimum element takes:",
          options: ["O(log n)", "O(1)", "O(n)", "O(n log n)"],
          correctOptionIndex: 0,
          explanation: "Extracting the root and restoring heap property via sift-down takes logarithmic time O(log n).",
        ),
        QuestionItem(
          questionText: "Which of the following sorting algorithms has worst-case time complexity of O(n log n) and is stable?",
          options: ["Merge Sort", "Quick Sort", "Heap Sort", "Selection Sort"],
          correctOptionIndex: 0,
          explanation: "Merge Sort guarantees O(n log n) across all cases and maintains relative order of equal keys.",
        ),
        QuestionItem(
          questionText: "Which data structure is optimal for implementing Undo/Redo operations in an editor?",
          options: ["Two Stacks", "Single Queue", "Circular Array", "Binary Heap"],
          correctOptionIndex: 0,
          explanation: "LIFO semantics of two stacks (Undo stack & Redo stack) perfectly support state reversibility.",
        ),
        QuestionItem(
          questionText: "What is the minimum number of queues required to implement a stack?",
          options: ["Two", "One", "Three", "Four"],
          correctOptionIndex: 0,
          explanation: "Two queues can implement a stack by shifting elements during push or pop operations.",
        ),
        QuestionItem(
          questionText: "Dijkstra's single source shortest path algorithm on non-negative weights runs in O((V + E) log V) using:",
          options: ["Min-Priority Queue / Binary Heap", "Unsorted Array", "Stack", "FIFO Queue"],
          correctOptionIndex: 0,
          explanation: "Using a min-heap priority queue achieves optimal O((V + E) log V) complexity.",
        ),
        QuestionItem(
          questionText: "In a circular queue implemented with array size N, the full condition with one empty slot is:",
          options: ["(rear + 1) % N == front", "rear == front", "(front + 1) % N == rear", "rear == N - 1"],
          correctOptionIndex: 0,
          explanation: "The condition (rear + 1) % N == front distinguishes a full queue from an empty queue.",
        ),
        QuestionItem(
          questionText: "Which tree traversal of a Binary Search Tree produces keys in ascending sorted order?",
          options: ["In-order traversal", "Pre-order traversal", "Post-order traversal", "Level-order traversal"],
          correctOptionIndex: 0,
          explanation: "Left-Root-Right in-order traversal naturally yields elements in non-decreasing order for BSTs.",
        ),
      ];
      generated = bank.take(targetCount).toList();
    } else {
      for (int i = 1; i <= targetCount; i++) {
        generated.add(
          QuestionItem(
            questionText: "Exam Question $i: In the study of $topic, which core principle holds under standard conditions?",
            options: [
              "Verified primary formulation with established boundary limits",
              "Secondary empirical approximation without constraints",
              "Invariable static constant regardless of parameters",
              "Arbitrary stochastic variance",
            ],
            correctOptionIndex: 0,
            explanation: "Core principle derived from standardized textbook definitions and entrance exam syllabi for $topic.",
          ),
        );
      }
    }

    setState(() {
      _selectedTopic = topic;
      _formQuestions.clear();
      _formQuestions.addAll(generated);
      for (final q in _formQuestions) {
        q.syncControllers();
      }
      if (_setTitleController.text.trim().isEmpty) {
        _setTitleController.text = "$topic — Practice Set";
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("AI drafted ${_formQuestions.length} questions for '$topic'! Review and edit."),
        backgroundColor: const Color(0xFF1E2865),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ===========================================================================
  // PUBLISH NEW QUESTION SET
  // ===========================================================================
  void _publishQuestionSet() {
    if (_selectedTopic == null || _selectedTopic!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please choose a topic."),
          backgroundColor: Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final title = _setTitleController.text.trim().isNotEmpty
        ? _setTitleController.text.trim()
        : "$_selectedTopic — Practice Set";

    final author = widget.portalRole == 'Principal'
        ? "Dr. K. S. Ramanathan, Principal"
        : (widget.portalRole == 'HOD' ? "HOD Desk" : "Dr. Lakshmi Sundaram");

    final newSet = QuestionSetItem(
      id: "qs_${DateTime.now().millisecondsSinceEpoch}",
      title: title,
      topic: _selectedTopic!,
      questionsCount: _formQuestions.length,
      exam: _selectedExams.isNotEmpty ? _selectedExams.first : null,
      author: author,
      status: _publishToStudents ? "Published" : "Draft",
      questions: List.from(_formQuestions),
    );

    setState(() {
      _questionSets.insert(0, newSet);
      _isCreatingQuestionSet = false;
      _resetNewQuestionSetForm();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("'$title' published to students' Prep Hub!"),
        backgroundColor: const Color(0xFF15803D),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ===========================================================================
  // AI STUDY NOTE GENERATOR
  // ===========================================================================
  void _generateAiStudyNote() {
    if (_selectedStudyNoteTopic == null || _selectedStudyNoteTopic!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a topic to start an AI study note draft."),
          backgroundColor: Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final topic = _selectedStudyNoteTopic!;
    final newNote = StudyNoteItem(
      id: "sn_${DateTime.now().millisecondsSinceEpoch}",
      title: topic,
      isAiGenerated: true,
      isReviewed: false,
      status: "Published",
      keyPointsCount: 10,
      description: "$topic comprehensive overview synthesized with key definitions, standard problem archetypes, derivation steps, and exam shortcuts.",
    );

    setState(() {
      _studyNotes.insert(0, newNote);
      _selectedStudyNoteTopic = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("AI draft generated for '$topic'. Review and approve below."),
        backgroundColor: const Color(0xFF1E2865),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // ===========================================================================
  // DELETE CONFIRMATION MODALS
  // ===========================================================================
  void _showDeleteQuestionSetDialog(QuestionSetItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Delete Question Set?",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
        ),
        content: Text(
          "Are you sure you want to remove '${item.title}'? This will withdraw the practice questions from students' Prep Hub.",
          style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B), height: 1.4),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF475569))),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _questionSets.remove(item));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Question set deleted"), behavior: SnackBarBehavior.floating),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Delete", style: GoogleFonts.poppins(fontSize: 12.5, color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showDeleteStudyNoteDialog(StudyNoteItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Delete Topic Note?",
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
        ),
        content: Text(
          "Are you sure you want to remove '${item.title}' notes? Students will revert to standard repository notes.",
          style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF64748B), height: 1.4),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Cancel", style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF475569))),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _studyNotes.remove(item));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Topic note deleted"), behavior: SnackBarBehavior.floating),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFDC2626),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Delete", style: GoogleFonts.poppins(fontSize: 12.5, color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _showReviewNoteDialog(StudyNoteItem item) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.rate_review_outlined, color: Color(0xFF1E2865), size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Review AI Note: ${item.title}",
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  item.description,
                  style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF334155), height: 1.5),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Approving this note will tag it as a verified Faculty Note and publish it permanently to students.",
                style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
              ),
            ],
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _openStudyNotesEditor(item);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Edit notes", style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF1E2865), fontWeight: FontWeight.w600)),
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(ctx),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text("Dismiss", style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF475569))),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                item.isAiGenerated = false;
                item.isReviewed = true;
                item.author = "Dr. Lakshmi Sundaram";
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Approved '${item.title}' as verified faculty notes!"),
                  backgroundColor: const Color(0xFF15803D),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2865),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(
              "Approve as Faculty Note",
              style: GoogleFonts.poppins(fontSize: 12.5, color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _openStudyNotesEditor(StudyNoteItem note) {
    setState(() {
      _editingStudyNote = note;
      _noteOverviewCtrl.text = note.description;
      _noteKeyPointsCtrl.text = note.keyPoints;
      _noteFormulasCtrl.text = note.formulasRules;
      _noteWorkedProblemCtrl.text = note.workedProblem;
      _noteWorkedSolutionCtrl.text = note.workedSolution;
      _noteMistakesCtrl.text = note.commonMistakes;
      _noteTipsCtrl.text = note.examTips;
      _notePublishToStudents = note.publishToStudents;
    });
  }

  void _saveAndPublishStudyNotes() {
    if (_editingStudyNote == null) return;

    setState(() {
      _editingStudyNote!.description = _noteOverviewCtrl.text.trim();
      _editingStudyNote!.keyPoints = _noteKeyPointsCtrl.text.trim();
      _editingStudyNote!.formulasRules = _noteFormulasCtrl.text.trim();
      _editingStudyNote!.workedProblem = _noteWorkedProblemCtrl.text.trim();
      _editingStudyNote!.workedSolution = _noteWorkedSolutionCtrl.text.trim();
      _editingStudyNote!.commonMistakes = _noteMistakesCtrl.text.trim();
      _editingStudyNote!.examTips = _noteTipsCtrl.text.trim();
      _editingStudyNote!.publishToStudents = _notePublishToStudents;
      _editingStudyNote!.isReviewed = true;
      _editingStudyNote!.status = _notePublishToStudents ? "Published" : "Draft";

      final lines = _editingStudyNote!.keyPoints
          .split('\n')
          .where((l) => l.trim().isNotEmpty)
          .length;
      _editingStudyNote!.keyPointsCount = lines > 0 ? lines : 15;

      _editingStudyNote = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Study notes published successfully!"),
        backgroundColor: Color(0xFF0D9488),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ===========================================================================
  // MAIN BUILD
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 750;

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 140),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 14),

              // 2. Info Alert Banner (Matching Screenshot 1)
              _buildDisclaimerAlert(),
              const SizedBox(height: 16),

              // 3. Metric Tiles (3 Cards: 7 / 4 / 1)
              _buildKpiMetricsRow(isNarrow),
              const SizedBox(height: 18),

              // 4. Pill Segmented Tabs (Question sets / Study notes)
              _buildSegmentedTabs(),
              const SizedBox(height: 16),

              // 5. Main Content Area
              if (_activeTab == 0) ...[
                if (_isCreatingQuestionSet)
                  _buildNewQuestionSetForm(constraints)
                else
                  _buildQuestionSetsCard(constraints),
              ] else ...[
                _buildStudyNotesTab(constraints),
              ],
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
      margin: const EdgeInsets.only(bottom: 24),
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
            // Blueprint grid background
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPaperPainter(
                  gridColor: Colors.white.withValues(alpha: 0.06),
                  step: 26.0,
                ),
              ),
            ),

            // Large decorative four-point star watermark on the right
            Positioned(
              right: 20,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  size: 160,
                  color: Colors.white,
                ),
              ),
            ),

            // Foreground Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb row (Home > Assessment > Exam Prep Studio)
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
                          "Assessment",
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
                          "Exam Prep Studio",
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

                  // Badges + Title Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Sparkle icon box
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
                            Icons.auto_awesome_rounded,
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
                            // Badges
                            Wrap(
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                _buildPillBadge(
                                  "ASSESSMENT",
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

                            // Main Title
                            Text(
                              "Exam Prep Studio",
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

                  // Subtitle
                  Text(
                    "Add question sets and study notes for competitive and entrance exams, by hand or from an AI draft you review. Published content reaches students' Prep Hub straight away.",
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

  // ===========================================================================
  // 2. DISCLAIMER ALERT (Matching Screenshot 1)
  // ===========================================================================
  Widget _buildDisclaimerAlert() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFDE68A), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 18,
            color: Color(0xFFB45309),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "AI drafts are suggestions. Nothing reaches students until you verify and publish it; every publish is audit-logged and can be withdrawn.",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF92400E),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 3. METRIC TILES ROW (7, 4, 1)
  // ===========================================================================
  Widget _buildKpiMetricsRow(bool isNarrow) {
    final publishedSetsCount = _questionSets.length;
    final totalQuestionsCount = _questionSets.fold<int>(0, (sum, set) => sum + set.questionsCount);
    final facultyNotesCount = _studyNotes.where((note) => !note.isAiGenerated || note.isReviewed).length;
    final aiNotesToReviewCount = _studyNotes.where((note) => note.isAiGenerated && !note.isReviewed).length;

    final card1 = _buildMetricCard(
      value: "$publishedSetsCount",
      title: "Published question sets",
      subtitle: "$totalQuestionsCount questions reaching students",
    );

    final card2 = _buildMetricCard(
      value: "$facultyNotesCount",
      title: "Topic notes by faculty",
    );

    final card3 = _buildMetricCard(
      value: "$aiNotesToReviewCount",
      title: "AI notes to review",
      subtitle: "AI drafting is on",
    );

    if (isNarrow) {
      return Column(
        children: [
          card1,
          const SizedBox(height: 12),
          card2,
          const SizedBox(height: 12),
          card3,
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: card1),
        const SizedBox(width: 14),
        Expanded(child: card2),
        const SizedBox(width: 14),
        Expanded(child: card3),
      ],
    );
  }

  Widget _buildMetricCard({
    required String value,
    required String title,
    String? subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
              height: 1.15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. SEGMENTED PILL TABS
  // ===========================================================================
  Widget _buildSegmentedTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSegmentButton(
              title: "Question sets",
              isSelected: _activeTab == 0,
              onTap: () => setState(() {
                _activeTab = 0;
                _isCreatingQuestionSet = false;
              }),
            ),
            _buildSegmentButton(
              title: "Study notes",
              isSelected: _activeTab == 1,
              onTap: () => setState(() {
                _activeTab = 1;
                _isCreatingQuestionSet = false;
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? const Color(0xFF0F172A) : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. TAB 0: QUESTION SETS LIST CARD (Matching Screenshot 1)
  // ===========================================================================
  Widget _buildQuestionSetsCard(BoxConstraints constraints) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
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
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row (Responsive)
          LayoutBuilder(
            builder: (context, box) {
              final isCompact = box.maxWidth < 450;
              final titleCol = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Question sets",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "Exam-style questions for any syllabus topic, or a new topic your college teaches. Published questions appear in drills and mocks.",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              );

              final newSetBtn = ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _resetNewQuestionSetForm();
                    _isCreatingQuestionSet = true;
                  });
                },
                icon: const Icon(Icons.add, size: 16),
                label: Text(
                  "New set",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );

              if (isCompact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleCol,
                    const SizedBox(height: 12),
                    newSetBtn,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: titleCol),
                  const SizedBox(width: 14),
                  newSetBtn,
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Empty State or List of Question Sets
          if (_questionSets.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Container(
                constraints: const BoxConstraints(minHeight: 180),
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFCBD5E1).withValues(alpha: 0.6),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      // Blueprint Grid Lines
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _GridPaperPainter(
                            gridColor: const Color(0xFFE2E8F0).withValues(alpha: 0.6),
                            step: 26.0,
                          ),
                        ),
                      ),

                      // Centered Message (Matches Screenshot 3)
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "No question sets yet",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Add previous-year-style questions for an exam, or a set for a topic your students find hard.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            OutlinedButton.icon(
                              onPressed: _loadSampleQuestionSets,
                              icon: const Icon(Icons.file_download_outlined, size: 13, color: Color(0xFF1E2865)),
                              label: Text(
                                "Load sample question sets",
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1E2865),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _questionSets.length,
              separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
              itemBuilder: (context, index) {
                final set = _questionSets[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            set.title,
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: 8,
                            runSpacing: 4,
                            children: [
                              // Published badge
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCFCE7),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  set.status,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF15803D),
                                  ),
                                ),
                              ),

                              // Topic Badge
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFEEF2FF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  set.topic,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF4338CA),
                                  ),
                                ),
                              ),

                              // Questions count
                              Text(
                                "${set.questionsCount} questions",
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),

                              // Exam badge if available
                              if (set.exam != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    set.exam!,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF475569),
                                    ),
                                  ),
                                ),

                              // Author
                              Text(
                                "· by ${set.author}",
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  color: const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Actions: Edit pencil & Delete trash
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 17, color: Color(0xFF64748B)),
                          onPressed: () {
                            setState(() {
                              _selectedTopic = set.topic;
                              _setTitleController.text = set.title;
                              if (set.exam != null) {
                                _selectedExams.clear();
                                _selectedExams.add(set.exam!);
                              }
                              _formQuestions.clear();
                              if (set.questions.isNotEmpty) {
                                _formQuestions.addAll(set.questions);
                              } else {
                                _formQuestions.add(QuestionItem());
                              }
                              _isCreatingQuestionSet = true;
                            });
                          },
                          splashRadius: 18,
                          tooltip: "Edit set",
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline_rounded, size: 17, color: Color(0xFFDC2626)),
                          onPressed: () => _showDeleteQuestionSetDialog(set),
                          splashRadius: 18,
                          tooltip: "Delete set",
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
    );
  }

  // ===========================================================================
  // 6. NEW QUESTION SET FORM VIEW (Matching Screenshot 2)
  // ===========================================================================
  Widget _buildNewQuestionSetForm(BoxConstraints constraints) {
    final isDesktop = constraints.maxWidth >= 800;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
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
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            "New question set",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            "Every question needs four different options and one correct answer. Check AI drafts before publishing.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),

          // Row 1: Topic Dropdown & Set Title Input
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildTopicDropdownField()),
                const SizedBox(width: 18),
                Expanded(child: _buildSetTitleField()),
              ],
            )
          else ...[
            _buildTopicDropdownField(),
            const SizedBox(height: 14),
            _buildSetTitleField(),
          ],
          const SizedBox(height: 16),

          // Row 2: Exam Section Dropdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Exam section (optional)",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedExamSection ?? _examSections.first,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
                    style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
                    onChanged: (val) => setState(() => _selectedExamSection = val),
                    items: _examSections.map((sec) {
                      return DropdownMenuItem<String>(
                        value: sec,
                        child: Text(sec),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Row 3: Exams (up to 10) Chips
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Exams (up to 10)",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableExams.map((exam) {
                  final isSelected = _selectedExams.contains(exam);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedExams.remove(exam);
                        } else {
                          if (_selectedExams.length < 10) {
                            _selectedExams.add(exam);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Maximum 10 exams can be selected"),
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Text(
                        exam,
                        style: GoogleFonts.poppins(
                          fontSize: 11.5,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected ? Colors.white : const Color(0xFF334155),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // AI Draft Box Banner (Soft cream background)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFBF8F2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF1ECE1)),
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12,
              runSpacing: 10,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    Text(
                      "How many to draft",
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                    ),
                    Container(
                      width: 52,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFCBD5E1)),
                      ),
                      child: TextField(
                        controller: _draftCountController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8),
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
                OutlinedButton.icon(
                  onPressed: _draftWithAi,
                  icon: const Icon(Icons.auto_awesome_rounded, size: 14, color: Color(0xFF1E2865)),
                  label: Text(
                    "Draft with AI",
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: const Color(0xFF1E2865)),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                Text(
                  "The AI writes a draft for you to check and edit.",
                  style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Question Cards List
          ..._formQuestions.asMap().entries.map((entry) {
            final qIndex = entry.key;
            final q = entry.value;
            return _buildQuestionEditorCard(qIndex, q);
          }),
          const SizedBox(height: 12),

          // "+ Add a question" Button
          OutlinedButton.icon(
            onPressed: () {
              setState(() {
                _formQuestions.add(QuestionItem());
              });
            },
            icon: const Icon(Icons.add, size: 15, color: Color(0xFF1E2865)),
            label: Text(
              "+ Add a question",
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E2865),
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xFFCBD5E1)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(height: 24),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 16),

          // Footer: Checkbox + Cancel & Publish Buttons
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: _publishToStudents,
                    activeColor: const Color(0xFF1E2865),
                    onChanged: (val) => setState(() => _publishToStudents = val ?? true),
                  ),
                  Text(
                    "Publish to students",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _isCreatingQuestionSet = false;
                        _resetNewQuestionSetForm();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF475569)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _publishQuestionSet,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E2865),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      "Publish",
                      style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTopicDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Topic",
              style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
            ),
            const SizedBox(width: 2),
            const Text("*", style: TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedTopic,
              hint: Text("Choose a topic...", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8))),
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
              onChanged: (val) {
                setState(() {
                  _selectedTopic = val;
                  if (_setTitleController.text.trim().isEmpty && val != null) {
                    _setTitleController.text = "$val — Practice Set";
                  }
                });
              },
              items: _topicsList.map((top) {
                return DropdownMenuItem<String>(
                  value: top,
                  child: Text(top),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Choose a syllabus topic or add a custom one",
          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
        ),
      ],
    );
  }

  Widget _buildSetTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Set title",
              style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
            ),
            const SizedBox(width: 2),
            const Text("*", style: TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
          child: TextField(
            controller: _setTitleController,
            style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
            decoration: InputDecoration(
              hintText: "e.g. Indian Polity & Constitution — Practice Set",
              hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              isDense: true,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Title displayed to students in their Prep Hub",
          style: GoogleFonts.poppins(fontSize: 11, color: const Color(0xFF64748B)),
        ),
      ],
    );
  }

  Widget _buildQuestionEditorCard(int index, QuestionItem q) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Question ${index + 1}",
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              if (_formQuestions.length > 1)
                InkWell(
                  onTap: () {
                    setState(() {
                      _formQuestions.removeAt(index);
                    });
                  },
                  borderRadius: BorderRadius.circular(14),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.close_rounded, size: 16, color: Color(0xFF94A3B8)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Question text field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: TextField(
              controller: q.questionCtrl,
              maxLines: 3,
              style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
              decoration: InputDecoration(
                hintText: "Question text",
                hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 4 Options (A, B, C, D) with Radio Selection
          LayoutBuilder(
            builder: (context, box) {
              final isWide = box.maxWidth >= 600;

              final optionA = _buildOptionRow(q, 0, "A");
              final optionB = _buildOptionRow(q, 1, "B");
              final optionC = _buildOptionRow(q, 2, "C");
              final optionD = _buildOptionRow(q, 3, "D");

              if (isWide) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: optionA),
                        const SizedBox(width: 12),
                        Expanded(child: optionB),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: optionC),
                        const SizedBox(width: 12),
                        Expanded(child: optionD),
                      ],
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  optionA,
                  const SizedBox(height: 8),
                  optionB,
                  const SizedBox(height: 8),
                  optionC,
                  const SizedBox(height: 8),
                  optionD,
                ],
              );
            },
          ),
          const SizedBox(height: 12),

          // Explanation field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: TextField(
              controller: q.explanationCtrl,
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
              decoration: InputDecoration(
                hintText: "Explanation shown after the test (recommended)",
                hintStyle: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF94A3B8)),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionRow(QuestionItem q, int optionIndex, String letter) {
    final isSelected = q.correctOptionIndex == optionIndex;
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? const Color(0xFF1E2865) : const Color(0xFFCBD5E1),
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => setState(() => q.correctOptionIndex = optionIndex),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF1E2865) : const Color(0xFF94A3B8),
                  width: isSelected ? 5.0 : 1.5,
                ),
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            letter,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? const Color(0xFF1E2865) : const Color(0xFF64748B),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: q.optionCtrls[optionIndex],
              style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF0F172A)),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 7. TAB 1: STUDY NOTES VIEW (Matching Screenshot 3)
  // ===========================================================================
  Widget _buildStudyNotesTab(BoxConstraints constraints) {
    if (_editingStudyNote != null) {
      return _buildStudyNotesEditorCard(_editingStudyNote!, constraints);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Top Card: Write notes for a topic
        Container(
          width: double.infinity,
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
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Write notes for a topic",
                style: GoogleFonts.poppins(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 10),
              LayoutBuilder(
                builder: (context, box) {
                  final isWide = box.maxWidth >= 600;

                  final topicDropdown = Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedStudyNoteTopic,
                        hint: Text("Choose a topic...", style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8))),
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
                        style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A)),
                        onChanged: (val) => setState(() => _selectedStudyNoteTopic = val),
                        selectedItemBuilder: (context) {
                          return _topicsList.map((top) {
                            return Text(
                              top,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            );
                          }).toList();
                        },
                        items: _topicsList.map((top) {
                          return DropdownMenuItem<String>(
                            value: top,
                            child: Text(top, overflow: TextOverflow.ellipsis, maxLines: 1),
                          );
                        }).toList(),
                      ),
                    ),
                  );

                  final draftButton = ElevatedButton.icon(
                    onPressed: _generateAiStudyNote,
                    icon: const Icon(Icons.auto_awesome_rounded, size: 15, color: Colors.white),
                    label: Text(
                      "Start from an AI draft",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  );

                  if (isWide) {
                    return Row(
                      children: [
                        Expanded(child: topicDropdown),
                        const SizedBox(width: 14),
                        draftButton,
                      ],
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      topicDropdown,
                      const SizedBox(height: 10),
                      draftButton,
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 2. Notes in your college Card
        Container(
          width: double.infinity,
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
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notes in your college",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                "Faculty notes replace the built-in or AI notes for their topic. AI notes were written when a student first opened a topic; review and approve them here.",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 18),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),

              // Empty State or List of Study Notes
              if (_studyNotes.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 180),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFCBD5E1).withValues(alpha: 0.6),
                        width: 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _GridPaperPainter(
                                gridColor: const Color(0xFFE2E8F0).withValues(alpha: 0.6),
                                step: 26.0,
                              ),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "No study notes yet",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    "Publish department-curated study material and reference guides for students.",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.5,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                OutlinedButton.icon(
                                  onPressed: _loadSampleStudyNotes,
                                  icon: const Icon(Icons.file_download_outlined, size: 13, color: Color(0xFF1E2865)),
                                  label: Text(
                                    "Load sample study notes",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF1E2865),
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color(0xFFCBD5E1)),
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _studyNotes.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  itemBuilder: (context, index) {
                  final note = _studyNotes[index];
                  final isAiPendingReview = note.isAiGenerated && !note.isReviewed;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => _openStudyNotesEditor(note),
                                child: Text(
                                  note.title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF0F172A),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                spacing: 8,
                                runSpacing: 4,
                                children: [
                                  // Faculty or AI badge
                                  if (isAiPendingReview)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFEF3C7),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.warning_amber_rounded, size: 12, color: Color(0xFFD97706)),
                                          const SizedBox(width: 4),
                                          Text(
                                            "AI, not yet reviewed",
                                            style: GoogleFonts.poppins(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFFD97706),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  else
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFCCFBF1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        "Faculty",
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF0F766E),
                                        ),
                                      ),
                                    ),

                                  // Published badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFDCFCE7),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      note.status,
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF15803D),
                                      ),
                                    ),
                                  ),

                                  // Key points count
                                  Text(
                                    "${note.keyPointsCount} key points",
                                    style: GoogleFonts.poppins(
                                      fontSize: 11.5,
                                      color: const Color(0xFF64748B),
                                    ),
                                  ),

                                  // Author if available
                                  if (note.author != null)
                                    Text(
                                      "· by ${note.author}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 11.5,
                                        color: const Color(0xFF64748B),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                note.description,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: const Color(0xFF64748B),
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Actions on right
                        if (isAiPendingReview) ...[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () => _showReviewNoteDialog(note),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1E2865),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: Text(
                                  "Review",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              IconButton(
                                icon: const Icon(Icons.delete_outline_rounded, size: 17, color: Color(0xFFDC2626)),
                                onPressed: () => _showDeleteStudyNoteDialog(note),
                                splashRadius: 18,
                                tooltip: "Delete note",
                              ),
                            ],
                          ),
                        ] else ...[
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined, size: 17, color: Color(0xFF64748B)),
                                onPressed: () => _openStudyNotesEditor(note),
                                splashRadius: 18,
                                tooltip: "Edit note",
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline_rounded, size: 17, color: Color(0xFFDC2626)),
                                onPressed: () => _showDeleteStudyNoteDialog(note),
                                splashRadius: 18,
                                tooltip: "Delete note",
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // STUDY NOTES FULL EDITOR CARD (Matches Image 2 exactly)
  // ===========================================================================
  Widget _buildStudyNotesEditorCard(StudyNoteItem note, BoxConstraints constraints) {
    final isWide = constraints.maxWidth >= 780;

    final leftColumnWidgets = [
      _buildEditorField(
        label: "Key points",
        sublabel: "One per line, up to 15",
        controller: _noteKeyPointsCtrl,
        maxLines: 7,
        hint: "Enter key facts, one per line...",
      ),
      const SizedBox(height: 18),
      _buildEditorField(
        label: "Formulas & rules",
        sublabel: "One per line (leave empty for fact topics)",
        controller: _noteFormulasCtrl,
        maxLines: 4,
        hint: "e.g. Master Theorem: T(n) = aT(n/b) + f(n)",
      ),
      const SizedBox(height: 18),
      _buildEditorField(
        label: "Worked example: problem",
        controller: _noteWorkedProblemCtrl,
        maxLines: 4,
        hint: "Describe a concrete example problem...",
      ),
    ];

    final rightColumnWidgets = [
      _buildEditorField(
        label: "Worked example: solution",
        controller: _noteWorkedSolutionCtrl,
        maxLines: 7,
        hint: "Step-by-step model solution...",
      ),
      const SizedBox(height: 18),
      _buildEditorField(
        label: "Common mistakes",
        sublabel: "One per line",
        controller: _noteMistakesCtrl,
        maxLines: 4,
        hint: "Mistakes students commonly make...",
      ),
      const SizedBox(height: 18),
      _buildEditorField(
        label: "Exam tips",
        sublabel: "One per line",
        controller: _noteTipsCtrl,
        maxLines: 4,
        hint: "e.g. Revise these facts again the day after...",
      ),
    ];

    return Container(
      width: double.infinity,
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
      padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Study notes: <Topic>
          Text(
            "Study notes: ${note.title}",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Plain text. One item per line in the lists. Saving replaces any earlier notes for this topic.",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 22),

          // Overview Field with Dynamic Character Counter (e.g. Overview (116/1200))
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Overview (${_noteOverviewCtrl.text.length}/1200)",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _noteOverviewCtrl,
                maxLines: 3,
                maxLength: 1200,
                buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
                style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A), height: 1.45),
                decoration: _studyNoteInputDecoration(
                  hint: "Brief summary of the topic and why it matters in the syllabus...",
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 2-Column Responsive Form Layout (Matches Screenshot 2)
          if (isWide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: leftColumnWidgets,
                  ),
                ),
                const SizedBox(width: 22),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: rightColumnWidgets,
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...leftColumnWidgets,
                const SizedBox(height: 18),
                ...rightColumnWidgets,
              ],
            ),

          const SizedBox(height: 26),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 18),

          // Bottom Actions: [x] Publish to students | Cancel | Publish notes
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: _notePublishToStudents,
                    activeColor: const Color(0xFF1E2865),
                    onChanged: (val) => setState(() => _notePublishToStudents = val ?? true),
                  ),
                  Text(
                    "Publish to students",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OutlinedButton(
                    onPressed: () => setState(() => _editingStudyNote = null),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      "Cancel",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _saveAndPublishStudyNotes,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E2865),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      "Publish notes",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditorField({
    required String label,
    String? sublabel,
    required TextEditingController controller,
    required int maxLines,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E293B),
              ),
            ),
            if (sublabel != null) ...[
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  sublabel,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.poppins(fontSize: 12.5, color: const Color(0xFF0F172A), height: 1.45),
          decoration: _studyNoteInputDecoration(hint: hint),
        ),
      ],
    );
  }

  InputDecoration _studyNoteInputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF94A3B8)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
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
  Widget _buildPillBadge(
    String text, {
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT / GRAPH PAPER GRID PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;

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
