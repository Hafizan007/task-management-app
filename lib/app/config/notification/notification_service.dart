import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../themes/app_color.dart';

@injectable
class NotificationService {
  Future<void> reqPermission() async {
    bool isNotExact = await Permission.scheduleExactAlarm.isDenied;

    final notifStatus = await Permission.notification.status;

    inspect(notifStatus);

    if (notifStatus.isPermanentlyDenied) {
      await openAppSettings();
    } else if (notifStatus.isDenied) {
      await Permission.notification.request();
    }

    if (isNotExact) {
      await Permission.scheduleExactAlarm.request();
    }
  }

  static Future<void> initializenotification() async {
    // Android Platform configuration required to send notifications
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'main_channel',
          channelName: 'Main channel',
          channelDescription: 'Basic channel from basic notification',
          defaultColor: AppColor.primaryColor,
          importance: NotificationImportance.Max,
          ledColor: AppColor.primaryColor,
          channelShowBadge: true,
          locked: true,
          vibrationPattern: highVibrationPattern,
          criticalAlerts: true,
          enableVibration: true,
          playSound: true,
        ),
      ],
      // Channel groups are only visual and are not required

      debug: true,
    );
  }

  @pragma("vm:entry-point")
  Future<void> setNotification({
    required String taskId,
    required String body,
    required DateTime date,
  }) async {
    String channelKey = 'main_channel';
    Map<String, String?>? payload = {
      'taskId': taskId,
    };

    final beforeFiveMinutes = date.subtract(const Duration(minutes: 5));
    print(beforeFiveMinutes);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(2147483647),
        channelKey: channelKey,
        title: 'Task kamu hampir deadline',
        body: '$body akan berakhir dalam 5 menit',
        wakeUpScreen: true,
        category: NotificationCategory.Reminder,
        displayOnForeground: true,
        displayOnBackground: true,
        criticalAlert: true,
        payload: payload,
      ),
      schedule: NotificationCalendar.fromDate(
        date: beforeFiveMinutes,
        allowWhileIdle: true,
        preciseAlarm: true,
      ),
    );
  }

  Future<void> cancleTask(String taskId) async {
    final isNotificationActive =
        await AwesomeNotifications().listScheduledNotifications();

    List<int> notifId = isNotificationActive
        .where((e) => e.content?.payload?['taskId'] == taskId)
        .map((e) => e.content!.id!)
        .toList();

    for (var id in notifId) {
      await AwesomeNotifications().cancel(id);
    }
  }
}
