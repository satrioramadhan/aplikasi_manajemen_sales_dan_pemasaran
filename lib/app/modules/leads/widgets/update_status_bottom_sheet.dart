import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../controllers/lead_controller.dart';

class UpdateStatusBottomSheet extends StatefulWidget {
  final dynamic lead;

  const UpdateStatusBottomSheet({
    super.key,
    required this.lead,
  });

  @override
  State<UpdateStatusBottomSheet> createState() =>
      _UpdateStatusBottomSheetState();
}

class _UpdateStatusBottomSheetState extends State<UpdateStatusBottomSheet> {
  late String _selectedStatus;
  final _lostReasonController = TextEditingController();
  final _isLoading = false.obs;

  final _statuses = [
    {'value': 'new', 'label': 'New', 'icon': Icons.fiber_new},
    {'value': 'contacted', 'label': 'Contacted', 'icon': Icons.phone},
    {'value': 'qualified', 'label': 'Qualified', 'icon': Icons.verified},
    {'value': 'proposal', 'label': 'Proposal', 'icon': Icons.description},
    {'value': 'negotiation', 'label': 'Negotiation', 'icon': Icons.handshake},
    {'value': 'won', 'label': 'Won', 'icon': Icons.check_circle},
    {'value': 'lost', 'label': 'Lost', 'icon': Icons.cancel},
  ];

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.lead.status;
  }

  @override
  void dispose() {
    _lostReasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle Bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: AppColors.heroGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.update,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Update Lead Status',
                    style: AppTextStyles.titleLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Status Options
              Text(
                'Select New Status',
                style: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _statuses.map((status) {
                  final isSelected = _selectedStatus == status['value'];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedStatus = status['value'] as String;
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? _getStatusColor(status['value'] as String)
                                .withOpacity(0.1)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? _getStatusColor(status['value'] as String)
                              : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            status['icon'] as IconData,
                            size: 18,
                            color: isSelected
                                ? _getStatusColor(status['value'] as String)
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            status['label'] as String,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.normal,
                              color: isSelected
                                  ? _getStatusColor(status['value'] as String)
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              // Lost Reason (only if status is lost)
              if (_selectedStatus == 'lost') ...[
                const SizedBox(height: 24),
                CustomTextField(
                  label: 'Reason for Lost',
                  hint: 'Enter reason why this lead was lost',
                  controller: _lostReasonController,
                  prefixIcon: const Icon(Icons.info_outline),
                  maxLines: 3,
                ),
              ],

              const SizedBox(height: 24),

              // Update Button
              Obx(() => CustomButton(
                    text: 'Update Status',
                    onPressed: _updateStatus,
                    isLoading: _isLoading.value,
                    width: double.infinity,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _updateStatus() async {
    if (_selectedStatus == 'lost' && _lostReasonController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter reason for lost',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return;
    }

    try {
      _isLoading.value = true;

      final controller = Get.find<LeadController>();
      await controller.updateLeadStatus(
        widget.lead.id,
        _selectedStatus,
        lostReason: _selectedStatus == 'lost' ? _lostReasonController.text : null,
      );

      Get.back();
    } finally {
      _isLoading.value = false;
    }
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
}
