import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../features/home/domain/models/customer.dart';
import '../../features/home/domain/models/reminder_frequency.dart';

const _kChannelId   = 'reminder_channel';
const _kChannelName = 'Payment Reminders';
const _kHour        = 9; // 9:00 AM local time

final _plugin = FlutterLocalNotificationsPlugin();

abstract final class ReminderScheduler {
  /// Call once at app start. Initialises the plugin and reschedules every
  /// active reminder (handles reinstall / notification loss).
  static Future<void> init(List<Customer> customers) async {
    tz.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios     = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    for (final c in customers) {
      final hasDate = c.reminderDate != null && c.reminderDate!.isAfter(DateTime.now());
      if (hasDate || c.reminderFrequency != ReminderFrequency.none) {
        await scheduleForCustomer(c);
      }
    }
  }

  /// Registers (or re-registers) a notification for [customer].
  ///
  /// Pass [notifTitle] and [notifBody] as localized strings from the caller
  /// when a [BuildContext] is available. Falls back to English when called
  /// from non-UI contexts (e.g. background reschedule on app start).
  ///
  /// - If [reminderDate] is set: one-shot on that date at 9 AM.
  /// - Otherwise uses [reminderFrequency] for recurring.
  static Future<void> scheduleForCustomer(
    Customer customer, {
    String? notifTitle,
    String? notifBody,
  }) async {
    final id = _notifId(customer.id);
    await _plugin.cancel(id);

    final hasDate = customer.reminderDate != null &&
        customer.reminderDate!.isAfter(DateTime.now());
    final hasFreq = customer.reminderFrequency != ReminderFrequency.none;

    if (!hasDate && !hasFreq) return;

    final now     = tz.TZDateTime.now(tz.local);
    final balance = customer.netBalance.abs().toStringAsFixed(0);
    final title   = notifTitle ?? 'Payment Reminder';
    final body    = notifBody  ?? '${customer.name} owes ₹$balance — tap to send reminder';

    final android = AndroidNotificationDetails(
      _kChannelId,
      _kChannelName,
      importance: Importance.defaultImportance,
      priority:   Priority.defaultPriority,
    );
    const ios = DarwinNotificationDetails();
    final details = NotificationDetails(android: android, iOS: ios);

    if (hasDate) {
      final d = customer.reminderDate!;
      final scheduled = tz.TZDateTime(
        tz.local, d.year, d.month, d.day, d.hour,
      );
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        scheduled,
        details,
        payload: customer.id,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
      return;
    }

    // Recurring path
    final scheduled = tz.TZDateTime(
      tz.local,
      now.year, now.month, now.day,
      _kHour,
    ).add(Duration(days: customer.reminderFrequency.days));

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduled,
      details,
      payload:            customer.id,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: _repeat(customer.reminderFrequency),
    );
  }

  /// Cancels any scheduled notification for [customerId].
  static Future<void> cancelForCustomer(String customerId) =>
      _plugin.cancel(_notifId(customerId));

  /// Requests notification permission contextually (call when user sets first reminder).
  /// Returns true if granted (or platform doesn't require explicit grant).
  static Future<bool> requestPermissions() async {
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      final granted = await ios.requestPermissions(
        alert: true,
        sound: true,
        badge: true,
      );
      return granted ?? false;
    }
    if (Platform.isAndroid) {
      final status = await Permission.notification.request();
      return status.isGranted;
    }
    return true;
  }

  /// Returns the plugin instance so [main.dart] can set tap callbacks.
  static FlutterLocalNotificationsPlugin get plugin => _plugin;

  // Stable 32-bit int from UUID string.
  static int _notifId(String id) => id.hashCode & 0x7FFFFFFF;

  static DateTimeComponents? _repeat(ReminderFrequency freq) =>
      switch (freq) {
        ReminderFrequency.weekly      => DateTimeComponents.dayOfWeekAndTime,
        ReminderFrequency.fortnightly => null, // manual reschedule on next open
        ReminderFrequency.monthly     => DateTimeComponents.dayOfMonthAndTime,
        ReminderFrequency.none        => null,
      };
}
