import 'package:caredoot/core/constants/usecase/usecase_interface.dart';
import 'package:equatable/equatable.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class InitialOTPState extends OnboardingState {}

class OTPSendingState extends OnboardingState {}

class OTPSentState extends OnboardingState {}

class OTPErrorState extends OnboardingState {
  final String error;

  const OTPErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class VerifyOtpLoadingState extends OnboardingState {}

class VerifyOtpSuccessState extends OnboardingState {}

class VerifyOTPErrorState extends OnboardingState {
  final String error;

  const VerifyOTPErrorState(this.error);

  @override
  List<Object> get props => [error];
}
