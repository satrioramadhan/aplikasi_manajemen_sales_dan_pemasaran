import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../widgets/stat_card.dart';
import '../../../widgets/quick_action_button.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/kpi_progress_card.dart';
import '../widgets/leaderboard_card.dart';
import '../widgets/recent_activity_card.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value && controller.dashboardStats.value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final stats = controller.dashboardStats.value;
          if (stats == null) {
            return const Center(
              child: Text('Failed to load dashboard'),
            );
          }

          return RefreshIndicator(
            onRefresh: controller.refreshDashboard,
            child: CustomScrollView(
              slivers: [
                // Header
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: AppColors.heroGradient,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hello, John 👋',
                                  style: AppTextStyles.headlineMedium.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Let\'s boost your sales today!',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: controller.goToProfile,
                              icon: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.person_outline,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Stats Cards
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.1,
                    ),
                    delegate: SliverChildListDelegate([
                      StatCard(
                        title: 'Today Leads',
                        value: stats.todayLeads.toString(),
                        icon: Icons.people_outline,
                        color: AppColors.primary,
                        subtitle: '+${stats.monthlyLeads} this month',
                        onTap: controller.goToLeads,
                      ),
                      StatCard(
                        title: 'Commission',
                        value: Formatters.formatCompactCurrency(stats.monthlyCommission),
                        icon: Icons.account_balance_wallet_outlined,
                        color: AppColors.success,
                        subtitle: 'This month',
                        onTap: controller.goToPayroll,
                      ),
                      StatCard(
                        title: 'Activities',
                        value: stats.activitiesCount.toString(),
                        icon: Icons.assignment_outlined,
                        color: AppColors.warning,
                        subtitle: 'Total activities',
                      ),
                      StatCard(
                        title: 'Follow-ups',
                        value: stats.pendingFollowUps.toString(),
                        icon: Icons.notifications_active_outlined,
                        color: AppColors.error,
                        subtitle: 'Pending',
                      ),
                    ]),
                  ),
                ),

                // KPI Progress
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: KPIProgressCard(
                      progress: stats.kpiProgress,
                      onTap: controller.goToKPI,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                // Quick Actions
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Quick Actions',
                          style: AppTextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            QuickActionButton(
                              label: 'Add Lead',
                              icon: Icons.person_add_outlined,
                              color: AppColors.primary,
                              onTap: controller.goToAddLead,
                            ),
                            const SizedBox(width: 16),
                            QuickActionButton(
                              label: 'Products',
                              icon: Icons.inventory_2_outlined,
                              color: AppColors.secondary,
                              onTap: controller.goToProducts,
                            ),
                            const SizedBox(width: 16),
                            QuickActionButton(
                              label: 'Attendance',
                              icon: Icons.location_on_outlined,
                              color: AppColors.success,
                              onTap: controller.goToAttendance,
                            ),
                            const SizedBox(width: 16),
                            QuickActionButton(
                              label: 'E-Learning',
                              icon: Icons.school_outlined,
                              color: AppColors.warning,
                              onTap: controller.goToELearning,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                // Leaderboard
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: LeaderboardCard(
                      leaderboard: controller.leaderboard,
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),

                // Recent Activities
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Activities',
                          style: AppTextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        RecentActivityCard(
                          activities: controller.recentActivities,
                        ),
                      ],
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          );
        }),
      ),
    );
  }
}
