class TodayScheduleItem {
  final String time;
  final String title;
  final String kind; // class, study, project, career
  final String room;

  const TodayScheduleItem({
    required this.time,
    required this.title,
    required this.kind,
    this.room = '',
  });
}

class WeakTopic {
  final String subject;
  final String topic;
  final int mastery;

  const WeakTopic({
    required this.subject,
    required this.topic,
    required this.mastery,
  });
}

class UpcomingDeadline {
  final String title;
  final String when;
  final String tag;

  const UpcomingDeadline({
    required this.title,
    required this.when,
    this.tag = 'Academic',
  });
}

class ExamCountdown {
  final String exam;
  final int days;
  final int syllabusCovered;

  const ExamCountdown({
    required this.exam,
    required this.days,
    required this.syllabusCovered,
  });
}

class StudentDashboardData {
  final String name;
  final String department;
  final String semester;
  final String rollNo;
  final int streak;
  final int xp;
  final int priorities;
  final String aiRecommendation;
  final ExamCountdown examCountdown;
  final int semesterProgress;
  final int examReadiness;
  final int technicalSkills;
  final int communicationSkills;
  final int interviewSkills;
  final int careerReadiness;
  final String projectName;
  final int projectProgress;
  final List<TodayScheduleItem> today;
  final List<UpcomingDeadline> upcoming;
  final List<WeakTopic> weakTopics;
  final double cgpa;
  final double attendance;
  final int completedCredits;
  final int totalCredits;

  const StudentDashboardData({
    required this.name,
    required this.department,
    required this.semester,
    required this.rollNo,
    required this.streak,
    required this.xp,
    required this.priorities,
    required this.aiRecommendation,
    required this.examCountdown,
    required this.semesterProgress,
    required this.examReadiness,
    required this.technicalSkills,
    required this.communicationSkills,
    required this.interviewSkills,
    required this.careerReadiness,
    required this.projectName,
    required this.projectProgress,
    required this.today,
    required this.upcoming,
    required this.weakTopics,
    this.cgpa = 8.84,
    this.attendance = 94.2,
    this.completedCredits = 104,
    this.totalCredits = 160,
  });
}
