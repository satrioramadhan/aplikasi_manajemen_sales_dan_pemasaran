import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/constants/app_constants.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    print('SplashController onInit called');
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    print('Starting splash navigation...');
    await Future.delayed(const Duration(seconds: 3));

    // Cek apakah user sudah melihat onboarding
    final hasSeenOnboarding = storage.read(AppConstants.hasSeenOnboarding) ?? false;
    print('Has seen onboarding: $hasSeenOnboarding');

    if (!hasSeenOnboarding) {
      // First time user, show onboarding
      print('Navigating to ONBOARDING');
      Get.offAllNamed(Routes.ONBOARDING);
      return;
    }

    // Cek apakah user sudah login
    final token = storage.read(AppConstants.tokenKey);
    print('Token: $token');

    if (token != null) {
      // User sudah login, navigate ke home/dashboard
      print('Navigating to HOME');
      Get.offAllNamed(Routes.HOME);
    } else {
      // User belum login, navigate ke auth
      print('Navigating to AUTH');
      Get.offAllNamed(Routes.AUTH);
    }
  }
}
