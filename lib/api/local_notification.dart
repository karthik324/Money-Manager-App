import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createFinTracNotification() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: createUniqueId(),
    channelKey: 'basic_channel',
    title: 'jajaja',
    body: 'hahaha',
  ));
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(2);
}

Future<void> reminderNotification() async {
  DateTime scheduleTime = DateTime.now().add(const Duration(days: 1));
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: 'Reminder',
      category: NotificationCategory.Reminder,
      body: "Don't forget to add today's income and expense!",
    ),
    schedule: NotificationCalendar.fromDate(
      date: scheduleTime,
      repeats: true,
    ),
  );

  Future<void> cancelScheduleNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}
