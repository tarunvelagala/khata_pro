import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';

abstract final class DateFormatter {
  /// Relative timestamp for transaction list tiles.
  ///
  /// < 60 min  → "5m ago"
  /// same day  → "Today 2:30 PM"
  /// yesterday → "Yesterday 2:30 PM"
  /// older     → "14 Jan, 2:30 PM"
  static String relativeTime(DateTime dt, AppLocalizations l10n) {
    final now    = DateTime.now();
    final diff   = now.difference(dt);
    final locale = l10n.localeName;
    if (diff.inMinutes < 60) return l10n.txnTimeMinutesAgo(diff.inMinutes);
    if (diff.inHours < 24)   return l10n.txnTimeToday(DateFormat.jm(locale).format(dt));
    if (diff.inDays == 1)    return l10n.txnTimeYesterday(DateFormat.jm(locale).format(dt));
    return DateFormat('d MMM, hh:mm a', locale).format(dt);
  }

  /// Day-group label for the customer detail screen date headers.
  ///
  /// today     → "Today"
  /// yesterday → "Yesterday"
  /// older     → "14 January 2025"
  static String dayLabel(DateTime dt, AppLocalizations l10n) {
    final now   = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date  = DateTime(dt.year, dt.month, dt.day);
    final diff  = today.difference(date).inDays;

    if (diff == 0) return l10n.dateToday;
    if (diff == 1) return l10n.dateYesterday;
    return DateFormat('d MMMM yyyy', l10n.localeName).format(dt);
  }
}
