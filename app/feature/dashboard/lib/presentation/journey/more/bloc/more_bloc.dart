import 'dart:async';

import 'package:feature_dashboard/domain/navigation/usecase/dashboard_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'more_event.dart';
part 'more_state.dart';

class MoreBloc extends BaseBloc<MoreEvent, MoreState> {
  final DashboardUsecase dashboardUsecase;

  MoreBloc(
    this.dashboardUsecase,
  ) : super(MoreInitial()) {
    on<LogoutEvent>(_onLogoutEvent);
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
