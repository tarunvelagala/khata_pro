import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';
import 'app_localizations_ml.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
    Locale('hi'),
    Locale('kn'),
    Locale('ml'),
    Locale('mr'),
    Locale('ta'),
    Locale('te'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'KhataPro'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'KHATAPRO DIGITAL BAHI KHATA'**
  String get appTagline;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @languageScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get languageScreenTitle;

  /// No description provided for @languageScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language to continue'**
  String get languageScreenSubtitle;

  /// No description provided for @languageActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get languageActive;

  /// No description provided for @themeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Theme'**
  String get themeScreenTitle;

  /// No description provided for @themeScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your workspace vibe. You can change this later in settings.'**
  String get themeScreenSubtitle;

  /// No description provided for @themeLightLabel.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get themeLightLabel;

  /// No description provided for @themeDarkLabel.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get themeDarkLabel;

  /// No description provided for @themeSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get themeSystemLabel;

  /// No description provided for @themeActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get themeActive;

  /// No description provided for @shopScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Shop Details'**
  String get shopScreenTitle;

  /// No description provided for @shopScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell us about your business so we can personalise your experience.'**
  String get shopScreenSubtitle;

  /// No description provided for @shopNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Shop / Business Name'**
  String get shopNameLabel;

  /// No description provided for @shopNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Sharma General Store'**
  String get shopNameHint;

  /// No description provided for @shopBusinessTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Business Type'**
  String get shopBusinessTypeLabel;

  /// No description provided for @businessTypeRetail.
  ///
  /// In en, this message translates to:
  /// **'Retail Shop'**
  String get businessTypeRetail;

  /// No description provided for @businessTypeWholesale.
  ///
  /// In en, this message translates to:
  /// **'Wholesale'**
  String get businessTypeWholesale;

  /// No description provided for @businessTypeServices.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get businessTypeServices;

  /// No description provided for @businessTypeRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant / Dhaba'**
  String get businessTypeRestaurant;

  /// No description provided for @businessTypePharmacy.
  ///
  /// In en, this message translates to:
  /// **'Pharmacy'**
  String get businessTypePharmacy;

  /// No description provided for @businessTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get businessTypeOther;

  /// No description provided for @permissionsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'App Permissions'**
  String get permissionsScreenTitle;

  /// No description provided for @permissionsScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We only ask for permissions we truly need. You can change these anytime in Settings.'**
  String get permissionsScreenSubtitle;

  /// No description provided for @permissionsAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow & Continue'**
  String get permissionsAllow;

  /// No description provided for @permissionsSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get permissionsSkip;

  /// No description provided for @permissionNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get permissionNotificationsTitle;

  /// No description provided for @permissionNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Payment reminders, due alerts'**
  String get permissionNotificationsDesc;

  /// No description provided for @permissionNotificationsWhy.
  ///
  /// In en, this message translates to:
  /// **'Never miss a collection'**
  String get permissionNotificationsWhy;

  /// No description provided for @permissionContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Contacts'**
  String get permissionContactsTitle;

  /// No description provided for @permissionContactsDesc.
  ///
  /// In en, this message translates to:
  /// **'Quickly add customers from phonebook'**
  String get permissionContactsDesc;

  /// No description provided for @permissionContactsWhy.
  ///
  /// In en, this message translates to:
  /// **'Faster customer onboarding'**
  String get permissionContactsWhy;

  /// No description provided for @permissionSmsTitle.
  ///
  /// In en, this message translates to:
  /// **'SMS (optional)'**
  String get permissionSmsTitle;

  /// No description provided for @permissionSmsDesc.
  ///
  /// In en, this message translates to:
  /// **'Auto-read payment confirmations'**
  String get permissionSmsDesc;

  /// No description provided for @permissionSmsWhy.
  ///
  /// In en, this message translates to:
  /// **'Reduce manual entry'**
  String get permissionSmsWhy;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'bn',
    'en',
    'hi',
    'kn',
    'ml',
    'mr',
    'ta',
    'te',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
    case 'ml':
      return AppLocalizationsMl();
    case 'mr':
      return AppLocalizationsMr();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
