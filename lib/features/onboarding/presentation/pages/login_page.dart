import 'package:caredoot/core/helpers/utils.dart';
import 'package:caredoot/features/onboarding/presentation/widgets/all_rights_reserved_bottom.dart';
import 'package:caredoot/route/app_pages.dart';
import 'package:caredoot/route/custom_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_imports.dart';

import '../../../../core/helpers/ui_helpers.dart';
import '../../../../ui/injection_container.dart';
import '../../../../ui/molecules/custom_button.dart';
import '../../../../ui/molecules/custom_text_field.dart';
import '../../domain/entities/send_otp_entity.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _mobileNumberController;
  bool isLoading = false;
  final _bloc = sl<OnboardingBloc>();

  @override
  void initState() {
    _mobileNumberController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocBuilder<OnboardingBloc, OnboardingState>(
            bloc: _bloc,
            builder: (context, state) {
              return BlocListener<OnboardingBloc, OnboardingState>(
                  listener: (context, state) {
                    if (state is OTPSentState) {
                      isLoading = false;
                      CustomNavigator.pushTo(context, AppPages.verifyOtp,
                          arguments: {'phone': _mobileNumberController.text});
                    }
                    if (state is OTPSendingState) {
                      isLoading = true;
                    }
                    if (state is OTPErrorState) {
                      isLoading = false;
                      UIHelper.showToast(
                          msg: state.error, type: ToastType.Alert);
                    }
                  },
                  child: GestureDetector(
                    onTap: () => Utils.dismissKeypad(context),
                    child: Scaffold(
                      body: Padding(
                        padding:
                            const EdgeInsets.all(VALUE_STANDARD_SCREEN_PADDING),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomSpacers.height80,
                            Image.asset(
                              AppIcons.appLogo,
                            ),
                            CustomSpacers.height64,
                            _buildWelcomeText(),
                            CustomSpacers.height36,
                            _buildLoginFields(),
                            const Spacer(),
                            _buildLoginActionButtons(context),
                            CustomSpacers.height12,
                            const AllRightReserved(),
                          ],
                        ),
                      ),
                    ),
                  ));
            }));
  }

  _buildWelcomeText() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Welcome",
              style: AppTextStyles.textStyleHeebo30w800Primary),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Sign in to continue !",
                  style: AppTextStyles.textStyleHeebo30w800Primary
                      .copyWith(color: AppColors.primaryText)),
            ]),
          ),
        ],
      );

  _buildLoginFields() => CustomTextField(
      controller: _mobileNumberController,
      hint: "Mobile Number",
      keyboardType: TextInputType.phone);

  _buildLoginActionButtons(context) => Column(
        children: [
          CustomButton(
              strButtonText: "Next",
              isLoading: isLoading,
              buttonAction: () {
                if (_mobileNumberController.text.isNotEmpty) {
                  _bloc.add(SendOtpEvent(
                      entity: SendOtpEntity(
                          phoneNumber: _mobileNumberController.text)));
                }
              }),
        ],
      );
}
