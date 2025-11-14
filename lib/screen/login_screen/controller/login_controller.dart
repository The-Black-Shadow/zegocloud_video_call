import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zegocloud_video_call/constant/constants.dart';
import 'package:zegocloud_video_call/screen/services/login_service.dart';
import 'package:zegocloud_video_call/utils/util.dart';


class LoginController extends GetxController {
  // TextEditingController for user ID
  final userIDTextCtrl = TextEditingController(text: 'user_id');
  
  // Observable for password visibility
  final passwordVisible = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    
    // Get unique user ID and set it
    getUniqueUserId().then((userID) {
      userIDTextCtrl.text = userID;
    });
  }
  
  @override
  void onClose() {
    // Dispose controllers
    userIDTextCtrl.dispose();
    super.onClose();
  }
  
  // Toggle password visibility
  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }
  
  // Sign in logic
  Future<void> signIn() async {
    if (userIDTextCtrl.text.isEmpty) {
      return;
    }
    
    await login(
      userID: userIDTextCtrl.text,
      userName: 'user_${userIDTextCtrl.text}',
    );
    
    await onUserLogin();
    
    // Navigate to home screen
    Get.offNamed(PageRouteNames.home);
  }
}