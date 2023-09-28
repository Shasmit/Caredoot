class SendOtpEntity {
  String phoneNumber;
  // bool isSignup;

  SendOtpEntity({
    required this.phoneNumber,
    // this.isSignup = false,
  });
  toMap() {
    return {'phone': phoneNumber};
  }
}
