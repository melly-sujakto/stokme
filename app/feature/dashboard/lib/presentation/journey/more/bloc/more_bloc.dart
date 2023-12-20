import 'dart:async';

import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'more_event.dart';
part 'more_state.dart';

class MoreBloc extends BaseBloc<MoreEvent, MoreState> {
  final FirebaseLibrary firebaseLibrary;

  MoreBloc(
    this.firebaseLibrary,
  ) : super(MoreInitial()) {
    on<LogoutEvent>(_onLogoutEvent);
  }
  FutureOr<void> _onLogoutEvent(
    LogoutEvent event,
    emit,
  ) async {
    try {
      // TODO(melly): use usecase and clear shared pref
      await firebaseLibrary.auth.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailed());
    }
  }
}
