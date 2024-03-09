import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:module_common/feature_flags/remote_config_updater.dart';

class FirebaseRemoteConfigWrapper extends RemoteConfigUpdater {
  FirebaseRemoteConfig getInstance() {
    return FirebaseRemoteConfig.instance;
  }

  Future<void> setConfigSettings({
    required Duration fetchTimeout,
    required Duration minimumFetchInterval,
  }) async {
    await FirebaseRemoteConfig.instance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: fetchTimeout,
        minimumFetchInterval: minimumFetchInterval,
      ),
    );
  }

  Stream<RemoteConfigUpdate> onConfigUpdated() {
    return FirebaseRemoteConfig.instance.onConfigUpdated;
  }

  @override
  bool getBool(String key) {
    return FirebaseRemoteConfig.instance.getBool(key);
  }

  @override
  int getInt(String key) {
    return FirebaseRemoteConfig.instance.getInt(key);
  }

  @override
  bool existsOnRemote(String key) {
    return FirebaseRemoteConfig.instance.getValue(key).source ==
        ValueSource.valueRemote;
  }

  Future<void> fetchAndActivate() async {
    await FirebaseRemoteConfig.instance.fetchAndActivate();
  }

  Map<String, RemoteConfigValue> getAll() {
    return FirebaseRemoteConfig.instance.getAll();
  }

  @override
  String getString(String key) {
    return FirebaseRemoteConfig.instance.getString(key);
  }
}
