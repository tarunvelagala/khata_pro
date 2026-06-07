import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../features/home/domain/models/reminder_frequency.dart';

const _kDefaultReminderKey = 'default_reminder_frequency';

final reminderSettingsProvider =
    AsyncNotifierProvider<ReminderSettingsNotifier, ReminderFrequency>(
  ReminderSettingsNotifier.new,
);

class ReminderSettingsNotifier extends AsyncNotifier<ReminderFrequency> {
  @override
  Future<ReminderFrequency> build() async {
    final prefs = await SharedPreferences.getInstance();
    return ReminderFrequency.fromString(prefs.getString(_kDefaultReminderKey));
  }

  Future<void> setFrequency(ReminderFrequency freq) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kDefaultReminderKey, freq.toDbString());
    state = AsyncData(freq);
  }
}
