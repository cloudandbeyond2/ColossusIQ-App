class ReadinessDimension {
  final String key;
  final String label;
  final int weight;
  final int rawScore;
  final int points;

  const ReadinessDimension({
    required this.key,
    required this.label,
    required this.weight,
    required this.rawScore,
    required this.points,
  });
}

class EligibilityCheck {
  final String title;
  final String requirement;
  final String currentValue;
  final bool isMet;
  final String? route;

  const EligibilityCheck({
    required this.title,
    required this.requirement,
    required this.currentValue,
    required this.isMet,
    this.route,
  });
}

class PlacementReadinessData {
  final int totalScore;
  final String status; // "Placement ready", "Almost ready", "Needs work"
  final List<ReadinessDimension> dimensions;
  final List<EligibilityCheck> checks;

  const PlacementReadinessData({
    required this.totalScore,
    required this.status,
    required this.dimensions,
    required this.checks,
  });
}

class CertificateItem {
  final String id;
  final String title;
  final String department;
  final String grade; // O, A+, A, B, C
  final String gradeLabel;
  final int marks;
  final int total;
  final int percentage;
  final String issuedDate;
  final String verificationUrl;

  const CertificateItem({
    required this.id,
    required this.title,
    required this.department,
    required this.grade,
    required this.gradeLabel,
    required this.marks,
    required this.total,
    required this.percentage,
    required this.issuedDate,
    required this.verificationUrl,
  });
}

class AssignmentItem {
  final String id;
  final String title;
  final String course;
  final String dueDate;
  final int submittedCount;
  final String status; // Open, Submitted, Graded
  final int? score;
  final int totalMarks;
  final String? submittedFileName;
  final int? submittedFileSize;

  const AssignmentItem({
    required this.id,
    required this.title,
    required this.course,
    required this.dueDate,
    required this.submittedCount,
    required this.status,
    this.score,
    this.totalMarks = 100,
    this.submittedFileName,
    this.submittedFileSize,
  });

  AssignmentItem copyWith({
    String? id,
    String? title,
    String? course,
    String? dueDate,
    int? submittedCount,
    String? status,
    int? score,
    int? totalMarks,
    String? submittedFileName,
    int? submittedFileSize,
  }) {
    return AssignmentItem(
      id: id ?? this.id,
      title: title ?? this.title,
      course: course ?? this.course,
      dueDate: dueDate ?? this.dueDate,
      submittedCount: submittedCount ?? this.submittedCount,
      status: status ?? this.status,
      score: score ?? this.score,
      totalMarks: totalMarks ?? this.totalMarks,
      submittedFileName: submittedFileName ?? this.submittedFileName,
      submittedFileSize: submittedFileSize ?? this.submittedFileSize,
    );
  }
}

class ClubItem {
  final String id;
  final String name;
  final String category; // Technical, Cultural, Social, Innovation
  final String description;
  final int memberCount;
  final String leadName;
  final String nextMeeting;
  final bool isJoined;

  const ClubItem({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.memberCount,
    required this.leadName,
    required this.nextMeeting,
    this.isJoined = false,
  });
}

class SportItem {
  final String id;
  final String title;
  final String category;
  final String venue;
  final String date;
  final String status; // "Trials open", "Active", "Off-season"
  final int registeredCount;

  const SportItem({
    required this.id,
    required this.title,
    required this.category,
    required this.venue,
    required this.date,
    required this.status,
    required this.registeredCount,
  });
}
