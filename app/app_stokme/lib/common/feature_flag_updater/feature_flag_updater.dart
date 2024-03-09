import 'dart:async';

import 'package:module_common/feature_flags/feature_flags.dart';
import 'package:stokme/common/feature_flag_updater/firebase_remote_config/firebase_remote_config_wrapper.dart';
import 'package:stokme/common/injector/injector.dart';

class FeatureFlagUpdater {
  late FirebaseRemoteConfigWrapper firebaseRemoteConfigWrapper;
  bool isInitialized = false;

  Future<void> setup() async {
    await _initialize();
    unawaited(updateAllFlags());
    firebaseRemoteConfigWrapper.onConfigUpdated().listen((event) {
      unawaited(updateAllFlags(isRealtimeOnly: true));
    });
  }

  Future<void> _initialize() async {
    try {
      firebaseRemoteConfigWrapper =
          Injector.resolve<FirebaseRemoteConfigWrapper>();

      await firebaseRemoteConfigWrapper.setConfigSettings(
        fetchTimeout: const Duration(seconds: 5),
        minimumFetchInterval: const Duration(minutes: 1),
      );

      Features.syncValue(firebaseRemoteConfigWrapper);

      isInitialized = true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateAllFlags({bool isRealtimeOnly = false}) async {
    try {
      if (!isInitialized) {
        await _initialize();
      }

      await firebaseRemoteConfigWrapper.fetchAndActivate();

      Features.syncValue(
        firebaseRemoteConfigWrapper,
        isRealtimeOnly: isRealtimeOnly,
      );
    } catch (e) {
      rethrow;
    }
  }
}
