import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:des/Features/Notification/Schedule.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> onActionReceivedMethod(ReceivedAction action) async {
  print('Notification action received: ${action.id}');
}

class NotificationServices {
  static Future<void> initializeNotification() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'flutter_schedule_app_channel',
          channelName: 'Flutter Schedule App Channel',
          channelDescription:
              'This channel is resposible for showing Flutter Schedule App notifications.',
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Public,
          defaultRingtoneType: DefaultRingtoneType.Alarm,
          defaultColor: Colors.transparent,
          locked: true,
          enableVibration: true,
          playSound: true,
        ),
      ],
    );
  }

  static Future<void> cancelAllNotifications() async
   {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     //await prefs.remove('Meditation Reminder');
     //await prefs.remove('DailyMood Rreminder');
     prefs.getString('refreshToken');
    AwesomeNotifications().cancelAll();
  }

  Future<void> cancelNotificationById(String NotificationType)  async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? Notification_id= prefs.getInt(NotificationType);
    AwesomeNotifications().cancel(Notification_id!);
     await prefs.remove(NotificationType);
  }

  Future<void> setupNotifications() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AwesomeNotifications().setListeners(
          onActionReceivedMethod: onActionReceivedMethod,
          onDismissActionReceivedMethod: (ReceivedAction receivedAction) async {
            print("Notification dismissed");
          });
    });
  }

  static Future<int> scheduleNotification(
    Schedule schedule,
  ) async {
    Random random = Random();
    int Notification_id = random.nextInt(1000000) + 1;
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Notification_id,
        channelKey: 'flutter_schedule_app_channel',
        title: "Reminder",
        body: schedule.details,
        category: NotificationCategory.Alarm,
        notificationLayout: NotificationLayout.BigText,
        locked: true,
        wakeUpScreen: true,
        autoDismissible: false,
        fullScreenIntent: true,
        backgroundColor: Colors.transparent,
      ),
      schedule: NotificationCalendar(
        minute: schedule.time.minute,
        hour: schedule.time.hour,
        day: schedule.time.day,
        weekday: schedule.time.weekday,
        month: schedule.time.month,
        year: schedule.time.year,
        preciseAlarm: true,
        allowWhileIdle: true,
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      ),
      actionButtons: [
        NotificationActionButton(
          key: "Close",
          label: "Close Reminder",
          autoDismissible: true,
        ),
      ],
    );
    return Notification_id;
  }

static Future<DateTime?> getNotificationTimeById(String NotificationType) async 
{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? Notification_id = prefs.getInt(NotificationType);
    List<NotificationModel> scheduledNotifications =   await AwesomeNotifications().listScheduledNotifications();
    for (var notification in scheduledNotifications) {
      if (notification.content?.id == Notification_id) 
      { 
        NotificationCalendar? schedule =   notification.schedule as NotificationCalendar?;
        if (schedule != null) {
          return DateTime(
            schedule.year ?? 0,
            schedule.month ?? 1,
            schedule.day ?? 1,
            schedule.hour ?? 0,
            schedule.minute ?? 0,
            schedule.second ?? 0,
          );
        }
      }
    }
    return null;
  }
}
