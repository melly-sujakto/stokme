import 'dart:async';

import 'package:feature_login/domain/usecase/login_usecase.dart';
import 'package:module_common/presentation/bloc/base_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;

  LoginBloc(this.loginUsecase) : super(LoginInitial()) {
    on<CheckLoginStatusEvent>(_onCheckLoginStatusEvent);
    on<SubmitEmailAndPasswordEvent>(_onSubmitEmailAndPasswordEvent);
  }

  FutureOr<void> _onSubmitEmailAndPasswordEvent(
    SubmitEmailAndPasswordEvent event,
    emit,
  ) async {
    try {
      await loginUsecase.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      await loginUsecase.saveUserCredentialToLocal(event.email);
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
      final user = await loginUsecase.checkLoginStatus();
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
