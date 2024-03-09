import 'feature_value_notifier.dart';
import 'remote_config_updater.dart';

abstract class BaseFeatureFlag<T> {
  final String key;
  final FeatureValueNotifier<T> notifier;
  final T _initialValue;
  final bool isRealtime;

  BaseFeatureFlag({
    required this.key,
    required T initialValue,
    this.isRealtime = false,
  })  : notifier = FeatureValueNotifier(initialValue),
        _initialValue = initialValue;

  T get value => notifier.value;

  set value(T newValue) {
    notifier.value = newValue;
  }

  void reset() {
    notifier.value = _initialValue;
  }

  void listen(ListenFeatureChangeCallback<T> callback) =>
      notifier.listen(callback);

  void syncValue(RemoteConfigUpdater configUpdater);
}
