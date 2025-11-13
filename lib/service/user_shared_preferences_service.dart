import 'package:new_fundamental_submission/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPreferencesService {
  final SharedPreferences _sharedPreferences;

  UserSharedPreferencesService(this._sharedPreferences);

  static const String _keyFullName = 'FOOD_APP_FULL_NAME_KEY';
  static const String _keyEmail = 'FOOD_APP_EMAIL_KEY';
  static const String _keyLoggedIn = 'FOOD_APP_LOGGED_IN_KEY';

  Future<void> loggedIn(User user) async {
    try {
      await _sharedPreferences.setString(_keyFullName, user.name);
      await _sharedPreferences.setString(_keyEmail, user.email);
      await _sharedPreferences.setBool(_keyLoggedIn, true);
    } catch (e) {
      throw Exception('Cannot save app state data');
    }
  }

  Future<void> loggedOut() async {
    try {
      await _sharedPreferences.remove(_keyFullName);
      await _sharedPreferences.remove(_keyEmail);
      await _sharedPreferences.remove(_keyLoggedIn);
    } catch (e) {
      throw Exception('Cannot save app state data');
    }
  }

  Future<User> getCurrentUser() async {
    return User(
      email: _sharedPreferences.getString(_keyEmail) ?? '',
      name: _sharedPreferences.getString(_keyFullName) ?? '',
    );
  }
}
