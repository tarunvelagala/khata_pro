enum ReminderFrequency {
  none,
  weekly,
  fortnightly,
  monthly;

  int get days => switch (this) {
        none => 0,
        weekly => 7,
        fortnightly => 14,
        monthly => 30,
      };

  static ReminderFrequency fromString(String? s) =>
      values.firstWhere((e) => e.name == s, orElse: () => none);

  String toDbString() => name;
}
