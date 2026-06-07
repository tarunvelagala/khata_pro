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
  String get summaryIncomeLabel => 'Total Credit';

  @override
  String get summaryExpenseLabel => 'Total Debit';

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
  String get homeNoTransactions => 'No transactions yet';

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
  String get txnTypeReceived => 'Credit';

  @override
  String get txnTypePaid => 'Debit';

  @override
  String get txnColGave => 'Credit';

  @override
  String get txnColGot => 'Debit';

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
  String get addCustomerDirectionTheyOwe => 'I gave';

  @override
  String get addCustomerDirectionIOwe => 'I received';

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
  String get customerDetailOwesYou => 'Credit';

  @override
  String get customerDetailYouOwe => 'Debit';

  @override
  String get customerDetailSettled => 'Settled';

  @override
  String get customerDetailNoEntries => 'No entries yet';

  @override
  String get customerDetailNoEntriesBody =>
      'Record the first transaction for this customer.';

  @override
  String get addEntryTitle => 'Add Entry';

  @override
  String get addEntryGave => 'Credit (You Gave)';

  @override
  String get addEntryReceived => 'Debit (You Got)';

  @override
  String get addEntryAmountLabel => 'Amount';

  @override
  String get addEntryAmountHint => '0';

  @override
  String get addEntryNoteLabel => 'Description (optional)';

  @override
  String get addEntrySave => 'Save';

  @override
  String get addEntryAmountRequired => 'Enter an amount';

  @override
  String get addEntryAmountInvalid => 'Enter a valid amount';

  @override
  String get retryButton => 'Retry';

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get dateToday => 'Today';

  @override
  String get dateYesterday => 'Yesterday';

  @override
  String get txnDirectionGave => 'Credit';

  @override
  String get txnDirectionReceived => 'Debit';

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
  String get contactsImportButton => 'Import from contacts';

  @override
  String get contactsSyncToggle => 'Save to phone contacts';

  @override
  String get contactsSynced => 'Synced with contacts';

  @override
  String get contactsPermissionDenied => 'Contacts permission denied';

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

  @override
  String get reportsFilterMonth => 'This Month';

  @override
  String get reportsFilterYear => 'This Year';

  @override
  String get reportsFilterAll => 'All Time';

  @override
  String get reportsTotalGave => 'Total Credit';

  @override
  String get reportsTotalGot => 'Total Debit';

  @override
  String get reportsNetBalance => 'Net Balance';

  @override
  String get reportsColCustomer => 'Customer';

  @override
  String get reportsColGave => 'Credit';

  @override
  String get reportsColGot => 'Debit';

  @override
  String get reportsColNet => 'Net';

  @override
  String get reportsEmpty => 'No transactions in this period';

  @override
  String get reportsDownloadPdf => 'Share as PDF';

  @override
  String get reportsFilterHint => 'Tap to filter by period';

  @override
  String get reportsPdfTitle => 'KhataPro Statement';

  @override
  String reportsPdfPeriod(String period) {
    return 'Period: $period';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSubtitle => 'Change app language';

  @override
  String get settingsAboutSection => 'About';

  @override
  String get settingsVersion => 'Version';

  @override
  String get settingsPrivacyPolicy => 'Privacy Policy';

  @override
  String get settingsRateApp => 'Rate KhataPro';

  @override
  String get recordPaymentPickerTitle => 'Select Customer';

  @override
  String get recordPaymentPickerHint => 'Search customers...';

  @override
  String get profileSetupTitle => 'About you';

  @override
  String get profileSetupSubtitle => 'Help us personalise your experience.';

  @override
  String get profileNameLabel => 'Your Name';

  @override
  String get profileNameHint => 'e.g. Ravi Kumar';

  @override
  String get profileNameRequired => 'Name is required';

  @override
  String get profileNameTooLong => 'Name must be under 80 characters';

  @override
  String get profileShopLabel => 'Business / Shop Name';

  @override
  String get profileShopHint => 'e.g. Ravi General Store';

  @override
  String get profileContinueButton => 'Continue';

  @override
  String get profileScreenTitle => 'My Profile';

  @override
  String get profileEditButton => 'Edit';

  @override
  String get profileAuthSection => 'Account';

  @override
  String get profileSignInButton => 'Sign in to sync & backup';

  @override
  String get reminderNoPhone => 'No phone number saved for this customer';

  @override
  String get reminderNoBalance => 'This customer has no outstanding balance';

  @override
  String get reminderShareUnavailable =>
      'No messaging app found. Copy the message and send manually.';

  @override
  String get copyAction => 'Copy';

  @override
  String get reminderSent => 'Opening WhatsApp…';

  @override
  String get reminderSendButton => 'Send Reminder';

  @override
  String reminderMessage(String name, String amount, String business) {
    return 'Hi $name, you have an outstanding payment of ₹$amount. Please settle at your earliest convenience. – $business';
  }

  @override
  String get catalogSectionTitle => 'Visiting Cards & Catalogs';

  @override
  String get catalogAddPhoto => 'Add photo';

  @override
  String get catalogTakePhoto => 'Take photo';

  @override
  String get catalogChooseGallery => 'Choose from gallery';

  @override
  String get catalogDeleteConfirm => 'Remove this image?';

  @override
  String get reminderAttachTitle => 'Attach a card?';

  @override
  String get reminderSendWithImage => 'Send with image';

  @override
  String get reminderSendWithoutImage => 'Send without image';

  @override
  String get generateBillTitle => 'Generate Bill';

  @override
  String get billScreenTitle => 'Account Statement';

  @override
  String get billPeriodMonth => 'This Month';

  @override
  String get billPeriodYear => 'This Year';

  @override
  String get billPeriodAll => 'All Time';

  @override
  String get billPeriodCustom => 'Custom';

  @override
  String billPeriodLabel(String from, String to) {
    return '$from – $to';
  }

  @override
  String get billColDate => 'Date';

  @override
  String get billColNote => 'Description';

  @override
  String get billColGave => 'Credit';

  @override
  String get billColGot => 'Debit';

  @override
  String get billTotalGave => 'Total Credit';

  @override
  String get billTotalGot => 'Total Debit';

  @override
  String get billNetBalance => 'Balance Due';

  @override
  String get billYouAreOwed => 'You are owed';

  @override
  String get billYouOwe => 'You owe';

  @override
  String get billEmpty => 'No transactions in this period';

  @override
  String get billShareButton => 'Share as PDF';

  @override
  String get billCustomRange => 'Select date range';

  @override
  String get billFilterHint => 'Tap to filter by period';

  @override
  String get backupSectionTitle => 'Data';

  @override
  String get backupTileTitle => 'Backup data';

  @override
  String get backupTileSubtitle => 'Export all customers & transactions';

  @override
  String get restoreTileTitle => 'Restore from backup';

  @override
  String get restoreTileSubtitle => 'Replace all data from a backup file';

  @override
  String get restoreConfirmTitle => 'Replace all data?';

  @override
  String get restoreConfirmBody =>
      'This will permanently replace all your current data with the backup. This cannot be undone.';

  @override
  String get restoreSuccess => 'Data restored successfully';

  @override
  String get restoreError =>
      'Could not restore backup. The file may be invalid or corrupted.';

  @override
  String get remindersSectionTitle => 'Reminders';

  @override
  String get defaultReminderTitle => 'Default Reminder';

  @override
  String get defaultReminderSubtitle =>
      'Applied to new customers automatically';

  @override
  String get defaultReminderSheetHint =>
      'Pre-selected when adding a new customer. Each customer\'s reminder is set individually.';

  @override
  String get setReminderTitle => 'Set Reminder';

  @override
  String get reminderFrequencyNone => 'None';

  @override
  String get reminderFrequencyWeekly => 'Weekly';

  @override
  String get reminderFrequencyFortnightly => 'Every 2 weeks';

  @override
  String get reminderFrequencyMonthly => 'Monthly';

  @override
  String get reminderModeRecurring => 'Recurring';

  @override
  String get reminderModeOnDate => 'On a date';

  @override
  String get reminderDateLabel => 'Reminder date';

  @override
  String get reminderDateHint => 'Pick a date';

  @override
  String get reminderDatePast => 'Please pick a future date';

  @override
  String get reminderTimeMorning => 'Morning · 9 AM';

  @override
  String get reminderTimeAfternoon => 'Afternoon · 1 PM';

  @override
  String get reminderTimeEvening => 'Evening · 6 PM';

  @override
  String reminderActiveChip(String freq) {
    return '$freq reminder';
  }

  @override
  String get reminderNotifTitle => 'Payment Reminder';

  @override
  String reminderNotifBody(String name, String amount) {
    return '$name owes ₹$amount — tap to send reminder';
  }

  @override
  String get authSignInTitle => 'Sign in to sync & backup';

  @override
  String get authSignInSubtitle => 'Your data stays safe across devices';

  @override
  String get authPhoneButton => 'Continue with Phone';

  @override
  String get authGoogleButton => 'Continue with Google';

  @override
  String get authOrDivider => 'OR';

  @override
  String get authPhoneStepTitle => 'Enter your phone number';

  @override
  String get authPhoneStepSubtitle =>
      'We\'ll send a one-time code to verify your number';

  @override
  String get authPhoneLabel => 'Phone Number';

  @override
  String get authPhoneHint => '+91 98765 43210';

  @override
  String get authSendOtpButton => 'Send OTP';

  @override
  String get authOtpTitle => 'Enter OTP';

  @override
  String get authOtpLabel => '6-digit code';

  @override
  String authOtpSubtitle(String phone) {
    return 'Sent to $phone';
  }

  @override
  String get authVerifyButton => 'Verify';

  @override
  String get authResendOtp => 'Resend OTP';

  @override
  String get authOtpResent => 'OTP resent successfully';

  @override
  String get authDidntReceive => 'Didn\'t receive it?';

  @override
  String authResendIn(int seconds) {
    return 'Resend in ${seconds}s';
  }

  @override
  String get authSignOut => 'Sign out';

  @override
  String authSignedInAs(String name) {
    return 'Signed in as $name';
  }

  @override
  String get authSkip => 'Skip for now';

  @override
  String get authSyncingData => 'Syncing your data…';

  @override
  String get authDataSynced => 'All data synced to cloud';

  @override
  String get syncUnsyncedBanner =>
      'Unsynced changes — connect to internet to sync.';

  @override
  String get syncCloudWinsTitle => 'Replace local data?';

  @override
  String get syncCloudWinsBody =>
      'Signing in will replace all local data with your cloud backup. This cannot be undone.';

  @override
  String get offlineBar => 'No internet connection';

  @override
  String get firstRunTitle => 'Welcome to KhataPro!';

  @override
  String get firstRunBody => 'Track what customers owe you — no paper needed.';

  @override
  String get firstRunStep1 => 'Add a customer';

  @override
  String get firstRunStep2 => 'Record a payment';

  @override
  String get firstRunStep3 => 'Send a reminder';

  @override
  String get firstRunDismiss => 'Got it';

  @override
  String get reportsFilterCustomer => 'All customers';

  @override
  String get reportsFilterByCustomer => 'Filter by customer';

  @override
  String reportsCustomerSelected(String name) {
    return '$name\'s report';
  }

  @override
  String get appLockSectionTitle => 'Security';

  @override
  String get appLockTileTitle => 'App Lock';

  @override
  String get appLockTileSubtitle => 'Require biometrics or PIN to open';

  @override
  String get appLockSetPin => 'Set PIN';

  @override
  String get pinSetupTitle => 'Create a PIN';

  @override
  String get pinSetupSubtitle => 'Used as fallback if biometrics fail';

  @override
  String get pinConfirmTitle => 'Confirm your PIN';

  @override
  String get pinMismatch => 'PINs don\'t match. Try again.';

  @override
  String get pinIncorrect => 'Incorrect PIN. Try again.';

  @override
  String get pinEnterTitle => 'Enter your PIN';

  @override
  String get pinForgot => 'Forgot PIN? Sign in to reset';

  @override
  String get biometricReason => 'Unlock KhataPro';

  @override
  String get appLockDisabledInfo => 'App lock disabled';

  @override
  String get notifPermDenied =>
      'Notification permission denied. Enable it in Settings to receive reminders.';
}
