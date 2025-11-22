import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../data/models/user_model.dart';

class EditProfileController extends GetxController {
  final storage = GetStorage();
  final isLoading = false.obs;
  final isSaving = false.obs;
  final photoUrl = ''.obs;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    loadUserData();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void loadUserData() {
    try {
      isLoading.value = true;
      final userData = storage.read(AppConstants.userKey);
      if (userData != null) {
        final user = UserModel.fromJson(userData);
        nameController.text = user.name;
        emailController.text = user.email;
        phoneController.text = user.phone ?? '';
        photoUrl.value = user.photo ?? '';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load user data',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void changePhoto() {
    // TODO: Implement image picker
    Get.snackbar(
      'Coming Soon',
      'Photo upload feature will be available soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> saveProfile() async {
    try {
      // Validate
      if (nameController.text.trim().isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Name is required',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (phoneController.text.trim().isNotEmpty &&
          phoneController.text.trim().length < 10) {
        Get.snackbar(
          'Validation Error',
          'Phone number must be at least 10 digits',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isSaving.value = true;

      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));

      // Update local storage
      final userData = storage.read(AppConstants.userKey);
      if (userData != null) {
        final user = UserModel.fromJson(userData);
        final updatedUser = UserModel(
          id: user.id,
          name: nameController.text.trim(),
          email: user.email,
          phone: phoneController.text.trim().isEmpty
              ? null
              : phoneController.text.trim(),
          role: user.role,
          status: user.status,
          photo: photoUrl.value.isEmpty ? null : photoUrl.value,
          lastLogin: user.lastLogin,
        );

        await storage.write(AppConstants.userKey, updatedUser.toJson());
      }

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Go back to profile
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isSaving.value = false;
    }
  }
}
