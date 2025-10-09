import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../leads/controllers/lead_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../reports/controllers/reports_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
    Get.lazyPut<LeadController>(
      () => LeadController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<ReportsController>(
      () => ReportsController(),
    );
  }
}
