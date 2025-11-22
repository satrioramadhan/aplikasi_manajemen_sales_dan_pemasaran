import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Obx(() => ListView(
            padding: const EdgeInsets.all(24),
            children: [
              // Notifications Section
              Text(
                'Notifications',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildSettingCard([
                _buildSwitchTile(
                  title: 'Push Notifications',
                  subtitle: 'Receive push notifications',
                  value: controller.pushNotifications.value,
                  onChanged: controller.togglePushNotifications,
                  icon: Icons.notifications_outlined,
                ),
                _buildSwitchTile(
                  title: 'Email Notifications',
                  subtitle: 'Receive email updates',
                  value: controller.emailNotifications.value,
                  onChanged: controller.toggleEmailNotifications,
                  icon: Icons.email_outlined,
                ),
                _buildSwitchTile(
                  title: 'Lead Alerts',
                  subtitle: 'Get notified for new leads',
                  value: controller.leadAlerts.value,
                  onChanged: controller.toggleLeadAlerts,
                  icon: Icons.person_add_outlined,
                ),
              ]),
              const SizedBox(height: 24),

              // Privacy Section
              Text(
                'Privacy',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildSettingCard([
                _buildSwitchTile(
                  title: 'Show Online Status',
                  subtitle: 'Let others see when you\'re online',
                  value: controller.showOnlineStatus.value,
                  onChanged: controller.toggleOnlineStatus,
                  icon: Icons.visibility_outlined,
                ),
                _buildSwitchTile(
                  title: 'Share Location',
                  subtitle: 'Share location for attendance',
                  value: controller.shareLocation.value,
                  onChanged: controller.toggleShareLocation,
                  icon: Icons.location_on_outlined,
                ),
              ]),
              const SizedBox(height: 24),

              // App Preferences
              Text(
                'App Preferences',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildSettingCard([
                _buildSwitchTile(
                  title: 'Dark Mode',
                  subtitle: 'Enable dark theme',
                  value: controller.darkMode.value,
                  onChanged: controller.toggleDarkMode,
                  icon: Icons.dark_mode_outlined,
                ),
                _buildTile(
                  title: 'Language',
                  subtitle: 'English',
                  icon: Icons.language_outlined,
                  onTap: controller.changeLanguage,
                ),
              ]),
              const SizedBox(height: 24),

              // Data & Storage
              Text(
                'Data & Storage',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildSettingCard([
                _buildTile(
                  title: 'Clear Cache',
                  subtitle: 'Free up storage space',
                  icon: Icons.cleaning_services_outlined,
                  onTap: controller.clearCache,
                ),
                _buildTile(
                  title: 'Download Quality',
                  subtitle: 'High',
                  icon: Icons.high_quality_outlined,
                  onTap: controller.changeDownloadQuality,
                ),
              ]),
            ],
          )),
    );
  }

  Widget _buildSettingCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 24),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  Widget _buildTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primary, size: 24),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }
}
