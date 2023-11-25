part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class UserloggedIn extends LoginState {}

final class UserloggedOut extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginFailed extends LoginState {}
