import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/attendance_controller.dart';

class AttendanceView extends GetView<AttendanceController> {
  const AttendanceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
          style: AppTextStyles.titleLarge.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white),
            onPressed: () {
              Get.toNamed('/attendance-history');
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.refreshAttendances,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // Header Section with Gradient
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Current Time
                        Text(
                          DateFormat('HH:mm:ss').format(DateTime.now()),
                          style: AppTextStyles.headlineLarge.copyWith(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),

                // Main Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Today's Status Card
                      _buildTodayStatusCard(),
                      const SizedBox(height: 20),

                      // Location Info Card
                      _buildLocationCard(),
                      const SizedBox(height: 20),

                      // Check-in/Check-out Buttons
                      _buildActionButtons(),
                      const SizedBox(height: 30),

                      // Today's Attendance Detail
                      if (controller.todayAttendance.value != null)
                        _buildAttendanceDetail(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTodayStatusCard() {
    final todayAttendance = controller.todayAttendance.value;
    final bool hasCheckedIn = todayAttendance != null;
    final bool hasCheckedOut = todayAttendance?.isCheckedOut() ?? false;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: hasCheckedIn
              ? [Colors.green.shade400, Colors.green.shade600]
              : [Colors.orange.shade400, Colors.orange.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: (hasCheckedIn ? Colors.green : Colors.orange).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            hasCheckedOut
                ? Icons.check_circle_outline
                : hasCheckedIn
                    ? Icons.access_time
                    : Icons.schedule,
            size: 48,
            color: Colors.white,
          ),
          const SizedBox(height: 12),
          Text(
            hasCheckedOut
                ? 'Work Completed'
                : hasCheckedIn
                    ? 'Currently Working'
                    : 'Not Checked In',
            style: AppTextStyles.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          if (hasCheckedIn) ...[
            Text(
              'Check-in: ${todayAttendance!.getCheckInTimeFormatted()}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
            if (hasCheckedOut)
              Text(
                'Check-out: ${todayAttendance.getCheckOutTimeFormatted()}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            if (hasCheckedOut) ...[
              const SizedBox(height: 8),
              Text(
                'Duration: ${todayAttendance.getWorkDurationFormatted()}',
                style: AppTextStyles.titleMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildLocationCard() {
    return Obx(() {
      final position = controller.currentPosition.value;
      final isLoading = controller.isLocationLoading.value;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.neutral.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Your Location',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (position != null) ...[
              _buildLocationInfo(
                icon: Icons.my_location,
                label: 'Latitude',
                value: position.latitude.toStringAsFixed(6),
              ),
              const SizedBox(height: 8),
              _buildLocationInfo(
                icon: Icons.my_location,
                label: 'Longitude',
                value: position.longitude.toStringAsFixed(6),
              ),
              const SizedBox(height: 8),
              _buildLocationInfo(
                icon: Icons.social_distance,
                label: 'Distance from Office',
                value: '${controller.calculateDistance(position.latitude, position.longitude).toStringAsFixed(0)}m',
                valueColor: controller.isWithinOfficeRadius(position)
                    ? Colors.green
                    : Colors.red,
              ),
            ] else
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.location_off,
                      size: 48,
                      color: AppColors.neutral.withOpacity(0.5),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Location not available',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.neutral,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: controller.getCurrentLocation,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Get Location'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildLocationInfo({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.neutral),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.neutral,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Obx(() {
      final todayAttendance = controller.todayAttendance.value;
      final hasCheckedIn = todayAttendance != null;
      final hasCheckedOut = todayAttendance?.isCheckedOut() ?? false;
      final isLoading = controller.isLoading.value;

      return Column(
        children: [
          // Check-in Button
          if (!hasCheckedIn)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : controller.checkIn,
                icon: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.login, size: 24),
                label: Text(
                  isLoading ? 'Processing...' : 'Check In',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
              ),
            ),

          // Check-out Button
          if (hasCheckedIn && !hasCheckedOut)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : controller.checkOut,
                icon: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.logout, size: 24),
                label: Text(
                  isLoading ? 'Processing...' : 'Check Out',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
              ),
            ),

          // Completed Message
          if (hasCheckedOut)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You have completed your work for today',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }

  Widget _buildAttendanceDetail() {
    final attendance = controller.todayAttendance.value!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Details',
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.neutral.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildDetailRow(
                icon: Icons.login,
                label: 'Check-in Time',
                value: attendance.getCheckInTimeFormatted(),
                iconColor: Colors.green,
              ),
              if (attendance.checkInAddress != null) ...[
                const SizedBox(height: 12),
                _buildDetailRow(
                  icon: Icons.location_on,
                  label: 'Check-in Location',
                  value: attendance.checkInAddress!,
                  iconColor: Colors.blue,
                ),
              ],
              if (attendance.isCheckedOut()) ...[
                const Divider(height: 24),
                _buildDetailRow(
                  icon: Icons.logout,
                  label: 'Check-out Time',
                  value: attendance.getCheckOutTimeFormatted() ?? '-',
                  iconColor: Colors.red,
                ),
                if (attendance.checkOutAddress != null) ...[
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    icon: Icons.location_on,
                    label: 'Check-out Location',
                    value: attendance.checkOutAddress!,
                    iconColor: Colors.blue,
                  ),
                ],
                const Divider(height: 24),
                _buildDetailRow(
                  icon: Icons.timer,
                  label: 'Work Duration',
                  value: attendance.getWorkDurationFormatted(),
                  iconColor: AppColors.primary,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.neutral,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
