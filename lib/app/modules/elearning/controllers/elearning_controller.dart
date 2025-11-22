import 'package:get/get.dart';
import '../../../data/models/course_model.dart';

class ElearningController extends GetxController {
  // Observable Variables
  final isLoading = false.obs;
  final selectedCategory = 'All'.obs;
  final courses = <CourseModel>[].obs;
  final categories = <CourseCategoryModel>[].obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
    loadCourses();
  }

  // Load Categories
  void loadCategories() {
    // TODO: Replace with actual API call
    categories.value = [
      CourseCategoryModel(
        id: '1',
        name: 'All',
        icon: 'apps',
        courseCount: 12,
      ),
      CourseCategoryModel(
        id: '2',
        name: 'Sales Basics',
        icon: 'trending_up',
        courseCount: 5,
      ),
      CourseCategoryModel(
        id: '3',
        name: 'Product Knowledge',
        icon: 'inventory',
        courseCount: 4,
      ),
      CourseCategoryModel(
        id: '4',
        name: 'Communication',
        icon: 'chat',
        courseCount: 3,
      ),
    ];
  }

  // Load Courses
  Future<void> loadCourses() async {
    try {
      isLoading.value = true;

      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      courses.value = [
        CourseModel(
          id: '1',
          title: 'Sales Fundamentals',
          description: 'Learn the basics of effective sales techniques and customer engagement strategies.',
          category: 'Sales Basics',
          thumbnail: 'https://via.placeholder.com/400x200',
          duration: 120,
          totalLessons: 8,
          completedLessons: 3,
          progress: 37.5,
          instructor: 'John Smith',
          isMandatory: true,
          deadline: DateTime.now().add(const Duration(days: 7)),
          lessons: [
            LessonModel(
              id: '1-1',
              title: 'Introduction to Sales',
              description: 'Overview of sales profession',
              type: 'video',
              content: 'https://example.com/video1',
              duration: 15,
              isCompleted: true,
            ),
            LessonModel(
              id: '1-2',
              title: 'Understanding Customer Needs',
              description: 'How to identify and address customer pain points',
              type: 'video',
              content: 'https://example.com/video2',
              duration: 20,
              isCompleted: true,
            ),
            LessonModel(
              id: '1-3',
              title: 'Sales Techniques Quiz',
              description: 'Test your knowledge',
              type: 'quiz',
              content: '',
              duration: 10,
              isCompleted: true,
              score: 85,
            ),
          ],
        ),
        CourseModel(
          id: '2',
          title: 'Product Catalog Mastery',
          description: 'Deep dive into our product portfolio and how to effectively present them to clients.',
          category: 'Product Knowledge',
          thumbnail: 'https://via.placeholder.com/400x200',
          duration: 90,
          totalLessons: 6,
          completedLessons: 6,
          progress: 100,
          instructor: 'Sarah Johnson',
          isMandatory: true,
        ),
        CourseModel(
          id: '3',
          title: 'Effective Communication Skills',
          description: 'Master the art of communication to build stronger relationships with clients.',
          category: 'Communication',
          thumbnail: 'https://via.placeholder.com/400x200',
          duration: 60,
          totalLessons: 5,
          completedLessons: 0,
          progress: 0,
          instructor: 'Michael Brown',
          isMandatory: false,
        ),
        CourseModel(
          id: '4',
          title: 'Advanced Negotiation',
          description: 'Learn advanced negotiation techniques to close deals successfully.',
          category: 'Sales Basics',
          thumbnail: 'https://via.placeholder.com/400x200',
          duration: 150,
          totalLessons: 10,
          completedLessons: 0,
          progress: 0,
          instructor: 'David Lee',
          isMandatory: false,
        ),
        CourseModel(
          id: '5',
          title: 'CRM System Training',
          description: 'Complete guide to using our CRM system effectively.',
          category: 'Product Knowledge',
          thumbnail: 'https://via.placeholder.com/400x200',
          duration: 45,
          totalLessons: 4,
          completedLessons: 2,
          progress: 50,
          instructor: 'Emily Davis',
          isMandatory: true,
          deadline: DateTime.now().add(const Duration(days: 3)),
        ),
        CourseModel(
          id: '6',
          title: 'Customer Service Excellence',
          description: 'Delivering exceptional customer service that builds loyalty.',
          category: 'Communication',
          thumbnail: 'https://via.placeholder.com/400x200',
          duration: 75,
          totalLessons: 6,
          completedLessons: 0,
          progress: 0,
          instructor: 'Robert Wilson',
          isMandatory: false,
        ),
      ];
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load courses',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Filter courses by category
  List<CourseModel> get filteredCourses {
    var filtered = courses.where((course) {
      // Category filter
      if (selectedCategory.value != 'All' &&
          course.category != selectedCategory.value) {
        return false;
      }

      // Search filter
      if (searchQuery.value.isNotEmpty) {
        final query = searchQuery.value.toLowerCase();
        return course.title.toLowerCase().contains(query) ||
            course.description.toLowerCase().contains(query) ||
            course.instructor.toLowerCase().contains(query);
      }

      return true;
    }).toList();

    return filtered;
  }

  // Get mandatory courses
  List<CourseModel> get mandatoryCourses {
    return courses.where((course) => course.isMandatory).toList();
  }

  // Get in-progress courses
  List<CourseModel> get inProgressCourses {
    return courses
        .where((course) => course.progress > 0 && course.progress < 100)
        .toList();
  }

  // Get completed courses
  List<CourseModel> get completedCourses {
    return courses.where((course) => course.progress == 100).toList();
  }

  // Select category
  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  // Update search query
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Navigate to course detail
  void goToCourseDetail(CourseModel course) {
    Get.toNamed('/course-detail', arguments: course);
  }

  // Start course
  void startCourse(CourseModel course) {
    Get.snackbar(
      'Starting Course',
      'Opening ${course.title}...',
      snackPosition: SnackPosition.BOTTOM,
    );
    goToCourseDetail(course);
  }

  // Continue course
  void continueCourse(CourseModel course) {
    goToCourseDetail(course);
  }

  // Refresh courses
  Future<void> refreshCourses() async {
    await loadCourses();
  }
}
