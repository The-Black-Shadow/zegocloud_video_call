import 'package:get/get.dart';
import 'package:zegocloud_video_call/screen/home_screen/controller/home_controller.dart';
import 'package:zegocloud_video_call/screen/login_screen/controller/login_controller.dart';

class AllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
