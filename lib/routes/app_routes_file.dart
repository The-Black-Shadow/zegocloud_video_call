import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zegocloud_video_call/routes/app_routes.dart';
import 'package:zegocloud_video_call/screen/home_screen/home_screen.dart';
import 'package:zegocloud_video_call/screen/login_screen/login_screen.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
  GetPage(
    name: AppRoutes.instance.login,
    // binding: AllBinding(),
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.home,
    page: () => const ZegoUIKitPrebuiltCallMiniPopScope(
      child: HomeScreen(),
    ),
  ),
];
