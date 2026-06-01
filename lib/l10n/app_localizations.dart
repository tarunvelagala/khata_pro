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

  /// No description provided for @tourHeadline1.
  ///
  /// In en, this message translates to:
  /// **'Track every rupee'**
  String get tourHeadline1;

  /// No description provided for @tourBody1.
  ///
  /// In en, this message translates to:
  /// **'Add customers, record what they owe you or you owe them. Balances update instantly.'**
  String get tourBody1;

  /// No description provided for @tourHeadline2.
  ///
  /// In en, this message translates to:
  /// **'Send reminders easily'**
  String get tourHeadline2;

  /// No description provided for @tourBody2.
  ///
  /// In en, this message translates to:
  /// **'Send payment reminders via WhatsApp or SMS in one tap. Even attach your visiting card.'**
  String get tourBody2;

  /// No description provided for @tourHeadline3.
  ///
  /// In en, this message translates to:
  /// **'Your data, always safe'**
  String get tourHeadline3;

  /// No description provided for @tourBody3.
  ///
  /// In en, this message translates to:
  /// **'Everything is stored privately on your phone. No account needed. Works offline too.'**
  String get tourBody3;

  /// No description provided for @tourNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get tourNext;

  /// No description provided for @tourGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get tourGetStarted;

  /// No description provided for @tourSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get tourSkip;

  /// No description provided for @tourSwipeHint.
  ///
  /// In en, this message translates to:
  /// **'SWIPE TO EXPLORE'**
  String get tourSwipeHint;

  /// No description provided for @languageScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get languageScreenTitle;

  /// No description provided for @languageScreenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your preferred language. Changes take effect immediately.'**
  String get languageScreenSubtitle;

  /// No description provided for @languageContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get languageContinueButton;

  /// No description provided for @languageSkipButton.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get languageSkipButton;

  /// No description provided for @balanceCardLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get balanceCardLabel;

  /// No description provided for @balanceShowTooltip.
  ///
  /// In en, this message translates to:
  /// **'Show balance'**
  String get balanceShowTooltip;

  /// No description provided for @balanceHideTooltip.
  ///
  /// In en, this message translates to:
  /// **'Hide balance'**
  String get balanceHideTooltip;

  /// No description provided for @summaryIncomeLabel.
  ///
  /// In en, this message translates to:
  /// **'You get'**
  String get summaryIncomeLabel;

  /// No description provided for @summaryExpenseLabel.
  ///
  /// In en, this message translates to:
  /// **'You give'**
  String get summaryExpenseLabel;

  /// No description provided for @homeCustomersHeader.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get homeCustomersHeader;

  /// No description provided for @homeAddEntryTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add entry'**
  String get homeAddEntryTooltip;

  /// No description provided for @homeEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No customers yet'**
  String get homeEmptyTitle;

  /// No description provided for @homeEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add your first customer to start tracking payments.'**
  String get homeEmptyBody;

  /// No description provided for @homeEmptyAddCustomer.
  ///
  /// In en, this message translates to:
  /// **'Add Customer'**
  String get homeEmptyAddCustomer;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navCustomers.
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get navCustomers;

  /// No description provided for @navMore.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get navMore;

  /// No description provided for @navReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navReports;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @appBarNotificationsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get appBarNotificationsTooltip;

  /// No description provided for @appBarGreetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get appBarGreetingMorning;

  /// No description provided for @appBarGreetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get appBarGreetingAfternoon;

  /// No description provided for @appBarGreetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get appBarGreetingEvening;

  /// No description provided for @quickActionAddCustomer.
  ///
  /// In en, this message translates to:
  /// **'Add Customer'**
  String get quickActionAddCustomer;

  /// No description provided for @quickActionGenerateBill.
  ///
  /// In en, this message translates to:
  /// **'Generate Bill'**
  String get quickActionGenerateBill;

  /// No description provided for @quickActionSendReminder.
  ///
  /// In en, this message translates to:
  /// **'Send Reminder'**
  String get quickActionSendReminder;

  /// No description provided for @quickActionRecordPayment.
  ///
  /// In en, this message translates to:
  /// **'Record Payment'**
  String get quickActionRecordPayment;

  /// No description provided for @homeRecentTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get homeRecentTransactions;

  /// No description provided for @homeSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get homeSeeAll;

  /// No description provided for @homeAddEntry.
  ///
  /// In en, this message translates to:
  /// **'Add Entry'**
  String get homeAddEntry;

  /// No description provided for @customersSearch.
  ///
  /// In en, this message translates to:
  /// **'Search customers...'**
  String get customersSearch;

  /// No description provided for @customersAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add Customer'**
  String get customersAddButton;

  /// No description provided for @customersNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String customersNoResults(String query);

  /// No description provided for @txnTimeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m ago'**
  String txnTimeMinutesAgo(int minutes);

  /// No description provided for @txnTimeToday.
  ///
  /// In en, this message translates to:
  /// **'Today, {time}'**
  String txnTimeToday(String time);

  /// No description provided for @txnTimeYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday, {time}'**
  String txnTimeYesterday(String time);

  /// No description provided for @txnTypeReceived.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get txnTypeReceived;

  /// No description provided for @txnTypePaid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get txnTypePaid;
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
