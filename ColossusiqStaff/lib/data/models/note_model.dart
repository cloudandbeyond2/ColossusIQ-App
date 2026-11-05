class HandoutResource {
  final String title;
  final String type; // pdf, link, slides, code
  final String url;

  const HandoutResource({
    required this.title,
    required this.type,
    required this.url,
  });
}

class ClassNote {
  final String id;
  final String courseCode;
  final String subject;
  final String facultyName;
  final String department;
  final String date;
  final String topic;
  final String summary;
  final List<String> keyTakeaways;
  final String homework;
  final bool isRead;
  final List<HandoutResource> resources;

  const ClassNote({
    required this.id,
    required this.courseCode,
    required this.subject,
    required this.facultyName,
    required this.department,
    required this.date,
    required this.topic,
    required this.summary,
    required this.keyTakeaways,
    required this.homework,
    this.isRead = false,
    required this.resources,
  });
}
