import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// QUESTION MODEL
// =============================================================================
class BankQuestionItem {
  final String id;
  String topic;
  String statement;
  String difficulty; // Easy, Medium, Hard
  String bloom; // Remember, Understand, Apply, Analyse, Evaluate, Create
  int marks;
  String co; // CO1, CO2, CO3, CO4, CO5, CO6
  String status; // Active, Draft
  String modelAnswer;
  bool isExpanded;

  BankQuestionItem({
    required this.id,
    required this.topic,
    required this.statement,
    this.difficulty = 'Medium',
    this.bloom = 'Understand',
    this.marks = 5,
    this.co = 'CO1',
    this.status = 'Draft',
    this.modelAnswer = '',
    this.isExpanded = false,
  });

  Color get difficultyColor {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return const Color(0xFF10B981);
      case 'medium':
        return const Color(0xFFF59E0B);
      case 'hard':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }

  Color get difficultyBgColor {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return const Color(0xFFECFDF5);
      case 'medium':
        return const Color(0xFFFEF3C7);
      case 'hard':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFF3F4F6);
    }
  }

  Color get bloomColor {
    switch (bloom.toLowerCase()) {
      case 'remember':
        return const Color(0xFF0284C7);
      case 'understand':
        return const Color(0xFF0D9488);
      case 'apply':
        return const Color(0xFF6366F1);
      case 'analyse':
        return const Color(0xFFD97706);
      case 'evaluate':
        return const Color(0xFF8B5CF6);
      case 'create':
        return const Color(0xFFDB2777);
      default:
        return const Color(0xFF4B5563);
    }
  }

  Color get bloomBgColor {
    switch (bloom.toLowerCase()) {
      case 'remember':
        return const Color(0xFFE0F2FE);
      case 'understand':
        return const Color(0xFFCCFBF1);
      case 'apply':
        return const Color(0xFFEEF2FF);
      case 'analyse':
        return const Color(0xFFFEF3C7);
      case 'evaluate':
        return const Color(0xFFF3E8FF);
      case 'create':
        return const Color(0xFFFCE7F3);
      default:
        return const Color(0xFFF3F4F6);
    }
  }
}

// =============================================================================
// ASSESSMENT: QUESTION BANK SCREEN
// Matches exactly the user reference designs:
// 1. Blueprint hero banner (Home > Assessment > Question Bank, MVP, Assessment badges)
// 2. Action sub-header (Assessment Question Bank, Generate with AI, + Add Question, Refresh)
// 3. 5 KPI Stat Cards (Topic Folders 7, Total Questions 22, Active 4, Drafts 18, Avg Marks 5.9)
// 4. Filter bar (Search, Difficulties, Bloom Levels, Statuses, Folders | Expandable view)
// 5. Topic Folders Grid with folder cards matching Image 1 & 2
// 6. Folder Detail View matching Image 3 with collapsible solution accordions & actions
// 7. Add Question Modal matching Image 4
// 8. Generate with AI Modal matching Image 5
// =============================================================================
class QuestionBankScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final String portalRole;

  const QuestionBankScreen({
    super.key,
    this.onBack,
    this.portalRole = 'Faculty',
  });

  @override
  State<QuestionBankScreen> createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends State<QuestionBankScreen> {
  // Navigation: null = all folders / list; non-null = opened folder topic name
  String? _openedFolderTopic;
  BankQuestionItem? _viewingQuestion;
  BankQuestionItem? _editingQuestion;

  // Search & Filters
  final TextEditingController _searchController = TextEditingController();
  String _selectedDifficulty = "All Difficulties";
  String _selectedBloom = "All Bloom Levels";
  String _selectedStatus = "All Statuses";
  String _selectedSort = "Newest First";
  int _viewMode = 0; // 0: Folders, 1: Expandable
  final Set<String> _expandedFolders = {};

  // Controllers for full-page edit form
  final TextEditingController _editStmtController = TextEditingController();
  final TextEditingController _editTopicController = TextEditingController();
  final TextEditingController _editMarksController = TextEditingController();
  final TextEditingController _editModelAnsController = TextEditingController();
  String _editDifficulty = "Hard";
  String _editBloom = "Analyse";
  String _editCo = "CO1";
  String _editStatus = "Draft";

  final List<String> _difficultyOptions = [
    "All Difficulties",
    "Easy",
    "Medium",
    "Hard",
  ];

  final List<String> _bloomOptions = [
    "All Bloom Levels",
    "Remember",
    "Understand",
    "Apply",
    "Analyse",
    "Evaluate",
    "Create",
  ];

  final List<String> _statusOptions = [
    "All Statuses",
    "Active",
    "Draft",
  ];

  final List<String> _sortOptions = [
    "Newest First",
    "Oldest First",
    "Most Questions",
    "Highest Marks",
  ];

  // Primary dataset matching images 1, 2, 3 exactly
  late List<BankQuestionItem> _questions;

  @override
  void initState() {
    super.initState();
    _initDefaultQuestions();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _editStmtController.dispose();
    _editTopicController.dispose();
    _editMarksController.dispose();
    _editModelAnsController.dispose();
    super.dispose();
  }

  void _startEditingQuestion(BankQuestionItem q) {
    _editingQuestion = q;
    _editStmtController.text = q.statement;
    _editTopicController.text = q.topic;
    _editMarksController.text = '${q.marks}';
    _editModelAnsController.text = q.modelAnswer;
    _editDifficulty = q.difficulty;
    _editBloom = q.bloom;
    _editCo = q.co;
    _editStatus = q.status;
    setState(() {});
  }

  void _saveEditingQuestion() {
    if (_editingQuestion == null) return;
    final stmt = _editStmtController.text.trim();
    final topic = _editTopicController.text.trim();
    final marks =
        int.tryParse(_editMarksController.text.trim()) ?? _editingQuestion!.marks;
    final modelAns = _editModelAnsController.text.trim();

    if (stmt.isEmpty || topic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please provide both question statement and topic',
            style: GoogleFonts.plusJakartaSans(color: Colors.white),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFFDC2626),
        ),
      );
      return;
    }

    setState(() {
      _editingQuestion!.statement = stmt;
      _editingQuestion!.topic = topic;
      _editingQuestion!.marks = marks;
      _editingQuestion!.modelAnswer = modelAns;
      _editingQuestion!.difficulty = _editDifficulty;
      _editingQuestion!.bloom = _editBloom;
      _editingQuestion!.co = _editCo;
      _editingQuestion!.status = _editStatus;

      // Finish editing and return to detail view if open, or topic folder
      _editingQuestion = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Question updated successfully. Changes audit-logged.',
          style: GoogleFonts.plusJakartaSans(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF1E2865),
      ),
    );
  }

  void _initDefaultQuestions() {
    _questions = [
      // 1. operating system (1 question · 2 marks · 1 active · 0 draft) - Matches Screenshot 5
      BankQuestionItem(
        id: "Q-1146",
        topic: "operating system",
        statement:
            "Explain the fundamental role of an Operating System and the core responsibilities of the kernel in process management and memory allocation.",
        difficulty: "Medium",
        bloom: "Understand",
        marks: 2,
        co: "CO1",
        status: "Active",
        modelAnswer:
            "An Operating System (OS) is system software that manages computer hardware, software resources, and provides common services for computer programs. The kernel facilitates process scheduling, virtual memory management, interrupt handling, device driver abstraction, and inter-process communication (IPC).",
      ),

      // 2. Transactions and concurrency control (3 questions · 21 marks · 1 active · 2 draft) - Matches Screenshot 5
      BankQuestionItem(
        id: "Q-1123",
        topic: "Transactions and concurrency control",
        statement:
            "Explain the potential problems that arise from concurrent execution of transactions if proper concurrency control mechanisms are not in place. Give an example of a dirty read.",
        difficulty: "Hard",
        bloom: "Understand",
        marks: 10,
        co: "CO4",
        status: "Active",
        modelAnswer:
            "Problems:\n1. Dirty Read: Reading uncommitted updates that later roll back.\n2. Non-repeatable Read: Multiple reads of same row return different values due to intermediate commit.\n3. Phantom Read: Query range returns new rows inserted by another committed transaction.\n4. Lost Update: Overwriting updates without reading preceding commits.",
      ),
      BankQuestionItem(
        id: "Q-1122",
        topic: "Transactions and concurrency control",
        statement:
            "Discuss Strict 2PL and Rigorous 2PL protocols and how they avoid cascading rollbacks.",
        difficulty: "Medium",
        bloom: "Understand",
        marks: 7,
        co: "CO4",
        status: "Draft",
        modelAnswer:
            "Strict 2PL requires all exclusive locks to be held until transaction commits/aborts. Rigorous 2PL holds ALL locks (shared and exclusive) until commit. This guarantees strict schedule and prevents cascading rollbacks.",
      ),
      BankQuestionItem(
        id: "Q-1121",
        topic: "Transactions and concurrency control",
        statement:
            "Define deadlock in DBMS and name two deadlock prevention protocols.",
        difficulty: "Easy",
        bloom: "Remember",
        marks: 4,
        co: "CO4",
        status: "Draft",
        modelAnswer:
            "Deadlock is a condition where two or more transactions are waiting for locks held by each other, creating circular wait.\nProtocols: Wait-Die (non-preemptive) and Wound-Wait (preemptive) based on transaction timestamps.",
      ),

      // 3. Normalization (3 questions · 17 marks · 0 active · 3 draft) - Matches Screenshot 2 & 5
      BankQuestionItem(
        id: "Q-1144",
        topic: "Normalization",
        statement:
            "How does BCNF (Boyce-Codd Normal Form) differ from 3NF? Provide an example of a relation that is in 3NF but not in BCNF.",
        difficulty: "Hard",
        bloom: "Analyse",
        marks: 10,
        co: "CO1",
        status: "Draft",
        modelAnswer:
            "BCNF is a stricter form of 3NF. For every non-trivial functional dependency X -> Y, X must be a superkey. In 3NF, Y can also be a prime attribute.\n\nExample relation:\nR(Student, Course, Instructor) where:\n- (Student, Course) -> Instructor\n- Instructor -> Course\nCandidate keys: {Student, Course}, {Student, Instructor}\nHere, Instructor -> Course has Course as prime attribute (in 3NF), but Instructor is not a superkey (violates BCNF).",
      ),
      BankQuestionItem(
        id: "Q-1140",
        topic: "Normalization",
        statement:
            "What is a transitive dependency? How does it violate 3NF, and how is it typically resolved during normalization?",
        difficulty: "Medium",
        bloom: "Understand",
        marks: 5,
        co: "CO1",
        status: "Draft",
        modelAnswer:
            "A transitive dependency occurs when A -> B and B -> C, where C is a non-prime attribute and B is not a candidate key. This violates 3NF because a non-prime attribute is determined by another non-prime attribute.\n\nResolution: Decompose relation R into R1(A, B) and R2(B, C).",
      ),
      BankQuestionItem(
        id: "Q-1136",
        topic: "Normalization",
        statement:
            "Define the Third Normal Form (3NF) and explain its primary goal in database design.",
        difficulty: "Easy",
        bloom: "Remember",
        marks: 2,
        co: "CO1",
        status: "Draft",
        modelAnswer:
            "A relation schema R is in 3NF if it is in 2NF and for every non-trivial functional dependency X -> Y, either X is a superkey or Y is a prime attribute.\n\nGoal: Eliminate transitive dependencies and reduce data redundancy while preserving all functional dependencies.",
      ),

      // 4. SQL joins (2 questions · 8 marks · 0 active · 2 draft) - Matches Screenshot 5
      BankQuestionItem(
        id: "Q-1135",
        topic: "SQL joins",
        statement:
            "Consider two tables: `Employees` (EmpID, EmpName, DeptID) and `Departments` (DeptID, DeptName). Write an SQL query to list all employees along with their department names.",
        difficulty: "Medium",
        bloom: "Apply",
        marks: 5,
        co: "CO3",
        status: "Draft",
        modelAnswer:
            "SELECT e.EmpID, e.EmpName, d.DeptName\nFROM Employees e\nINNER JOIN Departments d ON e.DeptID = d.DeptID;",
      ),
      BankQuestionItem(
        id: "Q-1134",
        topic: "SQL joins",
        statement:
            "Differentiate between INNER JOIN, LEFT OUTER JOIN, and FULL OUTER JOIN with concise output table representations.",
        difficulty: "Easy",
        bloom: "Understand",
        marks: 3,
        co: "CO3",
        status: "Draft",
        modelAnswer:
            "INNER JOIN returns matching rows from both tables. LEFT OUTER JOIN returns all rows from left table and matched rows from right (NULL if unmatched). FULL OUTER JOIN returns rows when there is a match in either table.",
      ),

      // 5. ACID Properties & Two-Phase Locking (2 questions · 13 marks · 0 active · 2 draft) - Matches Screenshot 5
      BankQuestionItem(
        id: "Q-1148",
        topic: "ACID Properties & Two-Phase Locking",
        statement:
            "Explain the concept of Two-Phase Locking (2PL) and state its primary goal. What are the two phases?",
        difficulty: "Medium",
        bloom: "Understand",
        marks: 8,
        co: "CO4",
        status: "Draft",
        modelAnswer:
            "Two-Phase Locking (2PL) is a concurrency control protocol that guarantees serializability.\n\nTwo phases:\n1. Growing Phase: A transaction may acquire locks, but cannot release any lock.\n2. Shrinking Phase: A transaction may release locks, but cannot acquire any new locks.\n\nPrimary Goal: To ensure conflict serializability and avoid race conditions during concurrent transaction execution.",
      ),
      BankQuestionItem(
        id: "Q-1147",
        topic: "ACID Properties & Two-Phase Locking",
        statement:
            "Define the four ACID properties in DBMS and discuss how atomicity is achieved during failure recovery.",
        difficulty: "Medium",
        bloom: "Remember",
        marks: 5,
        co: "CO4",
        status: "Draft",
        modelAnswer:
            "ACID properties:\n- Atomicity: All operations in transaction succeed or none.\n- Consistency: DB transitions from one valid state to another.\n- Isolation: Concurrent transactions do not interfere.\n- Durability: Committed updates persist permanently.\n\nAtomicity is maintained via Write-Ahead Logging (WAL) and undo logs during rollbacks.",
      ),

      // 6. SQL JOINS (10 questions · 66 marks · 1 active · 9 draft) - Matches Screenshot 5
      BankQuestionItem(
        id: "Q-1133",
        topic: "SQL JOINS",
        statement:
            "Explain the architectural distinction between Hash Join, Merge Join, and Nested Loops Join, including Big-O time and space complexity.",
        difficulty: "Hard",
        bloom: "Understand",
        marks: 8,
        co: "CO3",
        status: "Draft",
        modelAnswer:
            "1. Nested Loop Join: O(M*N) time, O(1) space. Best for small outer table with indexed inner table.\n2. Merge Join: O(M log M + N log N) time, O(1) space if presorted. Optimal for large pre-sorted relations.\n3. Hash Join: O(M+N) time, O(min(M,N)) space. Builds hash table for smaller table and probes with larger.",
      ),
      BankQuestionItem(
        id: "Q-1132",
        topic: "SQL JOINS",
        statement:
            "Write a recursive Common Table Expression (CTE) to find all reporting managers for an employee up to the CEO in an organizational hierarchy.",
        difficulty: "Hard",
        bloom: "Apply",
        marks: 10,
        co: "CO3",
        status: "Draft",
        modelAnswer:
            "WITH RECURSIVE MgrHierarchy AS (\n  SELECT EmpID, EmpName, ManagerID, 1 AS Level\n  FROM Employees\n  WHERE EmpID = @TargetEmpID\n  UNION ALL\n  SELECT e.EmpID, e.EmpName, e.ManagerID, mh.Level + 1\n  FROM Employees e\n  INNER JOIN MgrHierarchy mh ON e.EmpID = mh.ManagerID\n)\nSELECT * FROM MgrHierarchy ORDER BY Level;",
      ),
      BankQuestionItem(
        id: "Q-1131",
        topic: "SQL JOINS",
        statement:
            "Given two tables Customers and Orders, write an optimized query to find customers who placed orders in 2025 and 2026 without using subqueries.",
        difficulty: "Medium",
        bloom: "Apply",
        marks: 6,
        co: "CO3",
        status: "Active",
        modelAnswer:
            "SELECT c.CustomerID, c.CustomerName\nFROM Customers c\nJOIN Orders o1 ON c.CustomerID = o1.CustomerID AND YEAR(o1.OrderDate) = 2025\nJOIN Orders o2 ON c.CustomerID = o2.CustomerID AND YEAR(o2.OrderDate) = 2026\nGROUP BY c.CustomerID, c.CustomerName;",
      ),
      BankQuestionItem(
        id: "Q-1130",
        topic: "SQL JOINS",
        statement:
            "Explain the difference between CROSS JOIN and Cartesian product with WHERE clause. Are query execution plans identical?",
        difficulty: "Easy",
        bloom: "Remember",
        marks: 4,
        co: "CO3",
        status: "Draft",
        modelAnswer:
            "CROSS JOIN explicitly denotes Cartesian product. When WHERE conditions are applied, modern optimizers generate equivalent execution plans converting them to INNER JOINs where applicable.",
      ),
      BankQuestionItem(
        id: "Q-1129",
        topic: "SQL JOINS",
        statement:
            "Illustrate the use of self-join on an Employees table to find pairs of employees working in the same department.",
        difficulty: "Medium",
        bloom: "Apply",
        marks: 6,
        co: "CO3",
        status: "Draft",
        modelAnswer:
            "SELECT e1.EmpName AS Employee1, e2.EmpName AS Employee2, e1.DeptID\nFROM Employees e1\nJOIN Employees e2 ON e1.DeptID = e2.DeptID AND e1.EmpID < e2.EmpID;",
      ),
      BankQuestionItem(
        id: "Q-1128",
        topic: "SQL JOINS",
        statement:
            "Explain how NULL values behave in FULL OUTER JOIN and demonstrate COALESCE to handle NULL keys in reporting.",
        difficulty: "Medium",
        bloom: "Understand",
        marks: 6,
        co: "CO3",
        status: "Draft",
        modelAnswer:
            "In FULL OUTER JOIN, non-matching rows contain NULLs for absent attributes. COALESCE(t1.ID, t2.ID) ensures non-null consolidated key in combined projection.",
      ),
      BankQuestionItem(
        id: "Q-1127",
        topic: "SQL JOINS",
        statement:
            "What is a non-equi join? Give an example use case in calculating progressive tax brackets for employee payroll.",
        difficulty: "Hard",
        bloom: "Apply",
        marks: 8,
        co: "CO3",
        status: "Draft",
        modelAnswer:
            "A non-equi join joins tables based on inequality operators (<, >, BETWEEN). Example:\nSELECT e.Name, e.Salary, t.Rate\nFROM Employees e\nJOIN TaxBrackets t ON e.Salary BETWEEN t.MinSalary AND t.MaxSalary;",
      ),
      BankQuestionItem(
        id: "Q-1126",
        topic: "SQL JOINS",
        statement:
            "Discuss indexing strategies for foreign keys to optimize multi-table join performance on transactional databases.",
        difficulty: "Medium",
        bloom: "Understand",
        marks: 6,
        co: "CO3",
        status: "Draft",
        modelAnswer:
            "Indexing foreign key columns prevents full table scans on child tables during parent lookups or cascading deletes. B-tree indexes are ideal for equality join conditions.",
      ),
      BankQuestionItem(
        id: "Q-1125",
        topic: "SQL JOINS",
        statement:
            "Differentiate between LEFT SEMI JOIN and LEFT ANTI JOIN and provide SQL equivalents using EXISTS / NOT EXISTS.",
        difficulty: "Easy",
        bloom: "Remember",
        marks: 4,
        co: "CO3",
        status: "Draft",
        modelAnswer:
            "SEMI JOIN returns rows from left table where a match exists in right (without duplicate left rows). ANTI JOIN returns rows where no match exists. Implemented via WHERE EXISTS / WHERE NOT EXISTS.",
      ),
      BankQuestionItem(
        id: "Q-1124",
        topic: "SQL JOINS",
        statement:
            "Provide an optimized query using lateral join / cross apply to fetch top 3 orders for each customer.",
        difficulty: "Hard",
        bloom: "Apply",
        marks: 10,
        co: "CO3",
        status: "Draft",
        modelAnswer:
            "SELECT c.CustomerID, c.CustomerName, o.OrderID, o.OrderDate, o.TotalAmount\nFROM Customers c\nCROSS JOIN LATERAL (\n  SELECT OrderID, OrderDate, TotalAmount\n  FROM Orders ord\n  WHERE ord.CustomerID = c.CustomerID\n  ORDER BY ord.OrderDate DESC\n  LIMIT 3\n) o;",
      ),

      // 7. Web Development (1 question · 2 marks · 1 active · 0 draft) - Matches Screenshot 5
      BankQuestionItem(
        id: "Q-1120",
        topic: "Web Development",
        statement:
            "What is the difference between frontend and backend development?",
        difficulty: "Medium",
        bloom: "Understand",
        marks: 2,
        co: "CO2",
        status: "Active",
        modelAnswer:
            "Frontend handles client-side UI, layouts, styles, and interactivity in browser/client apps (HTML, CSS, JS, Flutter). Backend runs on servers managing databases, authentication, APIs, business logic, and security.",
      ),
    ];
  }

  // ===========================================================================
  // COMPUTED TOPICS & METRICS
  // ===========================================================================
  List<String> get _topicNames {
    final list = <String>[];
    for (final q in _questions) {
      if (!list.contains(q.topic)) {
        list.add(q.topic);
      }
    }
    return list;
  }

  List<BankQuestionItem> get _filteredQuestions {
    final query = _searchController.text.trim().toLowerCase();
    return _questions.where((q) {
      // Filter by selected topic if in folder detail
      if (_openedFolderTopic != null && q.topic != _openedFolderTopic) {
        return false;
      }
      // Difficulty filter
      if (_selectedDifficulty != "All Difficulties" &&
          q.difficulty.toLowerCase() != _selectedDifficulty.toLowerCase()) {
        return false;
      }
      // Bloom filter
      if (_selectedBloom != "All Bloom Levels" &&
          q.bloom.toLowerCase() != _selectedBloom.toLowerCase()) {
        return false;
      }
      // Status filter
      if (_selectedStatus != "All Statuses" &&
          q.status.toLowerCase() != _selectedStatus.toLowerCase()) {
        return false;
      }
      // Search query
      if (query.isNotEmpty) {
        final idMatch = q.id.toLowerCase().contains(query);
        final topicMatch = q.topic.toLowerCase().contains(query);
        final stmtMatch = q.statement.toLowerCase().contains(query);
        final coMatch = q.co.toLowerCase().contains(query);
        final bloomMatch = q.bloom.toLowerCase().contains(query);
        return idMatch || topicMatch || stmtMatch || coMatch || bloomMatch;
      }
      return true;
    }).toList();
  }

  // Folder helper calculations
  int _questionsCountForTopic(String topic) =>
      _questions.where((q) => q.topic == topic).length;

  int _totalMarksForTopic(String topic) => _questions
      .where((q) => q.topic == topic)
      .fold(0, (sum, q) => sum + q.marks);

  int _activeCountForTopic(String topic) =>
      _questions.where((q) => q.topic == topic && q.status == "Active").length;

  int _draftCountForTopic(String topic) =>
      _questions.where((q) => q.topic == topic && q.status == "Draft").length;

  Map<String, int> _difficultyCountsForTopic(String topic) {
    final map = {"Easy": 0, "Medium": 0, "Hard": 0};
    for (var q in _questions.where((q) => q.topic == topic)) {
      if (map.containsKey(q.difficulty)) {
        map[q.difficulty] = (map[q.difficulty] ?? 0) + 1;
      }
    }
    return map;
  }

  List<String> _bloomLevelsForTopic(String topic) {
    return _questions
        .where((q) => q.topic == topic)
        .map((q) => q.bloom)
        .toSet()
        .toList();
  }

  String _firstSnippetForTopic(String topic) {
    final list = _questions.where((q) => q.topic == topic).toList();
    if (list.isEmpty) return "";
    return list.first.statement;
  }

  // Global KPI calculations
  int get _totalTopicFolders => _topicNames.length;
  int get _totalQuestionsCount => _questions.length;
  int get _totalActiveCount =>
      _questions.where((q) => q.status == "Active").length;
  int get _totalDraftCount =>
      _questions.where((q) => q.status == "Draft").length;
  int get _totalPoints => _questions.fold(0, (sum, q) => sum + q.marks);
  double get _avgMarks =>
      _questions.isEmpty ? 0.0 : (_totalPoints / _questions.length);

  // ===========================================================================
  // BUILD METHOD
  // ===========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_editingQuestion != null) ...[
                _buildEditQuestionView(_editingQuestion!),
              ] else if (_viewingQuestion != null) ...[
                _buildQuestionDetailView(_viewingQuestion!),
              ] else ...[
                // 1. HERO BLUEPRINT BANNER
                _buildBlueprintHero(),
                const SizedBox(height: 18),

                // View routing: Folder Detail View (Image 3) OR Folders/All View (Image 1 & 2)
                if (_openedFolderTopic != null) ...[
                  _buildFolderDetailView(_openedFolderTopic!),
                ] else ...[
                  // 2. ACTION SUB-HEADER CARD
                  _buildActionSubHeader(),
                  const SizedBox(height: 18),

                  // 3. 5 KPI STAT CARDS
                  _buildKpiCardsRow(),
                  const SizedBox(height: 20),

                  // 4. FILTER & SEARCH BAR
                  _buildFilterSearchBar(),
                  const SizedBox(height: 18),

                  // 5. MAIN CONTENT (Folders Grid or Expandable List)
                  if (_viewMode == 0) ...[
                    _buildFoldersGridSection(),
                  ] else ...[
                    _buildExpandableQuestionsSection(),
                  ],
                ],
              ],

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 1. BLUEPRINT HERO BANNER
  // ===========================================================================
  Widget _buildBlueprintHero() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E2865),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E2865).withValues(alpha: 0.18),
            blurRadius: 16,
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
                painter: _BlueprintGridPainter(
                  gridColor: Colors.white.withValues(alpha: 0.08),
                  step: 26,
                ),
              ),
            ),
            Positioned(
              right: -16,
              bottom: -20,
              child: Icon(
                Icons.folder_shared_rounded,
                size: 150,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb row
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
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(Icons.arrow_back_rounded,
                                  size: 14, color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          'Home',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14,
                              color: Colors.white.withValues(alpha: 0.5)),
                        ),
                        Text(
                          'Assessment',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.chevron_right_rounded,
                              size: 14,
                              color: Colors.white.withValues(alpha: 0.5)),
                        ),
                        Text(
                          'Question Bank',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Icon, Badges, Title & Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.inventory_2_outlined,
                          color: Color(0xFFFBBF24),
                          size: 22,
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
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.14),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'ASSESSMENT',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981)
                                        .withValues(alpha: 0.35),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'MVP',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF6EE7B7),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Question Bank',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tagged questions by topic, difficulty, Bloom level and course outcome.',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 13,
                                color: Colors.white.withValues(alpha: 0.82),
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

  // ===========================================================================
  // 2. ACTION SUB-HEADER CARD
  // ===========================================================================
  Widget _buildActionSubHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 680;

          final titleCol = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assessment Question Bank',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E2865),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Topic-organized folders with Bloom's Taxonomy, course outcomes, and model solutions.",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          );

          final actions = Wrap(
            spacing: 10,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              // Generate with AI button
              ElevatedButton.icon(
                onPressed: () => _openAiGenerateModal(),
                icon: const Icon(Icons.auto_awesome_rounded,
                    size: 15, color: Color(0xFF78350F)),
                label: Text(
                  'Generate with AI',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF78350F),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFDE68A),
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xFFFCD34D)),
                  ),
                ),
              ),

              // + Add Question button
              ElevatedButton.icon(
                onPressed: () => _openAddQuestionModal(),
                icon: const Icon(Icons.add_rounded,
                    size: 17, color: Colors.white),
                label: Text(
                  'Add Question',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),

              // Refresh icon button
              InkWell(
                onTap: () {
                  setState(() => _initDefaultQuestions());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Question bank refreshed',
                        style: GoogleFonts.plusJakartaSans(color: Colors.white),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: const Color(0xFF1E2865),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: const Icon(
                    Icons.sync_rounded,
                    size: 18,
                    color: Color(0xFF4B5563),
                  ),
                ),
              ),
            ],
          );

          if (isNarrow) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleCol,
                const SizedBox(height: 14),
                actions,
              ],
            );
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: titleCol),
              const SizedBox(width: 16),
              actions,
            ],
          );
        },
      ),
    );
  }

  // ===========================================================================
  // 3. 5 KPI STAT CARDS
  // ===========================================================================
  Widget _buildKpiCardsRow() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // On very wide screen, 5 in a row; on tablet, 3 / 2; on mobile, stacked / wrap
        int columns = 5;
        if (width < 600) {
          columns = 2;
        } else if (width < 960) {
          columns = 3;
        }

        final cards = [
          _buildKpiCard(
            icon: Icons.folder_outlined,
            iconColor: const Color(0xFF1E2865),
            label: 'Topic Folders',
            value: '$_totalTopicFolders',
            subtitle: 'Categorized headings',
          ),
          _buildKpiCard(
            icon: Icons.help_outline_rounded,
            iconColor: const Color(0xFF2563EB),
            label: 'Total Questions',
            value: '$_totalQuestionsCount',
            subtitle: 'Across all syllabi',
          ),
          _buildKpiCard(
            icon: Icons.check_circle_outline_rounded,
            iconColor: const Color(0xFF10B981),
            label: 'Active & Ready',
            value: '$_totalActiveCount',
            subtitle: 'Usable in exams',
            valueColor: const Color(0xFF10B981),
          ),
          _buildKpiCard(
            icon: Icons.schedule_rounded,
            iconColor: const Color(0xFFF59E0B),
            label: 'Drafts',
            value: '$_totalDraftCount',
            subtitle: 'Awaiting review',
            valueColor: const Color(0xFFD97706),
          ),
          _buildKpiCard(
            icon: Icons.layers_outlined,
            iconColor: const Color(0xFF8B5CF6),
            label: 'Avg Marks',
            value: _avgMarks.toStringAsFixed(1),
            subtitle: '$_totalPoints total points',
            valueColor: const Color(0xFF7C3AED),
          ),
        ];

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards.map((c) {
            final cardWidth =
                (width - (columns - 1) * 12) / columns - 0.5;
            return SizedBox(
              width: cardWidth.clamp(140.0, 400.0),
              child: c,
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildKpiCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required String subtitle,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: iconColor),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4B5563),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: valueColor ?? const Color(0xFF1E2865),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              color: const Color(0xFF9CA3AF),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // 4. FILTER & SEARCH BAR
  // ===========================================================================
  Widget _buildFilterSearchBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 1280;

        // Search input
        final searchInput = Container(
          height: 42,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: (val) => setState(() {}),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: const Color(0xFF1E2865),
            ),
            decoration: InputDecoration(
              hintText:
                  'Search questions by statement, topic heading, ID, outcome...',
              hintStyle: GoogleFonts.plusJakartaSans(
                fontSize: 12.5,
                color: const Color(0xFF9CA3AF),
              ),
              prefixIcon: const Icon(Icons.search_rounded,
                  size: 18, color: Color(0xFF9CA3AF)),
              suffixIcon: _searchController.text.isNotEmpty
                  ? InkWell(
                      onTap: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      child: const Icon(Icons.close_rounded,
                          size: 16, color: Color(0xFF9CA3AF)),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        );

        // Filter dropdowns & view toggle
        final filters = Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            // Difficulty Dropdown
            _buildDropdown(
              value: _selectedDifficulty,
              items: _difficultyOptions,
              onChanged: (val) {
                if (val != null) setState(() => _selectedDifficulty = val);
              },
            ),

            // Bloom Levels Dropdown
            _buildDropdown(
              value: _selectedBloom,
              items: _bloomOptions,
              onChanged: (val) {
                if (val != null) setState(() => _selectedBloom = val);
              },
            ),

            // Status Dropdown
            _buildDropdown(
              value: _selectedStatus,
              items: _statusOptions,
              onChanged: (val) {
                if (val != null) setState(() => _selectedStatus = val);
              },
            ),

            // Sort Dropdown (Matches Screenshot 5)
            _buildDropdown(
              value: _selectedSort,
              items: _sortOptions,
              onChanged: (val) {
                if (val != null) setState(() => _selectedSort = val);
              },
            ),

            // View toggle: Folders | Expandable
            Container(
              height: 42,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildViewTabButton(
                    title: 'Folders',
                    icon: Icons.grid_view_rounded,
                    index: 0,
                  ),
                  _buildViewTabButton(
                    title: 'Expandable',
                    icon: Icons.format_list_bulleted_rounded,
                    index: 1,
                  ),
                ],
              ),
            ),
          ],
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchInput,
              const SizedBox(height: 10),
              filters,
            ],
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
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 17, color: Color(0xFF6B7280)),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12.5,
            color: const Color(0xFF374151),
            fontWeight: FontWeight.w500,
          ),
          selectedItemBuilder: (context) {
            return items.map((it) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  it,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12.5,
                    color: const Color(0xFF1E2865),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList();
          },
          items: items.map((it) {
            final isSelected = it == value;
            return DropdownMenuItem<String>(
              value: it,
              child: Text(
                it,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFF1E2865)
                      : const Color(0xFF374151),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildViewTabButton({
    required String title,
    required IconData icon,
    required int index,
  }) {
    final isActive = _viewMode == index;
    return InkWell(
      onTap: () => setState(() => _viewMode = index),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: isActive
                  ? const Color(0xFF1E2865)
                  : const Color(0xFF6B7280),
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive
                    ? const Color(0xFF1E2865)
                    : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 5. TOPIC FOLDERS GRID (MATCHES IMAGE 1 & 2)
  // ===========================================================================
  Widget _buildFoldersGridSection() {
    // Filter topics that have matching questions under the active filter
    final filteredTopics = _topicNames.where((topic) {
      final questionsInTopic = _filteredQuestions.where((q) => q.topic == topic);
      return questionsInTopic.isNotEmpty;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 6,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.folder_open_rounded,
                    size: 18, color: Color(0xFFF59E0B)),
                const SizedBox(width: 8),
                Text(
                  'TOPIC FOLDERS (${filteredTopics.length})',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF4B5563),
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
            Text(
              'Click any folder heading to view its questions',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        if (filteredTopics.isEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            alignment: Alignment.center,
            child: Column(
              children: [
                Icon(Icons.search_off_rounded,
                    size: 40, color: Colors.grey.shade400),
                const SizedBox(height: 10),
                Text(
                  'No topic folders match the current filters',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4B5563),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Try resetting search or difficulty filter.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              int cols = 3;
              if (width < 680) {
                cols = 1;
              } else if (width < 1050) {
                cols = 2;
              }

              final itemWidth = (width - (cols - 1) * 16) / cols - 0.5;

              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: filteredTopics.map((topic) {
                  return SizedBox(
                    width: itemWidth.clamp(280.0, 700.0),
                    child: _buildFolderCard(topic),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildFolderCard(String topic) {
    final count = _questionsCountForTopic(topic);
    final totalMarks = _totalMarksForTopic(topic);
    final activeCount = _activeCountForTopic(topic);
    final draftCount = _draftCountForTopic(topic);
    final difficulties = _difficultyCountsForTopic(topic);
    final snippet = _firstSnippetForTopic(topic);
    final bloomList = _bloomLevelsForTopic(topic);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: () => setState(() => _openedFolderTopic = topic),
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: Folder icon & Question count badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.folder_outlined,
                        size: 20,
                        color: Color(0xFFD97706),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$count ${count == 1 ? 'Question' : 'Questions'}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF4338CA),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Folder Title
                Text(
                  topic,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E2865),
                    height: 1.25,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),

                // Subtitle: Marks & status breakdown
                Text(
                  '$totalMarks total marks · $activeCount active · $draftCount draft',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 12),

                // Difficulty pills row
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    if ((difficulties['Easy'] ?? 0) > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Easy: ${difficulties['Easy']}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF047857),
                          ),
                        ),
                      ),
                    if ((difficulties['Medium'] ?? 0) > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF3C7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Medium: ${difficulties['Medium']}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFB45309),
                          ),
                        ),
                      ),
                    if ((difficulties['Hard'] ?? 0) > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE2E2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Hard: ${difficulties['Hard']}',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFB91C1C),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 14),

                // Preview snippet box
                if (snippet.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFF1F5F9)),
                    ),
                    child: Text(
                      '"$snippet"',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF64748B),
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 12),

                // Footer Row: "Open folder ->" and Bloom levels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Open folder',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFD97706),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_rounded,
                            size: 14, color: Color(0xFFD97706)),
                      ],
                    ),
                    Expanded(
                      child: Text(
                        bloomList.join(', '),
                        textAlign: TextAlign.end,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          color: const Color(0xFF9CA3AF),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // 6. FOLDER DETAIL VIEW (MATCHES IMAGE 3)
  // ===========================================================================
  Widget _buildFolderDetailView(String topic) {
    final questionsInFolder = _filteredQuestions.where((q) => q.topic == topic).toList();
    final count = questionsInFolder.length;
    final totalMarks = questionsInFolder.fold(0, (sum, q) => sum + q.marks);
    final activeCount =
        questionsInFolder.where((q) => q.status == "Active").length;
    final draftCount =
        questionsInFolder.where((q) => q.status == "Draft").length;
    final difficulties = _difficultyCountsForTopic(topic);
    final bloomList = _bloomLevelsForTopic(topic);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Top Navigation Bar: Back button & Breadcrumbs
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 8,
          children: [
            OutlinedButton.icon(
              onPressed: () => setState(() => _openedFolderTopic = null),
              icon: const Icon(Icons.arrow_back_rounded,
                  size: 15, color: Color(0xFF1E2865)),
              label: Text(
                'Back to All Folders',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E2865),
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFE5E7EB)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Question Bank',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Icon(Icons.chevron_right_rounded,
                      size: 14, color: Color(0xFF9CA3AF)),
                ),
                Text(
                  topic,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E2865),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // 2. Folder Summary Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 720;

              final leftInfo = Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.folder_outlined,
                      size: 24,
                      color: Color(0xFFD97706),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TOPIC FOLDER · $count ${count == 1 ? 'question' : 'questions'} · $totalMarks total marks',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFD97706),
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          topic,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1E2865),
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );

              final rightActions = Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _openAiGenerateModal(prefilledTopic: topic),
                    icon: const Icon(Icons.auto_awesome_rounded,
                        size: 15, color: Color(0xFF78350F)),
                    label: Text(
                      'AI Questions for Topic',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF78350F),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDE68A),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Color(0xFFFCD34D)),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _openAddQuestionModal(prefilledTopic: topic),
                    icon: const Icon(Icons.add_rounded,
                        size: 16, color: Colors.white),
                    label: Text(
                      'Add Question to Topic',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E2865),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  // Delete Topic Folder Button (Matches Screenshot 2)
                  OutlinedButton.icon(
                    onPressed: () => _showDeleteFolderDialog(topic),
                    icon: const Icon(Icons.delete_outline_rounded,
                        size: 15, color: Color(0xFFDC2626)),
                    label: Text(
                      'Delete Folder',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFDC2626),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFFCA5A5)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 11),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isNarrow) ...[
                    leftInfo,
                    const SizedBox(height: 14),
                    rightActions,
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: leftInfo),
                        const SizedBox(width: 14),
                        rightActions,
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 14),

                  // Metadata summary bar
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      // Difficulties
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Difficulties: ',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.5,
                              color: const Color(0xFF6B7280),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Wrap(
                            spacing: 4,
                            children: difficulties.entries
                                .where((e) => e.value > 0)
                                .map((e) {
                              Color c = e.key == 'Easy'
                                  ? const Color(0xFF047857)
                                  : e.key == 'Medium'
                                      ? const Color(0xFFB45309)
                                      : const Color(0xFFB91C1C);
                              Color bg = e.key == 'Easy'
                                  ? const Color(0xFFECFDF5)
                                  : e.key == 'Medium'
                                      ? const Color(0xFFFEF3C7)
                                      : const Color(0xFFFEE2E2);
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${e.key}: ${e.value}',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: c,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                      // Bloom levels
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Bloom Levels: ',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11.5,
                              color: const Color(0xFF6B7280),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Wrap(
                            spacing: 4,
                            children: bloomList.map((bl) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '$bl: 1',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFB45309),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                      // Active / Draft
                      Text(
                        '$activeCount Active · $draftCount Draft',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 20),

        // 3. Section Header: Questions in this folder (Fully responsive)
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 620;
            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'QUESTIONS IN THIS FOLDER ($count)',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF4B5563),
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Click "View Model Answer" to inspect solution criteria',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'QUESTIONS IN THIS FOLDER ($count)',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF4B5563),
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    'Click "View Model Answer" to inspect solution criteria',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: const Color(0xFF9CA3AF),
                    ),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 14),

        // 4. Questions List
        if (questionsInFolder.isEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(36),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            alignment: Alignment.center,
            child: Text(
              'No questions in this folder matching your search or filters.',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
        ] else ...[
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: questionsInFolder.length,
            separatorBuilder: (_, index) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final q = questionsInFolder[index];
              return _buildQuestionCard(q, index + 1);
            },
          ),
        ],
      ],
    );
  }

  // ===========================================================================
  // QUESTION CARD ITEM (MATCHES IMAGE 3)
  // ===========================================================================
  Widget _buildQuestionCard(BankQuestionItem q, int index) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Badges on left, action icons on right
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    // Index
                    Text(
                      '#$index',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF6B7280),
                      ),
                    ),

                    // ID Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        q.id,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4B5563),
                        ),
                      ),
                    ),

                    // Status Badge (Draft / Active)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: q.status == 'Active'
                            ? const Color(0xFFECFDF5)
                            : const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        q.status,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: q.status == 'Active'
                              ? const Color(0xFF047857)
                              : const Color(0xFFB45309),
                        ),
                      ),
                    ),

                    // Marks
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${q.marks} Marks',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1D4ED8),
                        ),
                      ),
                    ),

                    // Difficulty
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: q.difficultyBgColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        q.difficulty,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: q.difficultyColor,
                        ),
                      ),
                    ),

                    // Bloom Level
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: q.bloomBgColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Bloom: ${q.bloom}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: q.bloomColor,
                        ),
                      ),
                    ),

                    // Course Outcome
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        q.co,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Action buttons on right (Copy, Edit, Delete)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Copy
                  InkWell(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: q.statement));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Question statement copied to clipboard',
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.white),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: const Color(0xFF1E2865),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.copy_rounded,
                              size: 14, color: Color(0xFF6B7280)),
                          const SizedBox(width: 4),
                          Text(
                            'Copy',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: const Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Edit
                  InkWell(
                    onTap: () => _startEditingQuestion(q),
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.edit_outlined,
                              size: 14, color: Color(0xFF6B7280)),
                          const SizedBox(width: 4),
                          Text(
                            'Edit',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: const Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),

                  // Delete
                  IconButton(
                    onPressed: () => _confirmDeleteQuestion(q),
                    icon: const Icon(Icons.delete_outline_rounded,
                        size: 16, color: Color(0xFFEF4444)),
                    tooltip: 'Delete Question',
                    splashRadius: 16,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Question Statement Text (Tapping opens Question Detail View)
          InkWell(
            onTap: () => setState(() => _viewingQuestion = q),
            borderRadius: BorderRadius.circular(4),
            child: Text(
              q.statement,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E2865),
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Expandable Model Answer & Solution Accordion
          InkWell(
            onTap: () => setState(() => q.isExpanded = !q.isExpanded),
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.help_outline_rounded,
                      size: 14, color: Color(0xFF6B7280)),
                  const SizedBox(width: 6),
                  Text(
                    'View Model Answer & Solution',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    q.isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 16,
                    color: const Color(0xFF6B7280),
                  ),
                ],
              ),
            ),
          ),

          if (q.isExpanded) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.lightbulb_outline_rounded,
                          size: 14, color: Color(0xFFD97706)),
                      const SizedBox(width: 6),
                      Text(
                        'Model Solution & Evaluation Criteria',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFD97706),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    q.modelAnswer.isNotEmpty
                        ? q.modelAnswer
                        : 'No detailed model solution provided for this question.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      color: const Color(0xFF334155),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ===========================================================================
  // 7. EXPANDABLE TOPIC FOLDERS LIST (MATCHES SCREENSHOT 5)
  // ===========================================================================
  Widget _buildExpandableQuestionsSection() {
    final filteredTopics = _topicNames.where((topic) {
      final questionsInTopic =
          _filteredQuestions.where((q) => q.topic == topic);
      return questionsInTopic.isNotEmpty;
    }).toList();

    if (filteredTopics.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        alignment: Alignment.center,
        child: Text(
          'No topic folders match the current filters.',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: const Color(0xFF6B7280),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredTopics.length,
      separatorBuilder: (_, i) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final topic = filteredTopics[index];
        final topicQuestions =
            _filteredQuestions.where((q) => q.topic == topic).toList();
        final count = topicQuestions.length;
        final totalMarks =
            topicQuestions.fold<int>(0, (sum, q) => sum + q.marks);
        final activeCount =
            topicQuestions.where((q) => q.status == 'Active').length;
        final draftCount =
            topicQuestions.where((q) => q.status == 'Draft').length;
        final isExpanded = _expandedFolders.contains(topic);

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.folder_outlined,
                      size: 20,
                      color: Color(0xFFD97706),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                topic,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1E2865),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2F6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '$count questions',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF475569),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '$totalMarks total marks · $activeCount active · $draftCount draft',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            color: const Color(0xFF94A3B8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() => _openedFolderTopic = topic),
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 6),
                      child: Text(
                        'Open Folder Page →',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E2865),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (isExpanded) {
                          _expandedFolders.remove(topic);
                        } else {
                          _expandedFolders.add(topic);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        isExpanded
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
              if (isExpanded) ...[
                const SizedBox(height: 14),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                const SizedBox(height: 14),
                ...topicQuestions.map((q) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child:
                          _buildQuestionCard(q, topicQuestions.indexOf(q) + 1),
                    )),
              ],
            ],
          ),
        );
      },
    );
  }

  // ===========================================================================
  // 8. DIALOG: DELETE TOPIC FOLDER (MATCHES SCREENSHOT 4)
  // ===========================================================================
  void _showDeleteFolderDialog(String topic) {
    final topicQuestions = _questions.where((q) => q.topic == topic).toList();
    final count = topicQuestions.length;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Container(
            width: 480,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with red trash icon
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        size: 24,
                        color: Color(0xFFDC2626),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 6),
                          Text(
                            'Delete Topic Folder?',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1E2865),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Subtitle description
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13.5,
                      color: const Color(0xFF4B5563),
                      height: 1.45,
                    ),
                    children: [
                      const TextSpan(
                          text: 'Are you sure you want to permanently delete the folder '),
                      TextSpan(
                        text: '"$topic"',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E2865),
                        ),
                      ),
                      const TextSpan(text: ' and all of its '),
                      TextSpan(
                        text: '$count question(s)',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E2865),
                        ),
                      ),
                      const TextSpan(text: '?'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Callout alert box
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFECDD3)),
                  ),
                  child: Text(
                    'This action cannot be undone. All questions filed under this topic heading will be removed from the bank.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: const Color(0xFFE11D48),
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Actions: Cancel & Delete Folder
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE5E7EB)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 11),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4B5563),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _questions.removeWhere((q) => q.topic == topic);
                          if (_openedFolderTopic == topic) {
                            _openedFolderTopic = null;
                          }
                          _expandedFolders.remove(topic);
                        });
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Folder "$topic" and all questions permanently deleted.',
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: const Color(0xFFDC2626),
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete_outline_rounded,
                          size: 16, color: Colors.white),
                      label: Text(
                        'Delete Folder',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB91C1C),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 11),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // MODAL: ADD / EDIT QUESTION (MATCHES IMAGE 4)
  // ===========================================================================
  void _openAddQuestionModal({
    BankQuestionItem? existingQuestion,
    String? prefilledTopic,
  }) {
    final isEditing = existingQuestion != null;
    final topicCtrl = TextEditingController(
      text: existingQuestion?.topic ??
          prefilledTopic ??
          (_openedFolderTopic ?? 'Normalization'),
    );
    final stmtCtrl =
        TextEditingController(text: existingQuestion?.statement ?? '');
    final marksCtrl =
        TextEditingController(text: '${existingQuestion?.marks ?? 2}');
    final modelAnsCtrl =
        TextEditingController(text: existingQuestion?.modelAnswer ?? '');

    String difficulty = existingQuestion?.difficulty ?? 'Medium';
    String bloom = existingQuestion?.bloom ?? 'Understand';
    String co = existingQuestion?.co ?? 'CO1';
    String status = existingQuestion?.status ?? 'Active';

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Container(
                width: 620,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Modal Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    isEditing
                                        ? Icons.edit_note_rounded
                                        : Icons.add_rounded,
                                    size: 20,
                                    color: const Color(0xFF1E2865),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  isEditing
                                      ? 'Edit Question'
                                      : 'Add New Question',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1E2865),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(ctx),
                              borderRadius: BorderRadius.circular(20),
                              child: const Icon(Icons.close_rounded,
                                  size: 20, color: Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        const Divider(height: 1, color: Color(0xFFE5E7EB)),
                        const SizedBox(height: 18),

                        // Topic / Folder Heading *
                        _buildFieldLabel('Topic / Folder Heading *'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: topicCtrl,
                          style: GoogleFonts.plusJakartaSans(fontSize: 13.5),
                          decoration: _inputDeco(hint: 'e.g. Relational Normalization & BCNF'),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Type a new heading or select an existing folder to group this question.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Question Statement *
                        _buildFieldLabel('Question Statement *'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: stmtCtrl,
                          maxLines: 4,
                          style: GoogleFonts.plusJakartaSans(fontSize: 13.5),
                          decoration: _inputDeco(
                            hint:
                                'Enter clear, concise question statement or problem description...',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // 4 Columns: Difficulty, Bloom Level, Marks, Course Outcome
                        LayoutBuilder(
                          builder: (context, boxConstraints) {
                            final isMobile = boxConstraints.maxWidth < 480;

                            final diffField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Difficulty'),
                                const SizedBox(height: 6),
                                _buildModalDropdown(
                                  value: difficulty,
                                  items: const ['Easy', 'Medium', 'Hard'],
                                  onChanged: (v) {
                                    if (v != null) {
                                      setDialogState(() => difficulty = v);
                                    }
                                  },
                                ),
                              ],
                            );

                            final bloomField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Bloom Level'),
                                const SizedBox(height: 6),
                                _buildModalDropdown(
                                  value: bloom,
                                  items: const [
                                    'Remember',
                                    'Understand',
                                    'Apply',
                                    'Analyse',
                                    'Evaluate',
                                    'Create',
                                  ],
                                  onChanged: (v) {
                                    if (v != null) {
                                      setDialogState(() => bloom = v);
                                    }
                                  },
                                ),
                              ],
                            );

                            final marksField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Marks'),
                                const SizedBox(height: 6),
                                Container(
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: const Color(0xFFE5E7EB)),
                                  ),
                                  child: TextField(
                                    controller: marksCtrl,
                                    keyboardType: TextInputType.number,
                                    style: GoogleFonts.plusJakartaSans(
                                        fontSize: 13.5),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                    ),
                                  ),
                                ),
                              ],
                            );

                            final coField = Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Course Outcome'),
                                const SizedBox(height: 6),
                                _buildModalDropdown(
                                  value: co,
                                  items: const [
                                    'CO1',
                                    'CO2',
                                    'CO3',
                                    'CO4',
                                    'CO5',
                                    'CO6'
                                  ],
                                  onChanged: (v) {
                                    if (v != null) {
                                      setDialogState(() => co = v);
                                    }
                                  },
                                ),
                              ],
                            );

                            if (isMobile) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: diffField),
                                      const SizedBox(width: 10),
                                      Expanded(child: bloomField),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(child: marksField),
                                      const SizedBox(width: 10),
                                      Expanded(child: coField),
                                    ],
                                  ),
                                ],
                              );
                            }

                            return Row(
                              children: [
                                Expanded(child: diffField),
                                const SizedBox(width: 10),
                                Expanded(child: bloomField),
                                const SizedBox(width: 10),
                                SizedBox(width: 75, child: marksField),
                                const SizedBox(width: 10),
                                Expanded(child: coField),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        // Status Dropdown
                        _buildFieldLabel('Status'),
                        const SizedBox(height: 6),
                        _buildModalDropdown(
                          value: status,
                          items: const ['Active', 'Draft'],
                          onChanged: (v) {
                            if (v != null) setDialogState(() => status = v);
                          },
                        ),
                        const SizedBox(height: 16),

                        // Model Answer / Solution Explanation
                        _buildFieldLabel(
                            'Model Answer / Solution Explanation'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: modelAnsCtrl,
                          maxLines: 4,
                          style: GoogleFonts.plusJakartaSans(fontSize: 13.5),
                          decoration: _inputDeco(
                            hint:
                                'Step-by-step model solution, derivation or evaluation criteria...',
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Actions: Cancel & Save Question
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(ctx),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Color(0xFFE5E7EB)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4B5563),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton.icon(
                              onPressed: () {
                                final topic = topicCtrl.text.trim();
                                final stmt = stmtCtrl.text.trim();
                                final marks =
                                    int.tryParse(marksCtrl.text.trim()) ?? 5;
                                final modelAns = modelAnsCtrl.text.trim();

                                if (topic.isEmpty || stmt.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please provide both topic and question statement',
                                        style: GoogleFonts.plusJakartaSans(
                                            color: Colors.white),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      backgroundColor: const Color(0xFFDC2626),
                                    ),
                                  );
                                  return;
                                }

                                setState(() {
                                  if (isEditing) {
                                    existingQuestion.topic = topic;
                                    existingQuestion.statement = stmt;
                                    existingQuestion.difficulty = difficulty;
                                    existingQuestion.bloom = bloom;
                                    existingQuestion.marks = marks;
                                    existingQuestion.co = co;
                                    existingQuestion.status = status;
                                    existingQuestion.modelAnswer = modelAns;
                                  } else {
                                    final newId = 'Q-${1150 + _questions.length}';
                                    _questions.insert(
                                      0,
                                      BankQuestionItem(
                                        id: newId,
                                        topic: topic,
                                        statement: stmt,
                                        difficulty: difficulty,
                                        bloom: bloom,
                                        marks: marks,
                                        co: co,
                                        status: status,
                                        modelAnswer: modelAns,
                                      ),
                                    );
                                  }
                                });

                                Navigator.pop(ctx);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      isEditing
                                          ? 'Question updated successfully'
                                          : 'Question added to question bank',
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: const Color(0xFF1E2865),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add_rounded,
                                  size: 16, color: Colors.white),
                              label: Text(
                                isEditing ? 'Save Changes' : 'Save Question',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E2865),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
  // MODAL: GENERATE WITH AI (MATCHES IMAGE 5)
  // ===========================================================================
  void _openAiGenerateModal({String? prefilledTopic}) {
    final subjectCtrl = TextEditingController(text: 'Database Management Systems');
    final topicsCtrl = TextEditingController(
      text: prefilledTopic ??
          "Normalization\nTransactions and concurrency control\nSQL joins",
    );
    final marksEachCtrl = TextEditingController(text: 'Auto');
    final notesCtrl = TextEditingController();

    String numQuestions = "10";
    String difficulty = "Mixed";
    String bloom = "Mixed";
    String style = "Mixed";
    String co = "CO1";

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Container(
                width: 640,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Modal Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.auto_awesome_rounded,
                                    size: 20, color: Color(0xFF1E2865)),
                                const SizedBox(width: 10),
                                Text(
                                  'Generate questions with AI',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1E2865),
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(ctx),
                              borderRadius: BorderRadius.circular(20),
                              child: const Icon(Icons.close_rounded,
                                  size: 20, color: Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Enter the topics and the AI drafts questions with model answers for you to review.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Divider(height: 1, color: Color(0xFFE5E7EB)),
                        const SizedBox(height: 18),

                        // Subject or course (optional)
                        _buildFieldLabel('Subject or course (optional)'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: subjectCtrl,
                          style: GoogleFonts.plusJakartaSans(fontSize: 13.5),
                          decoration: _inputDeco(
                            hint: 'e.g. Database Management Systems',
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Topics
                        _buildFieldLabel('Topics'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: topicsCtrl,
                          maxLines: 3,
                          style: GoogleFonts.plusJakartaSans(fontSize: 13.5),
                          decoration: _inputDeco(
                            hint:
                                'Normalization\nTransactions and concurrency control\nSQL joins',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'One per line or comma-separated, up to 8.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Row 1: Number of questions, Difficulty, Bloom level
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFieldLabel('Number of questions'),
                                  const SizedBox(height: 6),
                                  _buildModalDropdown(
                                    value: numQuestions,
                                    items: const ['5', '10', '15', '20'],
                                    onChanged: (v) {
                                      if (v != null) {
                                        setDialogState(() => numQuestions = v);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFieldLabel('Difficulty'),
                                  const SizedBox(height: 6),
                                  _buildModalDropdown(
                                    value: difficulty,
                                    items: const [
                                      'Mixed',
                                      'Easy',
                                      'Medium',
                                      'Hard'
                                    ],
                                    onChanged: (v) {
                                      if (v != null) {
                                        setDialogState(() => difficulty = v);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFieldLabel('Bloom level'),
                                  const SizedBox(height: 6),
                                  _buildModalDropdown(
                                    value: bloom,
                                    items: const [
                                      'Mixed',
                                      'Remember',
                                      'Understand',
                                      'Apply',
                                      'Analyse',
                                      'Evaluate',
                                      'Create'
                                    ],
                                    onChanged: (v) {
                                      if (v != null) {
                                        setDialogState(() => bloom = v);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Row 2: Question style, Marks each, Course outcome
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFieldLabel('Question style'),
                                  const SizedBox(height: 6),
                                  _buildModalDropdown(
                                    value: style,
                                    items: const [
                                      'Mixed',
                                      'Conceptual',
                                      'Problem Solving',
                                      'Numerical',
                                      'Case Study'
                                    ],
                                    onChanged: (v) {
                                      if (v != null) {
                                        setDialogState(() => style = v);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildFieldLabel('Marks each'),
                                  const SizedBox(height: 6),
                                  Container(
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: const Color(0xFFE5E7EB)),
                                    ),
                                    child: TextField(
                                      controller: marksEachCtrl,
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 13.5),
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Blank lets the AI choose.',
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10.5,
                                      color: const Color(0xFF9CA3AF),
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
                                  _buildFieldLabel('Course outcome'),
                                  const SizedBox(height: 6),
                                  _buildModalDropdown(
                                    value: co,
                                    items: const [
                                      'CO1',
                                      'CO2',
                                      'CO3',
                                      'CO4',
                                      'CO5'
                                    ],
                                    onChanged: (v) {
                                      if (v != null) {
                                        setDialogState(() => co = v);
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 2),
                                  const SizedBox(height: 12), // spacer align
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Reference notes (optional)
                        _buildFieldLabel('Reference notes (optional)'),
                        const SizedBox(height: 6),
                        TextField(
                          controller: notesCtrl,
                          maxLines: 3,
                          style: GoogleFonts.plusJakartaSans(fontSize: 13.5),
                          decoration: _inputDeco(hint: ''),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Paste syllabus text or notes to keep the questions within what you taught.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Actions: Cancel & Generate
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: () => Navigator.pop(ctx),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Color(0xFFE5E7EB)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4B5563),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton.icon(
                              onPressed: () {
                                final topics = topicsCtrl.text
                                    .split('\n')
                                    .map((t) => t.trim())
                                    .where((t) => t.isNotEmpty)
                                    .toList();
                                final targetTopic = topics.isNotEmpty
                                    ? topics.first
                                    : 'General Topics';

                                // Generate questions into list
                                setState(() {
                                  _questions.insert(
                                    0,
                                    BankQuestionItem(
                                      id: 'Q-${1160 + _questions.length}',
                                      topic: targetTopic,
                                      statement:
                                          'Explain the synthesis algorithm for 3NF relational schemas with dependency preservation.',
                                      difficulty: 'Medium',
                                      bloom: 'Understand',
                                      marks: 5,
                                      co: co,
                                      status: 'Draft',
                                      modelAnswer:
                                          '1. Find minimal cover F for given FD set.\n2. For each FD X -> A in F, create schema with X U {A}.\n3. If no candidate key is contained in any created schema, add schema containing a candidate key.\n4. Eliminate redundant schemas.',
                                    ),
                                  );
                                });

                                Navigator.pop(ctx);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'AI generated draft question for "$targetTopic"',
                                      style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: const Color(0xFF1E2865),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.auto_awesome_rounded,
                                  size: 16, color: Colors.white),
                              label: Text(
                                'Generate',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E2865),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
  // DELETE QUESTION MODAL (MATCHES IMAGE 4)
  // ===========================================================================
  void _confirmDeleteQuestion(BankQuestionItem q) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Container(
            width: 480,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trash icon in soft red rounded box
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEE2E2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    size: 24,
                    color: Color(0xFFDC2626),
                  ),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  'Delete question?',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E2865),
                  ),
                ),
                const SizedBox(height: 8),

                // Question statement with ID
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${q.statement} ',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5,
                          color: const Color(0xFF374151),
                          height: 1.45,
                        ),
                      ),
                      TextSpan(
                        text: '(${q.id})',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                      TextSpan(
                        text: ' will be permanently removed.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5,
                          color: const Color(0xFF374151),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Amber warning callout banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Deleting a question permanently removes it from the department question bank.',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFB45309),
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE5E7EB)),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4B5563),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _questions.removeWhere((item) => item.id == q.id);
                          if (_viewingQuestion?.id == q.id) {
                            _viewingQuestion = null;
                          }
                          if (_editingQuestion?.id == q.id) {
                            _editingQuestion = null;
                          }
                        });
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Question ${q.id} deleted',
                              style: GoogleFonts.plusJakartaSans(color: Colors.white),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: const Color(0xFFDC2626),
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete_outline_rounded,
                          size: 16, color: Colors.white),
                      label: Text(
                        'Delete',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC2626),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ===========================================================================
  // QUESTION DETAIL VIEW (MATCHES IMAGE 3)
  // ===========================================================================
  Widget _buildQuestionDetailView(BankQuestionItem q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Top Blueprint Hero Banner
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF1E2865),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E2865).withValues(alpha: 0.18),
                blurRadius: 16,
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
                    painter: _BlueprintGridPainter(
                      gridColor: Colors.white.withValues(alpha: 0.08),
                      step: 26,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Breadcrumb row
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => setState(() => _viewingQuestion = null),
                              child: Text(
                                'Home',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Icon(Icons.chevron_right_rounded,
                                  size: 14, color: Colors.white.withValues(alpha: 0.5)),
                            ),
                            InkWell(
                              onTap: () => setState(() {
                                _viewingQuestion = null;
                                _openedFolderTopic = null;
                              }),
                              child: Text(
                                'Assessment',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Icon(Icons.chevron_right_rounded,
                                  size: 14, color: Colors.white.withValues(alpha: 0.5)),
                            ),
                            Text(
                              q.statement.length > 50
                                  ? '${q.statement.substring(0, 48)}...'
                                  : q.statement,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Icon(Icons.chevron_right_rounded,
                                  size: 14, color: Colors.white.withValues(alpha: 0.5)),
                            ),
                            Text(
                              q.id,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Badges
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'ASSESSMENT',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.35),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'MVP',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF6EE7B7),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Title & Action buttons (Edit & Delete)
                      LayoutBuilder(
                        builder: (context, bConstraints) {
                          final isNarrow = bConstraints.maxWidth < 680;

                          final titleCol = Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                q.statement,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  height: 1.3,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${q.topic} · ${q.co}',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );

                          final actions = Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () => _startEditingQuestion(q),
                                icon: const Icon(Icons.edit_outlined,
                                    size: 15, color: Color(0xFF78350F)),
                                label: Text(
                                  'Edit',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF78350F),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFBBF24),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              OutlinedButton.icon(
                                onPressed: () => _confirmDeleteQuestion(q),
                                icon: const Icon(Icons.delete_outline_rounded,
                                    size: 16, color: Colors.white),
                                label: Text(
                                  'Delete',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: Colors.white.withValues(alpha: 0.3)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          );

                          if (isNarrow) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                titleCol,
                                const SizedBox(height: 14),
                                actions,
                              ],
                            );
                          }

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: titleCol),
                              const SizedBox(width: 16),
                              actions,
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // 2. Main Content: Left Column (3 Detail Cards) & Right Column (Preview Card, History, Back Button)
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 840;

            final leftColumn = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card 1: Question details
                _buildCardContainer(
                  title: 'Question details',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'QUESTION',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF6B7280),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        q.statement,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1E2865),
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Card 2: Classification (2-column key-value grid)
                _buildCardContainer(
                  title: 'Classification',
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildKeyValueBlock(
                              label: 'TOPIC',
                              value: q.topic,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _buildKeyValueBadge(
                              label: 'DIFFICULTY',
                              badgeText: q.difficulty,
                              textColor: q.difficultyColor,
                              bgColor: q.difficultyBgColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildKeyValueBadge(
                              label: 'BLOOM LEVEL',
                              badgeText: q.bloom,
                              textColor: q.bloomColor,
                              bgColor: q.bloomBgColor,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _buildKeyValueBlock(
                              label: 'COURSE OUTCOME (CO)',
                              value: q.co,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildKeyValueBlock(
                              label: 'MARKS',
                              value: '${q.marks}',
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: _buildKeyValueBadge(
                              label: 'STATUS',
                              badgeText: q.status,
                              textColor: q.status == 'Active'
                                  ? const Color(0xFF047857)
                                  : const Color(0xFFB45309),
                              bgColor: q.status == 'Active'
                                  ? const Color(0xFFECFDF5)
                                  : const Color(0xFFFEF3C7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Card 3: Model answer & notes
                _buildCardContainer(
                  title: 'Model answer & notes',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MODEL ANSWER / EXPLANATION',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF6B7280),
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        q.modelAnswer.isNotEmpty
                            ? q.modelAnswer
                            : 'No model answer provided.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: const Color(0xFF334155),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );

            final rightColumn = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Identity Preview Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Avatar box
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2865),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          q.difficulty.length >= 2
                              ? q.difficulty.substring(0, 2).toUpperCase()
                              : 'Q',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      Text(
                        q.statement,
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E2865),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        q.id,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: const Color(0xFF9CA3AF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        alignment: WrapAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: q.status == 'Active'
                                  ? const Color(0xFFECFDF5)
                                  : const Color(0xFFFEF3C7),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              q.status,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: q.status == 'Active'
                                    ? const Color(0xFF047857)
                                    : const Color(0xFFB45309),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3E8FF),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.account_balance_rounded,
                                    size: 11, color: Color(0xFF7E22CE)),
                                const SizedBox(width: 4),
                                Text(
                                  'Anna Institute of Technology',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF7E22CE),
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
                const SizedBox(height: 16),

                // Record History Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
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
                        'Record history',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E2865),
                        ),
                      ),
                      const SizedBox(height: 14),

                      _buildHistoryRow(
                        icon: Icons.calendar_today_outlined,
                        label: 'Created',
                        value: '14 Oct 2026',
                      ),
                      const SizedBox(height: 10),
                      _buildHistoryRow(
                        icon: Icons.history_rounded,
                        label: 'Last updated',
                        value: '14 Oct 2026',
                      ),
                      const SizedBox(height: 10),
                      _buildHistoryRow(
                        icon: Icons.inventory_2_outlined,
                        label: 'Version',
                        value: '1',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Back Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => setState(() => _viewingQuestion = null),
                    icon: const Icon(Icons.arrow_back_rounded,
                        size: 15, color: Color(0xFF1E2865)),
                    label: Text(
                      'Back to Question Bank',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E2865),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            );

            if (isNarrow) {
              return Column(
                children: [
                  leftColumn,
                  const SizedBox(height: 20),
                  rightColumn,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 7, child: leftColumn),
                const SizedBox(width: 20),
                Expanded(flex: 4, child: rightColumn),
              ],
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // EDIT QUESTION FULL-PAGE VIEW (MATCHES IMAGE 1 & 2)
  // ===========================================================================
  Widget _buildEditQuestionView(BankQuestionItem q) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Top Blueprint Hero Banner
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF1E2865),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1E2865).withValues(alpha: 0.18),
                blurRadius: 16,
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
                    painter: _BlueprintGridPainter(
                      gridColor: Colors.white.withValues(alpha: 0.08),
                      step: 26,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Breadcrumb row
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () => setState(() => _editingQuestion = null),
                              child: Text(
                                'Home',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Icon(Icons.chevron_right_rounded,
                                  size: 14, color: Colors.white.withValues(alpha: 0.5)),
                            ),
                            Text(
                              'Assessment',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Icon(Icons.chevron_right_rounded,
                                  size: 14, color: Colors.white.withValues(alpha: 0.5)),
                            ),
                            Text(
                              'Edit question · ${q.id}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Icon(Icons.chevron_right_rounded,
                                  size: 14, color: Colors.white.withValues(alpha: 0.5)),
                            ),
                            Text(
                              q.id,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
                              child: Icon(Icons.chevron_right_rounded,
                                  size: 14, color: Colors.white.withValues(alpha: 0.5)),
                            ),
                            Text(
                              'Edit',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Badges
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.14),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'ASSESSMENT',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.35),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'MVP',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF6EE7B7),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Text(
                        'Edit question · ${q.id}',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Update the details below. Changes are validated, versioned and recorded in the audit log.',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.82),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // 2. Purple Institutional Notice Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF5FF),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE9D5FF)),
          ),
          child: Row(
            children: [
              const Icon(Icons.account_balance_rounded, size: 16, color: Color(0xFF7E22CE)),
              const SizedBox(width: 10),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12.5,
                      color: const Color(0xFF6B21A8),
                    ),
                    children: const [
                      TextSpan(text: 'Belongs to '),
                      TextSpan(
                        text: 'Anna Institute of Technology',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: ' — records cannot be moved between colleges.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 3. 2-Column Content: Left 3-Step Form Cards, Right Sidebar Card
        LayoutBuilder(
          builder: (context, constraints) {
            final isNarrow = constraints.maxWidth < 1280;

            final leftForm = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Card 1: Question details (Step 1 of 3)
                _buildStepCard(
                  icon: Icons.person_outline_rounded,
                  iconBg: const Color(0xFFEFF6FF),
                  iconColor: const Color(0xFF2563EB),
                  title: 'Question details',
                  step: 'Step 1 of 3',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel('Question *'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _editStmtController,
                        maxLines: 4,
                        style: GoogleFonts.plusJakartaSans(fontSize: 13.5),
                        decoration: _inputDeco(
                          hint:
                              'Enter clear, concise question statement or problem description...',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Card 2: Classification (Step 2 of 3)
                _buildStepCard(
                  icon: Icons.school_outlined,
                  iconBg: const Color(0xFFFEF3C7),
                  iconColor: const Color(0xFFD97706),
                  title: 'Classification',
                  step: 'Step 2 of 3',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1: Topic * & Difficulty *
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Topic *'),
                                const SizedBox(height: 6),
                                TextField(
                                  controller: _editTopicController,
                                  style: GoogleFonts.plusJakartaSans(fontSize: 13.5),
                                  decoration: _inputDeco(hint: 'Topic heading'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Difficulty *'),
                                const SizedBox(height: 6),
                                _buildModalDropdown(
                                  value: _editDifficulty,
                                  items: const ['Easy', 'Medium', 'Hard'],
                                  onChanged: (v) {
                                    if (v != null) setState(() => _editDifficulty = v);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 2: Bloom level * & Course outcome (CO) *
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Bloom level *'),
                                const SizedBox(height: 6),
                                _buildModalDropdown(
                                  value: _editBloom,
                                  items: const [
                                    'Remember',
                                    'Understand',
                                    'Apply',
                                    'Analyse',
                                    'Evaluate',
                                    'Create'
                                  ],
                                  onChanged: (v) {
                                    if (v != null) setState(() => _editBloom = v);
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
                                _buildFieldLabel('Course outcome (CO) *'),
                                const SizedBox(height: 6),
                                _buildModalDropdown(
                                  value: _editCo,
                                  items: const [
                                    'CO1',
                                    'CO2',
                                    'CO3',
                                    'CO4',
                                    'CO5',
                                    'CO6'
                                  ],
                                  onChanged: (v) {
                                    if (v != null) setState(() => _editCo = v);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Row 3: Marks * & Status *
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Marks *'),
                                const SizedBox(height: 6),
                                Container(
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border:
                                        Border.all(color: const Color(0xFFE5E7EB)),
                                  ),
                                  child: TextField(
                                    controller: _editMarksController,
                                    keyboardType: TextInputType.number,
                                    style:
                                        GoogleFonts.plusJakartaSans(fontSize: 13.5),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 14, vertical: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildFieldLabel('Status *'),
                                const SizedBox(height: 6),
                                _buildModalDropdown(
                                  value: _editStatus,
                                  items: const ['Active', 'Draft'],
                                  onChanged: (v) {
                                    if (v != null) setState(() => _editStatus = v);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Card 3: Model answer & notes (Step 3 of 3)
                _buildStepCard(
                  icon: Icons.description_outlined,
                  iconBg: const Color(0xFFCCFBF1),
                  iconColor: const Color(0xFF0D9488),
                  title: 'Model answer & notes',
                  step: 'Step 3 of 3',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel('Model answer / explanation'),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _editModelAnsController,
                        maxLines: 6,
                        style: GoogleFonts.plusJakartaSans(fontSize: 13.5),
                        decoration: _inputDeco(
                          hint:
                              'Step-by-step model solution, derivation or evaluation criteria...',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );

            final rightSidebar = Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE5E7EB)),
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
                    'Editing question',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E2865),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Progress
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Required fields',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                      Text(
                        '7/7',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0D9488),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: const LinearProgressIndicator(
                      value: 1.0,
                      minHeight: 6,
                      backgroundColor: Color(0xFFE5E7EB),
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF0D9488)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Bullets
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.shield_outlined,
                          size: 14, color: Color(0xFF0D9488)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Validated in the browser and on the server',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            color: const Color(0xFF6B7280),
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.history_rounded,
                          size: 14, color: Color(0xFF6B7280)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Version 1 — conflicting edits are blocked',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11.5,
                            color: const Color(0xFF6B7280),
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Save Changes button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _saveEditingQuestion,
                      icon: const Icon(Icons.save_outlined,
                          size: 16, color: Colors.white),
                      label: Text(
                        'Save changes',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8B5CF6),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Cancel button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => setState(() => _editingQuestion = null),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE5E7EB)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4B5563),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );

            if (isNarrow) {
              return Column(
                children: [
                  leftForm,
                  const SizedBox(height: 20),
                  rightSidebar,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 7, child: leftForm),
                const SizedBox(width: 20),
                Expanded(flex: 4, child: rightSidebar),
              ],
            );
          },
        ),
      ],
    );
  }

  // ===========================================================================
  // SUB-CARD WIDGET HELPERS
  // ===========================================================================
  Widget _buildCardContainer({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E2865),
            ),
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildStepCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String step,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: iconColor),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E2865),
                    ),
                  ),
                  Text(
                    step,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          child,
        ],
      ),
    );
  }

  Widget _buildKeyValueBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF6B7280),
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.5,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E2865),
          ),
        ),
      ],
    );
  }

  Widget _buildKeyValueBadge({
    required String label,
    required String badgeText,
    required Color textColor,
    required Color bgColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10.5,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF6B7280),
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            badgeText,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14, color: const Color(0xFF9CA3AF)),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            color: const Color(0xFF6B7280),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E2865),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // FORM FIELD HELPERS
  // ===========================================================================
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF374151),
      ),
    );
  }

  InputDecoration _inputDeco({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.plusJakartaSans(
        fontSize: 13,
        color: const Color(0xFF9CA3AF),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
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
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 18, color: Color(0xFF6B7280)),
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: const Color(0xFF1E2865),
            fontWeight: FontWeight.w500,
          ),
          items: items.map((it) {
            return DropdownMenuItem<String>(
              value: it,
              child: Text(
                it,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  color: const Color(0xFF1E2865),
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// =============================================================================
// BLUEPRINT GRID PAINTER
// =============================================================================
class _BlueprintGridPainter extends CustomPainter {
  final Color gridColor;
  final double step;
  const _BlueprintGridPainter({required this.gridColor, this.step = 26.0});

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
  bool shouldRepaint(covariant _BlueprintGridPainter oldDelegate) =>
      oldDelegate.gridColor != gridColor || oldDelegate.step != step;
}
