// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'KhataPro';

  @override
  String get appTagline => 'KHATAPRO DIGITAL BAHI KHATA';

  @override
  String get onboardingNext => 'Next';

  @override
  String get languageScreenTitle => 'Select Language';

  @override
  String get languageScreenSubtitle =>
      'Choose your preferred language to continue';

  @override
  String get languageActive => 'Active';

  @override
  String get themeScreenTitle => 'Choose Your Theme';

  @override
  String get themeScreenSubtitle =>
      'Choose your workspace vibe. You can change this later in settings.';

  @override
  String get themeLightLabel => 'Light Mode';

  @override
  String get themeDarkLabel => 'Dark Mode';

  @override
  String get themeSystemLabel => 'System Default';

  @override
  String get themeActive => 'Active';

  @override
  String get shopScreenTitle => 'Your Shop Details';

  @override
  String get shopScreenSubtitle =>
      'Tell us about your business so we can personalise your experience.';

  @override
  String get shopNameLabel => 'Shop / Business Name';

  @override
  String get shopNameHint => 'e.g. Sharma General Store';

  @override
  String get shopBusinessTypeLabel => 'Business Type';

  @override
  String get businessTypeRetail => 'Retail Shop';

  @override
  String get businessTypeWholesale => 'Wholesale';

  @override
  String get businessTypeServices => 'Services';

  @override
  String get businessTypeRestaurant => 'Restaurant / Dhaba';

  @override
  String get businessTypePharmacy => 'Pharmacy';

  @override
  String get businessTypeOther => 'Other';

  @override
  String get permissionsScreenTitle => 'App Permissions';

  @override
  String get permissionsScreenSubtitle =>
      'We only ask for permissions we truly need. You can change these anytime in Settings.';

  @override
  String get permissionsAllow => 'Allow & Continue';

  @override
  String get permissionsSkip => 'Skip for now';

  @override
  String get permissionNotificationsTitle => 'Notifications';

  @override
  String get permissionNotificationsDesc => 'Payment reminders, due alerts';

  @override
  String get permissionNotificationsWhy => 'Never miss a collection';

  @override
  String get permissionContactsTitle => 'Contacts';

  @override
  String get permissionContactsDesc => 'Quickly add customers from phonebook';

  @override
  String get permissionContactsWhy => 'Faster customer onboarding';

  @override
  String get permissionSmsTitle => 'SMS (optional)';

  @override
  String get permissionSmsDesc => 'Auto-read payment confirmations';

  @override
  String get permissionSmsWhy => 'Reduce manual entry';
}
