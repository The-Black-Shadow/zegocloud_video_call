import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:faker/faker.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../constant/constants.dart';
import '../services/login_service.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 20,
              right: 10,
              child: _logoutButton(controller, context),
            ),
            Positioned(
              top: 50,
              left: 10,
              child: Text('Your Phone Number: ${currentUser.id}'),
            ),
            _userListView(controller, context),
          ],
        ),
      ),
    );
  }

  Widget _logoutButton(HomeController controller, BuildContext context) {
    return Ink(
      width: 35,
      height: 35,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.redAccent,
      ),
      child: ValueListenableBuilder<bool>(
        valueListenable:
            ZegoUIKitPrebuiltCallController().minimize.isMinimizingNotifier,
        builder: (context, isMinimized, _) {
          return IconButton(
            icon: const Icon(Icons.exit_to_app_sharp),
            iconSize: 20,
            color: Colors.white,
            onPressed: isMinimized
                ? null
                : () => controller.performLogout(context),
          );
        },
      ),
    );
  }

  Widget _userListView(HomeController controller, BuildContext context) {
    final RandomGenerator random = RandomGenerator();
    final Faker faker = Faker();

    return Center(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          late TextEditingController inviteeUsersIDTextCtrl;
          late List<Widget> userInfo;
          if (0 == index) {
            inviteeUsersIDTextCtrl = controller.singleInviteeUserIDTextCtrl;
            userInfo = [
              const Text('invitee id ('),
              _inviteeIDFormField(
                textCtrl: inviteeUsersIDTextCtrl,
                formatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      r'^[a-zA-Z0-9,!#$%&()*+:\-;<=>.?@[\]^_{|}~]{1,32}$')),
                ],
                labelText: "invitee ID",
                hintText: "plz enter invitee ID",
              ),
              const Text(')'),
            ];
          } else if (1 == index) {
            inviteeUsersIDTextCtrl = controller.groupInviteeUserIDsTextCtrl;
            userInfo = [
              const Text('group id ('),
              _inviteeIDFormField(
                textCtrl: inviteeUsersIDTextCtrl,
                formatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      r'^[a-zA-Z0-9,!#$%&()*+:\-;<=>.?@[\]^_{|}~]{1,32}$')),
                ],
                labelText: "invitees ID",
                hintText: "separate IDs by ','",
              ),
              const Text(')'),
            ];
          } else {
            inviteeUsersIDTextCtrl = TextEditingController();
            userInfo = [
              Text(
                '${faker.person.firstName()}(${random.fromPattern([
                      '######'
                    ])})',
                style: textStyle,
              )
            ];
          }

          return Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 20),
                  ...userInfo,
                  Expanded(child: Container()),
                  _sendCallButton(
                    isVideoCall: false,
                    inviteeUsersIDTextCtrl: inviteeUsersIDTextCtrl,
                    onCallFinished: (code, message, errorInvitees) =>
                        controller.onSendCallInvitationFinished(
                      code,
                      message,
                      errorInvitees,
                      context,
                    ),
                  ),
                  _sendCallButton(
                    isVideoCall: true,
                    inviteeUsersIDTextCtrl: inviteeUsersIDTextCtrl,
                    onCallFinished: (code, message, errorInvitees) =>
                        controller.onSendCallInvitationFinished(
                      code,
                      message,
                      errorInvitees,
                      context,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Divider(height: 1.0, color: Colors.grey),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _inviteeIDFormField({
    required TextEditingController textCtrl,
    List<TextInputFormatter>? formatters,
    String hintText = '',
    String labelText = '',
  }) {
    const textStyle = TextStyle(fontSize: 12.0);
    return Expanded(
      flex: 100,
      child: SizedBox(
        height: 80,
        child: TextFormField(
          style: textStyle,
          controller: textCtrl,
          inputFormatters: formatters,
          maxLines: 3,
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            hintStyle: textStyle,
            labelText: labelText,
            labelStyle: textStyle,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _sendCallButton({
    required bool isVideoCall,
    required TextEditingController inviteeUsersIDTextCtrl,
    void Function(String code, String message, List<String>)? onCallFinished,
  }) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: inviteeUsersIDTextCtrl,
      builder: (context, inviteeUserID, _) {
        var invitees = _getInvitesFromTextCtrl(inviteeUsersIDTextCtrl.text.trim());

        return ZegoSendCallInvitationButton(
          isVideoCall: isVideoCall,
          invitees: invitees,
          resourceID: "zego_data",
          iconSize: const Size(40, 40),
          buttonSize: const Size(50, 50),
          timeoutSeconds: 30,
          onPressed: onCallFinished,
        );
      },
    );
  }

  List<ZegoUIKitUser> _getInvitesFromTextCtrl(String textCtrlText) {
    List<ZegoUIKitUser> invitees = [];

    var inviteeIDs = textCtrlText.trim().replaceAll('，', '');
    inviteeIDs.split(",").forEach((inviteeUserID) {
      if (inviteeUserID.isEmpty) {
        return;
      }

      invitees.add(ZegoUIKitUser(
        id: inviteeUserID,
        name: 'user_$inviteeUserID',
      ));
    });

    return invitees;
  }
}
