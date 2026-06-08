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

  /// No description provided for @scrollForMore.
  ///
  /// In en, this message translates to:
  /// **'Scroll for more'**
  String get scrollForMore;

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
  /// **'Total Credit'**
  String get summaryIncomeLabel;

  /// No description provided for @summaryExpenseLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Debit'**
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

  /// No description provided for @homeNoTransactions.
  ///
  /// In en, this message translates to:
  /// **'No transactions yet'**
  String get homeNoTransactions;

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
  /// **'Credit'**
  String get txnTypeReceived;

  /// No description provided for @txnTypePaid.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
  String get txnTypePaid;

  /// No description provided for @txnColGave.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get txnColGave;

  /// No description provided for @txnColGot.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
  String get txnColGot;

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
  /// **'I gave'**
  String get addCustomerDirectionTheyOwe;

  /// No description provided for @addCustomerDirectionIOwe.
  ///
  /// In en, this message translates to:
  /// **'I received'**
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
  /// **'Credit'**
  String get customerDetailOwesYou;

  /// No description provided for @customerDetailYouOwe.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
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

  /// No description provided for @addEntryTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Entry'**
  String get addEntryTitle;

  /// No description provided for @addEntryGave.
  ///
  /// In en, this message translates to:
  /// **'Credit (You Gave)'**
  String get addEntryGave;

  /// No description provided for @addEntryReceived.
  ///
  /// In en, this message translates to:
  /// **'Debit (You Got)'**
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
  /// **'Description (optional)'**
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

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorGeneric;

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
  /// **'Credit'**
  String get txnDirectionGave;

  /// No description provided for @txnDirectionReceived.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
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

  /// No description provided for @contactsImportButton.
  ///
  /// In en, this message translates to:
  /// **'Import from contacts'**
  String get contactsImportButton;

  /// No description provided for @contactsSyncToggle.
  ///
  /// In en, this message translates to:
  /// **'Save to phone contacts'**
  String get contactsSyncToggle;

  /// No description provided for @contactsSynced.
  ///
  /// In en, this message translates to:
  /// **'Synced with contacts'**
  String get contactsSynced;

  /// No description provided for @contactsPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Contacts permission denied'**
  String get contactsPermissionDenied;

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

  /// No description provided for @restoreAction.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restoreAction;

  /// No description provided for @reportsFilterMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get reportsFilterMonth;

  /// No description provided for @reportsFilterYear.
  ///
  /// In en, this message translates to:
  /// **'This Year'**
  String get reportsFilterYear;

  /// No description provided for @reportsFilterAll.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get reportsFilterAll;

  /// No description provided for @reportsTotalGave.
  ///
  /// In en, this message translates to:
  /// **'Total Credit'**
  String get reportsTotalGave;

  /// No description provided for @reportsTotalGot.
  ///
  /// In en, this message translates to:
  /// **'Total Debit'**
  String get reportsTotalGot;

  /// No description provided for @reportsNetBalance.
  ///
  /// In en, this message translates to:
  /// **'Net Balance'**
  String get reportsNetBalance;

  /// No description provided for @reportsColCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get reportsColCustomer;

  /// No description provided for @reportsColGave.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get reportsColGave;

  /// No description provided for @reportsColGot.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
  String get reportsColGot;

  /// No description provided for @reportsColNet.
  ///
  /// In en, this message translates to:
  /// **'Net'**
  String get reportsColNet;

  /// No description provided for @reportsWillReceive.
  ///
  /// In en, this message translates to:
  /// **'You\'ll receive'**
  String get reportsWillReceive;

  /// No description provided for @reportsWillPay.
  ///
  /// In en, this message translates to:
  /// **'You\'ll pay'**
  String get reportsWillPay;

  /// No description provided for @reportsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No transactions in this period'**
  String get reportsEmpty;

  /// No description provided for @reportsDownloadPdf.
  ///
  /// In en, this message translates to:
  /// **'Share as PDF'**
  String get reportsDownloadPdf;

  /// No description provided for @reportsFilterHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to filter by period'**
  String get reportsFilterHint;

  /// No description provided for @reportsPdfTitle.
  ///
  /// In en, this message translates to:
  /// **'KhataPro Statement'**
  String get reportsPdfTitle;

  /// No description provided for @reportsPdfPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period: {period}'**
  String reportsPdfPeriod(String period);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Change app language'**
  String get settingsLanguageSubtitle;

  /// No description provided for @settingsAboutSection.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAboutSection;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsRateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate KhataPro'**
  String get settingsRateApp;

  /// No description provided for @recordPaymentPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Customer'**
  String get recordPaymentPickerTitle;

  /// No description provided for @recordPaymentPickerHint.
  ///
  /// In en, this message translates to:
  /// **'Search customers...'**
  String get recordPaymentPickerHint;

  /// No description provided for @profileSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'About you'**
  String get profileSetupTitle;

  /// No description provided for @profileSetupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Help us personalise your experience.'**
  String get profileSetupSubtitle;

  /// No description provided for @profileNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get profileNameLabel;

  /// No description provided for @profileNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Ravi Kumar'**
  String get profileNameHint;

  /// No description provided for @profileNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get profileNameRequired;

  /// No description provided for @profileNameTooLong.
  ///
  /// In en, this message translates to:
  /// **'Name must be under 80 characters'**
  String get profileNameTooLong;

  /// No description provided for @profileShopLabel.
  ///
  /// In en, this message translates to:
  /// **'Business / Shop Name'**
  String get profileShopLabel;

  /// No description provided for @profileShopHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Ravi General Store'**
  String get profileShopHint;

  /// No description provided for @profileContinueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get profileContinueButton;

  /// No description provided for @profileScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get profileScreenTitle;

  /// No description provided for @profileEditButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get profileEditButton;

  /// No description provided for @profileAuthSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileAuthSection;

  /// No description provided for @profileSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync & backup'**
  String get profileSignInButton;

  /// No description provided for @reminderNoPhone.
  ///
  /// In en, this message translates to:
  /// **'No phone number saved for this customer'**
  String get reminderNoPhone;

  /// No description provided for @reminderNoBalance.
  ///
  /// In en, this message translates to:
  /// **'This customer has no outstanding balance'**
  String get reminderNoBalance;

  /// No description provided for @reminderShareUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No messaging app found. Copy the message and send manually.'**
  String get reminderShareUnavailable;

  /// No description provided for @copyAction.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copyAction;

  /// No description provided for @reminderSent.
  ///
  /// In en, this message translates to:
  /// **'Opening WhatsApp…'**
  String get reminderSent;

  /// No description provided for @reminderSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send Reminder'**
  String get reminderSendButton;

  /// No description provided for @reminderMessage.
  ///
  /// In en, this message translates to:
  /// **'Hi {name}, you have an outstanding payment of ₹{amount}. Please settle at your earliest convenience. – {business}'**
  String reminderMessage(String name, String amount, String business);

  /// No description provided for @catalogSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Visiting Cards & Catalogs'**
  String get catalogSectionTitle;

  /// No description provided for @catalogAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add photo'**
  String get catalogAddPhoto;

  /// No description provided for @catalogTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get catalogTakePhoto;

  /// No description provided for @catalogChooseGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get catalogChooseGallery;

  /// No description provided for @catalogDeleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove this image?'**
  String get catalogDeleteConfirm;

  /// No description provided for @reminderAttachTitle.
  ///
  /// In en, this message translates to:
  /// **'Attach a card?'**
  String get reminderAttachTitle;

  /// No description provided for @reminderSendWithImage.
  ///
  /// In en, this message translates to:
  /// **'Send with image'**
  String get reminderSendWithImage;

  /// No description provided for @reminderSendWithoutImage.
  ///
  /// In en, this message translates to:
  /// **'Send without image'**
  String get reminderSendWithoutImage;

  /// No description provided for @generateBillTitle.
  ///
  /// In en, this message translates to:
  /// **'Generate Bill'**
  String get generateBillTitle;

  /// No description provided for @billScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Statement'**
  String get billScreenTitle;

  /// No description provided for @billPeriodMonth.
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get billPeriodMonth;

  /// No description provided for @billPeriodYear.
  ///
  /// In en, this message translates to:
  /// **'This Year'**
  String get billPeriodYear;

  /// No description provided for @billPeriodAll.
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get billPeriodAll;

  /// No description provided for @billPeriodCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get billPeriodCustom;

  /// No description provided for @billPeriodLabel.
  ///
  /// In en, this message translates to:
  /// **'{from} – {to}'**
  String billPeriodLabel(String from, String to);

  /// No description provided for @billColDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get billColDate;

  /// No description provided for @billColNote.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get billColNote;

  /// No description provided for @billColGave.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get billColGave;

  /// No description provided for @billColGot.
  ///
  /// In en, this message translates to:
  /// **'Debit'**
  String get billColGot;

  /// No description provided for @billTotalGave.
  ///
  /// In en, this message translates to:
  /// **'Total Credit'**
  String get billTotalGave;

  /// No description provided for @billTotalGot.
  ///
  /// In en, this message translates to:
  /// **'Total Debit'**
  String get billTotalGot;

  /// No description provided for @billNetBalance.
  ///
  /// In en, this message translates to:
  /// **'Balance Due'**
  String get billNetBalance;

  /// No description provided for @billYouAreOwed.
  ///
  /// In en, this message translates to:
  /// **'You are owed'**
  String get billYouAreOwed;

  /// No description provided for @billYouOwe.
  ///
  /// In en, this message translates to:
  /// **'You owe'**
  String get billYouOwe;

  /// No description provided for @billEmpty.
  ///
  /// In en, this message translates to:
  /// **'No transactions in this period'**
  String get billEmpty;

  /// No description provided for @billShareButton.
  ///
  /// In en, this message translates to:
  /// **'Share as PDF'**
  String get billShareButton;

  /// No description provided for @billCustomRange.
  ///
  /// In en, this message translates to:
  /// **'Select date range'**
  String get billCustomRange;

  /// No description provided for @billFilterHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to filter by period'**
  String get billFilterHint;

  /// No description provided for @backupSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get backupSectionTitle;

  /// No description provided for @backupTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup data'**
  String get backupTileTitle;

  /// No description provided for @backupTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Export all customers & transactions'**
  String get backupTileSubtitle;

  /// No description provided for @restoreTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore from backup'**
  String get restoreTileTitle;

  /// No description provided for @restoreTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Replace all data from a backup file'**
  String get restoreTileSubtitle;

  /// No description provided for @restoreConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Replace all data?'**
  String get restoreConfirmTitle;

  /// No description provided for @restoreConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'This will permanently replace all your current data with the backup. This cannot be undone.'**
  String get restoreConfirmBody;

  /// No description provided for @restoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data restored successfully'**
  String get restoreSuccess;

  /// No description provided for @restoreError.
  ///
  /// In en, this message translates to:
  /// **'Could not restore backup. The file may be invalid or corrupted.'**
  String get restoreError;

  /// No description provided for @backupExportError.
  ///
  /// In en, this message translates to:
  /// **'Could not export backup. Please try again.'**
  String get backupExportError;

  /// No description provided for @backupEmptyError.
  ///
  /// In en, this message translates to:
  /// **'No data to back up. Add customers first.'**
  String get backupEmptyError;

  /// No description provided for @remindersSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get remindersSectionTitle;

  /// No description provided for @defaultReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Default Reminder'**
  String get defaultReminderTitle;

  /// No description provided for @defaultReminderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Applied to new customers automatically'**
  String get defaultReminderSubtitle;

  /// No description provided for @defaultReminderSheetHint.
  ///
  /// In en, this message translates to:
  /// **'Pre-selected when adding a new customer. Each customer\'s reminder is set individually.'**
  String get defaultReminderSheetHint;

  /// No description provided for @setReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Reminder'**
  String get setReminderTitle;

  /// No description provided for @setReminderSave.
  ///
  /// In en, this message translates to:
  /// **'Set Reminder'**
  String get setReminderSave;

  /// No description provided for @reminderFrequencyNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get reminderFrequencyNone;

  /// No description provided for @reminderFrequencyWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get reminderFrequencyWeekly;

  /// No description provided for @reminderFrequencyFortnightly.
  ///
  /// In en, this message translates to:
  /// **'Every 2 weeks'**
  String get reminderFrequencyFortnightly;

  /// No description provided for @reminderFrequencyMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get reminderFrequencyMonthly;

  /// No description provided for @reminderModeRecurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get reminderModeRecurring;

  /// No description provided for @reminderModeOnDate.
  ///
  /// In en, this message translates to:
  /// **'On a date'**
  String get reminderModeOnDate;

  /// No description provided for @reminderDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminder date'**
  String get reminderDateLabel;

  /// No description provided for @reminderDateHint.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get reminderDateHint;

  /// No description provided for @reminderDatePast.
  ///
  /// In en, this message translates to:
  /// **'Please pick a future date'**
  String get reminderDatePast;

  /// No description provided for @reminderTimeMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning · 9 AM'**
  String get reminderTimeMorning;

  /// No description provided for @reminderTimeAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon · 1 PM'**
  String get reminderTimeAfternoon;

  /// No description provided for @reminderTimeEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening · 6 PM'**
  String get reminderTimeEvening;

  /// No description provided for @reminderActiveChip.
  ///
  /// In en, this message translates to:
  /// **'{freq} reminder'**
  String reminderActiveChip(String freq);

  /// No description provided for @reminderNotifTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Reminder'**
  String get reminderNotifTitle;

  /// No description provided for @reminderNotifBody.
  ///
  /// In en, this message translates to:
  /// **'{name} owes ₹{amount} — tap to send reminder'**
  String reminderNotifBody(String name, String amount);

  /// No description provided for @authSignInTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to sync & backup'**
  String get authSignInTitle;

  /// No description provided for @authSignInSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your data stays safe across devices'**
  String get authSignInSubtitle;

  /// No description provided for @authPhoneButton.
  ///
  /// In en, this message translates to:
  /// **'Continue with Phone'**
  String get authPhoneButton;

  /// No description provided for @authGoogleButton.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authGoogleButton;

  /// No description provided for @authOrDivider.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get authOrDivider;

  /// No description provided for @authPhoneStepTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get authPhoneStepTitle;

  /// No description provided for @authPhoneStepSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send a one-time code to verify your number'**
  String get authPhoneStepSubtitle;

  /// No description provided for @authPhoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get authPhoneLabel;

  /// No description provided for @authPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'+91 98765 43210'**
  String get authPhoneHint;

  /// No description provided for @authSendOtpButton.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get authSendOtpButton;

  /// No description provided for @authOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get authOtpTitle;

  /// No description provided for @authOtpLabel.
  ///
  /// In en, this message translates to:
  /// **'6-digit code'**
  String get authOtpLabel;

  /// No description provided for @authOtpSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sent to {phone}'**
  String authOtpSubtitle(String phone);

  /// No description provided for @authVerifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get authVerifyButton;

  /// No description provided for @authResendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get authResendOtp;

  /// No description provided for @authOtpResent.
  ///
  /// In en, this message translates to:
  /// **'OTP resent successfully'**
  String get authOtpResent;

  /// No description provided for @authDidntReceive.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive it?'**
  String get authDidntReceive;

  /// No description provided for @authResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String authResendIn(int seconds);

  /// No description provided for @authSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get authSignOut;

  /// No description provided for @authSignedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {name}'**
  String authSignedInAs(String name);

  /// No description provided for @authSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip for now'**
  String get authSkip;

  /// No description provided for @authSyncingData.
  ///
  /// In en, this message translates to:
  /// **'Syncing your data…'**
  String get authSyncingData;

  /// No description provided for @authDataSynced.
  ///
  /// In en, this message translates to:
  /// **'All data synced to cloud'**
  String get authDataSynced;

  /// No description provided for @guestBannerBody.
  ///
  /// In en, this message translates to:
  /// **'Sign in to back up your data across devices'**
  String get guestBannerBody;

  /// No description provided for @guestBannerCta.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get guestBannerCta;

  /// No description provided for @syncUnsyncedBanner.
  ///
  /// In en, this message translates to:
  /// **'Unsynced changes — connect to internet to sync.'**
  String get syncUnsyncedBanner;

  /// No description provided for @syncCloudWinsTitle.
  ///
  /// In en, this message translates to:
  /// **'Replace local data?'**
  String get syncCloudWinsTitle;

  /// No description provided for @syncCloudWinsBody.
  ///
  /// In en, this message translates to:
  /// **'Signing in will replace all local data with your cloud backup. This cannot be undone.'**
  String get syncCloudWinsBody;

  /// No description provided for @offlineBar.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get offlineBar;

  /// No description provided for @firstRunTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to KhataPro!'**
  String get firstRunTitle;

  /// No description provided for @firstRunBody.
  ///
  /// In en, this message translates to:
  /// **'Track what customers owe you — no paper needed.'**
  String get firstRunBody;

  /// No description provided for @firstRunStep1.
  ///
  /// In en, this message translates to:
  /// **'Add a customer'**
  String get firstRunStep1;

  /// No description provided for @firstRunStep2.
  ///
  /// In en, this message translates to:
  /// **'Record a payment'**
  String get firstRunStep2;

  /// No description provided for @firstRunStep3.
  ///
  /// In en, this message translates to:
  /// **'Send a reminder'**
  String get firstRunStep3;

  /// No description provided for @firstRunDismiss.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get firstRunDismiss;

  /// No description provided for @reportsFilterCustomer.
  ///
  /// In en, this message translates to:
  /// **'All customers'**
  String get reportsFilterCustomer;

  /// No description provided for @reportsFilterByCustomer.
  ///
  /// In en, this message translates to:
  /// **'Filter by customer'**
  String get reportsFilterByCustomer;

  /// No description provided for @reportsCustomerSelected.
  ///
  /// In en, this message translates to:
  /// **'{name}\'s report'**
  String reportsCustomerSelected(String name);

  /// No description provided for @appLockSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get appLockSectionTitle;

  /// No description provided for @appLockTileTitle.
  ///
  /// In en, this message translates to:
  /// **'App Lock'**
  String get appLockTileTitle;

  /// No description provided for @appLockTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Require biometrics or PIN to open'**
  String get appLockTileSubtitle;

  /// No description provided for @appLockSetPin.
  ///
  /// In en, this message translates to:
  /// **'Set PIN'**
  String get appLockSetPin;

  /// No description provided for @pinSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create a PIN'**
  String get pinSetupTitle;

  /// No description provided for @pinSetupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Used as fallback if biometrics fail'**
  String get pinSetupSubtitle;

  /// No description provided for @pinConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm your PIN'**
  String get pinConfirmTitle;

  /// No description provided for @pinMismatch.
  ///
  /// In en, this message translates to:
  /// **'PINs don\'t match. Try again.'**
  String get pinMismatch;

  /// No description provided for @pinIncorrect.
  ///
  /// In en, this message translates to:
  /// **'Incorrect PIN. Try again.'**
  String get pinIncorrect;

  /// No description provided for @pinEnterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your PIN'**
  String get pinEnterTitle;

  /// No description provided for @pinForgot.
  ///
  /// In en, this message translates to:
  /// **'Forgot PIN? Sign in to reset'**
  String get pinForgot;

  /// No description provided for @biometricReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock KhataPro'**
  String get biometricReason;

  /// No description provided for @appLockDisabledInfo.
  ///
  /// In en, this message translates to:
  /// **'App lock disabled'**
  String get appLockDisabledInfo;

  /// No description provided for @notifPermDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission denied. Enable it in Settings to receive reminders.'**
  String get notifPermDenied;

  /// No description provided for @permContactsTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow Contacts'**
  String get permContactsTitle;

  /// No description provided for @permContactsBody.
  ///
  /// In en, this message translates to:
  /// **'KhataPro needs contacts access to fill in customer details automatically.'**
  String get permContactsBody;

  /// No description provided for @permNotifTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow Notifications'**
  String get permNotifTitle;

  /// No description provided for @permNotifBody.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications to receive payment reminders at the right time.'**
  String get permNotifBody;

  /// No description provided for @permCameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow Camera & Photos'**
  String get permCameraTitle;

  /// No description provided for @permCameraBody.
  ///
  /// In en, this message translates to:
  /// **'KhataPro needs camera or gallery access to attach visiting cards.'**
  String get permCameraBody;

  /// No description provided for @permAllowButton.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get permAllowButton;

  /// No description provided for @permOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get permOpenSettings;

  /// No description provided for @permNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get permNotNow;
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
