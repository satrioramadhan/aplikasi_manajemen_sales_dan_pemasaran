import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text_field.dart';
import '../controllers/lead_controller.dart';

class AddActivityBottomSheet extends StatefulWidget {
  final int leadId;

  const AddActivityBottomSheet({
    super.key,
    required this.leadId,
  });

  @override
  State<AddActivityBottomSheet> createState() => _AddActivityBottomSheetState();
}

class _AddActivityBottomSheetState extends State<AddActivityBottomSheet> {
  String _selectedType = 'call';
  final _subjectController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime? _nextFollowUp;
  final _isLoading = false.obs;

  final _activityTypes = [
    {'value': 'call', 'label': 'Call', 'icon': Icons.phone},
    {'value': 'email', 'label': 'Email', 'icon': Icons.email},
    {'value': 'meeting', 'label': 'Meeting', 'icon': Icons.event},
    {'value': 'whatsapp', 'label': 'WhatsApp', 'icon': Icons.chat},
    {'value': 'visit', 'label': 'Visit', 'icon': Icons.location_on},
    {'value': 'other', 'label': 'Other', 'icon': Icons.note},
  ];

  @override
  void dispose() {
    _subjectController.dispose();
    _notesController.dispose();
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
                      Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Add Activity',
                    style: AppTextStyles.titleLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Activity Type
              Text(
                'Activity Type',
                style: AppTextStyles.labelMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _activityTypes.map((type) {
                  final isSelected = _selectedType == type['value'];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedType = type['value'] as String;
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
                            ? AppColors.primary.withOpacity(0.1)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            type['icon'] as IconData,
                            size: 18,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            type['label'] as String,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.normal,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Subject
              CustomTextField(
                label: 'Subject',
                hint: 'Enter activity subject',
                controller: _subjectController,
                prefixIcon: const Icon(Icons.title),
              ),
              const SizedBox(height: 16),

              // Notes
              CustomTextField(
                label: 'Notes',
                hint: 'Enter activity notes',
                controller: _notesController,
                prefixIcon: const Icon(Icons.note_outlined),
                maxLines: 4,
              ),
              const SizedBox(height: 16),

              // Next Follow Up
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Next Follow-up (Optional)',
                    style: AppTextStyles.labelMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: _selectFollowUpDate,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _nextFollowUp != null
                                ? '${_nextFollowUp!.day}/${_nextFollowUp!.month}/${_nextFollowUp!.year}'
                                : 'Select date',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: _nextFollowUp != null
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                            ),
                          ),
                          const Spacer(),
                          if (_nextFollowUp != null)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _nextFollowUp = null;
                                });
                              },
                              child: const Icon(
                                Icons.clear,
                                color: AppColors.textSecondary,
                                size: 20,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Add Button
              Obx(() => CustomButton(
                    text: 'Add Activity',
                    onPressed: _addActivity,
                    isLoading: _isLoading.value,
                    width: double.infinity,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _selectFollowUpDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        _nextFollowUp = date;
      });
    }
  }

  void _addActivity() async {
    if (_subjectController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter activity subject',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
      );
      return;
    }

    try {
      _isLoading.value = true;

      final controller = Get.find<LeadController>();
      await controller.addActivity(
        leadId: widget.leadId,
        activityType: _selectedType,
        subject: _subjectController.text,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
        nextFollowUp: _nextFollowUp,
      );

      Get.back();
    } finally {
      _isLoading.value = false;
    }
  }
}
