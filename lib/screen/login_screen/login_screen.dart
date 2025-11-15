
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit/zego_uikit.dart';

import '../../constant/constants.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          return ZegoUIKit().onWillPop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _logo(),
              const SizedBox(height: 50),
              _userIDEditor(controller),
              _passwordEditor(controller),
              const SizedBox(height: 30),
              _signInButton(controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Center(
      child: RichText(
        text: const TextSpan(
          text: 'ZE',
          style: TextStyle(color: Colors.black, fontSize: 20),
          children: <TextSpan>[
            TextSpan(
              text: 'GO',
              style: TextStyle(color: Colors.blue),
            ),
            TextSpan(text: 'CLOUD'),
          ],
        ),
      ),
    );
  }

  Widget _userIDEditor(LoginController controller) {
    return TextFormField(
      controller: controller.userIDTextCtrl,
      decoration: const InputDecoration(
        labelText: 'Phone Num.(User for user id)',
      ),
    );
  }

  Widget _passwordEditor(LoginController controller) {
    return Obx(() {
      return TextFormField(
        obscureText: !controller.passwordVisible.value,
        decoration: InputDecoration(
          labelText: 'Password.(Any character for test)',
          suffixIcon: IconButton(
            icon: Icon(
              controller.passwordVisible.value ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: controller.togglePasswordVisibility,
          ),
        ),
      );
    });
  }

  Widget _signInButton(LoginController controller) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller.userIDTextCtrl,
      builder: (context, value, _) {
        return ElevatedButton(
          onPressed: controller.userIDTextCtrl.text.isEmpty
              ? null
              : () => controller.signIn(),
          child: const Text('Sign In', style: textStyle),
        );
      },
    );
  }
}
