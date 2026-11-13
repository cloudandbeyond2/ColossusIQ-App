import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// AI COURSE & CERTIFICATION: AI QUIZ BUILDER SCREEN
// Complete implementation matching all 5 design views & interactive click events:
// 1. Dashboard View: Blueprint grid hero banner, disclaimer banner, 4 KPI stats,
//    search, department filter, status pills, data table with Results, Edit, Close, Delete.
// 2. Interactive AI Quiz Builder / Editor (Screenshots 1 to 5):
//    - Left Panel: "Quiz settings" / "Edit quiz settings", Department, Topic,
//      Question count, Difficulty, Notes, "✦ Regenerate questions" button,
//      Quiz title, Course/subject, Pass mark %, Minutes, Mark-based certificate checkbox.
//    - Right Panel: AI-generated info banner, Question Cards (Statement, 4 interactive
//      radio options with green selection & click event, explanation textarea, trash icon).
//    - Floating / Sticky Bottom Bar: Questions count, "Save draft" and "Publish quiz" /
//      "Save & publish" with full click events and state updates!
// =============================================================================

class AiQuizBuilderScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AiQuizBuilderScreen({super.key, this.onBack});

  @override
  State<AiQuizBuilderScreen> createState() => _AiQuizBuilderScreenState();
}

class _AiQuizBuilderScreenState extends State<AiQuizBuilderScreen> {
  // View toggle:
  // false = Quizzes Dashboard Table (Default view)
  // true = Interactive Quiz Builder / Editor
  bool _isBuilderOpen = false; // Default: show quiz list
  bool _isEditMode = false;

  // Active quiz being viewed in Results Mode (null = not in results view)
  QuizBuilderItem? _viewingResultsQuiz;

  // Search & Filter state for Dashboard
  final TextEditingController _searchController = TextEditingController();
  String _selectedDept = "All departments (8)";
  String _activeFilter = "All"; // "All", "Published", "Draft", "Closed"

  // Builder Settings Form Controllers
  String _builderDept = "Computer Science & Engineering";
  final TextEditingController _topicCtrl = TextEditingController();
  final TextEditingController _numQuestionsCtrl = TextEditingController(text: "8");
  String _builderDifficulty = "Mixed";
  final TextEditingController _notesCtrl = TextEditingController();
  final TextEditingController _quizTitleCtrl =
      TextEditingController(text: "Computer Science & Engineering quiz");
  final TextEditingController _courseSubjectCtrl =
      TextEditingController(text: "Computer Science & Engineering");
  final TextEditingController _passMarkCtrl = TextEditingController(text: "50");
  final TextEditingController _durationMinutesCtrl =
      TextEditingController(text: "20");
  bool _issueCertificate = true;

  // Questions in builder
  List<QuizBuilderQuestion> _questions = [];

  // Active quiz being edited (if in edit mode)
  QuizBuilderItem? _currentEditingQuiz;

  // Department quizzes dataset
  late List<QuizBuilderItem> _quizzes;

  // 10 Detailed Questions for Quiz Results View matching screenshots
  final List<QuizResultQuestionDetail> _resultQuestionsDetails = const [
    QuizResultQuestionDetail(
      questionText:
          "Consider a scenario where a large number of insertions and deletions are performed at arbitrary positions in a list, and memory usage is a critical concern. Which data structure would be most efficient if random access is not frequently required?",
      options: [
        "Doubly Linked List",
        "Singly Linked List",
        "Hash Table",
        "Array"
      ],
      correctIndex: 0,
    ),
    QuizResultQuestionDetail(
      questionText:
          "You are designing a system that processes tasks with varying priorities. Tasks with higher priority should always be processed before tasks with lower priority, and among tasks of the same priority, they should be processed in a First-In, First-Out (FIFO) manner. Which data structure is most suitable for managing these tasks?",
      options: [
        "Circular Queue",
        "Priority Queue implemented with a Min-Heap",
        "Stack",
        "Hash Map"
      ],
      correctIndex: 1,
    ),
    QuizResultQuestionDetail(
      questionText:
          "Given a binary search tree (BST) where each node also stores the count of nodes in its left subtree, how can you efficiently find the k-th smallest element in O(h) time, where h is the height of the tree?",
      options: [
        "By traversing the tree, comparing k with the left subtree count at each node, and deciding to go left, right, or return the current node.",
        "By performing an in-order traversal and stopping after visiting k nodes.",
        "By repeatedly finding the minimum element k times.",
        "By converting the BST into a sorted array and then accessing the k-th element."
      ],
      correctIndex: 0,
    ),
    QuizResultQuestionDetail(
      questionText:
          "Consider a scenario where you need to implement an 'undo' functionality in a text editor. The editor must be able to undo the last 'N' operations. Which data structure is most appropriate for storing the operations to be undone?",
      options: [
        "A fixed-size array used as a circular buffer for a stack-like behavior",
        "A linked list of operations",
        "A queue of operations",
        "A hash table mapping operation IDs to operations"
      ],
      correctIndex: 0,
    ),
    QuizResultQuestionDetail(
      questionText:
          "You are tasked with merging 'k' sorted lists, each of length 'n', into a single sorted list. Which approach offers the most optimal time complexity?",
      options: [
        "Repeatedly merging two lists at a time using a standard merge sort merge operation.",
        "Using a large hash map to store all elements and then iterating through the map in sorted order.",
        "Using a Min-Heap to store the smallest element from each list.",
        "Concatenating all lists and then sorting the entire combined list using Quick Sort."
      ],
      correctIndex: 2,
    ),
    QuizResultQuestionDetail(
      questionText:
          "Which sorting algorithm has a worst-case time complexity of O(n log n) and is also stable?",
      options: [
        "Insertion Sort",
        "Merge Sort",
        "Quick Sort",
        "Heap Sort"
      ],
      correctIndex: 1,
    ),
    QuizResultQuestionDetail(
      questionText:
          "Consider a scenario where you need to implement a dictionary that supports searching, insertion, and deletion of elements, and also needs to efficiently find the element with the smallest key that is greater than a given key (successor). Which data structure is best suited for this requirement?",
      options: [
        "Self-balancing Binary Search Tree (e.g., AVL tree or Red-Black tree)",
        "Hash Table",
        "Singly Linked List",
        "Array"
      ],
      correctIndex: 0,
    ),
    QuizResultQuestionDetail(
      questionText:
          "You are given an array of 'n' integers, and you need to find the maximum sum of a contiguous subarray. Which algorithm can solve this problem in O(n) time?",
      options: [
        "Quick Sort",
        "Binary Search",
        "Merge Sort",
        "Kadane's Algorithm"
      ],
      correctIndex: 3,
    ),
    QuizResultQuestionDetail(
      questionText:
          "What is the primary advantage of using a circular linked list over a singly linked list for implementing a round-robin scheduler?",
      options: [
        "It simplifies traversal by eliminating the need to check for a null pointer at the end.",
        "It consumes less memory due to fewer pointers.",
        "It makes insertions and deletions at the head more efficient.",
        "It allows for direct access to the last node from any node in O(1) time."
      ],
      correctIndex: 3,
    ),
    QuizResultQuestionDetail(
      questionText:
          "When implementing a stack using a singly linked list, which operation would typically have a worst-case time complexity of O(N), assuming the stack grows by adding elements to the end of the list?",
      options: [
        "Checking if the stack is empty",
        "Pushing an element",
        "Popping an element",
        "Accessing the top element"
      ],
      correctIndex: 2,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initMockQuizzes();
    _initDefaultQuestions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _topicCtrl.dispose();
    _numQuestionsCtrl.dispose();
    _notesCtrl.dispose();
    _quizTitleCtrl.dispose();
    _courseSubjectCtrl.dispose();
    _passMarkCtrl.dispose();
    _durationMinutesCtrl.dispose();
    for (var q in _questions) {
      q.dispose();
    }
    super.dispose();
  }

  void _initMockQuizzes() {
    _quizzes = [
      QuizBuilderItem(
        id: "QZ201",
        title: "Computer Science & Engineering quiz",
        dept: "Computer Science & Engineering",
        duration: "20 min",
        hasCert: true,
        questionsCount: 8,
        passMark: "50%",
        students: "0",
        average: "—",
        passRate: "—",
        status: "Closed",
      ),
      QuizBuilderItem(
        id: "QZ202",
        title:
            "Computer Science & Engineering — Data Structures and Algorithms quiz",
        dept: "Computer Science & Engineering",
        duration: "20 min",
        hasCert: true,
        questionsCount: 10,
        passMark: "50%",
        students: "1",
        average: "90%",
        passRate: "100%",
        status: "Published",
      ),
      QuizBuilderItem(
        id: "QZ203",
        title: "Computer Science & Engineering — Web Technologies quiz",
        dept: "Computer Science & Engineering",
        duration: "20 min",
        hasCert: true,
        questionsCount: 10,
        passMark: "50%",
        students: "1",
        average: "40%",
        passRate: "100%",
        status: "Published",
      ),
      QuizBuilderItem(
        id: "QZ204",
        title: "Computer Science & Engineering — DBMS quiz",
        dept: "Computer Science & Engineering",
        duration: "20 min",
        hasCert: true,
        questionsCount: 8,
        passMark: "50%",
        students: "1",
        average: "50%",
        passRate: "100%",
        status: "Published",
      ),
      QuizBuilderItem(
        id: "QZ205",
        title: "Placement aptitude — quantitative",
        dept: "Training & Placement",
        duration: "10 min",
        hasCert: true,
        questionsCount: 8,
        passMark: "60%",
        students: "4",
        average: "68%",
        passRate: "75%",
        status: "Published",
      ),
      QuizBuilderItem(
        id: "QZ206",
        title: "Electronics & Communication — Embedded Systems",
        dept: "Electronics & Communication",
        duration: "15 min",
        hasCert: true,
        questionsCount: 10,
        passMark: "50%",
        students: "2",
        average: "70%",
        passRate: "100%",
        status: "Published",
      ),
      QuizBuilderItem(
        id: "QZ207",
        title: "Information Technology — Cloud Computing",
        dept: "Information Technology",
        duration: "20 min",
        hasCert: true,
        questionsCount: 10,
        passMark: "50%",
        students: "1",
        average: "80%",
        passRate: "100%",
        status: "Published",
      ),
      QuizBuilderItem(
        id: "QZ208",
        title: "Computer Science & Engineering — Operating Systems quiz",
        dept: "Computer Science & Engineering",
        duration: "20 min",
        hasCert: true,
        questionsCount: 10,
        passMark: "50%",
        students: "1",
        average: "70%",
        passRate: "100%",
        status: "Published",
      ),
    ];
  }

  void _initDefaultQuestions() {
    _questions = [
      QuizBuilderQuestion(
        questionText: "Which data structure uses LIFO order?",
        options: ["Heap", "Queue", "Stack", "Linked list"],
        correctIndex: 2, // Stack
        explanation:
            "A stack removes the most recently added element first (Last In, First Out).",
      ),
      QuizBuilderQuestion(
        questionText:
            "Worst-case time complexity of binary search on a sorted array of n items is...",
        options: ["O(n log n)", "O(n)", "O(1)", "O(log n)"],
        correctIndex: 3, // O(log n)
        explanation:
            "Each comparison halves the search space, giving O(log n).",
      ),
      QuizBuilderQuestion(
        questionText:
            "A relation in which every determinant is a candidate key is in...",
        options: ["3NF", "1NF", "BCNF", "2NF"],
        correctIndex: 2, // BCNF
        explanation:
            "BCNF requires every determinant of a non-trivial FD to be a superkey.",
      ),
      QuizBuilderQuestion(
        questionText:
            "Which scheduling algorithm can cause starvation of long processes?",
        options: [
          "Shortest job first",
          "FCFS",
          "Multilevel feedback with ageing",
          "Round robin"
        ],
        correctIndex: 0, // Shortest job first
        explanation:
            "SJF keeps favouring short jobs, so long jobs may wait indefinitely.",
      ),
      QuizBuilderQuestion(
        questionText:
            "Which layer of the OSI model is responsible for routing?",
        options: ["Network", "Data link", "Transport", "Session"],
        correctIndex: 0, // Network
        explanation:
            "The network layer (Layer 3) selects paths and routes packets.",
      ),
      QuizBuilderQuestion(
        questionText: "SQL injection is best prevented by...",
        options: [
          "Using POST instead of GET",
          "Parameterised queries",
          "Hiding error messages",
          "Client-side validation"
        ],
        correctIndex: 1, // Parameterised queries
        explanation:
            "Parameterised queries keep data separate from SQL code.",
      ),
      QuizBuilderQuestion(
        questionText:
            "In Agile Scrum, the time-boxed iteration is called a...",
        options: ["Epic", "Backlog", "Milestone", "Sprint"],
        correctIndex: 3, // Sprint
        explanation:
            "A sprint is a fixed-length iteration, typically 1–4 weeks.",
      ),
      QuizBuilderQuestion(
        questionText:
            "What is the primary role of a subnet mask in IPv4 networking?",
        options: [
          "To identify the MAC address of the default gateway",
          "To distinguish network portion from host portion of an IP address",
          "To encrypt packet headers across Ethernet switches",
          "To assign dynamic DHCP host IP leases"
        ],
        correctIndex: 1, // Distinguish network portion
        explanation:
            "A subnet mask separates the IP address into network and host portions.",
      ),
    ];
  }

  // Dashboard getters
  int get _publishedCount =>
      _quizzes.where((q) => q.status == "Published").length;

  List<QuizBuilderItem> get _filteredQuizzes {
    final query = _searchController.text.trim().toLowerCase();
    return _quizzes.where((q) {
      if (_activeFilter != "All" && q.status != _activeFilter) {
        return false;
      }
      if (_selectedDept != "All departments (8)" && q.dept != _selectedDept) {
        return false;
      }
      if (query.isNotEmpty) {
        final title = q.title.toLowerCase();
        final dept = q.dept.toLowerCase();
        return title.contains(query) || dept.contains(query);
      }
      return true;
    }).toList();
  }

  // Quiz Results Action
  void _openQuizResults(QuizBuilderItem quiz) {
    setState(() {
      _viewingResultsQuiz = quiz;
      _isBuilderOpen = false;
      _isEditMode = false;
    });
  }

  // Builder actions
  void _openNewBuilder() {
    setState(() {
      _viewingResultsQuiz = null;
      _isBuilderOpen = true;
      _isEditMode = false;
      _currentEditingQuiz = null;
      _builderDept = "Computer Science & Engineering";
      _topicCtrl.clear();
      _numQuestionsCtrl.text = "8";
      _builderDifficulty = "Mixed";
      _notesCtrl.clear();
      _quizTitleCtrl.text = "Computer Science & Engineering quiz";
      _courseSubjectCtrl.text = "Computer Science & Engineering";
      _passMarkCtrl.text = "50";
      _durationMinutesCtrl.text = "20";
      _issueCertificate = true;
      _initDefaultQuestions();
    });
  }

  void _openEditBuilder(QuizBuilderItem quiz) {
    setState(() {
      _viewingResultsQuiz = null;
      _isBuilderOpen = true;
      _isEditMode = true;
      _currentEditingQuiz = quiz;
      _builderDept = quiz.dept;
      _topicCtrl.clear();
      _numQuestionsCtrl.text = "${quiz.questionsCount}";
      _builderDifficulty = "Mixed";
      _notesCtrl.clear();
      _quizTitleCtrl.text = quiz.title;
      _courseSubjectCtrl.text = quiz.dept;
      _passMarkCtrl.text = quiz.passMark.replaceAll("%", "");
      _durationMinutesCtrl.text = quiz.duration.replaceAll(" min", "");
      _issueCertificate = quiz.hasCert;
      _initDefaultQuestions();
    });
  }

  void _regenerateQuestions() {
    final count = int.tryParse(_numQuestionsCtrl.text.trim()) ?? 8;
    setState(() {
      _initDefaultQuestions();
      if (count < _questions.length) {
        _questions = _questions.sublist(0, count);
      } else if (count > _questions.length) {
        for (int i = _questions.length + 1; i <= count; i++) {
          _questions.add(
            QuizBuilderQuestion(
              questionText:
                  "Sample question $i generated by AI for $_builderDept...",
              options: [
                "Option A (Verified)",
                "Option B",
                "Option C",
                "Option D"
              ],
              correctIndex: 0,
              explanation: "Explanation generated for question $i.",
            ),
          );
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "✦ Regenerated ${_questions.length} questions from $_builderDept question bank!",
        ),
        backgroundColor: const Color(0xFF4338CA),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _saveQuiz({required bool publish}) {
    final title = _quizTitleCtrl.text.trim().isNotEmpty
        ? _quizTitleCtrl.text.trim()
        : "Untitled Quiz";
    final duration = "${_durationMinutesCtrl.text.trim()} min";
    final passMark = "${_passMarkCtrl.text.trim()}%";

    setState(() {
      if (_isEditMode && _currentEditingQuiz != null) {
        _currentEditingQuiz!.title = title;
        _currentEditingQuiz!.dept = _builderDept;
        _currentEditingQuiz!.duration = duration;
        _currentEditingQuiz!.passMark = passMark;
        _currentEditingQuiz!.hasCert = _issueCertificate;
        _currentEditingQuiz!.questionsCount = _questions.length;
        if (publish) _currentEditingQuiz!.status = "Published";
      } else {
        _quizzes.insert(
          0,
          QuizBuilderItem(
            id: "QZ${DateTime.now().millisecondsSinceEpoch % 1000}",
            title: title,
            dept: _builderDept,
            duration: duration,
            hasCert: _issueCertificate,
            questionsCount: _questions.length,
            passMark: passMark,
            students: "0",
            average: "—",
            passRate: "—",
            status: publish ? "Published" : "Draft",
          ),
        );
      }
      _isBuilderOpen = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          publish
              ? "Quiz '$title' published to students successfully!"
              : "Quiz draft '$title' saved.",
        ),
        backgroundColor:
            publish ? const Color(0xFF15803D) : const Color(0xFF141938),
      ),
    );
  }

  void _addNewQuestion() {
    setState(() {
      _questions.add(
        QuizBuilderQuestion(
          questionText: "Enter new question statement here...",
          options: ["Option A", "Option B", "Option C", "Option D"],
          correctIndex: 0,
          explanation: "Explanation for the correct answer.",
        ),
      );
      _numQuestionsCtrl.text = "${_questions.length}";
    });
  }

  void _deleteQuestion(int index) {
    if (_questions.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("A quiz must have at least one question."),
          backgroundColor: Color(0xFFDC2626),
        ),
      );
      return;
    }
    setState(() {
      _questions[index].dispose();
      _questions.removeAt(index);
      _numQuestionsCtrl.text = "${_questions.length}";
    });
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
              const SizedBox(height: 14),

              // 2. Info Alert Banner
              _buildDisclaimerAlert(),
              const SizedBox(height: 18),

              // 3. Render Results View, Builder View, or Dashboard Table
              if (_viewingResultsQuiz != null)
                _buildQuizResultsView(isNarrow)
              else if (_isBuilderOpen)
                _buildQuizBuilderView(isNarrow)
              else ...[
                _buildMetricCardsRow(isNarrow),
                const SizedBox(height: 20),
                _buildQuizzesCard(),
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
                  Icons.assignment_turned_in_rounded,
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
                          "AI Course & Certification",
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
                          "AI Quiz Builder",
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
                            Icons.assignment_turned_in_rounded,
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
                                  "AI COURSE & CERTIFICATION",
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
                              "AI Quiz Builder",
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
                    "Generate department MCQs, edit them, set pass mark and time, enable certificates and track results.",
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
  // 2. DISCLAIMER ALERT
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
              "Review every AI-generated question and answer key before publishing. Questions marked \"review\" were built from templates.",
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
  // 3. FULL INTERACTIVE AI QUIZ BUILDER VIEW (MATCHES SCREENSHOTS 1 TO 5)
  // ===========================================================================
  Widget _buildQuizBuilderView(bool isNarrow) {
    if (isNarrow) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildQuizSettingsPanel(),
          const SizedBox(height: 18),
          _buildAiGeneratedNoticeCard(),
          const SizedBox(height: 14),
          _buildQuestionsList(),
          const SizedBox(height: 20),
          _buildBuilderStickyBottomBar(),
        ],
      );
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: Quiz settings
            SizedBox(
              width: 320,
              child: _buildQuizSettingsPanel(),
            ),
            const SizedBox(width: 20),

            // Right Column: AI Info Banner & Question Cards
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAiGeneratedNoticeCard(),
                  const SizedBox(height: 14),
                  _buildQuestionsList(),
                  const SizedBox(height: 20),
                  _buildBuilderStickyBottomBar(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Left Panel: Quiz Settings (Screenshots 1, 2, 5)
  Widget _buildQuizSettingsPanel() {
    return Container(
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
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: "Quiz settings" / "Edit quiz settings" and "Cancel"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _isEditMode ? "Edit quiz settings" : "Quiz settings",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              InkWell(
                onTap: () => setState(() => _isBuilderOpen = false),
                borderRadius: BorderRadius.circular(6),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Department Dropdown
          Text("Department",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _builderDept,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: Color(0xFF64748B)),
                style: GoogleFonts.poppins(
                    fontSize: 12, color: const Color(0xFF1E293B)),
                items: [
                  "Computer Science & Engineering",
                  "Information Technology",
                  "Electronics & Communication",
                  "Training & Placement",
                ]
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _builderDept = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Topic (optional)
          Text("Topic (optional)",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          SizedBox(
            height: 42,
            child: TextField(
              controller: _topicCtrl,
              style: GoogleFonts.poppins(fontSize: 12),
              decoration: InputDecoration(
                hintText: "e.g. Normalization, Cardiac cycle",
                hintStyle: GoogleFonts.poppins(
                    fontSize: 11.5, color: const Color(0xFF94A3B8)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Number of questions
          Text("Number of questions",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          SizedBox(
            height: 42,
            child: TextField(
              controller: _numQuestionsCtrl,
              keyboardType: TextInputType.number,
              style: GoogleFonts.poppins(fontSize: 12.5),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Difficulty
          Text("Difficulty",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFCBD5E1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _builderDifficulty,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down,
                    color: Color(0xFF64748B)),
                style: GoogleFonts.poppins(
                    fontSize: 12, color: const Color(0xFF1E293B)),
                items: ["Mixed", "Easy", "Medium", "Hard"]
                    .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _builderDifficulty = val);
                },
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Your notes (optional)
          Text("Your notes (optional)",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          TextField(
            controller: _notesCtrl,
            maxLines: 4,
            style: GoogleFonts.poppins(fontSize: 12),
            decoration: InputDecoration(
              hintText:
                  "Paste a syllabus or lecture notes and the questions stay within them.",
              hintStyle: GoogleFonts.poppins(
                  fontSize: 11, color: const Color(0xFF94A3B8)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
          const SizedBox(height: 16),

          // ✦ Regenerate questions button (Click Event)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _regenerateQuestions,
              icon: const Icon(Icons.auto_awesome, size: 15),
              label: Text(
                "Regenerate questions",
                style: GoogleFonts.poppins(
                    fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3730A3),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Quiz title
          Text("Quiz title",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          SizedBox(
            height: 42,
            child: TextField(
              controller: _quizTitleCtrl,
              style: GoogleFonts.poppins(fontSize: 12),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Course / subject
          Text("Course / subject",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF334155))),
          const SizedBox(height: 6),
          SizedBox(
            height: 42,
            child: TextField(
              controller: _courseSubjectCtrl,
              style: GoogleFonts.poppins(fontSize: 12),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Pass mark % & Minutes
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Pass mark %",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155))),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 42,
                      child: TextField(
                        controller: _passMarkCtrl,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.poppins(fontSize: 12),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFCBD5E1)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Minutes",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF334155))),
                    const SizedBox(height: 6),
                    SizedBox(
                      height: 42,
                      child: TextField(
                        controller: _durationMinutesCtrl,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.poppins(fontSize: 12),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Color(0xFFCBD5E1)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Issue mark-based certificate checkbox
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: _issueCertificate,
                    activeColor: const Color(0xFF141938),
                    onChanged: (val) =>
                        setState(() => _issueCertificate = val ?? false),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Issue mark-based certificate",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Students who pass get a signed certificate graded O / A+ / A / B / C.",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Right Panel: AI Info Notice Card (Screenshot 1)
  Widget _buildAiGeneratedNoticeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome,
                  size: 14, color: Color(0xFF6366F1)),
              const SizedBox(width: 6),
              Text(
                "AI-generated — verify important details",
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF4F46E5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "${_questions.length} from the curated $_builderDept bank. The AI could not write questions this time, so the built-in bank was used. Try again.",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF475569),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // Right Panel: Questions List (Screenshots 1 to 4)
  Widget _buildQuestionsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _questions.length,
      itemBuilder: (context, qIdx) {
        final q = _questions[qIdx];
        final qNumber = qIdx + 1;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(18),
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
              // Question Header & Trash Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Question $qNumber",
                    style: GoogleFonts.poppins(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _deleteQuestion(qIdx),
                    icon: const Icon(Icons.delete_outline_rounded,
                        size: 18, color: Color(0xFF94A3B8)),
                    tooltip: "Delete question",
                    splashRadius: 18,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Question Statement Textarea
              TextField(
                controller: q.textController,
                maxLines: 2,
                style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 14),

              // 4 Options Grid (Click event to toggle correct answer!)
              LayoutBuilder(
                builder: (context, optConstraints) {
                  final isWideOpt = optConstraints.maxWidth >= 540;

                  final optA = _buildOptionChoiceCard(q, 0, "A");
                  final optB = _buildOptionChoiceCard(q, 1, "B");
                  final optC = _buildOptionChoiceCard(q, 2, "C");
                  final optD = _buildOptionChoiceCard(q, 3, "D");

                  if (isWideOpt) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(child: optA),
                            const SizedBox(width: 12),
                            Expanded(child: optB),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(child: optC),
                            const SizedBox(width: 12),
                            Expanded(child: optD),
                          ],
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      optA,
                      const SizedBox(height: 8),
                      optB,
                      const SizedBox(height: 8),
                      optC,
                      const SizedBox(height: 8),
                      optD,
                    ],
                  );
                },
              ),
              const SizedBox(height: 14),

              // Explanation shown after submission
              Text(
                "Explanation shown after submission",
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: q.explanationController,
                maxLines: 2,
                style: GoogleFonts.poppins(fontSize: 12),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Interactive Option Choice Card: Clicking selects correct radio option!
  Widget _buildOptionChoiceCard(
      QuizBuilderQuestion q, int optIndex, String letter) {
    final isSelected = q.correctIndex == optIndex;

    return InkWell(
      onTap: () {
        setState(() {
          q.correctIndex = optIndex;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0FDF4) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF86EFAC)
                : const Color(0xFFE2E8F0),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              size: 16,
              color: isSelected
                  ? const Color(0xFF16A34A)
                  : const Color(0xFF94A3B8),
            ),
            const SizedBox(width: 8),
            Text(
              "$letter ",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? const Color(0xFF15803D)
                    : const Color(0xFF64748B),
              ),
            ),
            Expanded(
              child: TextField(
                controller: q.optionControllers[optIndex],
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFF14532D)
                      : const Color(0xFF1E293B),
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Floating / Sticky Bottom Bar (Screenshots 1, 2, 4, 5)
  Widget _buildBuilderStickyBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        runSpacing: 10,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${_questions.length} questions",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                onPressed: _addNewQuestion,
                icon: const Icon(Icons.add, size: 14),
                label: const Text("Add Question"),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  foregroundColor: const Color(0xFF334155),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
          Wrap(
            spacing: 10,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Save Draft Button
              OutlinedButton(
                onPressed: () => _saveQuiz(publish: false),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  side: const BorderSide(color: Color(0xFFCBD5E1)),
                  foregroundColor: const Color(0xFF334155),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  _isEditMode ? "Save as draft" : "Save draft",
                  style: GoogleFonts.poppins(
                      fontSize: 12.5, fontWeight: FontWeight.w600),
                ),
              ),

              // Publish Quiz Button (Gold / Amber)
              ElevatedButton.icon(
                onPressed: () => _saveQuiz(publish: true),
                icon: const Icon(Icons.send_rounded, size: 14),
                label: Text(
                  _isEditMode ? "Save & publish" : "Publish quiz",
                  style: GoogleFonts.poppins(
                      fontSize: 12.5, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD97706),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. METRIC CARDS ROW (DASHBOARD)
  // ===========================================================================
  Widget _buildMetricCardsRow(bool isNarrow) {
    final cards = [
      _buildMetricCard(
        icon: Icons.quiz_outlined,
        title: "Quizzes",
        value: "${_quizzes.length}",
      ),
      _buildMetricCard(
        icon: Icons.check_circle_outline_rounded,
        title: "Published",
        value: "$_publishedCount",
      ),
      _buildMetricCard(
        icon: Icons.people_outline_rounded,
        title: "Attempts",
        value: "10",
      ),
      _buildMetricCard(
        icon: Icons.analytics_outlined,
        title: "Average score",
        value: "52%",
      ),
    ];

    if (isNarrow) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 12),
              Expanded(child: cards[1]),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: cards[2]),
              const SizedBox(width: 12),
              Expanded(child: cards[3]),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: cards[0]),
        const SizedBox(width: 14),
        Expanded(child: cards[1]),
        const SizedBox(width: 14),
        Expanded(child: cards[2]),
        const SizedBox(width: 14),
        Expanded(child: cards[3]),
      ],
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          Row(
            children: [
              Icon(icon, size: 16, color: const Color(0xFF64748B)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 5. MAIN CARD: DEPARTMENT QUIZZES TABLE (DASHBOARD)
  // ===========================================================================
  Widget _buildQuizzesCard() {
    final filtered = _filteredQuizzes;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with + New AI quiz button
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 10,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Department quizzes",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Server-scored · students never receive the answer key",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: _openNewBuilder,
                icon: const Icon(Icons.auto_awesome_rounded, size: 16),
                label: Text(
                  "New AI quiz",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF141938),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Search + Dropdown + Filter Pills Row
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 760;
              final searchField = Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFD),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    const Icon(Icons.search_rounded,
                        size: 17, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        style: GoogleFonts.poppins(fontSize: 12),
                        decoration: InputDecoration(
                          hintText: "Search quizzes...",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 12, color: const Color(0xFF94A3B8)),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  ],
                ),
              );

              final deptDropdown = Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedDept,
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: const Color(0xFF334155)),
                    items: [
                      "All departments (8)",
                      "Computer Science & Engineering",
                      "Information Technology",
                      "Electronics & Communication",
                      "Training & Placement"
                    ]
                        .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedDept = val);
                    },
                  ),
                ),
              );

              final pills = Row(
                children: [
                  _buildFilterPill("All"),
                  const SizedBox(width: 6),
                  _buildFilterPill("Published"),
                  const SizedBox(width: 6),
                  _buildFilterPill("Draft"),
                  const SizedBox(width: 6),
                  _buildFilterPill("Closed"),
                ],
              );

              if (isWide) {
                return Row(
                  children: [
                    Expanded(flex: 3, child: searchField),
                    const SizedBox(width: 10),
                    deptDropdown,
                    const SizedBox(width: 10),
                    pills,
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  searchField,
                  const SizedBox(height: 10),
                  Row(children: [Expanded(child: deptDropdown)]),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: pills,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 18),

          // Horizontally Scrollable Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 1000),
              child: DataTable(
                dataRowMinHeight: 64,
                dataRowMaxHeight: 74,
                headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFF8FAFC)),
                headingTextStyle: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF64748B),
                  letterSpacing: 0.5,
                ),
                dataTextStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF1E293B),
                ),
                horizontalMargin: 12,
                columnSpacing: 22,
                columns: const [
                  DataColumn(label: Text("QUIZ")),
                  DataColumn(label: Text("QUESTIONS")),
                  DataColumn(label: Text("PASS MARK")),
                  DataColumn(label: Text("STUDENTS")),
                  DataColumn(label: Text("AVERAGE")),
                  DataColumn(label: Text("PASS RATE")),
                  DataColumn(label: Text("STATUS")),
                  DataColumn(label: Text("ACTIONS")),
                ],
                rows: filtered.map((quiz) {
                  return DataRow(
                    cells: [
                      // QUIZ
                      DataCell(
                        SizedBox(
                          width: 290,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                quiz.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "${quiz.dept} · ${quiz.duration} · ${quiz.hasCert ? "certificate" : ""}",
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: const Color(0xFF64748B),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // QUESTIONS
                      DataCell(Text("${quiz.questionsCount}")),

                      // PASS MARK
                      DataCell(Text(quiz.passMark)),

                      // STUDENTS
                      DataCell(Text(quiz.students)),

                      // AVERAGE
                      DataCell(
                        quiz.average == "—"
                            ? Text(
                                "—",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF64748B),
                                ),
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2.5),
                                decoration: BoxDecoration(
                                  color: quiz.average == "40%"
                                      ? const Color(0xFFFEF3C7)
                                      : const Color(0xFFE0F2FE),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  quiz.average,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: quiz.average == "40%"
                                        ? const Color(0xFFD97706)
                                        : const Color(0xFF0369A1),
                                  ),
                                ),
                              ),
                      ),

                      // PASS RATE
                      DataCell(Text(quiz.passRate)),

                      // STATUS
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: quiz.status == "Published"
                                ? const Color(0xFFDCFCE7)
                                : const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            quiz.status,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: quiz.status == "Published"
                                  ? const Color(0xFF15803D)
                                  : const Color(0xFFB91C1C),
                            ),
                          ),
                        ),
                      ),

                      // ACTIONS: Results, Edit, Publish/Close, Delete
                      DataCell(
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () => _openQuizResults(quiz),
                              icon: const Icon(Icons.bar_chart_rounded,
                                  size: 14),
                              label: const Text("Results"),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                foregroundColor: const Color(0xFF334155),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            const SizedBox(width: 6),
                            OutlinedButton.icon(
                              onPressed: () => _openEditBuilder(quiz),
                              icon: const Icon(Icons.edit_outlined, size: 14),
                              label: const Text("Edit"),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                side: const BorderSide(color: Color(0xFFCBD5E1)),
                                foregroundColor: const Color(0xFF4338CA),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            const SizedBox(width: 6),
                            OutlinedButton(
                              onPressed: () {
                                final isNowClosed =
                                    quiz.status == "Published";
                                setState(() {
                                  quiz.status =
                                      isNowClosed ? "Closed" : "Published";
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "${quiz.title} is now ${quiz.status}"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                side: BorderSide(
                                  color: quiz.status == "Published"
                                      ? const Color(0xFFCBD5E1)
                                      : const Color(0xFF15803D),
                                ),
                                foregroundColor: const Color(0xFF334155),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: Text(
                                quiz.status == "Published" ? "Close" : "Publish",
                                style: GoogleFonts.poppins(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _quizzes.remove(quiz);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("${quiz.title} deleted"),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete_outline_rounded,
                                  size: 16, color: Color(0xFFDC2626)),
                              tooltip: "Delete quiz",
                              splashRadius: 18,
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
        ],
      ),
    );
  }

  Widget _buildFilterPill(String filterName) {
    final isSelected = _activeFilter == filterName;
    return InkWell(
      onTap: () => setState(() => _activeFilter = filterName),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF141938) : const Color(0xFFF1F5F9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          filterName,
          style: GoogleFonts.poppins(
            fontSize: 11.5,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 6. QUIZ RESULTS & ANALYTICS VIEW (MATCHING USER SCREENSHOTS 1-4)
  // ===========================================================================
  Widget _buildQuizResultsView(bool isNarrow) {
    final quiz = _viewingResultsQuiz ?? _quizzes[1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Subheader: Title, Info, and "← Back to quizzes"
        _buildResultsSubheader(quiz),
        const SizedBox(height: 18),

        // 4 Metric KPI Cards
        _buildResultsMetricCards(quiz, isNarrow),
        const SizedBox(height: 18),

        // 2 Side-by-side Analytics Cards: Best score per student & Hardest questions
        _buildResultsDistributionRow(isNarrow),
        const SizedBox(height: 20),

        // Students Table Card
        _buildResultsStudentsCard(),
        const SizedBox(height: 20),

        // Every Question Card (All 10 Questions with Marked Correct Answers)
        _buildResultsEveryQuestionCard(),
      ],
    );
  }

  Widget _buildResultsSubheader(QuizBuilderItem quiz) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 12,
      runSpacing: 10,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quiz.title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${quiz.questionsCount} questions · pass mark ${quiz.passMark} · ",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    quiz.status,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF15803D),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        OutlinedButton.icon(
          onPressed: () {
            setState(() {
              _viewingResultsQuiz = null;
            });
          },
          icon: const Icon(Icons.arrow_back_rounded, size: 14),
          label: Text(
            "Back to quizzes",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            side: const BorderSide(color: Color(0xFFCBD5E1)),
            foregroundColor: const Color(0xFF334155),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultsMetricCards(QuizBuilderItem quiz, bool isNarrow) {
    final studentsCount = quiz.students == "0" ? "1" : quiz.students;
    final passRateVal = quiz.passRate == "—" ? "100%" : quiz.passRate;
    final avgScoreVal = quiz.average == "—" ? "90%" : quiz.average;

    final cards = [
      _buildSingleResultStatCard("Students", studentsCount),
      _buildSingleResultStatCard("Attempts", "1"),
      _buildSingleResultStatCard("Pass rate", passRateVal),
      _buildSingleResultStatCard("Average score", avgScoreVal),
    ];

    if (isNarrow) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(child: cards[0]),
              const SizedBox(width: 12),
              Expanded(child: cards[1]),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: cards[2]),
              const SizedBox(width: 12),
              Expanded(child: cards[3]),
            ],
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(child: cards[0]),
        const SizedBox(width: 14),
        Expanded(child: cards[1]),
        const SizedBox(width: 14),
        Expanded(child: cards[2]),
        const SizedBox(width: 14),
        Expanded(child: cards[3]),
      ],
    );
  }

  Widget _buildSingleResultStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
            label,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsDistributionRow(bool isNarrow) {
    final bestScoreCard = _buildBestScoreCard();
    final hardestQuestionsCard = _buildHardestQuestionsCard();

    if (isNarrow) {
      return Column(
        children: [
          bestScoreCard,
          const SizedBox(height: 14),
          hardestQuestionsCard,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: bestScoreCard),
        const SizedBox(width: 14),
        Expanded(child: hardestQuestionsCard),
      ],
    );
  }

  Widget _buildBestScoreCard() {
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
          Text(
            "Best score per student",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Highest 90% · lowest 90%",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          _buildScoreBarRow("0–39%", 0.0, 0),
          const SizedBox(height: 10),
          _buildScoreBarRow("40–59%", 0.0, 0),
          const SizedBox(height: 10),
          _buildScoreBarRow("60–79%", 0.0, 0),
          const SizedBox(height: 10),
          _buildScoreBarRow("80–100%", 1.0, 1),
        ],
      ),
    );
  }

  Widget _buildScoreBarRow(String range, double ratio, int count) {
    return Row(
      children: [
        SizedBox(
          width: 58,
          child: Text(
            range,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 9,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: ratio,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF141A46),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        SizedBox(
          width: 16,
          child: Text(
            "$count",
            textAlign: TextAlign.right,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHardestQuestionsCard() {
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
          Text(
            "Hardest questions",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Lowest share of correct answers first",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Question-level results appear once students submit answers to the current version of the quiz.",
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: const Color(0xFF64748B),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildResultsStudentsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            "Students",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Best attempt counts for the pass mark and the certificate",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowHeight: 38,
              dataRowMinHeight: 46,
              dataRowMaxHeight: 52,
              headingTextStyle: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF64748B),
                letterSpacing: 0.5,
              ),
              dataTextStyle: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF1E293B),
              ),
              horizontalMargin: 12,
              columnSpacing: 36,
              columns: const [
                DataColumn(label: Text("STUDENT")),
                DataColumn(label: Text("ATTEMPTS")),
                DataColumn(label: Text("BEST")),
                DataColumn(label: Text("LATEST")),
                DataColumn(label: Text("RESULT")),
                DataColumn(label: Text("CERTIFICATE")),
              ],
              rows: [
                DataRow(
                  cells: [
                    DataCell(
                      Text(
                        "Anand Kumar",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    const DataCell(Text("1")),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0F2FE),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "90%",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0369A1),
                          ),
                        ),
                      ),
                    ),
                    const DataCell(Text("90%")),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Passed",
                          style: GoogleFonts.poppins(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF15803D),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        "Issued",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF334155),
                        ),
                      ),
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

  Widget _buildResultsEveryQuestionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            "Every question",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "How the class answered. The correct option is marked.",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _resultQuestionsDetails.length,
            separatorBuilder: (context, index) => const SizedBox(height: 24),
            itemBuilder: (context, qIndex) {
              final q = _resultQuestionsDetails[qIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Q${qIndex + 1}. ${q.questionText}",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    q.recordedStatus,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  for (int optIdx = 0; optIdx < q.options.length; optIdx++) ...[
                    _buildResultOptionBox(
                      optIdx: optIdx,
                      text: q.options[optIdx],
                      isCorrect: optIdx == q.correctIndex,
                      count: q.responseCounts[optIdx],
                    ),
                    if (optIdx < q.options.length - 1)
                      const SizedBox(height: 6),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResultOptionBox({
    required int optIdx,
    required String text,
    required bool isCorrect,
    required int count,
  }) {
    final letter = String.fromCharCode(65 + optIdx);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isCorrect ? const Color(0xFFF0FDF4) : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCorrect ? const Color(0xFF86EFAC) : const Color(0xFFE2E8F0),
          width: 1.1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  color: isCorrect
                      ? const Color(0xFF166534)
                      : const Color(0xFF334155),
                ),
                children: [
                  TextSpan(
                    text: "$letter ",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: text),
                  if (isCorrect) ...[
                    const TextSpan(text: " "),
                    TextSpan(
                      text: "correct",
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0D9488),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "$count",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: isCorrect
                  ? const Color(0xFF166534)
                  : const Color(0xFF94A3B8),
            ),
          ),
        ],
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
// DATA MODELS
// =============================================================================
class QuizBuilderQuestion {
  final TextEditingController textController;
  final List<TextEditingController> optionControllers;
  final TextEditingController explanationController;
  int correctIndex;

  QuizBuilderQuestion({
    required String questionText,
    required List<String> options,
    required this.correctIndex,
    required String explanation,
  })  : textController = TextEditingController(text: questionText),
        optionControllers =
            options.map((opt) => TextEditingController(text: opt)).toList(),
        explanationController = TextEditingController(text: explanation);

  void dispose() {
    textController.dispose();
    for (var opt in optionControllers) {
      opt.dispose();
    }
    explanationController.dispose();
  }
}

class QuizBuilderItem {
  String id;
  String title;
  String dept;
  String duration;
  bool hasCert;
  int questionsCount;
  String passMark;
  String students;
  String average;
  String passRate;
  String status;

  QuizBuilderItem({
    required this.id,
    required this.title,
    required this.dept,
    required this.duration,
    required this.hasCert,
    required this.questionsCount,
    required this.passMark,
    required this.students,
    required this.average,
    required this.passRate,
    required this.status,
  });
}

class QuizResultQuestionDetail {
  final String questionText;
  final List<String> options;
  final int correctIndex;
  final String recordedStatus;
  final List<int> responseCounts;

  const QuizResultQuestionDetail({
    required this.questionText,
    required this.options,
    required this.correctIndex,
    this.recordedStatus = "No answers recorded",
    this.responseCounts = const [0, 0, 0, 0],
  });
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
