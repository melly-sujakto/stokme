import 'dart:async';

import 'package:feature_login/domain/usecase/login_usecase.dart';
import 'package:firebase_library/firebase_library.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final FirebaseLibrary firebaseLibrary;
  final LoginUsecase loginUsecase;

  LoginBloc({
    required this.firebaseLibrary,
    required this.loginUsecase,
  }) : super(LoginInitial()) {
    on<CheckLoginStatusEvent>(_onCheckLoginStatusEvent);
    on<SubmitEmailAndPasswordEvent>(_onSubmitEmailAndPasswordEvent);
  }

  FutureOr<void> _onSubmitEmailAndPasswordEvent(
    SubmitEmailAndPasswordEvent event,
    emit,
  ) async {
    try {
      final userCredential =
          await firebaseLibrary.auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      unawaited(loginUsecase.saveUserCredentialToLocal(userCredential));
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
