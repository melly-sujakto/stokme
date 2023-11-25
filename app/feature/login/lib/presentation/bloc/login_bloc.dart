import 'dart:async';

import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final FirebaseLibrary firebaseLibrary;

  LoginBloc(
    this.firebaseLibrary,
  ) : super(LoginInitial()) {
    on<CheckLoginStatusEvent>(_onCheckLoginStatusEvent);
    on<SubmitEmailAndPasswordEvent>(_onSubmitEmailAndPasswordEvent);
  }

  FutureOr<void> _onSubmitEmailAndPasswordEvent(
    SubmitEmailAndPasswordEvent event,
    emit,
  ) async {
    try {
      await firebaseLibrary.auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailed());
    }
  }

  FutureOr<void> _onCheckLoginStatusEvent(
    CheckLoginStatusEvent event,
    emit,
  ) async {
    try {
      final user = firebaseLibrary.auth.currentUser;
      if (user == null) {
        emit(UserloggedOut());
        return;
      }
      emit(UserloggedIn());
    } catch (e) {
      emit(UserloggedOut());
    }
  }
}
