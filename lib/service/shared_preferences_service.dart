import 'package:new_fundamental_submission/data/model/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _sharedPreferences;

  SharedPreferencesService(this._sharedPreferences);

  static const String _keyDarkmode = 'FOOD_APP_DARKMODE_KEY';

  Future<void> saveSettingValue(Setting setting) async {
    try {
      await _sharedPreferences.setBool(_keyDarkmode, setting.darkmode);
    } catch (e) {
      throw Exception('Shared preferences cannot save the setting value.');
    }
  }

  Setting getSettingValue() {
    return Setting(darkmode: _sharedPreferences.getBool(_keyDarkmode) ?? false);
  }
}
