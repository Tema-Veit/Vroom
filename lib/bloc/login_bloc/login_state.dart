part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginUpdate extends LoginState {}

class EnteringPhoneNumber extends LoginState {}

class EnteringOtpCode extends LoginState {}

class LoginLoading extends LoginState {}

class SuccessfulLogin extends LoginState {}
