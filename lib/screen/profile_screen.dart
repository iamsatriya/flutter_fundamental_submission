import 'package:flutter/material.dart';
import 'package:new_fundamental_submission/data/model/setting.dart';
import 'package:new_fundamental_submission/provider/main/local_notification_provider.dart';
import 'package:new_fundamental_submission/provider/main/user_provider.dart';
import 'package:new_fundamental_submission/provider/setting/setting_state_provider.dart';
import 'package:new_fundamental_submission/provider/setting/shared_preferences_provider.dart';
import 'package:new_fundamental_submission/service/workmanager_service.dart';
import 'package:new_fundamental_submission/static/state/switch_state.dart';
import 'package:new_fundamental_submission/widget/app_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<SettingStateProvider>(
            builder: (context, settingValue, child) {
              return Consumer<UserProvider>(
                builder: (context, value, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        'Profile',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 16),
                      if (value.isLoggedIn)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(value.user?.name ?? '-'),
                            Text(value.user?.email ?? '-'),
                          ],
                        )
                      else
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Log in and start planning your next lunch'),
                            const SizedBox(height: 16),
                            AppButton(
                              onPressed: () {},
                              type: AppButtonType.secondary,
                              child: Text('Log in or sign up'),
                            ),
                          ],
                        ),
                      const SizedBox(height: 8),
                      Divider(color: Colors.black12),
                      ListTile(
                        leading: Icon(Icons.dark_mode_outlined),
                        title: Text('Dark Mode'),
                        trailing: Switch(
                          value: settingValue.themeState.isEnable,
                          onChanged: (val) async {
                            final settingStateProvider = context
                                .read<SettingStateProvider>();
                            final sharedPreferencesProvider = context
                                .read<SharedPreferencesProvider>();

                            settingStateProvider.themeState = val.isEnable;

                            await sharedPreferencesProvider.saveSettingValue(
                              Setting(
                                darkmode: val,
                                scheduledNotification: settingValue
                                    .scheduledNotificationState
                                    .isEnable,
                                scheduleNotificationWithWorkmanagerState:
                                    settingValue
                                        .scheduleNotificationWithWorkmanagerState
                                        .isEnable,
                              ),
                            );
                            sharedPreferencesProvider.getSettingValue();
                          },
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications_outlined),
                        title: Text('Schedule Notification'),
                        trailing: Switch(
                          value:
                              settingValue.scheduledNotificationState.isEnable,
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
                                darkmode: settingValue.themeState.isEnable,
                                scheduleNotificationWithWorkmanagerState:
                                    settingValue
                                        .scheduleNotificationWithWorkmanagerState
                                        .isEnable,
                              ),
                            );

                            if (val) {
                              localNotificationProvider
                                  .scheduleDailyElevenAmNotification();
                            } else {
                              await localNotificationProvider
                                  .cancelScheduledNotification();
                            }

                            sharedPreferencesProvider.getSettingValue();
                          },
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.notification_important_outlined),
                        title: Text('Notification with Workmanager'),
                        trailing: Switch(
                          value: settingValue
                              .scheduleNotificationWithWorkmanagerState
                              .isEnable,
                          onChanged: (val) async {
                            final settingStateProvider = context
                                .read<SettingStateProvider>();
                            final sharedPreferencesProvider = context
                                .read<SharedPreferencesProvider>();
                            final workmanagerService = context
                                .read<WorkmanagerService>();

                            settingStateProvider
                                    .scheduleNotificationWithWorkmanagerState =
                                val.isEnable;

                            await sharedPreferencesProvider.saveSettingValue(
                              Setting(
                                scheduleNotificationWithWorkmanagerState: val,
                                darkmode: settingValue.themeState.isEnable,
                                scheduledNotification: settingValue
                                    .scheduledNotificationState
                                    .isEnable,
                              ),
                            );

                            if (val) {
                              workmanagerService
                                  .schedulePeriodicRestaurantFetch();
                            } else {
                              await workmanagerService.cancelAllTask();
                            }

                            sharedPreferencesProvider.getSettingValue();
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
