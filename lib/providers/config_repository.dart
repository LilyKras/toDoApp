import 'package:firebase_remote_config/firebase_remote_config.dart';

// class ConfigRepository {
//   final FirebaseRemoteConfig _remoteConfig;

//   ConfigRepository(this._remoteConfig);

//   bool get useRedColor =>
//       _remoteConfig.getBool(_ConfigFields.priorityColorSwitcher);

//   Future<void> init() async {
//     _remoteConfig.setDefaults({
//       _ConfigFields.priorityColorSwitcher: true,
//     });
//     _remoteConfig.onConfigUpdated.listen((event) async {
//       await _remoteConfig.activate();

//       // Use the new config values here.
//     });
//   }
// }

// abstract class _ConfigFields {
//   static const priorityColorSwitcher = 'priorityColorSwitcher';
// }

class RemoteConfigsService {
  RemoteConfigsService._();

  // [RemoteConfigsService] factory constructor.
  static Future<RemoteConfigsService> create() async {
    final RemoteConfigsService remoteConfigsService = RemoteConfigsService._();
    await remoteConfigsService._init();
    return remoteConfigsService;
  }

  _init() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig
        .setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 5),
      minimumFetchInterval: const Duration(minutes: 1),
    ),)
        .then((value) async {
      await remoteConfig.fetchAndActivate();
    });
  }
}
