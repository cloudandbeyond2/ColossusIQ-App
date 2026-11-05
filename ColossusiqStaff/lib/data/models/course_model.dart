class Lesson {
  final String id;
  final String title;
  final String duration;
  final String layoutKind; // overview, concepts, example, practice, revision
  final String chapterTitle;
  final String chapterPart; // "Start here", "Chapter 1", etc.
  final int chapterIndex;
  final List<String> objectives;
  final String body;
  final List<String> keyPoints;
  final List<Map<String, String>> terms;
  final bool isCompleted;

  const Lesson({
    required this.id,
    required this.title,
    required this.duration,
    this.layoutKind = 'concepts',
    required this.chapterTitle,
    this.chapterPart = 'Chapter 1',
    this.chapterIndex = 0,
    this.objectives = const [],
    required this.body,
    this.keyPoints = const [],
    this.terms = const [],
    this.isCompleted = false,
  });

  Lesson copyWith({
    bool? isCompleted,
    String? title,
    String? body,
    List<String>? objectives,
    List<String>? keyPoints,
  }) {
    return Lesson(
      id: id,
      title: title ?? this.title,
      duration: duration,
      layoutKind: layoutKind,
      chapterTitle: chapterTitle,
      chapterPart: chapterPart,
      chapterIndex: chapterIndex,
      objectives: objectives ?? this.objectives,
      body: body ?? this.body,
      keyPoints: keyPoints ?? this.keyPoints,
      terms: terms,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class CourseUnit {
  final String id;
  final String title;
  final String part; // "Start here", "Chapter 1", etc.
  final List<Lesson> lessons;

  const CourseUnit({
    required this.id,
    required this.title,
    required this.part,
    required this.lessons,
  });

  CourseUnit copyWith({
    String? id,
    String? title,
    String? part,
    List<Lesson>? lessons,
  }) {
    return CourseUnit(
      id: id ?? this.id,
      title: title ?? this.title,
      part: part ?? this.part,
      lessons: lessons ?? this.lessons,
    );
  }
}

class Course {
  final String id;
  final String code;
  final String title;
  final String department;
  final String facultyName;
  final String term;
  final int credits;
  final String summary;
  final int totalChapters;
  final int totalLessons;
  final String hours;
  final int completedLessons;
  final bool finalUnlocked;
  final String? certificateId;
  final int? bestScore;
  final List<CourseUnit> units;

  const Course({
    required this.id,
    required this.code,
    required this.title,
    required this.department,
    required this.facultyName,
    this.term = "Term 5",
    required this.credits,
    required this.summary,
    required this.totalChapters,
    required this.totalLessons,
    required this.hours,
    required this.completedLessons,
    this.finalUnlocked = false,
    this.certificateId,
    this.bestScore,
    required this.units,
  });

  /// Dynamically computes completed count based on completed lessons across all units
  int get currentCompletedCount {
    int count = 0;
    for (final u in units) {
      for (final l in u.lessons) {
        if (l.isCompleted) count++;
      }
    }
    return count > completedLessons ? count : completedLessons;
  }

  double get progressPercentage =>
      totalLessons > 0 ? (currentCompletedCount / totalLessons) * 100 : 0;

  Course copyWith({
    int? completedLessons,
    bool? finalUnlocked,
    String? certificateId,
    int? bestScore,
    List<CourseUnit>? units,
  }) {
    return Course(
      id: id,
      code: code,
      title: title,
      department: department,
      facultyName: facultyName,
      term: term,
      credits: credits,
      summary: summary,
      totalChapters: totalChapters,
      totalLessons: totalLessons,
      hours: hours,
      completedLessons: completedLessons ?? this.completedLessons,
      finalUnlocked: finalUnlocked ?? this.finalUnlocked,
      certificateId: certificateId ?? this.certificateId,
      bestScore: bestScore ?? this.bestScore,
      units: units ?? this.units,
    );
  }
}
