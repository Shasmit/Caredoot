import 'package:caredoot/core/helpers/utils.dart';
import 'package:caredoot/features/onboarding/domain/entities/verify_otp_entity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_imports.dart';
import '../../../../core/helpers/ui_helpers.dart';
import '../../../../route/app_pages.dart';
import '../../../../route/custom_navigator.dart';
import '../../../../ui/injection_container.dart';
import '../../../../ui/molecules/custom_back_button.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../ui/molecules/custom_button.dart';
import '../../domain/entities/send_otp_entity.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../widgets/all_rights_reserved_bottom.dart';

class VerifyOtpPage extends StatefulWidget {
  final Map<String, dynamic>? arguments;
  const VerifyOtpPage({super.key, required this.arguments});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  late final TextEditingController _otpController;
  late String _phoneNumber;
  final OnboardingBloc _bloc = sl<OnboardingBloc>();
  bool _isLoading = false;

  void _resendOtp() {
    _bloc.add(SendOtpEvent(entity: SendOtpEntity(phoneNumber: _phoneNumber)));
  }

  // void _verifyOtp() {
  //   if (_otpController.text.isEmpty || _otpController.text.length != 6) {
  //     FocusManager.instance.primaryFocus?.unfocus();
  //     UIHelper.showToast(msg: "Please enter otp.", type: ToastType.Alert);
  //   } else {
  //     _bloc.add(VerifyOtpEvent(
  //         verifyOtpEntity: VerifyOtpEntity(otp: _otpController.text)));
  //   }
  // }

  @override
  void initState() {
    _phoneNumber = widget.arguments!['phone'];
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final Map<String, dynamic> args =
  //       ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
  //   _phoneNumber = args["phoneNumber"];
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _bloc,
        child: BlocBuilder<OnboardingBloc, OnboardingState>(
            bloc: _bloc,
            builder: (context, state) {
              return BlocListener<OnboardingBloc, OnboardingState>(
                  listener: (context, state) {
                    if (state is VerifyOtpLoadingState) {
                      _isLoading = true;
                    }
                    if (state is VerifyOtpSuccessState) {
                      _isLoading = false;
                      // CustomNavigator.pushReplace(context, AppPages.dashboardPage);
                    }
                    if (state is VerifyOTPErrorState) {
                      _isLoading = false;
                      UIHelper.hideKeyboard();
                      UIHelper.showToast(
                          msg: state.error, type: ToastType.Error);
                    }
                  },
                  child: GestureDetector(
                      onTap: () => Utils.dismissKeypad(context),
                      child: Scaffold(
                        body: Padding(
                          padding: const EdgeInsets.all(
                              VALUE_STANDARD_SCREEN_PADDING),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomSpacers.height30,
                              CustombackButton(onTap: () {
                                Navigator.pop(context);
                              }),
                              CustomSpacers.height30,
                              _buildText(),

                              _buildResendTimerText(),
                              CustomSpacers.height20,
                              _buildOtpField(),
                              CustomSpacers.height20,
                              _buildResendOtpText(),
                              const Spacer(),
                              // BlocBuilder<OnboardingBloc, OnboardingState>(
                              //   builder: (context, state) {
                              //     return CustomButton(
                              //         isLoading: _isLoading,
                              //         strButtonText: "Verify",
                              //         buttonAction: () {
                              //           _verifyOtp();
                              //         });
                              //   },
                              // )
                              _buildLoginActionButtons(context),
                              CustomSpacers.height12,
                              AllRightReserved(),
                            ],
                          ),
                        ),
                      )));
            }));
  }

  Widget _buildResendOtpText() {
    return Align(
      alignment: Alignment.centerRight,
      child: Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: "Didn't Receive?",
              style: AppTextStyles.defaultTextStyle15_400,
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = _resendOtp,
              text: " Resend OTP",
              style: AppTextStyles.defaultTextStyle15_400_PRIMARY,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResendTimerText() {
    return Align(
      alignment: Alignment.centerRight,
      child: TweenAnimationBuilder<Duration>(
        duration: VALUE_RESEND_OTP_WAIT_DURATION,
        tween: Tween(begin: VALUE_RESEND_OTP_WAIT_DURATION, end: Duration.zero),
        onEnd: () {
          // _blocReference.add(OTPTimerEndEvent());
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final seconds = (value.inSeconds % 60) + 1;
          return Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Expires in",
                  style: AppTextStyles.defaultTextStyle15_400,
                ),
                TextSpan(
                  text: " 00:$seconds",
                  style: AppTextStyles.defaultTextStyle15_400_PRIMARY,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _buildOtpField() => SizedBox(
        height: 50,
        child: PinFieldAutoFill(
          controller: _otpController,

          decoration: BoxLooseDecoration(
            strokeColorBuilder: FixedColorBuilder(
              AppColors.black.withOpacity(0.3),
            ),
            textStyle: const TextStyle(fontSize: 20, color: AppColors.black),
          ),
          //currentCode: "1235",
          codeLength: 4,

          onCodeSubmitted: (code) {},
          onCodeChanged: (code) {
            if (code!.length == 4) {
              FocusScope.of(context).requestFocus(FocusNode());
              // _verifyOtp();
            }
          },
        ),
      );

  Widget _buildText() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("OTP Verification",
              style: AppTextStyles.textStyleHeebo30w800Primary),
          CustomSpacers.height10,
          Text(
            "Enter the verification code we just sent on your registered mobile.",
            style: AppTextStyles.defaultTextStyle.copyWith(fontSize: 16.h),
          ),
          CustomSpacers.height30,
        ],
      );
  _buildLoginActionButtons(context) => Column(
        children: [
          CustomButton(
              strButtonText: "Verify",
              isLoading: _isLoading,
              buttonAction: () {
                if (_otpController.text.isNotEmpty) {
                  _bloc.add(VerifyOtpEvent(
                      verifyOtpEntity: VerifyOtpEntity(
                          otp: _otpController.text.toString(),
                          phone: _phoneNumber.toString())));
                }
              }),
        ],
      );
}
