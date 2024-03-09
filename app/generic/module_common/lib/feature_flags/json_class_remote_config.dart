import 'dart:convert';

import 'base_feature_flag.dart';
import 'remote_config_updater.dart';

typedef JsonObjectClassMapper<Clazz> = Clazz? Function(
  Map<String, dynamic> json,
);

class JsonClassRemoteConfig<Clazz> extends BaseFeatureFlag<Clazz?> {
  JsonClassRemoteConfig({
    required super.key,
    required super.initialValue,
    required JsonObjectClassMapper<Clazz> mapper,
    this.ignoreNullChanges = false,
    super.isRealtime,
  }) : _mapper = mapper;

  final JsonObjectClassMapper<Clazz> _mapper;
  final bool ignoreNullChanges;

  @override
  void syncValue(RemoteConfigUpdater configUpdater) {
    if (configUpdater.existsOnRemote(key)) {
      final value = configUpdater.getString(key);
      if (value.isNotEmpty) {
        final Map<String, dynamic> decodedJson = json.decode(value);
        final mappedClass = _mapper(decodedJson);
        if ((mappedClass == null) && ignoreNullChanges) {
          return;
        }
        notifier.value = mappedClass;
      }
    }
  }
}
