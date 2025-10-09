import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/kpi_model.dart';
import '../../../data/models/lead_model.dart';
import '../../../data/models/leaderboard_model.dart';
import '../../../data/models/user_model.dart';

class HomeController extends GetxController {
  final storage = GetStorage();

  // Observable Variables
  final isLoading = false.obs;
  final selectedIndex = 0.obs;

  // User Data
  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  // Dashboard Data
  final todayLeadsCount = 0.obs;
  final monthCommission = 0.0.obs;
  final kpiAchievement = 0.0.obs;
  final totalActivities = 0.obs;

  // Lists
  final RxList<KpiModel> kpiList = <KpiModel>[].obs;
  final RxList<LeadModel> recentLeads = <LeadModel>[].obs;
  final RxList<LeaderboardModel> leaderboard = <LeaderboardModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserData();
    _loadDashboardData();
  }

  // Load User Data from Storage
  void _loadUserData() {
    final userData = storage.read(AppConstants.userKey);
    if (userData != null) {
      currentUser.value = UserModel.fromJson(userData);
    }
  }

  // Load Dashboard Data (Mock)
  Future<void> _loadDashboardData() async {
    try {
      isLoading.value = true;

      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock KPI Data
      kpiList.value = [
        KpiModel(
          id: 1,
          name: 'Monthly Sales Target',
          metricType: 'sales_value',
          targetValue: 50000000,
          actualValue: 38500000,
          achievementPercentage: 77.0,
          status: 'in_progress',
          periodStart: DateTime(2025, 10, 1),
          periodEnd: DateTime(2025, 10, 31),
        ),
        KpiModel(
          id: 2,
          name: 'Lead Conversion',
          metricType: 'lead_conversion',
          targetValue: 30,
          actualValue: 23,
          achievementPercentage: 76.67,
          status: 'in_progress',
          periodStart: DateTime(2025, 10, 1),
          periodEnd: DateTime(2025, 10, 31),
        ),
        KpiModel(
          id: 3,
          name: 'Activities Count',
          metricType: 'activity_count',
          targetValue: 100,
          actualValue: 87,
          achievementPercentage: 87.0,
          status: 'in_progress',
          periodStart: DateTime(2025, 10, 1),
          periodEnd: DateTime(2025, 10, 31),
        ),
      ];

      // Mock Recent Leads
      recentLeads.value = [
        LeadModel(
          id: 1,
          companyId: 1,
          customerName: 'Budi Santoso',
          customerEmail: 'budi@example.com',
          customerPhone: '081234567890',
          leadSource: 'online',
          status: 'new',
          priority: 'high',
          estimatedValue: 15000000,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        LeadModel(
          id: 2,
          companyId: 1,
          customerName: 'Siti Nurhaliza',
          customerEmail: 'siti@example.com',
          customerPhone: '081234567891',
          leadSource: 'landing_page',
          status: 'contacted',
          priority: 'medium',
          estimatedValue: 8500000,
          lastContactAt: DateTime.now().subtract(const Duration(hours: 5)),
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        LeadModel(
          id: 3,
          companyId: 1,
          customerName: 'Ahmad Rahman',
          customerEmail: 'ahmad@example.com',
          customerPhone: '081234567892',
          leadSource: 'referral',
          status: 'qualified',
          priority: 'urgent',
          estimatedValue: 25000000,
          lastContactAt: DateTime.now().subtract(const Duration(hours: 8)),
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 8)),
        ),
        LeadModel(
          id: 4,
          companyId: 1,
          customerName: 'Dewi Lestari',
          customerEmail: 'dewi@example.com',
          customerPhone: '081234567893',
          leadSource: 'offline',
          status: 'proposal',
          priority: 'high',
          estimatedValue: 12000000,
          lastContactAt: DateTime.now().subtract(const Duration(hours: 12)),
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
        ),
      ];

      // Mock Leaderboard
      leaderboard.value = [
        LeaderboardModel(
          rank: 1,
          salesId: 1,
          salesName: 'John Doe',
          totalSales: 45000000,
          totalLeads: 35,
          achievementPercentage: 90.0,
        ),
        LeaderboardModel(
          rank: 2,
          salesId: 2,
          salesName: 'Jane Smith',
          totalSales: 38500000,
          totalLeads: 28,
          achievementPercentage: 77.0,
        ),
        LeaderboardModel(
          rank: 3,
          salesId: 3,
          salesName: 'Michael Johnson',
          totalSales: 32000000,
          totalLeads: 25,
          achievementPercentage: 64.0,
        ),
        LeaderboardModel(
          rank: 4,
          salesId: 4,
          salesName: 'Sarah Williams',
          totalSales: 28000000,
          totalLeads: 22,
          achievementPercentage: 56.0,
        ),
      ];

      // Update Summary Data
      todayLeadsCount.value = 5;
      monthCommission.value = 3850000;
      kpiAchievement.value = 77.0;
      totalActivities.value = 87;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load dashboard data');
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh Dashboard
  Future<void> refreshDashboard() async {
    await _loadDashboardData();
  }

  // Change Bottom Nav Index
  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  // Get Greeting based on time
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
