import 'base_feature_flag.dart';
import 'remote_config_updater.dart';

class StringFeatureFlag extends BaseFeatureFlag<String?> {
  StringFeatureFlag({
    required super.key,
    required super.initialValue,
    super.isRealtime,
  });

  @override
  void syncValue(RemoteConfigUpdater configUpdater) {
    if (configUpdater.existsOnRemote(key)) {
      final remoteValue = configUpdater.getString(key);

      notifier.value = remoteValue;
    }
  }
}
