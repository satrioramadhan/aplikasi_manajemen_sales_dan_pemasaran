import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/models/user_model.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final storage = GetStorage();
  final isLoading = false.obs;
  final currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  // Load User Data
  void loadUserData() {
    try {
      final userData = storage.read(AppConstants.userKey);
      if (userData != null) {
        currentUser.value = UserModel.fromJson(userData);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load user data',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Logout Function
  Future<void> logout() async {
    try {
      // Show confirmation dialog
      final confirm = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
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
              child: const Text('Logout'),
            ),
          ],
        ),
      );

      if (confirm == true) {
        isLoading.value = true;

        // Simulate API call
        await Future.delayed(const Duration(seconds: 1));

        // Clear storage
        await storage.remove(AppConstants.tokenKey);
        await storage.remove(AppConstants.userKey);

        // Show success message
        Get.snackbar(
          'Success',
          'Logged out successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to auth
        Get.offAllNamed(Routes.AUTH);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to Edit Profile
  void goToEditProfile() {
    Get.toNamed(Routes.EDIT_PROFILE);
  }

  // Navigate to Change Password
  void goToChangePassword() {
    Get.toNamed(Routes.CHANGE_PASSWORD);
  }

  // Navigate to Settings
  void goToSettings() {
    Get.toNamed(Routes.SETTINGS);
  }

  // Navigate to Help & Support
  void goToHelpSupport() {
    Get.toNamed(Routes.HELP_SUPPORT);
  }

  // Navigate to About
  void goToAbout() {
    Get.toNamed(Routes.ABOUT);
  }
}
