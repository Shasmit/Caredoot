import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/value_constants.dart';
import '../../../../core/helpers/ui_helpers.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  OnboardingBloc({required this.sendOtpUseCase, required this.verifyOtpUseCase})
      : super(InitialOTPState()) {
    on<SendOtpEvent>(
      (event, emit) async {
        UIHelper.showLoader();
        emit(OTPSendingState());
        final result = await sendOtpUseCase(event.entity);
        UIHelper.hideLoader();
        result.fold((failure) {
          UIHelper.showToast(msg: failure.toString(), type: ToastType.Error);
          emit(OTPErrorState(failure.toString()));
        }, (loaded) {
          emit(OTPSentState());
        });
      },
    );

    on<VerifyOtpEvent>(
      (event, emit) async {
        UIHelper.showLoader();
        emit(VerifyOtpLoadingState());
        final result = await verifyOtpUseCase(event.verifyOtpEntity);
        UIHelper.hideLoader();
        result.fold((failure) {
          UIHelper.showToast(msg: failure.toString(), type: ToastType.Error);
          emit(VerifyOTPErrorState(failure.toString()));
        }, (loaded) {
          emit(VerifyOtpSuccessState());
        });
      },
    );
  }
}
