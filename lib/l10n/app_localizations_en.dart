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
  String get tourHeadline1 => 'Track every rupee';

  @override
  String get tourBody1 =>
      'Add customers, record what they owe you or you owe them. Balances update instantly.';

  @override
  String get tourHeadline2 => 'Send reminders easily';

  @override
  String get tourBody2 =>
      'Send payment reminders via WhatsApp or SMS in one tap. Even attach your visiting card.';

  @override
  String get tourHeadline3 => 'Your data, always safe';

  @override
  String get tourBody3 =>
      'Everything is stored privately on your phone. No account needed. Works offline too.';

  @override
  String get tourNext => 'Next';

  @override
  String get tourGetStarted => 'Get Started';

  @override
  String get tourSkip => 'Skip';

  @override
  String get tourSwipeHint => 'SWIPE TO EXPLORE';

  @override
  String get languageScreenTitle => 'Select Language';

  @override
  String get languageScreenSubtitle =>
      'Choose your preferred language. Changes take effect immediately.';

  @override
  String get languageContinueButton => 'Continue';

  @override
  String get languageSkipButton => 'Skip for now';

  @override
  String get balanceCardLabel => 'Total Balance';

  @override
  String get balanceShowTooltip => 'Show balance';

  @override
  String get balanceHideTooltip => 'Hide balance';

  @override
  String get summaryIncomeLabel => 'You get';

  @override
  String get summaryExpenseLabel => 'You give';

  @override
  String get homeCustomersHeader => 'Customers';

  @override
  String get homeAddEntryTooltip => 'Add entry';

  @override
  String get homeEmptyTitle => 'No customers yet';

  @override
  String get homeEmptyBody =>
      'Add your first customer to start tracking payments.';

  @override
  String get homeEmptyAddCustomer => 'Add Customer';

  @override
  String get navHome => 'Home';

  @override
  String get navCustomers => 'Customers';

  @override
  String get navMore => 'More';

  @override
  String get navReports => 'Reports';

  @override
  String get navSettings => 'Settings';

  @override
  String get appBarNotificationsTooltip => 'Notifications';

  @override
  String get appBarGreetingMorning => 'Good morning';

  @override
  String get appBarGreetingAfternoon => 'Good afternoon';

  @override
  String get appBarGreetingEvening => 'Good evening';

  @override
  String get quickActionAddCustomer => 'Add Customer';

  @override
  String get quickActionGenerateBill => 'Generate Bill';

  @override
  String get quickActionSendReminder => 'Send Reminder';

  @override
  String get quickActionRecordPayment => 'Record Payment';

  @override
  String get homeRecentTransactions => 'Recent Transactions';

  @override
  String get homeSeeAll => 'See all';

  @override
  String get homeAddEntry => 'Add Entry';

  @override
  String get customersSearch => 'Search customers...';

  @override
  String get customersAddButton => 'Add Customer';

  @override
  String customersNoResults(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String txnTimeMinutesAgo(int minutes) {
    return '${minutes}m ago';
  }

  @override
  String txnTimeToday(String time) {
    return 'Today, $time';
  }

  @override
  String txnTimeYesterday(String time) {
    return 'Yesterday, $time';
  }

  @override
  String get txnTypeReceived => 'Received';

  @override
  String get txnTypePaid => 'Paid';

  @override
  String get addCustomerTitle => 'Add Customer';

  @override
  String get addCustomerNameLabel => 'Customer Name';

  @override
  String get addCustomerNameHint => 'e.g. Ravi Kumar';

  @override
  String get addCustomerPhoneLabel => 'Phone Number';

  @override
  String get addCustomerPhoneHint => 'e.g. 9876543210';

  @override
  String get addCustomerShopLabel => 'Shop / Business Name';

  @override
  String get addCustomerShopHint => 'e.g. Ravi General Store';

  @override
  String get addCustomerBalanceLabel => 'Opening Balance';

  @override
  String get addCustomerBalanceHint => '0';

  @override
  String get addCustomerDirectionTheyOwe => 'They owe me';

  @override
  String get addCustomerDirectionIOwe => 'I owe them';

  @override
  String get addCustomerSave => 'Save Customer';

  @override
  String get addCustomerError => 'Couldn\'t save. Please try again.';

  @override
  String get addCustomerDuplicate =>
      'A customer with this name, phone and shop already exists.';

  @override
  String get addCustomerNameRequired => 'Name is required';

  @override
  String get addCustomerNameTooLong => 'Name must be under 80 characters';

  @override
  String get addCustomerPhoneInvalid =>
      'Enter a valid phone number (10–15 digits)';

  @override
  String get addCustomerBalanceInvalid => 'Enter a valid amount';

  @override
  String get customerDetailOwesYou => 'Owes you';

  @override
  String get customerDetailYouOwe => 'You owe';

  @override
  String get customerDetailSettled => 'Settled';

  @override
  String get customerDetailNoEntries => 'No entries yet';

  @override
  String get customerDetailNoEntriesBody =>
      'Record the first transaction for this customer.';

  @override
  String get customerDetailAddFirstEntry => 'Add First Entry';

  @override
  String get addEntryTitle => 'Add Entry';

  @override
  String get addEntryGave => 'You Gave';

  @override
  String get addEntryReceived => 'You Received';

  @override
  String get addEntryAmountLabel => 'Amount';

  @override
  String get addEntryAmountHint => '0';

  @override
  String get addEntryNoteLabel => 'Note (optional)';

  @override
  String get addEntrySave => 'Save';

  @override
  String get addEntryAmountRequired => 'Enter an amount';

  @override
  String get addEntryAmountInvalid => 'Enter a valid amount';

  @override
  String get retryButton => 'Retry';

  @override
  String get dateToday => 'Today';

  @override
  String get dateYesterday => 'Yesterday';

  @override
  String get txnDirectionGave => 'You gave';

  @override
  String get txnDirectionReceived => 'You received';

  @override
  String get offlineSafeLabel => 'OFFLINE SAFE';

  @override
  String get offlinePropertyPrivate => 'Private';

  @override
  String get offlinePropertyOffline => 'Offline';

  @override
  String get offlinePropertySecure => 'Secure';

  @override
  String get editCustomerTitle => 'Edit Customer';

  @override
  String get editEntryTitle => 'Edit Entry';

  @override
  String get deleteConfirmTitle => 'Delete?';

  @override
  String get deleteCustomerConfirmBody =>
      'This will permanently delete the customer and all their transactions.';

  @override
  String get deleteTxnConfirmBody => 'This entry will be permanently deleted.';

  @override
  String get deleteAction => 'Delete';

  @override
  String get cancelAction => 'Cancel';
}
