import '../../core/theme/app_colors.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/widgets/blueprint_hero_banner.dart';
import '../../core/widgets/portal_page_body.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// 1. Communication Lab Screen (Image 4)
/// ─────────────────────────────────────────────────────────────────────────────
class CommunicationLabScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const CommunicationLabScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Communication Lab",
      category: "Communication & Skills",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Communication & Skills  ›  Communication Lab",
          category: "COMMUNICATION & SKILLS",
          phase: "Phase 2",
          isMvp: false,
          icon: Icons.chat_bubble_outline_rounded,
          title: "Communication Lab",
          subtitle: "Presentation, public speaking, email and workplace conversation practice.",
          watermarkIcon: Icons.chat_bubble_outline_rounded,
        ),
        const SizedBox(height: 20),

        // Responsive Top Row: Radar Chart + Dimensions
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 12, child: _buildRadarCard()),
                  const SizedBox(width: 20),
                  Expanded(flex: 10, child: _buildDimensionsCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildRadarCard(),
                const SizedBox(height: 16),
                _buildDimensionsCard(),
              ],
            );
          },
        ),
        const SizedBox(height: 20),

        // Bottom Row: Strengths, Gaps, Improvement plan
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 850;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _buildStrengthsCard()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildGapsCard()),
                  const SizedBox(width: 16),
                  Expanded(child: _buildPlanCard()),
                ],
              );
            }
            return Column(
              children: [
                _buildStrengthsCard(),
                const SizedBox(height: 16),
                _buildGapsCard(),
                const SizedBox(height: 16),
                _buildPlanCard(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildRadarCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Communication profile",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Dimension-level view — no single number decides outcomes",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              height: 280,
              width: 320,
              child: CustomPaint(
                painter: _CommRadarChartPainter(
                  labels: const ["Grammar", "Vocabulary", "Fluency", "Structure", "Speaking pace", "Filler words"],
                  currentValues: const [72, 64, 55, 61, 58, 47],
                  targetValues: const [80, 75, 75, 75, 70, 70],
                  maxValue: 100,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primaryBlue, shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Text("Current", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF1E293B))),
              const SizedBox(width: 20),
              Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFD97706), shape: BoxShape.circle)),
              const SizedBox(width: 6),
              Text("Target", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFFD97706))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDimensionsCard() {
    final dimensions = [
      {"name": "Grammar", "score": 72, "target": 80, "color": AppColors.primaryBlue},
      {"name": "Vocabulary", "score": 64, "target": 75, "color": AppColors.primaryBlue},
      {"name": "Fluency", "score": 55, "target": 75, "color": AppColors.primaryBlue},
      {"name": "Structure", "score": 61, "target": 75, "color": AppColors.primaryBlue},
      {"name": "Speaking pace", "score": 58, "target": 70, "color": AppColors.primaryBlue},
      {"name": "Filler words", "score": 47, "target": 70, "color": const Color(0xFFD97706)},
    ];

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dimensions",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Overall 60%",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 18),
          ...dimensions.asMap().entries.map((entry) {
            final index = entry.key;
            final d = entry.value;
            final score = d["score"] as int;
            final target = d["target"] as int;
            final color = d["color"] as Color;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TweenAnimationBuilder<double>(
                key: ValueKey("comm_dim_${index}_$score"),
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 700 + (index * 70)),
                curve: Curves.easeOutCubic,
                builder: (context, animValue, _) {
                  final animatedScore = (score * animValue).round();
                  final widthFactor = ((score / 100.0) * animValue).clamp(0.0, 1.0);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              d["name"] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "$animatedScore ",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF334155),
                                  ),
                                ),
                                TextSpan(
                                  text: "/ target $target",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 7,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: widthFactor,
                            child: Container(
                              height: 7,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildStrengthsCard() {
    const items = [
      "Clear written English",
      "Good use of examples",
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Strengths",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          ...items.map((it) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline_rounded, color: Color(0xFF0D9488), size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        it,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF334155),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildGapsCard() {
    const items = [
      "Frequent fillers (\"basically\", \"like\")",
      "Answers lack a clear structure",
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gaps",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          ...items.map((it) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.error_outline_rounded, color: Color(0xFFD97706), size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        it,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF334155),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPlanCard() {
    const items = [
      "Practise STAR-format answers",
      "2-minute daily speaking drill",
      "Weekly presentation practice",
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Improvement plan",
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 14),
          ...items.asMap().entries.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "${entry.key + 1}",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4338CA),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: GoogleFonts.poppins(
                          fontSize: 12.5,
                          color: const Color(0xFF334155),
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 2. GD & Debate Simulator Screen (Image 5)
/// ─────────────────────────────────────────────────────────────────────────────
class GdSimulatorScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const GdSimulatorScreen({super.key, this.onBack});

  @override
  State<GdSimulatorScreen> createState() => _GdSimulatorScreenState();
}

class _GdSimulatorScreenState extends State<GdSimulatorScreen> {
  final TextEditingController _msgController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      "sender": "GD Agent",
      "text": "Welcome to the GD room. Three AI participants — Asha (pro), Vikram (against) and Neha (moderator) — will join you.",
      "isAi": "true",
    },
  ];

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  void _sendMessage([String? preset]) {
    final text = preset ?? _msgController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"sender": "You", "text": text, "isAi": "false"});
      if (preset == null) _msgController.clear();
    });

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() {
        _messages.add({
          "sender": "Asha (AI Pro)",
          "text": "That's an interesting point. In my view, embracing AI tools with proper transparency prepares students far better for industry reality than strict prohibitions.",
          "isAi": "true",
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "GD & Debate Simulator",
      category: "Communication & Skills",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Communication & Skills  ›  GD & Debate Simulator",
          category: "COMMUNICATION & SKILLS",
          phase: "Phase 2",
          isMvp: false,
          icon: Icons.groups_outlined,
          title: "GD & Debate Simulator",
          subtitle: "Simulated multi-person discussions with AI participants and feedback.",
          watermarkIcon: Icons.groups_outlined,
        ),
        const SizedBox(height: 18),

        // 2. Responsive 2-Column: Chat Workspace + Agent Sidebar
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 950;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 15, child: _buildChatCard()),
                  const SizedBox(width: 20),
                  Expanded(flex: 8, child: _buildSidebar()),
                ],
              );
            }
            return Column(
              children: [
                _buildChatCard(),
                const SizedBox(height: 20),
                _buildSidebar(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildChatCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Context Chips Header Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Icon(Icons.explore_outlined, size: 14, color: Color(0xFF64748B)),
                  const SizedBox(width: 6),
                  Text("CONTEXT", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B), letterSpacing: 0.5)),
                  const SizedBox(width: 12),
                  _contextChip("Mode: Group discussion"),
                  const SizedBox(width: 8),
                  _contextChip("Participants: 3 AI + you"),
                  const SizedBox(width: 8),
                  _contextChip("Duration: 10 minutes"),
                ],
              ),
            ),
          ),

          // Chat Messages
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._messages.map((m) {
                  final isAi = m["isAi"] == "true";
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: isAi ? AppColors.primaryBlue : const Color(0xFF4338CA),
                          child: Icon(
                            isAi ? Icons.smart_toy_outlined : Icons.person_outline,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                m["sender"]!,
                                style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: isAi ? const Color(0xFFF8FAFC) : const Color(0xFFEEF2FF),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: isAi ? const Color(0xFFE2E8F0) : const Color(0xFFC7D2FE)),
                                ),
                                child: Text(
                                  m["text"]!,
                                  style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF334155), height: 1.45),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 10),
                // Quick prompt starter buttons (Image 5)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _starterPill(
                      icon: Icons.lightbulb_outline_rounded,
                      text: "Topic: Should AI be allowed in exams?",
                      onTap: () => _sendMessage("Topic: Should AI be allowed in exams?"),
                    ),
                    _starterPill(
                      icon: Icons.business_outlined,
                      text: "Topic: Work from home vs office",
                      onTap: () => _sendMessage("Topic: Work from home vs office"),
                    ),
                    _starterPill(
                      icon: Icons.insights_outlined,
                      text: "Give me feedback on my last point",
                      onTap: () => _sendMessage("Give me feedback on my last point"),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Message input box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _msgController,
                          onSubmitted: (_) => _sendMessage(),
                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                          decoration: InputDecoration(
                            hintText: "Message GD Agent...",
                            hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            filled: false,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _sendMessage(),
                        icon: const Icon(Icons.send_rounded, size: 18, color: Color(0xFF4338CA)),
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
                        style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF94A3B8)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "0/2000",
                      style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF94A3B8)),
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

  Widget _contextChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF475569), fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _starterPill({required IconData icon, required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: const Color(0xFF4338CA)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF334155)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Column(
      children: [
        // Agent Overview Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AGENT",
                style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B), letterSpacing: 0.5),
              ),
              const SizedBox(height: 4),
              Text(
                "GD Agent",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
              ),
              const SizedBox(height: 4),
              Text(
                "Simulated multi-person group discussions and debates.",
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B), height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Institution Source Notice (Image 5)
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
              const Icon(Icons.info_outline_rounded, color: Color(0xFF2563EB), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF1E3A8A), height: 1.45),
                    children: const [
                      TextSpan(text: "Answers marked "),
                      TextSpan(text: "Institution source", style: TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(text: " come from approved documents. Everything else is a general AI explanation — verify before relying on it."),
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

/// Custom Radar Chart Painter for Communication Profile
class _CommRadarChartPainter extends CustomPainter {
  final List<String> labels;
  final List<double> currentValues;
  final List<double> targetValues;
  final double maxValue;

  _CommRadarChartPainter({
    required this.labels,
    required this.currentValues,
    required this.targetValues,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - 38;
    final count = labels.length;

    // Web background rings
    final webPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int step = 1; step <= 4; step++) {
      final r = radius * (step / 4.0);
      final path = Path();
      for (int i = 0; i < count; i++) {
        final angle = -math.pi / 2 + (i * 2 * math.pi / count);
        final x = center.dx + r * math.cos(angle);
        final y = center.dy + r * math.sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, webPaint);
    }

    // Spokes and labels
    for (int i = 0; i < count; i++) {
      final angle = -math.pi / 2 + (i * 2 * math.pi / count);
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), webPaint);

      final labelX = center.dx + (radius + 22) * math.cos(angle);
      final labelY = center.dy + (radius + 22) * math.sin(angle);

      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: GoogleFonts.poppins(
            fontSize: 10.5,
            color: const Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(labelX - (textPainter.width / 2), labelY - (textPainter.height / 2)),
      );
    }

    // Target polygon (Gold/Amber)
    final targetPath = Path();
    for (int i = 0; i < count; i++) {
      final r = radius * (targetValues[i] / maxValue);
      final angle = -math.pi / 2 + (i * 2 * math.pi / count);
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        targetPath.moveTo(x, y);
      } else {
        targetPath.lineTo(x, y);
      }
    }
    targetPath.close();

    final targetFillPaint = Paint()
      ..color = const Color(0xFFD97706).withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;
    final targetStrokePaint = Paint()
      ..color = const Color(0xFFD97706)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawPath(targetPath, targetFillPaint);
    canvas.drawPath(targetPath, targetStrokePaint);

    // Current polygon (Dark Navy/Slate)
    final currentPath = Path();
    for (int i = 0; i < count; i++) {
      final r = radius * (currentValues[i] / maxValue);
      final angle = -math.pi / 2 + (i * 2 * math.pi / count);
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        currentPath.moveTo(x, y);
      } else {
        currentPath.lineTo(x, y);
      }
    }
    currentPath.close();

    final currentFillPaint = Paint()
      ..color = AppColors.primaryBlue.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    final currentStrokePaint = Paint()
      ..color = AppColors.primaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(currentPath, currentFillPaint);
    canvas.drawPath(currentPath, currentStrokePaint);
  }

  @override
  bool shouldRepaint(covariant _CommRadarChartPainter oldDelegate) => false;
}

/// ─────────────────────────────────────────────────────────────────────────────
/// 3. Language Learning Screen (Image 1)
/// ─────────────────────────────────────────────────────────────────────────────
class LanguageLearningScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const LanguageLearningScreen({super.key, this.onBack});

  @override
  State<LanguageLearningScreen> createState() => _LanguageLearningScreenState();
}

class _LanguageLearningScreenState extends State<LanguageLearningScreen> {
  final TextEditingController _msgController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      "sender": "Language Coach",
      "text": "Vanakkam! Choose a language and a mode — beginner, conversation, workplace, travel or academic. Listen → Speak → Correct → Repeat → Improve.",
      "isAi": "true",
    },
  ];

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  void _sendMessage([String? preset]) {
    final text = preset ?? _msgController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"sender": "You", "text": text, "isAi": "false"});
      if (preset == null) _msgController.clear();
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() {
        _messages.add({
          "sender": "Language Coach",
          "text": "Namaste! Bahut badhiya. Let's start with basic greetings in Hindi:\n• Namaste (Hello)\n• Aap kaise hain? (How are you?)\n• Shukriya (Thank you)\n\nTry repeating: 'Aap kaise hain?'",
          "isAi": "true",
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Language Learning",
      category: "Communication & Skills",
      onBack: widget.onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Communication & Skills  ›  Language Learning",
          category: "COMMUNICATION & SKILLS",
          phase: "Phase 2",
          isMvp: false,
          icon: Icons.translate_rounded,
          title: "Language Learning",
          subtitle: "English, Tamil, Hindi, Telugu, Kannada, Malayalam, French, German, Japanese and more.",
          watermarkIcon: Icons.translate_rounded,
        ),
        const SizedBox(height: 18),

        // 2. Responsive 2-Column: Chat Workspace + Agent Sidebar
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 950;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 15, child: _buildChatCard()),
                  const SizedBox(width: 20),
                  Expanded(flex: 8, child: _buildSidebar()),
                ],
              );
            }
            return Column(
              children: [
                _buildChatCard(),
                const SizedBox(height: 20),
                _buildSidebar(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildChatCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Context Chips Header Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Icon(Icons.explore_outlined, size: 14, color: Color(0xFF64748B)),
                  const SizedBox(width: 6),
                  Text("CONTEXT", style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B), letterSpacing: 0.5)),
                  const SizedBox(width: 12),
                  _contextChip("UI language: English"),
                  const SizedBox(width: 8),
                  _contextChip("Learning: Hindi"),
                  const SizedBox(width: 8),
                  _contextChip("Mode: Conversation"),
                ],
              ),
            ),
          ),

          // Chat Messages
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._messages.map((m) {
                  final isAi = m["isAi"] == "true";
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: isAi ? AppColors.primaryBlue : const Color(0xFF4338CA),
                          child: Icon(
                            isAi ? Icons.record_voice_over_outlined : Icons.person_outline,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                m["sender"]!,
                                style: GoogleFonts.poppins(fontSize: 12.5, fontWeight: FontWeight.w600, color: const Color(0xFF1E293B)),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: isAi ? const Color(0xFFF8FAFC) : const Color(0xFFEEF2FF),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: isAi ? const Color(0xFFE2E8F0) : const Color(0xFFC7D2FE)),
                                ),
                                child: Text(
                                  m["text"]!,
                                  style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF334155), height: 1.45),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 10),
                // 3 Starter prompts (Image 1)
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _starterPill(
                      icon: Icons.lightbulb_outline_rounded,
                      text: "Teach me basic Hindi greetings",
                      onTap: () => _sendMessage("Teach me basic Hindi greetings"),
                    ),
                    _starterPill(
                      icon: Icons.business_outlined,
                      text: "Workplace English: asking for a deadline extension",
                      onTap: () => _sendMessage("Workplace English: asking for a deadline extension"),
                    ),
                    _starterPill(
                      icon: Icons.insights_outlined,
                      text: "Explain operating systems in Tamil",
                      onTap: () => _sendMessage("Explain operating systems in Tamil"),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Message input box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _msgController,
                          onSubmitted: (_) => _sendMessage(),
                          style: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF1E293B)),
                          decoration: InputDecoration(
                            hintText: "Message Language Coach...",
                            hintStyle: GoogleFonts.poppins(fontSize: 13, color: const Color(0xFF94A3B8)),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            filled: false,
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _sendMessage(),
                        icon: const Icon(Icons.send_rounded, size: 18, color: Color(0xFF4338CA)),
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
                        style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF94A3B8)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "0/2000",
                      style: GoogleFonts.poppins(fontSize: 10.5, color: const Color(0xFF94A3B8)),
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

  Widget _contextChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 11.5, color: const Color(0xFF475569), fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _starterPill({required IconData icon, required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: const Color(0xFF4338CA)),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF334155)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AGENT",
                style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF64748B), letterSpacing: 0.5),
              ),
              const SizedBox(height: 4),
              Text(
                "Language Coach",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: const Color(0xFF1E293B)),
              ),
              const SizedBox(height: 4),
              Text(
                "Beginner, conversation, workplace, travel and academic language modes.",
                style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF64748B), height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
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
              const Icon(Icons.info_outline_rounded, color: Color(0xFF2563EB), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF1E3A8A), height: 1.45),
                    children: const [
                      TextSpan(text: "Answers marked "),
                      TextSpan(text: "Institution source", style: TextStyle(fontWeight: FontWeight.w700)),
                      TextSpan(text: " come from approved documents. Everything else is a general AI explanation — verify before relying on it."),
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

/// ─────────────────────────────────────────────────────────────────────────────
/// 4. Certification Roadmap Screen (Image 2)
/// ─────────────────────────────────────────────────────────────────────────────
class CertificationRoadmapScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const CertificationRoadmapScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return PortalPageBody(
      title: "Certification Roadmap",
      category: "Communication & Skills",
      onBack: onBack ?? (Navigator.canPop(context) ? () => Navigator.pop(context) : null),
      children: [
        // 1. Blueprint Hero Banner
        const BlueprintHeroBanner(
          breadcrumb: "Home  ›  Communication & Skills  ›  Certification Roadmap",
          category: "COMMUNICATION & SKILLS",
          phase: "Phase 2",
          isMvp: false,
          icon: Icons.settings_suggest_outlined,
          title: "Certification Roadmap",
          subtitle: "Recommended certifications sequenced against your career target.",
          watermarkIcon: Icons.settings_suggest_outlined,
        ),
        const SizedBox(height: 20),

        // 2. Responsive 2-Column: Timeline + Overall Progress
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 14, child: _buildTimelineCard()),
                  const SizedBox(width: 20),
                  Expanded(flex: 8, child: _buildProgressColumn()),
                ],
              );
            }
            return Column(
              children: [
                _buildTimelineCard(),
                const SizedBox(height: 20),
                _buildProgressColumn(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTimelineCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Certification roadmap — Data Scientist",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "2 of 6 stages complete",
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 22),

          // Stage 1: SQL fundamentals
          _buildStageItem(
            status: _StageStatus.done,
            title: "SQL fundamentals",
            subtitle: "Free · 12 hours",
            tag: "Completed Aug 2026",
            isLast: false,
          ),

          // Stage 2: Python for Data Science
          _buildStageItem(
            status: _StageStatus.done,
            title: "Python for Data Science",
            subtitle: "Free · 20 hours",
            tag: "Completed Sep 2026",
            isLast: false,
          ),

          // Stage 3: Statistics essentials
          _buildStageItem(
            status: _StageStatus.current,
            title: "Statistics essentials",
            subtitle: "In progress · 60%",
            tagBadge: "Current",
            isLast: false,
          ),

          // Stage 4: Cloud fundamentals
          _buildStageItem(
            status: _StageStatus.todo,
            title: "Cloud fundamentals (any major provider)",
            subtitle: "Recommended for Sem 6",
            isLast: false,
          ),

          // Stage 5: Machine Learning specialisation
          _buildStageItem(
            status: _StageStatus.todo,
            title: "Machine Learning specialisation",
            subtitle: "Recommended for Sem 6",
            isLast: false,
          ),

          // Stage 6: Data visualisation
          _buildStageItem(
            status: _StageStatus.todo,
            title: "Data visualisation",
            subtitle: "Recommended for Sem 7",
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildStageItem({
    required _StageStatus status,
    required String title,
    required String subtitle,
    String? tag,
    String? tagBadge,
    required bool isLast,
  }) {
    Widget iconWidget;
    Color lineColor;

    switch (status) {
      case _StageStatus.done:
        iconWidget = Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(color: Color(0xFF0F766E), shape: BoxShape.circle),
          child: const Icon(Icons.check, size: 15, color: Colors.white),
        );
        lineColor = const Color(0xFF0F766E);
        break;
      case _StageStatus.current:
        iconWidget = Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFD97706), width: 2),
          ),
          child: const Icon(Icons.auto_awesome, size: 13, color: Color(0xFFD97706)),
        );
        lineColor = const Color(0xFFE2E8F0);
        break;
      case _StageStatus.todo:
        iconWidget = Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFCBD5E1), width: 2),
          ),
        );
        lineColor = const Color(0xFFE2E8F0);
        break;
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator & line
          SizedBox(
            width: 24,
            child: Column(
              children: [
                iconWidget,
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: lineColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 14),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      if (tagBadge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            tagBadge,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFB45309),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  if (tag != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        tag,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0xFF475569),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressColumn() {
    return Column(
      children: [
        // Overall Progress Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Overall progress",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "33%",
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: const LinearProgressIndicator(
                  value: 0.33,
                  minHeight: 7,
                  backgroundColor: Color(0xFFF1F5F9),
                  valueColor: AlwaysStoppedAnimation(Color(0xFF0F766E)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Info Notice Card
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
              const Icon(Icons.info_outline_rounded, color: Color(0xFF2563EB), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Each stage can be supported by an AI agent, but stage approvals are made by your mentor or faculty.",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF1E3A8A),
                    height: 1.45,
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

enum _StageStatus { done, current, todo }


