import 'package:flutter/widgets.dart';
import 'package:new_fundamental_submission/static/state/switch_state.dart';

class SettingStateProvider extends ChangeNotifier {
  SwitchState _themeState = SwitchState.disable;
  SwitchState _scheduledNotificationState = SwitchState.disable;
  SwitchState _scheduleNotificationWithWorkmanagerState = SwitchState.disable;

  SwitchState get themeState => _themeState;

  set themeState(SwitchState value) {
    _themeState = value;
    notifyListeners();
  }

  SwitchState get scheduledNotificationState => _scheduledNotificationState;

  set scheduledNotificationState(SwitchState value) {
    _scheduledNotificationState = value;
    notifyListeners();
  }

  SwitchState get scheduleNotificationWithWorkmanagerState =>
      _scheduleNotificationWithWorkmanagerState;

  set scheduleNotificationWithWorkmanagerState(SwitchState value) {
    _scheduleNotificationWithWorkmanagerState = value;
    notifyListeners();
  }
}
