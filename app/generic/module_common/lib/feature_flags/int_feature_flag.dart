import 'base_feature_flag.dart';
import 'remote_config_updater.dart';

class IntFeatureFlag extends BaseFeatureFlag<int> {
  IntFeatureFlag({
    required super.key,
    required super.initialValue,
    super.isRealtime,
  });

  @override
  void syncValue(RemoteConfigUpdater configUpdater) {
    if (configUpdater.existsOnRemote(key)) {
      final remoteValue = configUpdater.getInt(key);

      notifier.value = remoteValue;
    }
  }
}
