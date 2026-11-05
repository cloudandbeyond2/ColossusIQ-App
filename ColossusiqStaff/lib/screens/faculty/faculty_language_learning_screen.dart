import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// COMMUNICATION & SKILLS: LANGUAGE LEARNING SCREEN
// Exactly matches screenshots 3 & 4:
// - Blueprint grid hero banner with watermark & badges (COMMUNICATION & SKILLS, Phase 2)
// - Two-column responsive layout:
//     * Left:
//         - "Today's lesson" card with "Start a lesson" sparkle button and blueprint graph paper empty state
//         - "Language Coach" AI chat card with CONTEXT pills (Learning, Mode, Level),
//           bot introduction message, 4 quick suggestion prompt cards (2x2), and interactive chat input bar with counter
//     * Right:
//         - "What are you learning?" with 9-language selector grid (English, Tamil, Hindi, Telugu, Kannada, Malayalam, French, German, Japanese)
//           and Mode + Level dropdown selectors
//         - "Your progress" card with 3 metric counters (Day streak, Phrases saved, Coach chats), 14-day streak tracker squares
//         - "My phrasebook" card with blueprint graph paper empty state
// =============================================================================

class FacultyLanguageLearningScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyLanguageLearningScreen({super.key, this.onBack});

  @override
  State<FacultyLanguageLearningScreen> createState() =>
      _FacultyLanguageLearningScreenState();
}

class _FacultyLanguageLearningScreenState
    extends State<FacultyLanguageLearningScreen> {
  String _selectedLanguage = "English";
  String _selectedMode = "Conversation";
  String _selectedLevel = "Beginner";

  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, String>> _languages = [
    {"name": "English", "native": "English"},
    {"name": "Tamil", "native": "தமிழ்"},
    {"name": "Hindi", "native": "हिन्दी"},
    {"name": "Telugu", "native": "తెలుగు"},
    {"name": "Kannada", "native": "ಕನ್ನಡ"},
    {"name": "Malayalam", "native": "മലയാളം"},
    {"name": "French", "native": "Français"},
    {"name": "German", "native": "Deutsch"},
    {"name": "Japanese", "native": "日本語"},
  ];

  final List<String> _modes = [
    "Conversation",
    "Grammar",
    "Vocabulary",
    "Interview Prep"
  ];

  final List<String> _levels = [
    "Beginner",
    "Intermediate",
    "Advanced",
  ];

  final List<Map<String, String>> _messages = [
    {
      "sender": "bot",
      "text":
          "Hello! I'm your Language Coach. We're working on English: conversation practice at beginner level. Mark the phrases you know in today's lesson and I'll build your phrasebook. Ask me to teach you phrases, correct a sentence you wrote, or quiz you."
    }
  ];

  int _coachChatsCount = 0;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage([String? presetText]) {
    final text = presetText ?? _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "text": text});
      _coachChatsCount++;
      if (presetText == null) {
        _messageController.clear();
      }

      // Add coach reply
      _messages.add({
        "sender": "bot",
        "text":
            "Great! In $_selectedLanguage ($_selectedMode · $_selectedLevel), a natural way to say this is: \"Hello, it's wonderful to meet you!\" Would you like me to break down pronunciation or grammar?"
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 980;
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 90),
            children: [
              // 1. Hero Blueprint Banner
              _buildHeroBanner(),
              const SizedBox(height: 18),

              // 2. Main Two-Column Layout
              if (isNarrow)
                Column(
                  children: [
                    _buildLeftColumn(),
                    const SizedBox(height: 20),
                    _buildRightColumn(),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 13,
                      child: _buildLeftColumn(),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 8,
                      child: _buildRightColumn(),
                    ),
                  ],
                ),
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
              right: 25,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.08,
                child: const Icon(
                  Icons.translate_rounded,
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
                  // Breadcrumbs (clean, no leading arrow)
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
                              color: Colors.white.withValues(alpha: 0.75),
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "Communication & Skills",
                          style: GoogleFonts.poppins(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Text(
                            "›",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          "Language Learning",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Badges Row
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      _buildPillBadge(
                        "COMMUNICATION & SKILLS",
                        const Color(0xFF232D60),
                        Colors.white,
                      ),
                      _buildPillBadge(
                        "Phase 2",
                        const Color(0xFFD97706),
                        Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Icon + Title + Subtitle
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF232F6E),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        child: const Icon(
                          Icons.translate_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Language Learning",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "English, Tamil, Hindi, Telugu, Kannada, Malayalam, French, German, Japanese and more.",
                              style: GoogleFonts.poppins(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 13,
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

  Widget _buildPillBadge(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          color: text,
          letterSpacing: 0.4,
        ),
      ),
    );
  }

  // ===========================================================================
  // 2. LEFT COLUMN: TODAY'S LESSON + LANGUAGE COACH CHAT
  // ===========================================================================
  Widget _buildLeftColumn() {
    return Column(
      children: [
        // Card 1: Today's Lesson
        _buildTodaysLessonCard(),
        const SizedBox(height: 18),

        // Card 2: Language Coach Chat
        _buildLanguageCoachCard(),
      ],
    );
  }

  Widget _buildTodaysLessonCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    "Today's lesson",
                    style: GoogleFonts.poppins(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    "$_selectedLanguage · $_selectedMode · $_selectedLevel",
                    style: GoogleFonts.poppins(
                      fontSize: 12.5,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Starting $_selectedLanguage $_selectedMode Lesson ($_selectedLevel)...",
                        style: GoogleFonts.poppins(),
                      ),
                      backgroundColor: const Color(0xFF1E2865),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.auto_awesome_rounded, size: 15),
                label: Text(
                  "Start a lesson",
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E2865),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Blueprint Graph Paper Empty State Container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFD),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _GridPaperPainter(
                        gridColor:
                            const Color(0xFF6366F1).withValues(alpha: 0.07),
                        step: 22.0,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No lesson yet",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Pick a language, mode and level, then start a lesson. Mark the\nphrases you know to build your phrasebook.",
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF64748B),
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
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

  Widget _buildLanguageCoachCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top CONTEXT row
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Icon(
                    Icons.hub_outlined,
                    size: 15,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "CONTEXT",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF64748B),
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(width: 10),
                  _buildContextPill("Learning: $_selectedLanguage"),
                  const SizedBox(width: 8),
                  _buildContextPill("Mode: $_selectedMode"),
                  const SizedBox(width: 8),
                  _buildContextPill("Level: $_selectedLevel"),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Chat messages body
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Coach messages
                ..._messages.map((m) {
                  final isBot = m["sender"] == "bot";
                  if (isBot) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: const BoxDecoration(
                            color: Color(0xFF1E2865),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.smart_toy_rounded,
                              size: 18,
                              color: Color(0xFFFBBF24),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Language Coach",
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8FAFC),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: const Color(0xFFE2E8F0)),
                                ),
                                child: Text(
                                  m["text"]!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    color: const Color(0xFF334155),
                                    height: 1.45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E2865),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                m["text"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 12.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }),
                const SizedBox(height: 16),

                // 4 Quick Prompt Cards (2x2 grid)
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3.4,
                  children: [
                    _buildPromptCard(
                      icon: Icons.lightbulb_outline_rounded,
                      text: "Teach me conversation phrases in $_selectedLanguage",
                      onTap: () => _sendMessage(
                          "Teach me conversation phrases in $_selectedLanguage"),
                    ),
                    _buildPromptCard(
                      icon: Icons.badge_outlined,
                      text: "How do I introduce myself in $_selectedLanguage?",
                      onTap: () => _sendMessage(
                          "How do I introduce myself in $_selectedLanguage?"),
                    ),
                    _buildPromptCard(
                      icon: Icons.trending_up_rounded,
                      text: "What should I learn first?",
                      onTap: () =>
                          _sendMessage("What should I learn first?"),
                    ),
                    _buildPromptCard(
                      icon: Icons.spellcheck_rounded,
                      text: "Correct my $_selectedLanguage sentence",
                      onTap: () => _sendMessage(
                          "Correct my $_selectedLanguage sentence"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Message input bar
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF9F6),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          onSubmitted: (v) => _sendMessage(),
                          style: GoogleFonts.poppins(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: "Message Language Coach...",
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 13,
                              color: const Color(0xFF94A3B8),
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            filled: false,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _sendMessage(),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCBD5E1)
                                .withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.near_me_rounded,
                            size: 16,
                            color: Color(0xFF475569),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Enter to send · Shift+Enter for a new line · Don't share passwords or personal IDs",
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: const Color(0xFF94A3B8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${_messageController.text.length}/2000",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: const Color(0xFF94A3B8),
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

  Widget _buildContextPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF475569),
        ),
      ),
    );
  }

  Widget _buildPromptCard({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: const Color(0xFF64748B)),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF1E293B),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // 3. RIGHT COLUMN: WHAT ARE YOU LEARNING + PROGRESS + PHRASEBOOK
  // ===========================================================================
  Widget _buildRightColumn() {
    return Column(
      children: [
        // Card 1: What are you learning?
        _buildLearningSelectionCard(),
        const SizedBox(height: 18),

        // Card 2: Your progress
        _buildProgressCard(),
        const SizedBox(height: 18),

        // Card 3: My phrasebook
        _buildPhrasebookCard(),
      ],
    );
  }

  Widget _buildLearningSelectionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What are you learning?",
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Saved to your account",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 14),

          // 9-language grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _languages.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              final lang = _languages[index];
              final isSelected = _selectedLanguage == lang["name"];
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedLanguage = lang["name"]!;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFEEF2FF)
                        : const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4F46E5)
                          : const Color(0xFFE2E8F0),
                      width: isSelected ? 1.6 : 1.0,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lang["name"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w600,
                          color: isSelected
                              ? const Color(0xFF312E81)
                              : const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        lang["native"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: isSelected
                              ? const Color(0xFF4338CA)
                              : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Mode & Level Dropdowns
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mode",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedMode,
                          isExpanded: true,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF0F172A),
                          ),
                          items: _modes.map((m) {
                            return DropdownMenuItem(
                              value: m,
                              child: Text(m),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedMode = val;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Level",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF334155),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedLevel,
                          isExpanded: true,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: const Color(0xFF0F172A),
                          ),
                          items: _levels.map((l) {
                            return DropdownMenuItem(
                              value: l,
                              child: Text(l),
                            );
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedLevel = val;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your progress",
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),

          // 3 Metric Counters
          Row(
            children: [
              Expanded(
                child: _buildMetricTile("0", "Day streak"),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMetricTile("0", "Phrases saved"),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMetricTile("$_coachChatsCount", "Coach chats"),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 14 Days tracker
          Text(
            "Last 14 days",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(14, (i) {
              final isToday = i == 13;
              return Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: isToday
                      ? const Color(0xFFF1F5F9)
                      : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isToday
                        ? const Color(0xFF64748B)
                        : const Color(0xFFE2E8F0),
                    width: isToday ? 1.5 : 1.0,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          Text(
            "Mark phrases as known in a lesson to see your progress here.",
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricTile(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10.5,
              color: const Color(0xFF64748B),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPhrasebookCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "My phrasebook",
            style: GoogleFonts.poppins(
              fontSize: 15.5,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 14),

          // Blueprint Graph Paper Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFFAFAFD),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _GridPaperPainter(
                        gridColor:
                            const Color(0xFF6366F1).withValues(alpha: 0.07),
                        step: 22.0,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Nothing saved yet",
                        style: GoogleFonts.poppins(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Phrases you mark as known appear\nhere.",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                        textAlign: TextAlign.center,
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
}

// =============================================================================
// GRID PAPER PAINTER
// =============================================================================
class _GridPaperPainter extends CustomPainter {
  final Color gridColor;
  final double step;

  _GridPaperPainter({required this.gridColor, this.step = 24.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

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
