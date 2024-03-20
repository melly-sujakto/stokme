import 'dart:async';

import 'package:feature_dashboard/domain/navigation/usecase/dashboard_usecase.dart';
import 'package:module_common/package/bluetooth_print.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'more_event.dart';
part 'more_state.dart';

class MoreBloc extends BaseBloc<MoreEvent, MoreState> {
  final DashboardUsecase dashboardUsecase;

  MoreBloc(
    this.dashboardUsecase,
  ) : super(MoreInitial()) {
    on<LogoutEvent>(_onLogoutEvent);
    on<PrepareMoreDataEvent>(_onPrepareMoreDataEvent);
    on<ResetDefaultPrinter>(_onResetDefaultPrinter);
    on<SetDefaultPrinter>(_onSetDefaultPrinter);
    on<SetAlwaysUseCameraAsScanner>(_onSetAlwaysUseCameraAsScanner);
  }

  List<BluetoothDevice> availablePrinters = [];
  BluetoothDevice? defaultPrinter;
  bool alwaysUseCameraAsScanner = false;

  FutureOr<void> _onPrepareMoreDataEvent(
    PrepareMoreDataEvent event,
    emit,
  ) async {
    availablePrinters = await dashboardUsecase.scanAvailablePrinters();
    defaultPrinter = await dashboardUsecase.getDefaultPrinter();
    alwaysUseCameraAsScanner =
        await dashboardUsecase.getFlagScannerCamera() ?? false;
    emit(
      MoreDataLoaded(
        devices: availablePrinters,
        defaultDevice: defaultPrinter,
        alwaysUseCameraAsScanner: alwaysUseCameraAsScanner,
      ),
    );
  }

  FutureOr<void> _onSetDefaultPrinter(
    SetDefaultPrinter event,
    emit,
  ) async {
    await dashboardUsecase.setDefaultPrinter(event.device);
    defaultPrinter = event.device;
    emit(
      MoreDataLoaded(
        devices: availablePrinters,
        defaultDevice: defaultPrinter,
        alwaysUseCameraAsScanner: alwaysUseCameraAsScanner,
      ),
    );
  }

  FutureOr<void> _onResetDefaultPrinter(
    ResetDefaultPrinter event,
    emit,
  ) async {
    await dashboardUsecase.resetDefaultPrinter();
    defaultPrinter = null;
    emit(
      MoreDataLoaded(
        devices: availablePrinters,
        defaultDevice: defaultPrinter,
        alwaysUseCameraAsScanner: alwaysUseCameraAsScanner,
      ),
    );
  }

  FutureOr<void> _onSetAlwaysUseCameraAsScanner(
    SetAlwaysUseCameraAsScanner event,
    emit,
  ) async {
    await dashboardUsecase.setFlagScannerCamera(event.value);
    alwaysUseCameraAsScanner = event.value;
    emit(
      MoreDataLoaded(
        devices: availablePrinters,
        defaultDevice: defaultPrinter,
        alwaysUseCameraAsScanner: alwaysUseCameraAsScanner,
      ),
    );
  }

  FutureOr<void> _onLogoutEvent(
    LogoutEvent event,
    emit,
  ) async {
    try {
      await dashboardUsecase.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailed());
    }
  }
}
