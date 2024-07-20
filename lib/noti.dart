import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    tz.initializeTimeZones();
    _initializeNotifications();
  }

  void _initializeNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _selectNotification);

    _scheduleMinuteNotifications();
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Handle notification tapped logic here
  }

  void _selectNotification(String? payload) {
    // Handle notification tapped logic here
    // If you need to perform async operations, use a separate async function
    if (payload != null) {
      // For example, navigate to a specific screen
      print('Notification payload: $payload');
    }
  }

  void _scheduleMinuteNotifications() {
    final List<String> subjects = [
      'IOT',
      'DE',
      'CN',
      'CD',
      'ML/CP Practical',
      'Mini Project2'
    ];

    for (int i = 0; i < subjects.length; i++) {
      _scheduleNotification(i, subjects[i], i + 1);
    }
  }

  void _scheduleNotification(int id, String subject, int minuteOffset) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduledDate = now.add(Duration(minutes: 1));
    const styleInformation = DefaultStyleInformation(true, true);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        '<b> Hey Student </b>',
        'It\'s time for your $subject lesson!',
        scheduledDate,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'minute_notification_channel',
                'Minute Notifications',
                channelDescription:
                'This channel is used for minute notifications.',
                importance: Importance.max,
                priority: Priority.high,
                styleInformation: styleInformation,
                showWhen: false)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  void scheduleImmediateNotification() async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime scheduledDate = now.add(Duration(seconds: 2));
    const styleInformation = DefaultStyleInformation(true, true);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        111,
        '<b> Hey Student </b>',
        'You\'re not in lecture, go to lecture',
        scheduledDate,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'minute_notification_channel',
                'Minute Notifications',
                channelDescription:
                'This channel is used for minute notifications.',
                importance: Importance.max,
                priority: Priority.high,
                styleInformation: styleInformation,
                showWhen: false)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}
