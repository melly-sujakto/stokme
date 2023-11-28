part of 'more_bloc.dart';

sealed class MoreState {}

final class MoreInitial extends MoreState {}
final class LogoutSuccess extends MoreState {}
final class LogoutFailed extends MoreState {}
