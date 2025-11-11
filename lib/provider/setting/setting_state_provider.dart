import 'package:flutter/widgets.dart';
import 'package:new_fundamental_submission/static/state/switch_state.dart';

class SettingStateProvider extends ChangeNotifier {
  SwitchState _switchState = SwitchState.disable;

  SwitchState get switchState => _switchState;

  set switchState(SwitchState value) {
    _switchState = value;
    notifyListeners();
  }
}
