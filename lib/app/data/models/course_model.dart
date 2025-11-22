class CourseModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String thumbnail;
  final int duration; // in minutes
  final int totalLessons;
  final int completedLessons;
  final double progress;
  final String instructor;
  final bool isMandatory;
  final DateTime? deadline;
  final List<LessonModel> lessons;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.thumbnail,
    required this.duration,
    required this.totalLessons,
    this.completedLessons = 0,
    this.progress = 0.0,
    required this.instructor,
    this.isMandatory = false,
    this.deadline,
    this.lessons = const [],
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      duration: json['duration'] ?? 0,
      totalLessons: json['total_lessons'] ?? 0,
      completedLessons: json['completed_lessons'] ?? 0,
      progress: (json['progress'] ?? 0).toDouble(),
      instructor: json['instructor'] ?? '',
      isMandatory: json['is_mandatory'] ?? false,
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'])
          : null,
      lessons: json['lessons'] != null
          ? (json['lessons'] as List)
              .map((lesson) => LessonModel.fromJson(lesson))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'thumbnail': thumbnail,
      'duration': duration,
      'total_lessons': totalLessons,
      'completed_lessons': completedLessons,
      'progress': progress,
      'instructor': instructor,
      'is_mandatory': isMandatory,
      'deadline': deadline?.toIso8601String(),
      'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
    };
  }
}

class LessonModel {
  final String id;
  final String title;
  final String description;
  final String type; // video, pdf, quiz
  final String content; // URL or content
  final int duration; // in minutes
  final bool isCompleted;
  final int? score;

  LessonModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.content,
    required this.duration,
    this.isCompleted = false,
    this.score,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? 'video',
      content: json['content'] ?? '',
      duration: json['duration'] ?? 0,
      isCompleted: json['is_completed'] ?? false,
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type': type,
      'content': content,
      'duration': duration,
      'is_completed': isCompleted,
      'score': score,
    };
  }
}

class CourseCategoryModel {
  final String id;
  final String name;
  final String icon;
  final int courseCount;

  CourseCategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.courseCount,
  });

  factory CourseCategoryModel.fromJson(Map<String, dynamic> json) {
    return CourseCategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      courseCount: json['course_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'course_count': courseCount,
    };
  }
}
