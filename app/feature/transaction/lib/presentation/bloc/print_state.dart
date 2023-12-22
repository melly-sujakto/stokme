part of 'print_bloc.dart';

sealed class PrintState {}

final class PrintInitial extends PrintState {}

final class PrintLoading extends PrintState {}

final class PrintSuccess extends PrintState {}

final class PrintFailed extends PrintState {}
