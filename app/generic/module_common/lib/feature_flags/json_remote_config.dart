import 'dart:convert';
import 'base_feature_flag.dart';
import 'remote_config_updater.dart';

class JsonRemoteConfig extends BaseFeatureFlag<List<dynamic>?> {
  JsonRemoteConfig({
    required super.key,
    required super.initialValue,
    super.isRealtime,
  });

  @override
  void syncValue(RemoteConfigUpdater configUpdater) {
    if (configUpdater.existsOnRemote(key)) {
      final value = configUpdater.getString(key);
      if (value.isNotEmpty) {
        notifier.value = json.decode(value);
      }
    }
  }
}
