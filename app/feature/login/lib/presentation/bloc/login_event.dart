part of 'login_bloc.dart';

sealed class LoginEvent {}

final class SubmitEmailAndPasswordEvent extends LoginEvent {
  final String email;
  final String password;

  SubmitEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
}

final class CheckLoginStatusEvent extends LoginEvent {}
