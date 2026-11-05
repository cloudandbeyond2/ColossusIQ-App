import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FacultyCampusAssistantScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultyCampusAssistantScreen({super.key, this.onBack});

  @override
  State<FacultyCampusAssistantScreen> createState() =>
      _FacultyCampusAssistantScreenState();
}

class _FacultyCampusAssistantScreenState
    extends State<FacultyCampusAssistantScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _chatScrollController = ScrollController();

  final List<Map<String, dynamic>> _messages = [
    {
      'isUser': false,
      'sender': 'Knowledge Agent',
      'text':
          'Ask me anything about Anna Institute of Technology. I answer from institution-approved sources and cite them.',
      'source': null,
    },
  ];

  final List<Map<String, dynamic>> _quickPrompts = [
    {
      'icon': Icons.lightbulb_outline_rounded,
      'text': 'Where is the placement office?',
    },
    {
      'icon': Icons.calendar_today_outlined,
      'text': 'What is the exam application process?',
    },
    {
      'icon': Icons.show_chart_rounded,
      'text': 'How can I register for sports?',
    },
  ];

  bool _isGenerating = false;

  void _sendMessage([String? presetText]) {
    final text = presetText ?? _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'isUser': true,
        'sender': 'You',
        'text': text,
        'source': null,
      });
      _messageController.clear();
      _isGenerating = true;
    });

    _scrollToBottom();

    // Simulate AI response with institution source citation
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      String reply = '';
      String source = 'Institution Knowledge Base (Sec 3.1)';

      if (text.toLowerCase().contains('placement')) {
        reply =
            'The Career Guidance & Placement Cell is located on the Ground Floor of the Ramanujan Academic Block (Room G-12), right opposite the Main Seminar Hall. Office hours are 9:00 AM to 5:00 PM on weekdays.';
        source = 'Campus Directory 2026 · Annexure II';
      } else if (text.toLowerCase().contains('exam')) {
        reply =
            'Exam applications for Anna Institute of Technology are submitted via the Faculty/Student ERP Portal under Examinations > Hall Ticket & Registrations. The deadline for regular session registration is the 25th of each odd/even semester.';
        source = 'Academic Regulations Circular AIT/COE/2026/04';
      } else if (text.toLowerCase().contains('sports')) {
        reply =
            'Students and faculty can register for intra-college and zonal sports through the Physical Education Department portal or visit the Indoor Sports Complex reception between 4:00 PM and 6:30 PM.';
        source = 'Sports Council Charter 2025-26';
      } else {
        reply =
            'Here is the verified institution information regarding your query: "$text". Anna Institute of Technology administrative guidelines confirm all standard procedures are logged in the central campus registry.';
        source = 'Anna Institute Institutional Archives v2.4';
      }

      setState(() {
        _isGenerating = false;
        _messages.add({
          'isUser': false,
          'sender': 'Knowledge Agent',
          'text': reply,
          'source': source,
        });
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_chatScrollController.hasClients) {
        _chatScrollController.animateTo(
          _chatScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _chatScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopHeroBanner(),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= 960;
                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildChatCard()),
                        const SizedBox(width: 20),
                        SizedBox(width: 320, child: _buildRightSidebar()),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildChatCard(),
                        const SizedBox(height: 20),
                        _buildRightSidebar(),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TOP HERO BANNER (Pixel Perfect Match to Screenshot 4)
  // ===========================================================================
  Widget _buildTopHeroBanner() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF161E4A),
            Color(0xFF222B68),
            Color(0xFF38439E),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BlueprintGridPainter(),
              ),
            ),
            // Watermark icon on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: Icon(
                  Icons.school_rounded,
                  size: 190,
                  color: Colors.white,
                ),
              ),
            ),
            // Banner Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breadcrumb without arrow
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Home',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Campus Life',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '›',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        Text(
                          'Campus Assistant',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Golden/Yellow graduation cap icon box
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.18),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Badges
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E2548),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withValues(alpha: 0.15),
                                    ),
                                  ),
                                  child: Text(
                                    'CAMPUS LIFE',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                      color: const Color(0xFF93C5FD),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFD97706),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Phase 3',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Campus Assistant',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Ask anything about your campus — answered from institution-approved sources.',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withValues(alpha: 0.85),
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
  // LEFT COLUMN: MAIN CHAT CARD (Screenshot 4)
  // ===========================================================================
  Widget _buildChatCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Context top bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Icon(
                    Icons.radar_rounded,
                    size: 15,
                    color: Color(0xFF64748B),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'CONTEXT',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      'Knowledge base: 8 approved documents',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                    ),
                    child: Text(
                      'Campus: Main',
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Messages & suggestions scroll area
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rendered Messages
                ..._messages.map((msg) => _buildMessageRow(msg)),

                if (_isGenerating) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: Color(0xFF38439E),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.smart_toy_rounded,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Searching approved sources...',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],

                const SizedBox(height: 18),

                // Quick Prompt Chips (Screenshot 4)
                Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: _quickPrompts.map((p) {
                    return InkWell(
                      onTap: () => _sendMessage(p['text'] as String),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 11),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.015),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              p['icon'] as IconData,
                              size: 16,
                              color: const Color(0xFF4338CA),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              p['text'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF334155),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),

          // Bottom Input Bar (Screenshot 4)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Input box with send button
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          maxLines: null,
                          style: GoogleFonts.poppins(
                            fontSize: 13.5,
                            color: const Color(0xFF1E293B),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Message Knowledge Agent...',
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
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onSubmitted: (_) => _sendMessage(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () => _sendMessage(),
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(9),
                          decoration: BoxDecoration(
                            color: const Color(0xFF9FA8DA),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.send_rounded,
                            size: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Footer helper text & character counter
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Enter to send · Shift+Enter for a new line · Don\'t share passwords or personal IDs',
                        style: GoogleFonts.poppins(
                          fontSize: 10.5,
                          color: const Color(0xFF94A3B8),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${_messageController.text.length}/2000',
                      style: GoogleFonts.poppins(
                        fontSize: 10.5,
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

  Widget _buildMessageRow(Map<String, dynamic> msg) {
    final isUser = msg['isUser'] as bool;
    final text = msg['text'] as String;
    final sender = msg['sender'] as String;
    final source = msg['source'] as String?;

    if (isUser) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF38439E),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 18,
                color: Color(0xFF475569),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFF38439E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.smart_toy_rounded,
              size: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sender,
                  style: GoogleFonts.poppins(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF334155),
                          height: 1.45,
                        ),
                      ),
                      if (source != null) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFBFDBFE)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.verified_outlined,
                                size: 12,
                                color: Color(0xFF2563EB),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                source,
                                style: GoogleFonts.poppins(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF1D4ED8),
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
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // RIGHT SIDEBAR (Screenshot 4)
  // ===========================================================================
  Widget _buildRightSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Card 1: Knowledge Agent details
        Container(
          padding: const EdgeInsets.all(20),
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
              Text(
                'AGENT',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Knowledge Agent',
                style: GoogleFonts.poppins(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Institution-specific RAG assistant with source citations.',
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF475569),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Card 2: Light Blue Info Note (Screenshot 4)
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.info_outline_rounded,
                  size: 18,
                  color: Color(0xFF2563EB),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF1E3A8A),
                      height: 1.45,
                    ),
                    children: const [
                      TextSpan(text: 'Answers marked '),
                      TextSpan(
                        text: 'Institution source',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text:
                            ' come from approved documents. Everything else is a general AI explanation — verify before relying on it.',
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
}

// Background painter for blueprint grid
class _BlueprintGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.06)
      ..strokeWidth = 1.0;

    const double step = 28.0;

    for (double x = 0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
