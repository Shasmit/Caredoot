import 'package:flutter/material.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/value_constants.dart';
import '../../../../core/helpers/scaffold_helpers.dart';
import '../../../../core/helpers/ui_helpers.dart';
import '../../../../core/helpers/user_helpers.dart';
import '../../../../ui/molecules/buttons.dart';
import '../../../onboarding/presentation/pages/login_sheet_widget.dart';

class UserNotLoggedIn extends StatefulWidget {
  const UserNotLoggedIn({super.key});

  @override
  State<UserNotLoggedIn> createState() => _UserNotLoggedInState();
}

class _UserNotLoggedInState extends State<UserNotLoggedIn> {
  bool isSignedIn = false;

  Future<void> _checkUserStatus() async {
    bool userStatus = await UserHelpers.getUserDetails() != false;
    var a = await UserHelpers.getUserDetails();
    isSignedIn = userStatus;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Please login before you continue',
          style: AppTextStyles.textStyle16w500Secondary.copyWith(
            fontSize: 15,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonsWidget(
            buttonText: 'Login',
            onPressed: () async {
              ScaffoldHelpers.showBottomSheet(
                  context: context,
                  child: LoginSheetWidget(
                    onSuccess: () async {
                      _checkUserStatus().then((value) {
                        Navigator.pop(context);
                      });
                    },
                    onFailure: () {
                      UIHelper.showToast(
                          msg: "Login Failure", type: ToastType.Error);
                    },
                  ));
            }),
      ],
    );
  }
}
