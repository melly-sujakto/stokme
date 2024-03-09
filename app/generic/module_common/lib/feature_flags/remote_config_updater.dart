abstract class RemoteConfigUpdater {
  int getInt(String key);

  bool getBool(String key);

  String getString(String key);

  bool existsOnRemote(String key);
}
