import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportView extends StatelessWidget {
  const HelpSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Contact Section
          Text(
            'Contact Us',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildContactCard([
            _buildContactTile(
              icon: Icons.email_outlined,
              title: 'Email Support',
              subtitle: 'support@samarazen.com',
              onTap: () => _launchEmail('support@samarazen.com'),
              color: AppColors.primary,
            ),
            _buildContactTile(
              icon: Icons.phone_outlined,
              title: 'Phone Support',
              subtitle: '+62 812-3456-7890',
              onTap: () => _launchPhone('+628123456789'),
              color: Colors.green,
            ),
            _buildContactTile(
              icon: Icons.chat_outlined,
              title: 'Live Chat',
              subtitle: 'Chat with our support team',
              onTap: () => _openLiveChat(),
              color: Colors.blue,
            ),
          ]),
          const SizedBox(height: 24),

          // FAQ Section
          Text(
            'Frequently Asked Questions',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildFAQCard([
            _buildFAQItem(
              question: 'How do I add a new lead?',
              answer:
                  'Go to the Dashboard and tap the "Add Lead" button. Fill in the required information and save.',
            ),
            _buildFAQItem(
              question: 'How do I mark my attendance?',
              answer:
                  'Navigate to the Attendance section and tap "Check In" when you arrive at work location. Make sure to enable location services.',
            ),
            _buildFAQItem(
              question: 'How do I access my commission report?',
              answer:
                  'Go to the Reports section from the main menu. You can view your commission details by month.',
            ),
            _buildFAQItem(
              question: 'How do I update my profile?',
              answer:
                  'Go to Profile > Edit Profile. Update your information and tap Save Changes.',
            ),
            _buildFAQItem(
              question: 'How do I reset my password?',
              answer:
                  'Go to Profile > Change Password. Enter your current password and new password, then save.',
            ),
          ]),
          const SizedBox(height: 24),

          // Resources Section
          Text(
            'Resources',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildContactCard([
            _buildContactTile(
              icon: Icons.book_outlined,
              title: 'User Guide',
              subtitle: 'Learn how to use the app',
              onTap: () => _openUserGuide(),
              color: AppColors.secondary,
            ),
            _buildContactTile(
              icon: Icons.video_library_outlined,
              title: 'Video Tutorials',
              subtitle: 'Watch step-by-step guides',
              onTap: () => _openVideoTutorials(),
              color: Colors.red,
            ),
            _buildContactTile(
              icon: Icons.bug_report_outlined,
              title: 'Report a Bug',
              subtitle: 'Help us improve the app',
              onTap: () => _reportBug(),
              color: Colors.orange,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildContactCard(List<Widget> children) {
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

  Widget _buildContactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 24),
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

  Widget _buildFAQCard(List<Widget> children) {
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

  Widget _buildFAQItem({
    required String question,
    required String answer,
  }) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      title: Text(
        question,
        style: AppTextStyles.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Support Request',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        Get.snackbar(
          'Error',
          'Could not open email app',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Coming Soon',
        'Email support feature',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        Get.snackbar(
          'Error',
          'Could not open phone app',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Coming Soon',
        'Phone support feature',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _openLiveChat() {
    Get.snackbar(
      'Coming Soon',
      'Live chat feature will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _openUserGuide() {
    Get.snackbar(
      'Coming Soon',
      'User guide feature will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _openVideoTutorials() {
    Get.snackbar(
      'Coming Soon',
      'Video tutorials feature will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _reportBug() {
    Get.snackbar(
      'Coming Soon',
      'Bug report feature will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
