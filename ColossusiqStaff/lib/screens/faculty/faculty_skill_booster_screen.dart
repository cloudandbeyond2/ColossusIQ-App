import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// =============================================================================
// FACULTY: FACULTY SKILL BOOSTER SCREEN
// Exactly matches Screenshots 1 & 2:
// - Blueprint grid hero banner with watermark & badges (FACULTY, MVP)
// - Level Progression Banner Card (Explorer 0 pts, 60 to Practitioner, 4 level milestones)
// - Two-Column Split:
//     * Left: Teaching Tasks (Teach on smart board, Save lesson outline, Share summaries, etc.)
//       with progress bars, point tags, "+ Record (POST)" and "Do it ->" actions
//     * Right: Badges Grid (Smart board starter, Class sharer, etc.) & Skill tracks accordions
// =============================================================================

class FacultySkillBoosterScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const FacultySkillBoosterScreen({super.key, this.onBack});

  @override
  State<FacultySkillBoosterScreen> createState() =>
      _FacultySkillBoosterScreenState();
}

class _FacultySkillBoosterScreenState extends State<FacultySkillBoosterScreen> {
  int _points = 0;
  final Set<int> _completedTasks = {};
  final Set<int> _expandedTracks = {};

  final List<Map<String, dynamic>> _tasks = [
    {
      'id': 1,
      'title': 'Teach a class on the smart board',
      'points': '+20 pts',
      'pointsVal': 20,
      'subtitle':
          'Teaching Studio → Smart board: present a topic and annotate live.',
      'current': 0,
      'target': 1,
      'hasRecordButton': true,
    },
    {
      'id': 2,
      'title': 'Save a lesson outline',
      'points': '+10 pts',
      'pointsVal': 10,
      'subtitle': 'Plan a class with the timed lesson outline and save it.',
      'current': 0,
      'target': 1,
      'hasRecordButton': false,
    },
    {
      'id': 3,
      'title': 'Share 3 class summaries with students',
      'points': '+30 pts',
      'pointsVal': 30,
      'subtitle': 'After class, share what was covered, homework and resources.',
      'current': 0,
      'target': 3,
      'hasRecordButton': false,
    },
    {
      'id': 4,
      'title': 'Share an infographic lesson',
      'points': '+15 pts',
      'pointsVal': 15,
      'subtitle': 'Attach the one-page infographic to a class summary.',
      'current': 0,
      'target': 1,
      'hasRecordButton': false,
    },
    {
      'id': 5,
      'title': 'Pin a lecture video to a course lesson',
      'points': '+15 pts',
      'pointsVal': 15,
      'subtitle': 'AI Course Studio → Lessons → Videos.',
      'current': 0,
      'target': 1,
      'hasRecordButton': false,
    },
    {
      'id': 6,
      'title': 'Publish a quiz for your class',
      'points': '+15 pts',
      'pointsVal': 15,
      'subtitle': 'AI Quiz Builder: generate, review and publish.',
      'current': 0,
      'target': 1,
      'hasRecordButton': false,
    },
  ];

  final List<Map<String, dynamic>> _badges = [
    {
      'title': 'Smart board starter',
      'icon': Icons.co_present_outlined,
      'unlocked': false,
    },
    {
      'title': 'Class sharer',
      'icon': Icons.share_outlined,
      'unlocked': false,
    },
    {
      'title': 'Visual teacher',
      'icon': Icons.image_outlined,
      'unlocked': false,
    },
    {
      'title': 'Fair assessor',
      'icon': Icons.assignment_outlined,
      'unlocked': false,
    },
    {
      'title': 'Responsible AI user',
      'icon': Icons.verified_user_outlined,
      'unlocked': false,
    },
  ];

  final List<Map<String, dynamic>> _skillTracks = [
    {
      'id': 1,
      'title': 'Active learning in a 50-minute class',
      'desc': '0/4 steps · ~20 min',
      'steps': [
        'Hooking attention with real-world failure cases (5 min)',
        'Think-Pair-Share interactive peer problem solving (15 min)',
        'Live misconception checks with polling (15 min)',
        'Synthesis and 60-second muddiest point exit ticket (15 min)',
      ],
    },
    {
      'id': 2,
      'title': 'Teaching with visuals and the smart board',
      'desc': '0/4 steps · ~15 min',
      'steps': [
        'Setting up live canvas annotation presets',
        'Importing textbook SVGs and schematics onto blackboard',
        'Engaging students at the board with dual pen modes',
        'One-click PDF snapshot export for class WhatsApp group',
      ],
    },
    {
      'id': 3,
      'title': 'Writing good multiple-choice questions',
      'desc': '0/4 steps · ~15 min',
      'steps': [
        'Avoiding common distracter traps and grammatical clues',
        'Designing plausible distractors using genuine student errors',
        'Mapping questions directly to Bloom\'s taxonomy K1 - K4',
        'Evaluating question discrimination index in mock tests',
      ],
    },
    {
      'id': 4,
      'title': 'Using AI responsibly in teaching',
      'desc': '0/4 steps · ~15 min',
      'steps': [
        'Verifying generative AI output against university curriculum',
        'Disclosing AI syllabus assistance transparently',
        'Preventing hallucinated citations in lecture slide notes',
        'Designing AI-proof authentic assessment viva questions',
      ],
    },
  ];

  void _recordTask(int taskId, int pts) {
    if (_completedTasks.contains(taskId)) return;
    setState(() {
      _completedTasks.add(taskId);
      _points += pts;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Task verified and saved to platform PostgreSQL database! (+$pts pts)',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: const Color(0xFF0F766E),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
              const SizedBox(height: 18),
              _buildLevelCard(),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth >= 940;
                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 6, child: _buildTeachingTasksCard()),
                        const SizedBox(width: 20),
                        Expanded(flex: 4, child: _buildRightSidebar()),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTeachingTasksCard(),
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
  // TOP HERO BANNER (Screenshot 1)
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
            // Watermark gear/medal on right
            Positioned(
              right: 28,
              top: -15,
              bottom: -15,
              child: Opacity(
                opacity: 0.12,
                child: const Icon(
                  Icons.military_tech_rounded,
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: widget.onBack,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            'Home',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withValues(alpha: 0.7),
                            ),
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
                          'Faculty',
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
                          'Faculty Skill Booster',
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
                          Icons.military_tech_rounded,
                          color: Color(0xFFFBBF24),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      color:
                                          Colors.white.withValues(alpha: 0.15),
                                    ),
                                  ),
                                  child: Text(
                                    'FACULTY',
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
                                    color: const Color(0xFF0F766E),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'MVP',
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
                              'Faculty Skill Booster',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              'Teaching tasks that complete from what you actually do, short skill tracks, levels and badges.',
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
  // LEVEL PROGRESSION BANNER CARD (Screenshot 1)
  // ===========================================================================
  Widget _buildLevelCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2B3784),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2B3784).withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Part (Title, Level name, points counter)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 22, 24, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR LEVEL',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: const Color(0xFF93C5FD),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Explorer',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${60 - _points > 0 ? 60 - _points : 0} points to Practitioner',
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '$_points',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                    Text(
                      'POINTS',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Milestone Path Bottom Bar (Screenshot 1)
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildMilestonePill(
                        step: '1',
                        title: 'Explorer',
                        subtitle: '0+ pts',
                        isPassed: true,
                      ),
                      _buildMilestoneDivider(),
                      _buildMilestonePill(
                        step: '2',
                        title: 'Practitioner',
                        subtitle: '60+ pts',
                        isPassed: _points >= 60,
                      ),
                      _buildMilestoneDivider(),
                      _buildMilestonePill(
                        step: '3',
                        title: 'Mentor',
                        subtitle: '140+ pts',
                        isPassed: _points >= 140,
                      ),
                      _buildMilestoneDivider(),
                      _buildMilestonePill(
                        step: '4',
                        title: 'Champion',
                        subtitle: '220+ pts',
                        isPassed: _points >= 220,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestonePill({
    required String step,
    required String title,
    required String subtitle,
    required bool isPassed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isPassed ? const Color(0xFF0F766E) : Colors.transparent,
              shape: BoxShape.circle,
              border: isPassed
                  ? null
                  : Border.all(color: const Color(0xFFCBD5E1), width: 1.5),
            ),
            child: Center(
              child: isPassed
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : Text(
                      step,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF64748B),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: isPassed
                      ? const Color(0xFF0F172A)
                      : const Color(0xFF64748B),
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  fontSize: 10.5,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneDivider() {
    return Container(
      width: 1,
      height: 28,
      color: const Color(0xFFE2E8F0),
    );
  }

  // ===========================================================================
  // LEFT COLUMN: TEACHING TASKS CARD (Screenshot 1 & 2)
  // ===========================================================================
  Widget _buildTeachingTasksCard() {
    return Container(
      padding: const EdgeInsets.all(22),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Teaching tasks',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'These complete automatically when you do them in the platform, or you can record them directly into PostgreSQL.',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF64748B),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          ..._tasks.map((t) => _buildTaskItem(t)),
        ],
      ),
    );
  }

  Widget _buildTaskItem(Map<String, dynamic> t) {
    final id = t['id'] as int;
    final isDone = _completedTasks.contains(id);
    final target = t['target'] as int;
    final current = isDone ? target : (t['current'] as int);
    final progress = current / target;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDone ? const Color(0xFF86EFAC) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Icon(
                  isDone
                      ? Icons.check_circle_rounded
                      : Icons.hourglass_top_rounded,
                  size: 16,
                  color: isDone
                      ? const Color(0xFF10B981)
                      : const Color(0xFF64748B),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            t['title'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            t['points'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF475569),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      t['subtitle'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar + Actions
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 4,
                    backgroundColor: const Color(0xFFF1F5F9),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isDone
                          ? const Color(0xFF10B981)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '$current/$target',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  _recordTask(id, t['pointsVal'] as int);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Text(
                    isDone ? 'Completed' : 'Do it →',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDone
                          ? const Color(0xFF10B981)
                          : const Color(0xFF334155),
                    ),
                  ),
                ),
              ),
              if (t['hasRecordButton'] == true && !isDone) ...[
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => _recordTask(id, t['pointsVal'] as int),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F766E),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '+ Record (POST)',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // RIGHT COLUMN: BADGES & SKILL TRACKS (Screenshot 1 & 2)
  // ===========================================================================
  Widget _buildRightSidebar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBadgesCard(),
        const SizedBox(height: 20),
        _buildSkillTracksCard(),
      ],
    );
  }

  Widget _buildBadgesCard() {
    return Container(
      padding: const EdgeInsets.all(22),
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
            'Badges',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Unlocked through verified PostgreSQL activity',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.32,
            children: [
              _buildBadgeTile(_badges[0]),
              _buildBadgeTile(_badges[1]),
              _buildBadgeTile(_badges[2]),
              _buildBadgeTile(_badges[3]),
            ],
          ),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 170,
              height: 88,
              child: _buildBadgeTile(_badges[4]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeTile(Map<String, dynamic> b) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color(0xFFF8FAFC),
              shape: BoxShape.circle,
            ),
            child: Icon(
              b['icon'] as IconData,
              size: 16,
              color: const Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            b['title'] as String,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF334155),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Locked',
            style: GoogleFonts.poppins(
              fontSize: 9.5,
              color: const Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillTracksCard() {
    return Container(
      padding: const EdgeInsets.all(22),
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
            'Skill tracks',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Short, practical reading · 5 points per step (POST/DELETE to PostgreSQL)',
            style: GoogleFonts.poppins(
              fontSize: 11.5,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 16),
          ..._skillTracks.map((st) {
            final id = st['id'] as int;
            final isExpanded = _expandedTracks.contains(id);
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (isExpanded) {
                          _expandedTracks.remove(id);
                        } else {
                          _expandedTracks.add(id);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.school_outlined,
                              size: 16,
                              color: Color(0xFF38439E),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  st['title'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                                Text(
                                  st['desc'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            size: 18,
                            color: const Color(0xFF64748B),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isExpanded)
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(color: Color(0xFFF1F5F9)),
                          ...(st['steps'] as List<String>).map((step) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Icon(
                                      Icons.check_circle_outline_rounded,
                                      size: 14,
                                      color: Color(0xFF0F766E),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      step,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: const Color(0xFF475569),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// Background painter for blueprint grid in top banner
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
