import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final String time;

  const ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
  });
}

class MentorChatScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const MentorChatScreen({super.key, this.onBack});

  @override
  State<MentorChatScreen> createState() => _MentorChatScreenState();
}

class _MentorChatScreenState extends State<MentorChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [];
  bool _isAITyping = false;

  final List<Map<String, dynamic>> _suggestions = [
    {
      "icon": Icons.lightbulb_outline_rounded,
      "text": "What should I study today?",
      "hasArrow": true,
    },
    {
      "icon": Icons.calendar_today_outlined,
      "text": "Why is my mastery in ER Model & Relational Algebra only 0%?",
      "hasArrow": false,
    },
    {
      "icon": Icons.trending_up_rounded,
      "text": "Help me prepare for DBMS Internal Assessment II",
      "hasArrow": false,
    },
    {
      "icon": Icons.folder_open_outlined,
      "text": "Explain ER Model & Relational Algebra with an example",
      "hasArrow": false,
    },
    {
      "icon": Icons.mic_none_outlined,
      "text": "What skills should I build for my career?",
      "hasArrow": false,
    },
    {
      "icon": Icons.account_balance_outlined,
      "text": "Help me with my project: Smart Campus AI & Autonomous Attendance",
      "hasArrow": false,
    },
  ];

  final List<String> _agents = const [
    "AI Mentor",
    "Academic Tutor",
    "Study Planner",
    "Revision Agent",
    "Exam Agent",
    "Viva Agent",
    "Career Coach",
    "Resume Agent",
    "Interview Agent",
    "GD Agent",
    "Communication Coach",
    "Language Coach",
    "Competitive Exam Agent",
    "Project Mentor",
    "Research Agent",
    "Startup / Incubation",
    "Alumni Mentor",
  ];

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage([String? presetText]) {
    final text = presetText ?? _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
          time: "Just now",
        ),
      );
      _isAITyping = true;
    });
    _controller.clear();

    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      String reply =
          "I've analyzed your current academic status for this request. Let me generate a personalized walkthrough based on your DBMS syllabus, active project, and upcoming internal assessment.";

      if (text.contains("study today")) {
        reply =
            "Looking at your schedule today:\n\n"
            "1. **09:00 AM - 10:30 AM**: Review ER Model cardinalities & Relational Algebra operators (Join, Project, Select).\n"
            "2. **11:30 AM - 01:00 PM**: Operating Systems Lab on Thread Synchronization.\n"
            "3. **04:00 PM - 05:00 PM**: Work on your Smart Campus AI Attendance facial recognition dataset.\n"
            "4. **Evening Revision**: 30-minute practice quiz on DBMS IA-II sample questions.\n\n"
            "Would you like me to set a reminder for your 4 PM project sprint?";
      } else if (text.contains("0%") || text.contains("mastery")) {
        reply =
            "Your mastery in **ER Model & Relational Algebra** is at **0%** because:\n\n"
            "• You haven't attempted the Unit 2 practice quiz yet.\n"
            "• 2 homework problem sets on Tuple Relational Calculus remain unsubmitted.\n"
            "• IA-II is in **9 days** and covers 35% of these topics.\n\n"
            "I recommend starting with a 15-minute quick diagnostic quiz right now to calibrate your score.";
      } else if (text.contains("Internal Assessment II") || text.contains("prepare")) {
        reply =
            "Here is your 9-day high-yield prep plan for **DBMS Internal Assessment II**:\n\n"
            "• **Days 1-3**: ER-to-Relational Mapping, Primary/Foreign Key constraints.\n"
            "• **Days 4-6**: Relational Algebra (Selection, Projection, Theta Join, Division).\n"
            "• **Days 7-8**: SQL Queries & Subqueries practice with 10 previous exam questions.\n"
            "• **Day 9**: Full timed mock test (50 Marks).";
      } else if (text.contains("example")) {
        reply =
            "**ER Model to Relational Schema Example**:\n\n"
            "Entity: `Student(RollNo, Name, Dept)`\n"
            "Entity: `Course(CourseId, Title, Credits)`\n"
            "Relationship: `Enrolls(RollNo, CourseId, Grade)`\n\n"
            "**Relational Algebra Query**:\n"
            "To find names of students enrolled in 'DBMS':\n"
            "π Name (σ Title='DBMS' (Student ⨝ Enrolls ⨝ Course))\n\n"
            "Notice how the natural join (`⨝`) combines the tuples on matching keys!";
      } else if (text.contains("career") || text.contains("skills")) {
        reply =
            "For a Tier-1 Software Engineering profile (Sem 5):\n\n"
            "1. **Core CS Foundations**: Master DBMS indexing (B-Trees) and OS concurrency.\n"
            "2. **System Design**: Learn RESTful API design, Caching (Redis), and PostgreSQL.\n"
            "3. **DSA**: Complete 75 LeetCode medium questions across Graphs & DP.\n"
            "4. **Full-Stack Project**: Deploy your Smart Campus AI project with Docker and CI/CD.";
      } else if (text.contains("Smart Campus") || text.contains("project")) {
        reply =
            "For **Smart Campus AI & Autonomous Attendance**:\n\n"
            "• **Next Milestone**: Edge camera face embeddings extraction using MobileNet/InsightFace.\n"
            "• **Backend**: Store embeddings in pgvector (PostgreSQL) for sub-50ms matching.\n"
            "• **Fault Tolerance**: Offline fallback caching when campus Wi-Fi drops.\n\n"
            "Do you want me to generate the database schema for the attendance logging table?";
      }

      setState(() {
        _isAITyping = false;
        _messages.add(
          ChatMessage(
            text: reply,
            isUser: false,
            time: "Just now",
          ),
        );
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1320),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Top Hero Banner
                        _buildHeroBanner(),
                        const SizedBox(height: 24),

                        // Two column responsive layout
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (constraints.maxWidth >= 960) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Left Column: Chat Area & Suggestions
                                  Expanded(
                                    flex: 7,
                                    child: _buildChatMainArea(),
                                  ),
                                  const SizedBox(width: 24),
                                  // Right Column: Sidebar Panels
                                  SizedBox(
                                    width: 380,
                                    child: _buildSidebar(),
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  _buildChatMainArea(),
                                  const SizedBox(height: 24),
                                  _buildSidebar(),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Grid background pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _HeroGridPainter(),
              ),
            ),

            // Giant robot watermark icon on the bottom right
            Positioned(
              right: -10,
              bottom: -20,
              child: Icon(
                Icons.smart_toy_rounded,
                size: 150,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),

            // Banner content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb row
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
                            fontSize: 12.5,
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
                          "Student Success",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
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
                          "AI Mentor",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Hero Title & Badges
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Robot avatar squircle
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1.2,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.smart_toy_rounded,
                            size: 26,
                            color: Color(0xFFFBBF24),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Text column
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
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "STUDENT SUCCESS",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF059669),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "MVP",
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
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
                              "AI Mentor",
                              style: GoogleFonts.poppins(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              "Your persistent academic & career mentor that knows your progress, goals and weak areas.",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
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

  Widget _buildChatMainArea() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Context Bar
          _buildContextPillsBar(),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFFF1F3F5), height: 1),
          const SizedBox(height: 20),

          // Initial AI Mentor Intro Bubble
          _buildInitialAIMessage(),
          const SizedBox(height: 20),

          // Suggestion Cards (6 items)
          _buildSuggestionGrid(),
          const SizedBox(height: 20),

          // Conversation Thread (if messages exist)
          if (_messages.isNotEmpty) ...[
            const Divider(color: Color(0xFFF1F3F5), height: 1),
            const SizedBox(height: 16),
            ..._messages.map((m) => _buildMessageRow(m)),
            if (_isAITyping) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    _buildAIAvatar(),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.brand,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "AI Mentor is thinking...",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
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
            const SizedBox(height: 12),
          ],

          // Input Box & Footer
          _buildChatInputBox(),
        ],
      ),
    );
  }

  Widget _buildContextPillsBar() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.tune_rounded,
              size: 14,
              color: Color(0xFF64748B),
            ),
            const SizedBox(width: 5),
            Text(
              "CONTEXT",
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: const Color(0xFF475569),
              ),
            ),
          ],
        ),
        _contextPill("Computer Science & Engineering · Sem 5"),
        _contextPill("DBMS Internal Assessment II in 9 days"),
        _contextPill("Project: Smart Campus AI & Autonomous Attendance"),
        _contextPill("Focus: ER Model & Relational Algebra (0%)"),
        _contextPill("Attendance below 75%: DBMS, OS, CN, ML, Algorithms, Python"),
      ],
    );
  }

  Widget _contextPill(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 11.5,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF475569),
        ),
      ),
    );
  }

  Widget _buildAIAvatar() {
    return Container(
      width: 28,
      height: 28,
      decoration: const BoxDecoration(
        color: Color(0xFF1E286D),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.smart_toy_rounded,
          size: 15,
          color: Color(0xFFFBBF24),
        ),
      ),
    );
  }

  Widget _buildInitialAIMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAIAvatar(),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AI Mentor",
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.015),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      height: 1.55,
                      color: const Color(0xFF334155),
                    ),
                    children: const [
                      TextSpan(
                        text:
                            "Hi Anand 👋 I'm your academic & career mentor. I work from your own records: your 6 subjects this semester, internal marks, attendance, topic mastery and project. Right now your lowest-mastery topic is ",
                      ),
                      TextSpan(
                        text: "ER Model & Relational Algebra",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text:
                            " (DBMS, 0%), and ",
                      ),
                      TextSpan(
                        text: "DBMS Internal Assessment II",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text:
                            " is in 9 days. Ask me anything, or pick a suggestion.",
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

  Widget _buildSuggestionGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 640;
        final halfLength = (_suggestions.length / 2).ceil();

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  children: [
                    for (int i = 0; i < halfLength; i++) ...[
                      _suggestionCard(_suggestions[i]),
                      if (i < halfLength - 1) const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  children: [
                    for (int i = halfLength; i < _suggestions.length; i++) ...[
                      _suggestionCard(_suggestions[i]),
                      if (i < _suggestions.length - 1)
                        const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
            ],
          );
        } else {
          return Column(
            children: [
              for (int i = 0; i < _suggestions.length; i++) ...[
                _suggestionCard(_suggestions[i]),
                if (i < _suggestions.length - 1) const SizedBox(height: 10),
              ],
            ],
          );
        }
      },
    );
  }

  Widget _suggestionCard(Map<String, dynamic> item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _sendMessage(item["text"] as String),
        borderRadius: BorderRadius.circular(12),
        hoverColor: const Color(0xFFF1F5F9),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  item["icon"] as IconData,
                  size: 16,
                  color: const Color(0xFF334155),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item["text"] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B),
                    height: 1.35,
                  ),
                ),
              ),
              if (item["hasArrow"] == true) ...[
                const SizedBox(width: 6),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: Color(0xFF64748B),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageRow(ChatMessage msg) {
    if (msg.isUser) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.brand,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  msg.text,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white,
                    height: 1.45,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Color(0xFFE2E8F0),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.person_rounded,
                  size: 16,
                  color: Color(0xFF475569),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAIAvatar(),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  msg.text,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF1E293B),
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildChatInputBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  onSubmitted: (v) => _sendMessage(),
                  decoration: InputDecoration(
                    hintText: "Message AI Mentor...",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 13,
                      color: const Color(0xFF94A3B8),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Material(
                color: const Color(0xFF8B93D6),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: () => _sendMessage(),
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.send_rounded,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Enter to send · Shift+Enter for a new line · Don't share passwords or personal IDs",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "${_controller.text.length}/2000",
              style: GoogleFonts.poppins(
                fontSize: 10.5,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Panel 1: What your mentor knows
        _buildMentorKnowledgeCard(),
        const SizedBox(height: 18),

        // Panel 2: Your focus topics
        _buildFocusTopicsCard(),
        const SizedBox(height: 18),

        // Panel 3: Agents your mentor can call
        _buildAgentsCard(),
        const SizedBox(height: 18),

        // Panel 4: Wellness disclaimer alert
        _buildWellnessDisclaimer(),
      ],
    );
  }

  Widget _buildMentorKnowledgeCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "What your mentor knows",
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "AI live",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF059669),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            "Built from your own marks, attendance and progress",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),

          _knowledgeProgressItem(
            label: "Academic progress",
            pct: "0%",
            value: 0.0,
            subtext: "Syllabus covered this semester",
          ),
          _knowledgeProgressItem(
            label: "Exam readiness",
            pct: "0%",
            value: 0.0,
            subtext: "From your internal assessment marks",
          ),
          _knowledgeProgressItem(
            label: "Attendance",
            pct: "0%",
            value: 0.0,
            subtext: "Average across your subjects",
          ),
          _knowledgeProgressItem(
            label: "Technical skills",
            pct: "0%",
            value: 0.0,
          ),
          _knowledgeProgressItem(
            label: "Communication",
            pct: "0%",
            value: 0.0,
          ),
          _knowledgeProgressItem(
            label: "Interview readiness",
            pct: "0%",
            value: 0.0,
            isLast: true,
          ),
          const SizedBox(height: 14),
          Text(
            "You can review or delete what the mentor remembers from Profile → Privacy.",
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: const Color(0xFF94A3B8),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _knowledgeProgressItem({
    required String label,
    required String pct,
    required double value,
    String? subtext,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                pct,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ),
          if (subtext != null) ...[
            const SizedBox(height: 2),
            Text(
              subtext,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ],
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: const Color(0xFFF1F5F9),
              color: const Color(0xFF6366F1),
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusTopicsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your focus topics",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Lowest mastery first",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),

          _focusTopicItem(
            name: "ER Model & Relational Algebra · DBMS",
            pct: "0%",
            val: 0.0,
          ),
          _focusTopicItem(
            name: "SQL Queries & Joins · DBMS",
            pct: "0%",
            val: 0.0,
          ),
          _focusTopicItem(
            name: "Normalization & Functional Depende...",
            pct: "0%",
            val: 0.0,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _focusTopicItem({
    required String name,
    required String pct,
    required double val,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                pct,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF475569),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: val,
              backgroundColor: const Color(0xFFF1F5F9),
              color: const Color(0xFF6366F1),
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgentsCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Agents your mentor can call",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 6,
            runSpacing: 7,
            children: _agents.map((agent) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Text(
                  agent,
                  style: GoogleFonts.poppins(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF334155),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildWellnessDisclaimer() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.info_outline_rounded,
            size: 16,
            color: Color(0xFF2563EB),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              "Wellness questions get general educational guidance only. For personal concerns the mentor will point you to the Student Welfare Office.",
              style: GoogleFonts.poppins(
                fontSize: 11.5,
                height: 1.45,
                color: const Color(0xFF1E3A8A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroGridPainter extends CustomPainter {
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
