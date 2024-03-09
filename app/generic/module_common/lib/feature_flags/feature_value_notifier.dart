import 'dart:async';

import 'package:flutter/foundation.dart';

typedef ListenFeatureChangeCallback<T> = Function(T value);

class FeatureValueNotifier<T> extends ValueNotifier<T> {
  FeatureValueNotifier(T value) : super(value) {
    _valueStream.add(value);
  }

  final _valueStream = StreamController<T>.broadcast();

  @override
  set value(T newValue) {
    super.value = newValue;
    _valueStream.add(newValue);
  }

  @override
  void dispose() {
    _valueStream.close();
    super.dispose();
  }

  void listen(ListenFeatureChangeCallback<T> callback) {
    addListener(() => callback.call(value));
  }

  Stream<T> get stream {
    return _valueStream.stream;
  }
}
