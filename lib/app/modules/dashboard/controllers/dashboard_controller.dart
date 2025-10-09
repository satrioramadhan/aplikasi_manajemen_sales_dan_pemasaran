import 'package:get/get.dart';
import '../../../data/models/dashboard_stats.dart';
import '../../../data/models/leaderboard_item.dart';
import '../../../data/models/recent_activity.dart';
import '../../../routes/app_pages.dart';

class DashboardController extends GetxController {
  // Observable Variables
  final isLoading = false.obs;
  final isRefreshing = false.obs;
  final dashboardStats = Rx<DashboardStats?>(null);
  final leaderboard = <LeaderboardItem>[].obs;
  final recentActivities = <RecentActivity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  // Load Dashboard Data
  Future<void> loadDashboardData() async {
    try {
      isLoading.value = true;

      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      // Mock Dashboard Stats
      dashboardStats.value = DashboardStats(
        todayLeads: 8,
        monthlyLeads: 45,
        monthlyCommission: 15750000,
        kpiProgress: 78.5,
        activitiesCount: 24,
        pendingFollowUps: 5,
      );

      // Mock Leaderboard
      leaderboard.value = [
        LeaderboardItem(
          rank: 1,
          name: 'Ahmad Rizki',
          photo: '',
          sales: 45500000,
          leadsCount: 67,
        ),
        LeaderboardItem(
          rank: 2,
          name: 'Siti Nurhaliza',
          photo: '',
          sales: 38200000,
          leadsCount: 52,
        ),
        LeaderboardItem(
          rank: 3,
          name: 'John Doe',
          photo: '',
          sales: 32750000,
          leadsCount: 45,
          isCurrentUser: true,
        ),
        LeaderboardItem(
          rank: 4,
          name: 'Budi Santoso',
          photo: '',
          sales: 28900000,
          leadsCount: 38,
        ),
        LeaderboardItem(
          rank: 5,
          name: 'Lisa Permata',
          photo: '',
          sales: 25600000,
          leadsCount: 34,
        ),
      ];

      // Mock Recent Activities
      recentActivities.value = [
        RecentActivity(
          id: '1',
          type: 'lead',
          title: 'New Lead Assigned',
          description: 'PT Maju Jaya - Product A',
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          icon: 'person_add',
          statusColor: 'blue',
        ),
        RecentActivity(
          id: '2',
          type: 'activity',
          title: 'Follow-up Call Completed',
          description: 'Called CV Sukses Mandiri',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          icon: 'phone',
          statusColor: 'green',
        ),
        RecentActivity(
          id: '3',
          type: 'order',
          title: 'Deal Closed!',
          description: 'PT Berkah - Rp 5,500,000',
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
          icon: 'check_circle',
          statusColor: 'success',
        ),
        RecentActivity(
          id: '4',
          type: 'reminder',
          title: 'Upcoming Meeting',
          description: 'Meeting with PT Global at 14:00',
          timestamp: DateTime.now().subtract(const Duration(hours: 8)),
          icon: 'event',
          statusColor: 'orange',
        ),
        RecentActivity(
          id: '5',
          type: 'activity',
          title: 'Site Visit',
          description: 'Visited UD Sejahtera location',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
          icon: 'location_on',
          statusColor: 'purple',
        ),
      ];
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load dashboard data',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh Dashboard
  Future<void> refreshDashboard() async {
    try {
      isRefreshing.value = true;
      await loadDashboardData();
    } finally {
      isRefreshing.value = false;
    }
  }

  // Quick Actions
  void goToAddLead() {
    Get.toNamed(Routes.ADD_LEAD);
  }

  void goToLeads() {
    Get.toNamed(Routes.LEADS);
  }

  void goToProducts() {
    Get.toNamed(Routes.PRODUCTS);
  }

  void goToAttendance() {
    Get.toNamed(Routes.ATTENDANCE);
  }

  void goToKPI() {
    // TODO: Navigate to KPI
    Get.snackbar('Coming Soon', 'KPI feature');
  }

  void goToPayroll() {
    // TODO: Navigate to payroll
    Get.snackbar('Coming Soon', 'Payroll feature');
  }

  void goToELearning() {
    // TODO: Navigate to e-learning
    Get.snackbar('Coming Soon', 'E-Learning feature');
  }

  void goToProfile() {
    Get.toNamed(Routes.PROFILE);
  }
}
