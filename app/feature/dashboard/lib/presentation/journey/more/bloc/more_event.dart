part of 'more_bloc.dart';

sealed class MoreEvent {}

final class LogoutEvent extends MoreEvent {}

final class PrepareMoreDataEvent extends MoreEvent {}

final class ResetDefaultPrinter extends MoreEvent {}

final class SetDefaultPrinter extends MoreEvent {
  final BluetoothDevice device;

  SetDefaultPrinter(this.device);
}
