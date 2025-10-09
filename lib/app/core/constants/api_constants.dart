class ApiConstants {
  ApiConstants._();

  // Base URL - ganti dengan URL backend Laravel kamu
  static const String baseUrl = 'http://localhost:8000/api';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  // User Endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update-profile';
  static const String changePassword = '/user/change-password';

  // Sales Endpoints
  static const String salesProfile = '/sales/profile';
  static const String updateSalesProfile = '/sales/update-profile';

  // Dashboard Endpoints
  static const String dashboard = '/dashboard';
  static const String kpiSummary = '/dashboard/kpi';
  static const String leaderboard = '/dashboard/leaderboard';

  // Products Endpoints
  static const String products = '/products';
  static const String productDetail = '/products/{id}';

  // Leads Endpoints
  static const String leads = '/leads';
  static const String leadDetail = '/leads/{id}';
  static const String createLead = '/leads/create';
  static const String updateLead = '/leads/{id}/update';
  static const String leadActivities = '/leads/{id}/activities';

  // Orders Endpoints
  static const String orders = '/orders';
  static const String orderDetail = '/orders/{id}';

  // Attendance Endpoints
  static const String checkIn = '/attendance/check-in';
  static const String checkOut = '/attendance/check-out';
  static const String attendanceHistory = '/attendance/history';

  // Payroll Endpoints
  static const String payroll = '/payroll';
  static const String payrollDetail = '/payroll/{id}';

  // E-Learning Endpoints
  static const String elearningCategories = '/elearning/categories';
  static const String elearningMaterials = '/elearning/materials';
  static const String elearningProgress = '/elearning/progress';

  // Quiz Endpoints
  static const String quizzes = '/quizzes';
  static const String quizDetail = '/quizzes/{id}';
  static const String submitQuiz = '/quizzes/{id}/submit';

  // Notifications Endpoints
  static const String notifications = '/notifications';
  static const String markAsRead = '/notifications/{id}/read';
}
