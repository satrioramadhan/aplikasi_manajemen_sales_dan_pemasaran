import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/onboarding_model.dart';
import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  final storage = GetStorage();
  final pageController = PageController();
  final currentPage = 0.obs;

  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      title: 'Manage Your Sales Team',
      description: 'Effortlessly track and manage your sales team performance in real-time with powerful analytics',
      icon: Icons.groups_rounded,
      gradient: AppColors.purpleGradient,
    ),
    OnboardingModel(
      title: 'Track Your Progress',
      description: 'Monitor KPIs, targets, and achievements with beautiful dashboards and detailed reports',
      icon: Icons.trending_up_rounded,
      gradient: AppColors.oceanGradient,
    ),
    OnboardingModel(
      title: 'Boost Your Revenue',
      description: 'Increase your sales with smart lead management, automated follow-ups, and commission tracking',
      icon: Icons.payments_rounded,
      gradient: AppColors.sunsetGradient,
    ),
    OnboardingModel(
      title: 'GPS Attendance',
      description: 'Track field sales attendance with GPS location verification and automated reporting',
      icon: Icons.location_on_rounded,
      gradient: AppColors.heroGradient,
    ),
  ];

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < onboardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      completeOnboarding();
    }
  }

  void skipOnboarding() {
    completeOnboarding();
  }

  void completeOnboarding() {
    // Mark onboarding as completed
    storage.write(AppConstants.hasSeenOnboarding, true);

    // Navigate to Auth
    Get.offAllNamed(Routes.AUTH);
  }

  bool get isLastPage => currentPage.value == onboardingPages.length - 1;
}
