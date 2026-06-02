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

  /// No description provided for @addCustomerTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Customer'**
  String get addCustomerTitle;

  /// No description provided for @addCustomerNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get addCustomerNameLabel;

  /// No description provided for @addCustomerNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Ravi Kumar'**
  String get addCustomerNameHint;

  /// No description provided for @addCustomerPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get addCustomerPhoneLabel;

  /// No description provided for @addCustomerPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 9876543210'**
  String get addCustomerPhoneHint;

  /// No description provided for @addCustomerShopLabel.
  ///
  /// In en, this message translates to:
  /// **'Shop / Business Name'**
  String get addCustomerShopLabel;

  /// No description provided for @addCustomerShopHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Ravi General Store'**
  String get addCustomerShopHint;

  /// No description provided for @addCustomerBalanceLabel.
  ///
  /// In en, this message translates to:
  /// **'Opening Balance'**
  String get addCustomerBalanceLabel;

  /// No description provided for @addCustomerBalanceHint.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get addCustomerBalanceHint;

  /// No description provided for @addCustomerDirectionTheyOwe.
  ///
  /// In en, this message translates to:
  /// **'They owe me'**
  String get addCustomerDirectionTheyOwe;

  /// No description provided for @addCustomerDirectionIOwe.
  ///
  /// In en, this message translates to:
  /// **'I owe them'**
  String get addCustomerDirectionIOwe;

  /// No description provided for @addCustomerSave.
  ///
  /// In en, this message translates to:
  /// **'Save Customer'**
  String get addCustomerSave;

  /// No description provided for @addCustomerError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t save. Please try again.'**
  String get addCustomerError;

  /// No description provided for @addCustomerDuplicate.
  ///
  /// In en, this message translates to:
  /// **'A customer with this name, phone and shop already exists.'**
  String get addCustomerDuplicate;

  /// No description provided for @addCustomerNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get addCustomerNameRequired;

  /// No description provided for @addCustomerNameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Name must be under 80 characters'**
  String get addCustomerNameTooLong;

  /// No description provided for @addCustomerPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number (10–15 digits)'**
  String get addCustomerPhoneInvalid;

  /// No description provided for @addCustomerBalanceInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get addCustomerBalanceInvalid;

  /// No description provided for @customerDetailOwesYou.
  ///
  /// In en, this message translates to:
  /// **'Owes you'**
  String get customerDetailOwesYou;

  /// No description provided for @customerDetailYouOwe.
  ///
  /// In en, this message translates to:
  /// **'You owe'**
  String get customerDetailYouOwe;

  /// No description provided for @customerDetailSettled.
  ///
  /// In en, this message translates to:
  /// **'Settled'**
  String get customerDetailSettled;

  /// No description provided for @customerDetailNoEntries.
  ///
  /// In en, this message translates to:
  /// **'No entries yet'**
  String get customerDetailNoEntries;

  /// No description provided for @customerDetailNoEntriesBody.
  ///
  /// In en, this message translates to:
  /// **'Record the first transaction for this customer.'**
  String get customerDetailNoEntriesBody;

  /// No description provided for @customerDetailAddFirstEntry.
  ///
  /// In en, this message translates to:
  /// **'Add First Entry'**
  String get customerDetailAddFirstEntry;

  /// No description provided for @addEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Entry'**
  String get addEntryTitle;

  /// No description provided for @addEntryGave.
  ///
  /// In en, this message translates to:
  /// **'You Gave'**
  String get addEntryGave;

  /// No description provided for @addEntryReceived.
  ///
  /// In en, this message translates to:
  /// **'You Received'**
  String get addEntryReceived;

  /// No description provided for @addEntryAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get addEntryAmountLabel;

  /// No description provided for @addEntryAmountHint.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get addEntryAmountHint;

  /// No description provided for @addEntryNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get addEntryNoteLabel;

  /// No description provided for @addEntrySave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get addEntrySave;

  /// No description provided for @addEntryAmountRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount'**
  String get addEntryAmountRequired;

  /// No description provided for @addEntryAmountInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get addEntryAmountInvalid;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// No description provided for @dateToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dateToday;

  /// No description provided for @dateYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get dateYesterday;

  /// No description provided for @txnDirectionGave.
  ///
  /// In en, this message translates to:
  /// **'You gave'**
  String get txnDirectionGave;

  /// No description provided for @txnDirectionReceived.
  ///
  /// In en, this message translates to:
  /// **'You received'**
  String get txnDirectionReceived;

  /// No description provided for @offlineSafeLabel.
  ///
  /// In en, this message translates to:
  /// **'OFFLINE SAFE'**
  String get offlineSafeLabel;

  /// No description provided for @offlinePropertyPrivate.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get offlinePropertyPrivate;

  /// No description provided for @offlinePropertyOffline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offlinePropertyOffline;

  /// No description provided for @offlinePropertySecure.
  ///
  /// In en, this message translates to:
  /// **'Secure'**
  String get offlinePropertySecure;

  /// No description provided for @editCustomerTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Customer'**
  String get editCustomerTitle;

  /// No description provided for @editEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Entry'**
  String get editEntryTitle;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete?'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteCustomerConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete the customer and all their transactions.'**
  String get deleteCustomerConfirmBody;

  /// No description provided for @deleteTxnConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This entry will be permanently deleted.'**
  String get deleteTxnConfirmBody;

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @cancelAction.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;
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
