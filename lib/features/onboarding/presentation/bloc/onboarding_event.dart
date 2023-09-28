// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import '../../domain/entities/send_otp_entity.dart';
import '../../domain/entities/verify_otp_entity.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class SendOtpEvent extends OnboardingEvent {
  SendOtpEntity entity;
  SendOtpEvent({required this.entity});
  @override
  // TODO: implement props
  List<Object> get props => [entity];
}

class VerifyOtpEvent extends OnboardingEvent {
  final VerifyOtpEntity verifyOtpEntity;
  const VerifyOtpEvent({required this.verifyOtpEntity});
}
