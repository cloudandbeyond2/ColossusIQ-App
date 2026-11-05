import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_badge.dart';
import '../../core/widgets/app_progress.dart';
import '../../data/models/assessment_model.dart';

class TestPlayerScreen extends StatefulWidget {
  final MockTest test;

  const TestPlayerScreen({super.key, required this.test});

  @override
  State<TestPlayerScreen> createState() => _TestPlayerScreenState();
}

class _TestPlayerScreenState extends State<TestPlayerScreen> {
  int _currentIndex = 0;
  final Map<int, int> _selectedAnswers = {}; // questionIndex -> optionIndex
  bool _isSubmitted = false;
  Timer? _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    final duration = widget.test.durationMinutes > 0 ? widget.test.durationMinutes : 20;
    _remainingSeconds = duration * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer?.cancel();
        if (!_isSubmitted) {
          _submitTest();
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _selectOption(int optionIndex) {
    if (_isSubmitted) return;
    setState(() {
      _selectedAnswers[_currentIndex] = optionIndex;
    });
  }

  void _submitTest() {
    _timer?.cancel();
    int score = 0;
    for (int i = 0; i < widget.test.questions.length; i++) {
      if (_selectedAnswers[i] == widget.test.questions[i].correctOptionIndex) {
        score++;
      }
    }
    final percentage =
        ((score / widget.test.questions.length) * 100).round();
    final isPassed = percentage >= widget.test.passPercentage;

    setState(() {
      _isSubmitted = true;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Row(
          children: [
            Icon(
              isPassed ? Icons.check_circle_rounded : Icons.info_outline,
              color: isPassed ? AppColors.teal : AppColors.amber,
              size: 26,
            ),
            const SizedBox(width: 8),
            Text(
              isPassed ? "Assessment Passed!" : "Assessment Completed",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You scored $score out of ${widget.test.questions.length} ($percentage%).",
              style: GoogleFonts.poppins(fontSize: 14, color: AppColors.ink),
            ),
            const SizedBox(height: 12),
            if (isPassed && widget.test.certificateEnabled)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.goldSoft,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.gold.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.workspace_premium, color: AppColors.gold),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Certificate earned! You can view and download your verifiable credential in My Certificates.",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.amber,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // close dialog
            },
            child: const Text("Review Answers"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop(); // exit player
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.brand),
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.test.questions[_currentIndex];
    final selectedOption = _selectedAnswers[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.test.title,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Question ${_currentIndex + 1} of ${widget.test.questions.length}",
              style: GoogleFonts.poppins(fontSize: 11, color: AppColors.ink3),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _remainingSeconds <= 60 ? AppColors.roseSoft : AppColors.brandSoft,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      size: 14,
                      color: _remainingSeconds <= 60 ? AppColors.rose : AppColors.brand,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDuration(_remainingSeconds),
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _remainingSeconds <= 60 ? AppColors.rose : AppColors.brand,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            AppLinearProgress(
              value: (_currentIndex + 1) / widget.test.questions.length,
              color: AppColors.brand,
              height: 6,
            ),
            const SizedBox(height: 18),

            // Question Box
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AppBadge(
                        label: "Question ${_currentIndex + 1}",
                        tone: BadgeTone.brand,
                      ),
                      const Spacer(),
                      Text(
                        "${q.marks} Mark",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.ink3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    q.text,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Options List
            Text(
              "Choose an option:",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.ink2,
              ),
            ),
            const SizedBox(height: 10),

            for (int i = 0; i < q.options.length; i++) ...[
              _buildOptionTile(
                optionIndex: i,
                optionText: q.options[i],
                isSelected: selectedOption == i,
                isCorrect: q.correctOptionIndex == i,
              ),
              const SizedBox(height: 10),
            ],

            // Explanation after submission
            if (_isSubmitted) ...[
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.tealSoft,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.teal.withValues(alpha: 0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "AI Tutor Explanation",
                      style: GoogleFonts.poppins(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.teal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      q.explanation,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.ink,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Bottom Navigation & Submit
            Row(
              children: [
                if (_currentIndex > 0)
                  OutlinedButton.icon(
                    onPressed: () {
                      setState(() => _currentIndex--);
                    },
                    icon: const Icon(Icons.arrow_back, size: 16),
                    label: const Text("Previous"),
                  ),
                const Spacer(),
                if (_currentIndex < widget.test.questions.length - 1)
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() => _currentIndex++);
                    },
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    label: const Text("Next Question"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brand,
                    ),
                  )
                else if (!_isSubmitted)
                  ElevatedButton.icon(
                    onPressed: _selectedAnswers.length ==
                            widget.test.questions.length
                        ? _submitTest
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please answer all questions."),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                    icon: const Icon(Icons.check_circle_outline, size: 16),
                    label: const Text("Submit Assessment"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teal,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required int optionIndex,
    required String optionText,
    required bool isSelected,
    required bool isCorrect,
  }) {
    Color bg = AppColors.surface;
    Color border = AppColors.line;
    Color textColor = AppColors.ink;

    if (_isSubmitted) {
      if (isCorrect) {
        bg = AppColors.tealSoft;
        border = AppColors.teal;
        textColor = AppColors.teal;
      } else if (isSelected && !isCorrect) {
        bg = AppColors.roseSoft;
        border = AppColors.rose;
        textColor = AppColors.rose;
      }
    } else if (isSelected) {
      bg = AppColors.brandSoft;
      border = AppColors.brand;
      textColor = AppColors.brand;
    }

    return InkWell(
      onTap: () => _selectOption(optionIndex),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: border, width: isSelected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? border : AppColors.surface2,
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + optionIndex), // A, B, C, D
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.ink2,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                optionText,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
