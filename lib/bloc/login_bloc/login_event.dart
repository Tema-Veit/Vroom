part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class InitialLogin extends LoginEvent {
  final BuildContext context;
  const InitialLogin({required this.context});
}

class LoadMobileForm extends LoginEvent {}

class LoadOtpForm extends LoginEvent {
  final String phoneNumber;
  const LoadOtpForm({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class VerificationAttempt extends LoginEvent {
  final String otpCode;
  final BuildContext context;
  const VerificationAttempt({required this.otpCode, required this.context});

  @override
  List<Object> get props => [otpCode, context];
}

class LogOut extends LoginEvent {
  final BuildContext context;
  const LogOut({required this.context});
}
