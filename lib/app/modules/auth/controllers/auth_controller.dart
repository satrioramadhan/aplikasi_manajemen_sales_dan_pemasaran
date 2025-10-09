import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/constants/app_constants.dart';
import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  // Form Keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();

  // Text Controllers for Login
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Text Controller for Forgot Password
  final forgotPasswordEmailController = TextEditingController();

  // Text Controllers for Register
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final nikController = TextEditingController();
  final addressController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final accountHolderController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable Variables
  final isLoading = false.obs;
  final agreeToTerms = false.obs;

  // Storage
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // Dispose controllers
    emailController.dispose();
    passwordController.dispose();
    forgotPasswordEmailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    nikController.dispose();
    addressController.dispose();
    bankNameController.dispose();
    accountNumberController.dispose();
    accountHolderController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Login Function
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      // TODO: Implement API call ke backend Laravel
      // Sementara ini mock login
      await Future.delayed(const Duration(seconds: 2));

      // Mock response
      final email = emailController.text;
      final password = passwordController.text;

      // Validasi sederhana (nanti diganti dengan API call)
      if (email.isNotEmpty && password.length >= 8) {
        // Save token dan user data ke storage
        await storage.write(AppConstants.tokenKey, 'mock_token_12345');
        await storage.write(AppConstants.userKey, {
          'id': 1,
          'name': 'John Doe',
          'email': email,
          'phone': '081234567890',
          'role': AppConstants.roleSales,
          'status': 'active',
          'photo': null,
          'last_login': DateTime.now().toIso8601String(),
        });

        // Show success message
        Get.snackbar(
          'Success',
          'Login successful!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Navigate to home
        Get.offAllNamed(Routes.HOME);
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Register Function
  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) {
      return;
    }

    if (!agreeToTerms.value) {
      Get.snackbar(
        'Error',
        'Please agree to terms and conditions',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // TODO: Implement API call ke backend Laravel
      // Sementara ini mock register
      await Future.delayed(const Duration(seconds: 2));

      // Mock response
      final registerData = {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'nik': nikController.text,
        'address': addressController.text,
        'bank_name': bankNameController.text,
        'account_number': accountNumberController.text,
        'account_holder': accountHolderController.text,
        'password': passwordController.text,
      };

      // Simulate successful registration
      Get.snackbar(
        'Success',
        'Registration successful! Please wait for admin verification.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      // Clear form
      _clearRegisterForm();

      // Navigate back to login
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Registration Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Logout Function
  Future<void> logout() async {
    try {
      // TODO: Implement API call untuk logout
      await Future.delayed(const Duration(seconds: 1));

      // Clear storage
      await storage.remove(AppConstants.tokenKey);
      await storage.remove(AppConstants.userKey);

      // Navigate to auth
      Get.offAllNamed(Routes.AUTH);

      Get.snackbar(
        'Success',
        'Logged out successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Navigate to Register
  void goToRegister() {
    _clearLoginForm();
    Get.toNamed(Routes.REGISTER);
  }

  // Clear Login Form
  void _clearLoginForm() {
    emailController.clear();
    passwordController.clear();
  }

  // Clear Register Form
  void _clearRegisterForm() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    nikController.clear();
    addressController.clear();
    bankNameController.clear();
    accountNumberController.clear();
    accountHolderController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    agreeToTerms.value = false;
  }

  // Forgot Password Function
  Future<void> forgotPassword() async {
    if (!forgotPasswordFormKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      // TODO: Implement API call ke backend Laravel untuk forgot password
      // Sementara ini mock request
      await Future.delayed(const Duration(seconds: 2));

      final email = forgotPasswordEmailController.text;

      // Simulate successful request
      Get.snackbar(
        'Success',
        'Password reset link has been sent to $email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );

      // Clear form
      forgotPasswordEmailController.clear();

      // Navigate back to login after 1 second
      await Future.delayed(const Duration(seconds: 1));
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send reset link. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to Forgot Password
  void goToForgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }
}
