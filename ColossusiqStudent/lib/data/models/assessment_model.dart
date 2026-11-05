class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;
  final int marks;

  const Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
    this.marks = 1,
  });
}

class MockTest {
  final String id;
  final String title;
  final String subject;
  final String department;
  final int durationMinutes;
  final int totalQuestions;
  final int passPercentage;
  final int? bestScore;
  final int attemptsUsed;
  final int maxAttempts;
  final bool certificateEnabled;
  final String? certificateId;
  final List<Question> questions;

  const MockTest({
    required this.id,
    required this.title,
    required this.subject,
    required this.department,
    required this.durationMinutes,
    required this.totalQuestions,
    required this.passPercentage,
    this.bestScore,
    this.attemptsUsed = 0,
    this.maxAttempts = 3,
    this.certificateEnabled = false,
    this.certificateId,
    required this.questions,
  });
}
