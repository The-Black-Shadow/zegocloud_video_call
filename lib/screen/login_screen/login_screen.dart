
import 'package:flutter/material.dart';

import 'package:zego_uikit/zego_uikit.dart';

import '../../constant/constants.dart';
import '../services/login_service.dart';
import '../../utils/util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _userIDTextCtrl = TextEditingController(text: 'user_id');
  final _passwordVisible = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    getUniqueUserId().then((userID) async {
      setState(() {
        _userIDTextCtrl.text = userID;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
              logo(),
              const SizedBox(height: 50),
              userIDEditor(),
              passwordEditor(),
              const SizedBox(height: 30),
              signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget logo() {
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

  Widget userIDEditor() {
    return TextFormField(
      controller: _userIDTextCtrl,
      decoration: const InputDecoration(
        labelText: 'Phone Num.(User for user id)',
      ),
    );
  }

  Widget passwordEditor() {
    return ValueListenableBuilder<bool>(
      valueListenable: _passwordVisible,
      builder: (context, isPasswordVisible, _) {
        return TextFormField(
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Password.(Any character for test)',
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                _passwordVisible.value = !_passwordVisible.value;
              },
            ),
          ),
        );
      },
    );
  }

  Widget signInButton() {
    return ElevatedButton(
      onPressed: _userIDTextCtrl.text.isEmpty
          ? null
          : () async {
              login(
                userID: _userIDTextCtrl.text,
                userName: 'user_${_userIDTextCtrl.text}',
              ).then((value) {
                onUserLogin().then((_) {
                  Navigator.pushNamed(
                    context,
                    PageRouteNames.home,
                  );
                });
              });
            },
      child: const Text('Sign In', style: textStyle),
    );
  }
}
