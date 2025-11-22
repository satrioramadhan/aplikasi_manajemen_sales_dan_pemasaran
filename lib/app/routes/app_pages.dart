import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/auth/views/forgot_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/products/bindings/product_binding.dart';
import '../modules/products/views/product_list_view.dart';
import '../modules/products/views/product_detail_view.dart';
import '../modules/leads/bindings/lead_binding.dart';
import '../modules/leads/views/lead_list_view.dart';
import '../modules/leads/views/lead_detail_view.dart';
import '../modules/leads/views/add_lead_view.dart';
import '../modules/attendance/bindings/attendance_binding.dart';
import '../modules/attendance/views/attendance_view.dart';
import '../modules/attendance/views/attendance_history_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/elearning/bindings/elearning_binding.dart';
import '../modules/elearning/views/elearning_view.dart';
import '../modules/profile/views/edit_profile/edit_profile_view.dart';
import '../modules/profile/views/edit_profile/edit_profile_controller.dart';
import '../modules/profile/views/change_password/change_password_view.dart';
import '../modules/profile/views/change_password/change_password_controller.dart';
import '../modules/profile/views/settings/settings_view.dart';
import '../modules/profile/views/settings/settings_controller.dart';
import '../modules/profile/views/help_support/help_support_view.dart';
import '../modules/profile/views/about/about_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => const ProductListView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL,
      page: () => const ProductDetailView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.LEADS,
      page: () => const LeadListView(),
      binding: LeadBinding(),
    ),
    GetPage(
      name: _Paths.LEAD_DETAIL,
      page: () => const LeadDetailView(),
      binding: LeadBinding(),
    ),
    GetPage(
      name: _Paths.ADD_LEAD,
      page: () => const AddLeadView(),
      binding: LeadBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE,
      page: () => const AttendanceView(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: _Paths.ATTENDANCE_HISTORY,
      page: () => const AttendanceHistoryView(),
      binding: AttendanceBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ELEARNING,
      page: () => const ElearningView(),
      binding: ElearningBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<EditProfileController>(() => EditProfileController());
      }),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      page: () => const ChangePasswordView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
      }),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SettingsController>(() => SettingsController());
      }),
    ),
    GetPage(
      name: _Paths.HELP_SUPPORT,
      page: () => const HelpSupportView(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
    ),
  ];
}
