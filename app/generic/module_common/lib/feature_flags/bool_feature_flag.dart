import 'base_feature_flag.dart';
import 'remote_config_updater.dart';

class BoolFeatureFlag extends BaseFeatureFlag<bool> {
  BoolFeatureFlag({
    required super.key,
    required super.initialValue,
    super.isRealtime,
  });

  @override
  void syncValue(RemoteConfigUpdater configUpdater) {
    if (configUpdater.existsOnRemote(key)) {
      final remoteValue = configUpdater.getBool(key);

      notifier.value = remoteValue;
    }
  }

  bool get isEnabled => value;
}
