import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final storage = GetStorage();

  // Notification Settings
  final pushNotifications = true.obs;
  final emailNotifications = true.obs;
  final leadAlerts = true.obs;

  // Privacy Settings
  final showOnlineStatus = true.obs;
  final shareLocation = true.obs;

  // App Preferences
  final darkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }

  void loadSettings() {
    pushNotifications.value = storage.read('push_notifications') ?? true;
    emailNotifications.value = storage.read('email_notifications') ?? true;
    leadAlerts.value = storage.read('lead_alerts') ?? true;
    showOnlineStatus.value = storage.read('show_online_status') ?? true;
    shareLocation.value = storage.read('share_location') ?? true;
    darkMode.value = storage.read('dark_mode') ?? false;
  }

  void togglePushNotifications(bool value) {
    pushNotifications.value = value;
    storage.write('push_notifications', value);
    Get.snackbar(
      'Settings Updated',
      'Push notifications ${value ? 'enabled' : 'disabled'}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleEmailNotifications(bool value) {
    emailNotifications.value = value;
    storage.write('email_notifications', value);
    Get.snackbar(
      'Settings Updated',
      'Email notifications ${value ? 'enabled' : 'disabled'}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleLeadAlerts(bool value) {
    leadAlerts.value = value;
    storage.write('lead_alerts', value);
    Get.snackbar(
      'Settings Updated',
      'Lead alerts ${value ? 'enabled' : 'disabled'}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleOnlineStatus(bool value) {
    showOnlineStatus.value = value;
    storage.write('show_online_status', value);
    Get.snackbar(
      'Settings Updated',
      'Online status ${value ? 'shown' : 'hidden'}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleShareLocation(bool value) {
    shareLocation.value = value;
    storage.write('share_location', value);
    Get.snackbar(
      'Settings Updated',
      'Location sharing ${value ? 'enabled' : 'disabled'}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void toggleDarkMode(bool value) {
    darkMode.value = value;
    storage.write('dark_mode', value);
    Get.snackbar(
      'Coming Soon',
      'Dark mode will be available in the next update',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void changeLanguage() {
    Get.snackbar(
      'Coming Soon',
      'Multi-language support will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void clearCache() async {
    final confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text('Are you sure you want to clear cache?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // TODO: Implement cache clearing
      await Future.delayed(const Duration(seconds: 1));
      Get.snackbar(
        'Success',
        'Cache cleared successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void changeDownloadQuality() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Download Quality',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Low'),
              subtitle: const Text('Save data'),
              leading: Radio(
                value: 'low',
                groupValue: 'high',
                onChanged: (value) => Get.back(),
              ),
            ),
            ListTile(
              title: const Text('Medium'),
              subtitle: const Text('Balanced'),
              leading: Radio(
                value: 'medium',
                groupValue: 'high',
                onChanged: (value) => Get.back(),
              ),
            ),
            ListTile(
              title: const Text('High'),
              subtitle: const Text('Best quality'),
              leading: Radio(
                value: 'high',
                groupValue: 'high',
                onChanged: (value) => Get.back(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
