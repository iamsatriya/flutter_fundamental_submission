import 'package:flutter/widgets.dart';
import 'package:new_fundamental_submission/data/model/user.dart';
import 'package:new_fundamental_submission/service/user_shared_preferences_service.dart';

class UserProvider extends ChangeNotifier {
  final UserSharedPreferencesService _userSharedPreferencesService;

  UserProvider(this._userSharedPreferencesService);

  String _message = '';
  String get message => _message;

  User? _user;
  User? get user => _user;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> getCurrentUser() async {
    try {
      _user = await _userSharedPreferencesService.getCurrentUser();
      _message = 'Success get user';
    } catch (e) {
      _message = 'Failed get user';
    } finally {
      notifyListeners();
    }
  }

  Future<void> loggedIn(User user) async {
    try {
      await _userSharedPreferencesService.loggedIn(user);
      _message = 'Success login';
      _isLoggedIn = true;
    } catch (e) {
      _message = 'Failed to login';
    } finally {
      notifyListeners();
    }
  }

  Future<void> loggedOut() async {
    try {
      await _userSharedPreferencesService.loggedOut();
      _message = 'Success logout';
      _isLoggedIn = false;
    } catch (e) {
      _message = 'Failed to logout';
    } finally {
      notifyListeners();
    }
  }
}
