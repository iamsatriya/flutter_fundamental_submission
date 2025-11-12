import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/data/model/setting.dart';
import 'package:new_fundamental_submission/provider/main/local_notification_provider.dart';
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
                  value: value.themeState.isEnable,
                  onChanged: (val) async {
                    final settingStateProvider = context
                        .read<SettingStateProvider>();
                    final sharedPreferencesProvider = context
                        .read<SharedPreferencesProvider>();

                    settingStateProvider.themeState = val.isEnable;

                    await sharedPreferencesProvider.saveSettingValue(
                      Setting(
                        darkmode: val,
                        scheduledNotification:
                            value.scheduledNotificationState.isEnable,
                      ),
                    );

                    sharedPreferencesProvider.getSettingValue();
                  },
                );
              },
            ),
            Text('Schedule Notification', textAlign: TextAlign.center),
            Consumer<SettingStateProvider>(
              builder: (context, value, child) {
                return Switch(
                  value: value.scheduledNotificationState.isEnable,
                  onChanged: (val) async {
                    final settingStateProvider = context
                        .read<SettingStateProvider>();
                    final sharedPreferencesProvider = context
                        .read<SharedPreferencesProvider>();
                    final localNotificationProvider = context
                        .read<LocalNotificationProvider>();

                    settingStateProvider.scheduledNotificationState =
                        val.isEnable;

                    await sharedPreferencesProvider.saveSettingValue(
                      Setting(
                        scheduledNotification: val,
                        darkmode: value.themeState.isEnable,
                      ),
                    );

                    if (val) {
                      localNotificationProvider
                          .scheduleDailyElevenAmNotification();
                    } else {
                      await localNotificationProvider.cancelScheduledNotification();
                    }

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
