import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

Future<void> createTaskScheduledReminder({
  required String bodyText,
  required String buttonText,
  required int yearText,
  required int dayText,
  required int monthText,
  required int hourText,
  required int minuteText,
}) async {
  String timezone = await AwesomeNotifications().getLocalTimeZoneIdentifier();

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _createUniqueId(),
        channelKey: 'scheduled_channel',
        title: 'Tasks',
        body: bodyText,
        backgroundColor: const Color(0xff5F33E1),
        notificationLayout: NotificationLayout.Default,
        category: NotificationCategory.Reminder,
      ),
      actionButtons: [
        NotificationActionButton(
          key: buttonText.toUpperCase(),
          label: buttonText,
        ),
      ],
      schedule: NotificationCalendar(
        allowWhileIdle: true,
        year: yearText,
        month: monthText,
        day: dayText,
        hour: hourText,
        minute: minuteText,
        second: 0,
        millisecond: 0,
        timeZone: timezone,
      ));
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

int _createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}
