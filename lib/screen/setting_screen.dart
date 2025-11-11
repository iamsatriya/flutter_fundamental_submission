import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/data/model/setting.dart';
import 'package:new_fundamental_submission/provider/setting/setting_state_provider.dart';
import 'package:new_fundamental_submission/provider/setting/shared_preferences_provider.dart';
import 'package:new_fundamental_submission/static/state/switch_state.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Dark Mode', textAlign: TextAlign.center),
            Consumer<SettingStateProvider>(
              builder: (context, value, child) {
                return Switch(
                  value: value.switchState.isEnable,
                  onChanged: (val) async {
                    final settingStateProvider = context
                        .read<SettingStateProvider>();
                    final sharedPreferencesProvider = context
                        .read<SharedPreferencesProvider>();

                    settingStateProvider.switchState = val.isEnable;
                    await sharedPreferencesProvider.saveSettingValue(
                      Setting(darkmode: val),
                    );
                    sharedPreferencesProvider.getSettingValue();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
