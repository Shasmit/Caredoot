// ignore_for_file: unused_field, camel_case_types

import 'package:caredoot/core/app_imports.dart';
import 'package:caredoot/core/helpers/ui_helpers.dart';
import 'package:caredoot/features/onboarding/domain/entities/verify_otp_entity.dart';
import 'package:caredoot/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:caredoot/features/onboarding/presentation/bloc/onboarding_event.dart';
import 'package:caredoot/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:caredoot/ui/injection_container.dart';
import 'package:caredoot/ui/molecules/custom_button.dart';
import 'package:caredoot/ui/molecules/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../domain/entities/send_otp_entity.dart';

String? mobileNumber;

class LoginSheetWidget extends StatefulWidget {
  final Function onSuccess;
  final Function onFailure;
  const LoginSheetWidget(
      {super.key, required this.onSuccess, required this.onFailure});

  @override
  State<LoginSheetWidget> createState() => _LoginSheetWidgetState();
}

class _LoginSheetWidgetState extends State<LoginSheetWidget> {
  static final PageController _pageController = PageController(initialPage: 0);
  static final TextEditingController _mobileNumberController =
      TextEditingController();

  int _currentPage = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    _pages = [
      _buildPage1(
          pageController: _pageController,
          mobileNumberController: _mobileNumberController),
      _buildPage2(
        onSuccess: widget.onSuccess,
        onFailure: widget.onFailure,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SizedBox(
            height: 298.h,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemCount: _pages.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 23),
                  child: _pages[index],
                );
              },
            )));
  }
}

//================================= Page 1 ================================================

// ignore: must_be_immutable, camel_case_types
class _buildPage1 extends StatefulWidget {
  PageController pageController;
  TextEditingController mobileNumberController;
  _buildPage1(
      {required this.pageController, required this.mobileNumberController});

  @override
  State<_buildPage1> createState() => __buildPage1State();
}

class __buildPage1State extends State<_buildPage1> {
  bool isLoading = false;
  final _bloc = sl<OnboardingBloc>();

  @override
  void initState() {
    widget.mobileNumberController = TextEditingController();
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
                  mobileNumber = widget.mobileNumberController.text;
                  isLoading = false;
                  widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                }
                if (state is OTPSendingState) {
                  isLoading = true;
                }
                if (state is OTPErrorState) {
                  isLoading = false;
                  UIHelper.showToast(msg: state.error, type: ToastType.Alert);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  CustomSpacers.height14,
                  _buildForm(),
                  const Spacer(),
                  CustomButton(
                    strButtonText: "Proceed",
                    buttonAction: () {
                      _bloc.add(SendOtpEvent(
                          entity: SendOtpEntity(
                        phoneNumber: widget.mobileNumberController.text,
                      )));
                      // widget.pageController.nextPage(
                      //   duration: const Duration(milliseconds: 500),
                      //   curve: Curves.ease,
                      // );
                    },
                    dHeight: 62.h,
                    dCornerRadius: 8,
                  ),
                  CustomSpacers.height30,
                ],
              ),
            );
          }),
    );
  }

  _buildHeader() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login/Sign Up',
            textAlign: TextAlign.start,
            style: AppTextStyles.textStyleHeebo14w500Secondary
                .copyWith(fontSize: 18),
          ),
          Text('Login to proceed furthur',
              style: AppTextStyles.textStyleHeebo14w500Secondary
                  .copyWith(fontSize: 13, fontWeight: FontWeight.w400))
        ],
      );

  _buildForm() => SizedBox(
        child: CustomTextField(
          controller: widget.mobileNumberController,
          fillColor: const Color.fromARGB(255, 227, 227, 227),
          hint: "Enter Mobile Number",
          keyboardType: TextInputType.phone,
        ),
      );
}

//================================= Page 2 ================================================

// ignore: must_be_immutable
class _buildPage2 extends StatefulWidget {
  final Function onSuccess;
  final Function onFailure;
  const _buildPage2({required this.onSuccess, required this.onFailure});

  @override
  State<_buildPage2> createState() => __buildPage2State();
}

class __buildPage2State extends State<_buildPage2> {
  late TextEditingController _otpController;

  final OnboardingBloc _bloc = sl<OnboardingBloc>();
  bool _isLoading = false;

  // ignore: unused_element
  void _resendOtp() {
    _bloc.add(SendOtpEvent(entity: SendOtpEntity(phoneNumber: mobileNumber!)));
  }

  @override
  void initState() {
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                if (state is VerifyOtpLoadingState) {
                  _isLoading = true;
                  widget.onFailure();
                }
                if (state is VerifyOtpSuccessState) {
                  _isLoading = false;
                  widget.onSuccess();

                  //TODO: Trigger and show all addresses if none move to new address page
                }
                if (state is VerifyOTPErrorState) {
                  _isLoading = false;
                  UIHelper.hideKeyboard();
                  UIHelper.showToast(msg: state.error, type: ToastType.Error);
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      CustomSpacers.height16,
                      _buildForm(),
                      CustomSpacers.height16,
                      _buildResendTimerText()
                    ],
                  ),
                  const Spacer(),
                  CustomButton(
                    strButtonText: "Proceed",
                    buttonAction: () {
                      _verifyOtp();
                    },
                  )
                ],
              ),
            );
          }),
    );
  }

  _verifyOtp() {
    if (_otpController.text.isNotEmpty && mobileNumber != null) {
      _bloc.add(VerifyOtpEvent(
          verifyOtpEntity: VerifyOtpEntity(
              otp: _otpController.text.toString(), phone: mobileNumber!)));
      // CustomNavigator.pushTo(context, AppPages.addAddressPage);
    }
  }

  Widget _buildResendTimerText() {
    return Align(
      alignment: Alignment.centerLeft,
      child: TweenAnimationBuilder<Duration>(
        duration: VALUE_RESEND_OTP_WAIT_DURATION,
        tween: Tween(begin: VALUE_RESEND_OTP_WAIT_DURATION, end: Duration.zero),
        onEnd: () {},
        builder: (BuildContext context, Duration value, Widget? child) {
          final seconds = (value.inSeconds % 60) + 1;
          return Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Resend in",
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

  _buildHeader() => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Verification Code',
              textAlign: TextAlign.start,
              style: AppTextStyles.textStyleHeebo14w500Secondary
                  .copyWith(fontSize: 16),
            ),
            Text('We have sent you a 4 digit code',
                style: AppTextStyles.textStyleHeebo14w500Secondary
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w400))
          ],
        ),
      );

  _buildForm() => SizedBox(
        height: 46.h,
        width: 250.w,
        child: PinFieldAutoFill(
          autoFocus: true,
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
              _verifyOtp();
            }
          },
        ),
      );
}
