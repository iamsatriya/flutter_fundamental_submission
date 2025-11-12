import 'package:new_fundamental_submission/data/model/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesService(this._sharedPreferences);

  static const String _keyDarkmode = 'FOOD_APP_DARKMODE_KEY';
  static const String _keyScheduledLunchNotification = 'FOOD_APP_SCHEDULED_KEY';
  static const String _keyScheduledLunchWithWorkManagerNotification =
      'FOOD_APP_SCHEDULED_WORK_MANAGER_KEY';

  Future<void> saveSettingValue(Setting setting) async {
    try {
      await _sharedPreferences.setBool(_keyDarkmode, setting.darkmode);
      await _sharedPreferences.setBool(
        _keyScheduledLunchNotification,
        setting.scheduledNotification,
      );
      await _sharedPreferences.setBool(
        _keyScheduledLunchWithWorkManagerNotification,
        setting.scheduleNotificationWithWorkmanagerState,
      );
    } catch (e) {
      throw Exception('Shared preferences cannot save the setting value.');
    }
  }

  Setting getSettingValue() {
    return Setting(
      darkmode: _sharedPreferences.getBool(_keyDarkmode) ?? false,
      scheduledNotification:
          _sharedPreferences.getBool(_keyScheduledLunchNotification) ?? false,
      scheduleNotificationWithWorkmanagerState:
          _sharedPreferences.getBool(
            _keyScheduledLunchWithWorkManagerNotification,
          ) ??
          false,
    );
  }
}
