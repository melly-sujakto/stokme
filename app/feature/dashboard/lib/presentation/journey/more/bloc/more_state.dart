part of 'more_bloc.dart';

sealed class MoreState {}

final class MoreInitial extends MoreState {}

final class LogoutSuccess extends MoreState {}

final class LogoutFailed extends MoreState {}

final class MoreDataLoaded extends MoreState {
  final List<BluetoothDevice> devices;
  final BluetoothDevice? defaultDevice;

  MoreDataLoaded({
    required this.devices,
    this.defaultDevice,
  });
}
