import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  String appVersion = '1.0.0';
  String buildNumber = '1';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        appVersion = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    } catch (e) {
      // Keep default values if error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // App Logo & Name
          Center(
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: AppColors.heroGradient,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.business_center,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Sama Razen',
                  style: AppTextStyles.headlineMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sales Management App',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Version $appVersion ($buildNumber)',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // App Info
          _buildInfoCard([
            _buildInfoTile(
              icon: Icons.info_outline,
              title: 'About App',
              subtitle:
                  'Sama Razen is a comprehensive sales management application designed to help sales teams track leads, manage activities, and boost productivity.',
            ),
            _buildInfoTile(
              icon: Icons.business_outlined,
              title: 'Company',
              subtitle: 'PT Sama Razen Indonesia',
            ),
            _buildInfoTile(
              icon: Icons.location_on_outlined,
              title: 'Address',
              subtitle: 'Jakarta, Indonesia',
            ),
          ]),
          const SizedBox(height: 24),

          // Legal
          Text(
            'Legal',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoCard([
            _buildActionTile(
              icon: Icons.description_outlined,
              title: 'Terms of Service',
              onTap: _openTermsOfService,
            ),
            _buildActionTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: _openPrivacyPolicy,
            ),
            _buildActionTile(
              icon: Icons.gavel_outlined,
              title: 'Licenses',
              onTap: _showLicenses,
            ),
          ]),
          const SizedBox(height: 24),

          // Social Media
          Text(
            'Connect With Us',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                icon: Icons.language,
                label: 'Website',
                onTap: _openWebsite,
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                icon: Icons.facebook,
                label: 'Facebook',
                onTap: _openFacebook,
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                icon: Icons.camera_alt,
                label: 'Instagram',
                onTap: _openInstagram,
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Copyright
          Center(
            child: Text(
              '© 2025 Sama Razen. All rights reserved.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
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

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String subtitle,
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
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
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
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.textSecondary,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openTermsOfService() {
    Get.snackbar(
      'Coming Soon',
      'Terms of Service will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _openPrivacyPolicy() {
    Get.snackbar(
      'Coming Soon',
      'Privacy Policy will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _showLicenses() {
    showLicensePage(
      context: context,
      applicationName: 'Sama Razen',
      applicationVersion: '$appVersion ($buildNumber)',
      applicationIcon: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: AppColors.heroGradient,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.business_center,
          size: 30,
          color: Colors.white,
        ),
      ),
    );
  }

  void _openWebsite() {
    Get.snackbar(
      'Coming Soon',
      'Website link will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _openFacebook() {
    Get.snackbar(
      'Coming Soon',
      'Facebook link will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _openInstagram() {
    Get.snackbar(
      'Coming Soon',
      'Instagram link will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
