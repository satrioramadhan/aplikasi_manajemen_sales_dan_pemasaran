class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'Sales & Marketing';
  static const String appVersion = '1.0.0';
  static const String companyName = 'PT Razen Teknologi Indonesia';

  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String isFirstTimeKey = 'is_first_time';
  static const String hasSeenOnboarding = 'has_seen_onboarding';
  static const String languageKey = 'language';
  static const String themeKey = 'theme_mode';

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int otpLength = 6;

  // Pagination
  static const int defaultPageSize = 10;
  static const int maxPageSize = 50;

  // Date Formats
  static const String dateFormat = 'dd MMM yyyy';
  static const String dateTimeFormat = 'dd MMM yyyy HH:mm';
  static const String timeFormat = 'HH:mm';

  // Animation Durations
  static const Duration shortDuration = Duration(milliseconds: 200);
  static const Duration mediumDuration = Duration(milliseconds: 300);
  static const Duration longDuration = Duration(milliseconds: 500);

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // User Roles
  static const String roleAdmin = 'admin';
  static const String roleCompany = 'company';
  static const String roleSales = 'sales';

  // Lead Status
  static const String leadNew = 'new';
  static const String leadContacted = 'contacted';
  static const String leadQualified = 'qualified';
  static const String leadProposal = 'proposal';
  static const String leadNegotiation = 'negotiation';
  static const String leadWon = 'won';
  static const String leadLost = 'lost';

  // Lead Priority
  static const String priorityLow = 'low';
  static const String priorityMedium = 'medium';
  static const String priorityHigh = 'high';
  static const String priorityUrgent = 'urgent';

  // Activity Types
  static const String activityCall = 'call';
  static const String activityEmail = 'email';
  static const String activityMeeting = 'meeting';
  static const String activityWhatsapp = 'whatsapp';
  static const String activityVisit = 'visit';
  static const String activityOther = 'other';

  // Attendance Status
  static const String statusPresent = 'present';
  static const String statusLate = 'late';
  static const String statusAbsent = 'absent';
  static const String statusLeave = 'leave';
  static const String statusSick = 'sick';
  static const String statusPermission = 'permission';
}
