import 'dart:math';

import 'package:new_fundamental_submission/data/api/api.dart';
import 'package:new_fundamental_submission/service/local_notification_service.dart';
import 'package:new_fundamental_submission/static/constant/work_manager.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == WorkManagerType.periodicRestaurantFetch.key) {
        final api = Api();
        final result = await api.getListRestaurant();

        final randomRestaurant =
            result.restaurants[Random().nextInt(result.count - 1)];

        await (LocalNotificationService()
              ..init()
              ..configureLocalTimeZone())
            .showWorkManagerNotification(body: randomRestaurant.name);
      }
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  });
}

class WorkmanagerService {
  final Workmanager _workmanager;

  WorkmanagerService([Workmanager? workmanager])
    : _workmanager = workmanager ??= Workmanager();

  Future<void> init() async {
    await _workmanager.initialize(callbackDispatcher);
  }

  Future<void> schedulePeriodicRestaurantFetch() async {
    await _workmanager.registerPeriodicTask(
      WorkManagerType.periodicRestaurantFetch.key,
      WorkManagerType.periodicRestaurantFetch.key,
      frequency: const Duration(hours: 24),
      initialDelay: _calculateDelayUntil11AM(),
      constraints: Constraints(networkType: NetworkType.connected),
      existingWorkPolicy: ExistingPeriodicWorkPolicy.replace,
    );
  }

  Duration _calculateDelayUntil11AM() {
    final now = DateTime.now();
    var scheduledTime = DateTime(now.year, now.month, now.day, 11, 0, 0);

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    return scheduledTime.difference(now);
  }

  Future<void> cancelAllTask() async {
    await _workmanager.cancelAll();
  }
}
