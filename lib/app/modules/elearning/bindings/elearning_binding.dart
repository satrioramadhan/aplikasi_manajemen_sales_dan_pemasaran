import 'package:get/get.dart';
import '../controllers/elearning_controller.dart';

class ElearningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ElearningController>(
      () => ElearningController(),
    );
  }
}
