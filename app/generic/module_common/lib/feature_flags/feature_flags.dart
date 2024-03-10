import 'base_feature_flag.dart';
import 'bool_feature_flag.dart';
import 'remote_config_updater.dart';

abstract class Features {
  static final enableTransaction = BoolFeatureFlag(
    key: 'feat_enableTransaction_20240309',
    initialValue: false,
  );
  static final enableSupplier = BoolFeatureFlag(
    key: 'feat_enableSupplier_20240310',
    initialValue: false,
  );

  static final List<BaseFeatureFlag<dynamic>> updatableFlags = [
    Features.enableTransaction,
    Features.enableSupplier,
  ];

  static void syncValue(
    RemoteConfigUpdater updater, {
    bool isRealtimeOnly = false,
  }) {
    final flags =
        updatableFlags.where((flag) => !isRealtimeOnly || flag.isRealtime);
    for (final flag in flags) {
      flag.syncValue(updater);
    }
  }
}
