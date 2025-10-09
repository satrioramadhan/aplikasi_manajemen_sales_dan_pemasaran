import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../routes/app_pages.dart';
import '../controllers/lead_controller.dart';

class LeadListView extends GetView<LeadController> {
  const LeadListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Leads',
          style: AppTextStyles.headlineMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.primary),
            onPressed: () => Get.toNamed(Routes.ADD_LEAD),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.leads.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.refreshLeads,
          child: Column(
            children: [
              // Search & Filter Section
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Search Bar
                    TextField(
                      onChanged: controller.searchLeads,
                      decoration: InputDecoration(
                        hintText: 'Search leads...',
                        hintStyle: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Status Filter
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.statuses.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final status = controller.statuses[index];

                          return FilterChip(
                            label: Text(_getStatusLabel(status)),
                            selected: controller.selectedStatus.value == status,
                            onSelected: (_) => controller.filterByStatus(status),
                            backgroundColor: Colors.white,
                            selectedColor: _getStatusChipColor(status),
                            labelStyle: AppTextStyles.labelMedium.copyWith(
                              color: controller.selectedStatus.value == status
                                  ? Colors.white
                                  : AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            side: BorderSide(
                              color: controller.selectedStatus.value == status
                                  ? _getStatusChipColor(status)
                                  : AppColors.border,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // Leads Count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${controller.filteredLeads.length} Leads',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    )),
              ),
              const SizedBox(height: 16),

              // Lead List
              Expanded(
                child: Obx(() {
                  if (controller.filteredLeads.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.people_outline,
                            size: 64,
                            color: AppColors.textSecondary.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No leads found',
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.filteredLeads.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final lead = controller.filteredLeads[index];
                      return _buildLeadCard(lead);
                    },
                  );
                }),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildLeadCard(lead) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.LEAD_DETAIL, arguments: lead.id),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: AppColors.heroGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      lead.getInitial(),
                      style: AppTextStyles.titleMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Lead Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lead.customerName,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 14,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              lead.customerPhone,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(lead.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    lead.statusLabel,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: _getStatusColor(lead.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Product & Value
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        lead.productName ?? '-',
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Est. Value',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      lead.estimatedValue != null
                          ? Formatters.formatCompactCurrency(
                              lead.estimatedValue!)
                          : '-',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Priority & Source
            Row(
              children: [
                // Priority
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(lead.priority).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.flag,
                        size: 12,
                        color: _getPriorityColor(lead.priority),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        lead.priorityLabel,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: _getPriorityColor(lead.priority),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Source
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.border.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    _getSourceLabel(lead.leadSource),
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),

                // Days since created
                Text(
                  '${lead.getDaysSinceCreated()}d ago',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusLabel(String status) {
    if (status == 'All') return 'All';
    return status[0].toUpperCase() + status.substring(1);
  }

  Color _getStatusChipColor(String status) {
    if (status == 'All') return AppColors.primary;
    return _getStatusColor(status);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'new':
        return const Color(0xFF2196F3);
      case 'contacted':
        return const Color(0xFF9C27B0);
      case 'qualified':
        return const Color(0xFFFF9800);
      case 'proposal':
        return const Color(0xFFFFEB3B);
      case 'negotiation':
        return const Color(0xFF00BCD4);
      case 'won':
        return AppColors.success;
      case 'lost':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'urgent':
        return AppColors.error;
      case 'high':
        return const Color(0xFFFF9800);
      case 'medium':
        return const Color(0xFF2196F3);
      case 'low':
        return AppColors.textSecondary;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getSourceLabel(String source) {
    switch (source) {
      case 'online':
        return 'Online';
      case 'offline':
        return 'Offline';
      case 'referral':
        return 'Referral';
      case 'landing_page':
        return 'Landing Page';
      case 'manual':
        return 'Manual';
      default:
        return source;
    }
  }
}
