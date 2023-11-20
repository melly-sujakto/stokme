import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  BaseBloc(S initialState) : super(initialState) {
    stateStream = stream;
  }

  final _toBeExecutedOnClose = <FutureOr Function()>[];

  /// property to get the state stream
  /// since the object constructed
  late final Stream<S> stateStream;

  void doOnClose(FutureOr Function() func) {
    _toBeExecutedOnClose.add(func);
  }

  @override
  @mustCallSuper
  Future<void> close() async {
    if (_toBeExecutedOnClose.isNotEmpty) {
      await Future.wait(
        _toBeExecutedOnClose.map((e) async => await e()).toList(),
      );
    }
    return super.close();
  }
}
