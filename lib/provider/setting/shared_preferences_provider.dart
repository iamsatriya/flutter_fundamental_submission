import 'package:flutter/widgets.dart';
import 'package:new_fundamental_submission/data/model/setting.dart';
import 'package:new_fundamental_submission/service/shared_preferences_service.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  SharedPreferencesProvider(this._service);

  String _message = '';
  String get message => _message;

  Setting? _setting;
  Setting? get setting => _setting;

  Future<void> saveSettingValue(Setting setting) async {
    try {
      await _service.saveSettingValue(setting);
      _message = 'Success to save your data';
    } catch (e) {
      _message = 'Failed to save your data';
    } finally {
      notifyListeners();
    }
  }

  void getSettingValue() {
    try {
      _setting = _service.getSettingValue();
      _message = 'Success to get data';
    } catch (e) {
      _message = 'Failed to get your data';
    } finally {
      notifyListeners();
    }
  }
}
