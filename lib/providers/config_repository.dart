import 'package:firebase_remote_config/firebase_remote_config.dart';

class ConfigRepository {
  final FirebaseRemoteConfig _remoteConfig;

  ConfigRepository(this._remoteConfig);

  bool get useRedColor =>
      _remoteConfig.getBool(_ConfigFields.priorityColorSwitcher);

  Future<void> init() async {
    _remoteConfig.setDefaults({
      _ConfigFields.priorityColorSwitcher: true,
    });
    _remoteConfig.onConfigUpdated.listen((event) async {
      await _remoteConfig.activate();

      // Use the new config values here.
    });
  }
}

abstract class _ConfigFields {
  static const priorityColorSwitcher = 'priorityColorSwitcher';
}
