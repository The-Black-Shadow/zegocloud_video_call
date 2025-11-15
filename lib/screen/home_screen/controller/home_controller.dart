import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../routes/app_routes.dart';
import '../../services/login_service.dart';

class HomeController extends GetxController {
  // Text controllers for invitee IDs
  final singleInviteeUserIDTextCtrl = TextEditingController();
  final groupInviteeUserIDsTextCtrl = TextEditingController();
  
  // Observable for minimize state
  final isMinimizing = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    
    // Enter accepted offline call after widget is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ZegoUIKitPrebuiltCallInvitationService().enterAcceptedOfflineCall();
    });
  }
  
  @override
  void onClose() {
    // Dispose controllers
    singleInviteeUserIDTextCtrl.dispose();
    groupInviteeUserIDsTextCtrl.dispose();
    super.onClose();
  }
  
  // Logout logic
  Future<void> performLogout(BuildContext context) async {
    await logout();
    onUserLogout();
    
    // Navigate to login screen
    Get.offNamed(AppRoutes.instance.login);
  }
  
  // Handle send call invitation finished
  void onSendCallInvitationFinished(
    String code,
    String message,
    List<String> errorInvitees,
    BuildContext context,
  ) {
    if (errorInvitees.isNotEmpty) {
      String userIDs = "";
      for (int index = 0; index < errorInvitees.length; index++) {
        if (index >= 5) {
          userIDs += '... ';
          break;
        }

        var userID = errorInvitees.elementAt(index);
        userIDs += '$userID ';
      }
      if (userIDs.isNotEmpty) {
        userIDs = userIDs.substring(0, userIDs.length - 1);
      }

      var message = 'User doesn\'t exist or is offline: $userIDs';
      if (code.isNotEmpty) {
        message += ', code: $code, message:$message';
      }
      showToast(
        message,
        position: StyledToastPosition.top,
        context: context,
      );
    } else if (code.isNotEmpty) {
      showToast(
        'code: $code, message:$message',
        position: StyledToastPosition.top,
        context: context,
      );
    }
  }
}
