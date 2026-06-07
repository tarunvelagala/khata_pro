// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'খাতা প্রো';

  @override
  String get appTagline => 'খাতা প্রো ডিজিটাল বহি খাতা';

  @override
  String get tourHeadline1 => 'প্রতিটি টাকা ট্র্যাক করুন';

  @override
  String get tourBody1 =>
      'গ্রাহক যোগ করুন, তাদের পাওনা ও দেনা রেকর্ড করুন। ব্যালেন্স তাৎক্ষণিক আপডেট হয়।';

  @override
  String get tourHeadline2 => 'সহজে রিমাইন্ডার পাঠান';

  @override
  String get tourBody2 =>
      'WhatsApp বা SMS-এ এক ট্যাপে পেমেন্ট রিমাইন্ডার পাঠান। ভিজিটিং কার্ডও যুক্ত করুন।';

  @override
  String get tourHeadline3 => 'আপনার ডেটা, সবসময় নিরাপদ';

  @override
  String get tourBody3 =>
      'সবকিছু আপনার ফোনে ব্যক্তিগতভাবে সংরক্ষিত। কোনো অ্যাকাউন্ট লাগবে না। অফলাইনেও কাজ করে।';

  @override
  String get tourNext => 'পরবর্তী';

  @override
  String get tourGetStarted => 'শুরু করুন';

  @override
  String get tourSkip => 'এড়িয়ে যান';

  @override
  String get tourSwipeHint => 'সোয়াইপ করুন';

  @override
  String get languageScreenTitle => 'ভাষা বেছে নিন';

  @override
  String get languageScreenSubtitle =>
      'পছন্দের ভাষা বেছে নিন। পরিবর্তন তাৎক্ষণিক কার্যকর হবে।';

  @override
  String get languageContinueButton => 'চালিয়ে যান';

  @override
  String get languageSkipButton => 'এখন নয়';

  @override
  String get balanceCardLabel => 'মোট বাকি';

  @override
  String get balanceShowTooltip => 'ব্যালেন্স দেখান';

  @override
  String get balanceHideTooltip => 'ব্যালেন্স লুকান';

  @override
  String get summaryIncomeLabel => 'আপনি দিয়েছেন';

  @override
  String get summaryExpenseLabel => 'আপনি পেয়েছেন';

  @override
  String get homeCustomersHeader => 'গ্রাহক';

  @override
  String get homeAddEntryTooltip => 'এন্ট্রি যোগ করুন';

  @override
  String get homeEmptyTitle => 'এখনও কোনো গ্রাহক নেই';

  @override
  String get homeEmptyBody => 'পেমেন্ট ট্র্যাক করতে প্রথম গ্রাহক যোগ করুন।';

  @override
  String get homeEmptyAddCustomer => 'গ্রাহক যোগ করুন';

  @override
  String get navHome => 'হোম';

  @override
  String get navCustomers => 'গ্রাহক';

  @override
  String get navMore => 'আরও';

  @override
  String get navReports => 'রিপোর্ট';

  @override
  String get navSettings => 'সেটিংস';

  @override
  String get appBarNotificationsTooltip => 'বিজ্ঞপ্তি';

  @override
  String get appBarGreetingMorning => 'শুভ সকাল';

  @override
  String get appBarGreetingAfternoon => 'শুভ দুপুর';

  @override
  String get appBarGreetingEvening => 'শুভ সন্ধ্যা';

  @override
  String get quickActionAddCustomer => 'গ্রাহক যোগ করুন';

  @override
  String get quickActionGenerateBill => 'বিল তৈরি করুন';

  @override
  String get quickActionSendReminder => 'রিমাইন্ডার পাঠান';

  @override
  String get quickActionRecordPayment => 'পেমেন্ট রেকর্ড করুন';

  @override
  String get homeRecentTransactions => 'সাম্প্রতিক লেনদেন';

  @override
  String get homeSeeAll => 'সব দেখুন';

  @override
  String get homeAddEntry => 'এন্ট্রি যোগ করুন';

  @override
  String get homeNoTransactions => 'এখনও কোনো লেনদেন নেই';

  @override
  String get customersSearch => 'গ্রাহক খুঁজুন...';

  @override
  String get customersAddButton => 'গ্রাহক যোগ করুন';

  @override
  String customersNoResults(String query) {
    return '\"$query\" এর জন্য কোনো ফলাফল নেই';
  }

  @override
  String txnTimeMinutesAgo(int minutes) {
    return '$minutes মিনিট আগে';
  }

  @override
  String txnTimeToday(String time) {
    return 'আজ, $time';
  }

  @override
  String txnTimeYesterday(String time) {
    return 'গতকাল, $time';
  }

  @override
  String get txnTypeReceived => 'পেয়েছি';

  @override
  String get txnTypePaid => 'দিয়েছি';

  @override
  String get txnColGave => 'আপনি দিয়েছেন';

  @override
  String get txnColGot => 'আপনি পেয়েছেন';

  @override
  String get addCustomerTitle => 'গ্রাহক যোগ করুন';

  @override
  String get addCustomerNameLabel => 'গ্রাহকের নাম';

  @override
  String get addCustomerNameHint => 'যেমন রবি কুমার';

  @override
  String get addCustomerPhoneLabel => 'ফোন নম্বর';

  @override
  String get addCustomerPhoneHint => 'যেমন 9876543210';

  @override
  String get addCustomerShopLabel => 'দোকান / ব্যবসার নাম';

  @override
  String get addCustomerShopHint => 'যেমন রবি জেনারেল স্টোর';

  @override
  String get addCustomerBalanceLabel => 'প্রারম্ভিক ব্যালেন্স';

  @override
  String get addCustomerBalanceHint => '0';

  @override
  String get addCustomerDirectionTheyOwe => 'তারা আমাকে দেবে';

  @override
  String get addCustomerDirectionIOwe => 'আমি তাদের দেব';

  @override
  String get addCustomerSave => 'গ্রাহক সংরক্ষণ করুন';

  @override
  String get addCustomerError => 'সংরক্ষণ করা যায়নি। আবার চেষ্টা করুন।';

  @override
  String get addCustomerDuplicate =>
      'এই নাম, ফোন এবং দোকান সহ একজন গ্রাহক ইতিমধ্যে বিদ্যমান।';

  @override
  String get addCustomerNameRequired => 'নাম প্রয়োজন';

  @override
  String get addCustomerNameTooLong => 'নাম ৮০ অক্ষরের কম হতে হবে';

  @override
  String get addCustomerPhoneInvalid => 'সঠিক ফোন নম্বর দিন (১০–১৫ সংখ্যা)';

  @override
  String get addCustomerBalanceInvalid => 'সঠিক পরিমাণ দিন';

  @override
  String get customerDetailOwesYou => 'আপনি দিয়েছেন';

  @override
  String get customerDetailYouOwe => 'আপনি পেয়েছেন';

  @override
  String get customerDetailSettled => 'সমতা';

  @override
  String get customerDetailNoEntries => 'এখনো কোনো লেনদেন নেই';

  @override
  String get customerDetailNoEntriesBody =>
      'এই গ্রাহকের প্রথম লেনদেন রেকর্ড করুন।';

  @override
  String get addEntryTitle => 'এন্ট্রি যোগ করুন';

  @override
  String get addEntryGave => 'আপনি দিয়েছেন';

  @override
  String get addEntryReceived => 'আপনি পেয়েছেন';

  @override
  String get addEntryAmountLabel => 'পরিমাণ';

  @override
  String get addEntryAmountHint => '0';

  @override
  String get addEntryNoteLabel => 'বিবরণ (ঐচ্ছিক)';

  @override
  String get addEntrySave => 'সংরক্ষণ করুন';

  @override
  String get addEntryAmountRequired => 'পরিমাণ লিখুন';

  @override
  String get addEntryAmountInvalid => 'সঠিক পরিমাণ লিখুন';

  @override
  String get retryButton => 'পুনরায় চেষ্টা করুন';

  @override
  String get errorGeneric => 'কিছু একটা ভুল হয়েছে';

  @override
  String get dateToday => 'আজ';

  @override
  String get dateYesterday => 'গতকাল';

  @override
  String get txnDirectionGave => 'আপনি দিয়েছেন';

  @override
  String get txnDirectionReceived => 'আপনি পেয়েছেন';

  @override
  String get offlineSafeLabel => 'অফলাইন নিরাপদ';

  @override
  String get offlinePropertyPrivate => 'ব্যক্তিগত';

  @override
  String get offlinePropertyOffline => 'অফলাইন';

  @override
  String get offlinePropertySecure => 'নিরাপদ';

  @override
  String get editCustomerTitle => 'গ্রাহক সম্পাদনা করুন';

  @override
  String get editEntryTitle => 'এন্ট্রি সম্পাদনা করুন';

  @override
  String get contactsImportButton => 'কন্টাক্ট থেকে আমদানি করুন';

  @override
  String get contactsSyncToggle => 'ফোন কন্টাক্টে সেভ করুন';

  @override
  String get contactsSynced => 'কন্টাক্টের সাথে সিঙ্ক হয়েছে';

  @override
  String get contactsPermissionDenied => 'কন্টাক্ট অনুমতি দেওয়া হয়নি';

  @override
  String get deleteConfirmTitle => 'মুছবেন?';

  @override
  String get deleteCustomerConfirmBody =>
      'এই গ্রাহক এবং তাদের সমস্ত লেনদেন স্থায়ীভাবে মুছে যাবে।';

  @override
  String get deleteTxnConfirmBody => 'এই এন্ট্রি স্থায়ীভাবে মুছে যাবে।';

  @override
  String get deleteAction => 'মুছুন';

  @override
  String get cancelAction => 'বাতিল';

  @override
  String get reportsFilterMonth => 'এই মাস';

  @override
  String get reportsFilterYear => 'এই বছর';

  @override
  String get reportsFilterAll => 'সব সময়';

  @override
  String get reportsTotalGave => 'মোট দিয়েছি';

  @override
  String get reportsTotalGot => 'মোট পেয়েছি';

  @override
  String get reportsNetBalance => 'নিট ব্যালেন্স';

  @override
  String get reportsColCustomer => 'গ্রাহক';

  @override
  String get reportsColGave => 'দিয়েছি';

  @override
  String get reportsColGot => 'পেয়েছি';

  @override
  String get reportsColNet => 'নিট';

  @override
  String get reportsEmpty => 'এই সময়কালে কোনো লেনদেন নেই';

  @override
  String get reportsDownloadPdf => 'PDF শেয়ার করুন';

  @override
  String get reportsFilterHint => 'সময়কাল বেছে নিন';

  @override
  String get reportsPdfTitle => 'KhataPro বিবৃতি';

  @override
  String reportsPdfPeriod(String period) {
    return 'সময়কাল: $period';
  }

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get settingsLanguage => 'ভাষা';

  @override
  String get settingsLanguageSubtitle => 'অ্যাপের ভাষা পরিবর্তন করুন';

  @override
  String get settingsAboutSection => 'সম্পর্কে';

  @override
  String get settingsVersion => 'সংস্করণ';

  @override
  String get settingsPrivacyPolicy => 'গোপনীয়তা নীতি';

  @override
  String get settingsRateApp => 'KhataPro রেট করুন';

  @override
  String get recordPaymentPickerTitle => 'গ্রাহক বেছে নিন';

  @override
  String get recordPaymentPickerHint => 'গ্রাহক খুঁজুন...';

  @override
  String get profileSetupTitle => 'আপনার সম্পর্কে';

  @override
  String get profileSetupSubtitle =>
      'আপনার অভিজ্ঞতা ব্যক্তিগত করতে সাহায্য করুন।';

  @override
  String get profileNameLabel => 'আপনার নাম';

  @override
  String get profileNameHint => 'যেমন রবি কুমার';

  @override
  String get profileNameRequired => 'নাম প্রয়োজন';

  @override
  String get profileNameTooLong => 'নাম ৮০ অক্ষরের কম হতে হবে';

  @override
  String get profileShopLabel => 'ব্যবসা / দোকানের নাম';

  @override
  String get profileShopHint => 'যেমন রবি জেনারেল স্টোর';

  @override
  String get profileContinueButton => 'চালিয়ে যান';

  @override
  String get profileScreenTitle => 'আমার প্রোফাইল';

  @override
  String get profileEditButton => 'সম্পাদনা করুন';

  @override
  String get profileAuthSection => 'অ্যাকাউন্ট';

  @override
  String get profileSignInButton => 'সিঙ্ক ও ব্যাকআপের জন্য সাইন ইন করুন';

  @override
  String get reminderNoPhone => 'এই গ্রাহকের ফোন নম্বর সংরক্ষিত নেই';

  @override
  String get reminderNoBalance => 'এই গ্রাহকের কোনো বকেয়া নেই';

  @override
  String get reminderShareUnavailable =>
      'কোনো মেসেজিং অ্যাপ পাওয়া যায়নি। বার্তাটি কপি করুন এবং ম্যানুয়ালি পাঠান।';

  @override
  String get copyAction => 'কপি করুন';

  @override
  String get reminderSent => 'WhatsApp খুলছে…';

  @override
  String get reminderSendButton => 'রিমাইন্ডার পাঠান';

  @override
  String reminderMessage(String name, String amount, String business) {
    return 'নমস্কার $name, আপনার ₹$amount বকেয়া আছে। অনুগ্রহ করে দ্রুত পরিশোধ করুন। – $business';
  }

  @override
  String get catalogSectionTitle => 'ভিজিটিং কার্ড ও ক্যাটালগ';

  @override
  String get catalogAddPhoto => 'ছবি যোগ করুন';

  @override
  String get catalogTakePhoto => 'ছবি তুলুন';

  @override
  String get catalogChooseGallery => 'গ্যালারি থেকে বেছে নিন';

  @override
  String get catalogDeleteConfirm => 'এই ছবিটি সরাবেন?';

  @override
  String get reminderAttachTitle => 'কার্ড সংযুক্ত করবেন?';

  @override
  String get reminderSendWithImage => 'ছবি সহ পাঠান';

  @override
  String get reminderSendWithoutImage => 'ছবি ছাড়া পাঠান';

  @override
  String get generateBillTitle => 'বিল তৈরি করুন';

  @override
  String get billScreenTitle => 'অ্যাকাউন্ট স্টেটমেন্ট';

  @override
  String get billPeriodMonth => 'এই মাস';

  @override
  String get billPeriodYear => 'এই বছর';

  @override
  String get billPeriodAll => 'সমস্ত সময়';

  @override
  String get billPeriodCustom => 'কাস্টম';

  @override
  String billPeriodLabel(String from, String to) {
    return '$from – $to';
  }

  @override
  String get billColDate => 'তারিখ';

  @override
  String get billColNote => 'বিবরণ';

  @override
  String get billColGave => 'দিয়েছি';

  @override
  String get billColGot => 'পেয়েছি';

  @override
  String get billTotalGave => 'মোট দিয়েছি';

  @override
  String get billTotalGot => 'মোট পেয়েছি';

  @override
  String get billNetBalance => 'বকেয়া পরিমাণ';

  @override
  String get billYouAreOwed => 'আপনি পাবেন';

  @override
  String get billYouOwe => 'আপনাকে দিতে হবে';

  @override
  String get billEmpty => 'এই সময়কালে কোনো লেনদেন নেই';

  @override
  String get billShareButton => 'PDF হিসেবে শেয়ার করুন';

  @override
  String get billCustomRange => 'তারিখ পরিসর নির্বাচন করুন';

  @override
  String get billFilterHint => 'সময়কাল বেছে নিন';

  @override
  String get backupSectionTitle => 'ডেটা';

  @override
  String get backupTileTitle => 'ডেটা ব্যাকআপ করুন';

  @override
  String get backupTileSubtitle => 'সমস্ত গ্রাহক ও লেনদেন রপ্তানি করুন';

  @override
  String get restoreTileTitle => 'ব্যাকআপ থেকে পুনরুদ্ধার করুন';

  @override
  String get restoreTileSubtitle =>
      'ব্যাকআপ ফাইল থেকে সমস্ত ডেটা প্রতিস্থাপন করুন';

  @override
  String get restoreConfirmTitle => 'সমস্ত ডেটা প্রতিস্থাপন করবেন?';

  @override
  String get restoreConfirmBody =>
      'এটি আপনার সমস্ত বর্তমান ডেটা ব্যাকআপ দিয়ে স্থায়ীভাবে প্রতিস্থাপন করবে। এটি পূর্বাবস্থায় ফেরানো যাবে না।';

  @override
  String get restoreSuccess => 'ডেটা সফলভাবে পুনরুদ্ধার হয়েছে';

  @override
  String get restoreError =>
      'ব্যাকআপ পুনরুদ্ধার করা যায়নি। ফাইলটি অবৈধ বা দূষিত হতে পারে।';

  @override
  String get remindersSectionTitle => 'রিমাইন্ডার';

  @override
  String get defaultReminderTitle => 'ডিফল্ট রিমাইন্ডার';

  @override
  String get defaultReminderSubtitle =>
      'নতুন গ্রাহকদের জন্য স্বয়ংক্রিয়ভাবে প্রযোজ্য';

  @override
  String get defaultReminderSheetHint =>
      'নতুন গ্রাহক যোগ করার সময় আগে থেকে নির্বাচিত হয়। প্রতিটি গ্রাহকের রিমাইন্ডার আলাদাভাবে সেট করা হয়।';

  @override
  String get setReminderTitle => 'রিমাইন্ডার সেট করুন';

  @override
  String get reminderFrequencyNone => 'কোনোটি নয়';

  @override
  String get reminderFrequencyWeekly => 'সাপ্তাহিক';

  @override
  String get reminderFrequencyFortnightly => 'প্রতি ২ সপ্তাহ';

  @override
  String get reminderFrequencyMonthly => 'মাসিক';

  @override
  String get reminderModeRecurring => 'পুনরাবৃত্তি';

  @override
  String get reminderModeOnDate => 'একটি তারিখে';

  @override
  String get reminderDateLabel => 'স্মরণিকা তারিখ';

  @override
  String get reminderDateHint => 'তারিখ বেছে নিন';

  @override
  String get reminderDatePast => 'অনুগ্রহ করে ভবিষ্যতের তারিখ বেছে নিন';

  @override
  String get reminderTimeMorning => 'সকাল · ৯টা';

  @override
  String get reminderTimeAfternoon => 'দুপুর · ১টা';

  @override
  String get reminderTimeEvening => 'সন্ধ্যা · ৬টা';

  @override
  String reminderActiveChip(String freq) {
    return '$freq রিমাইন্ডার';
  }

  @override
  String get reminderNotifTitle => 'পেমেন্ট রিমাইন্ডার';

  @override
  String reminderNotifBody(String name, String amount) {
    return '$name ₹$amount বকেয়া — রিমাইন্ডার পাঠাতে ট্যাপ করুন';
  }

  @override
  String get authSignInTitle => 'সিঙ্ক ও ব্যাকআপের জন্য সাইন ইন করুন';

  @override
  String get authSignInSubtitle => 'আপনার ডেটা সব ডিভাইসে সুরক্ষিত থাকে';

  @override
  String get authPhoneButton => 'ফোন দিয়ে চালিয়ে যান';

  @override
  String get authGoogleButton => 'Google দিয়ে চালিয়ে যান';

  @override
  String get authOrDivider => 'অথবা';

  @override
  String get authPhoneStepTitle => 'আপনার ফোন নম্বর দিন';

  @override
  String get authPhoneStepSubtitle => 'আপনার নম্বর যাচাই করতে একটি কোড পাঠাব';

  @override
  String get authPhoneLabel => 'ফোন নম্বর';

  @override
  String get authPhoneHint => '+91 98765 43210';

  @override
  String get authSendOtpButton => 'OTP পাঠান';

  @override
  String get authOtpTitle => 'OTP দিন';

  @override
  String get authOtpLabel => '৬ সংখ্যার কোড';

  @override
  String authOtpSubtitle(String phone) {
    return '$phone নম্বরে পাঠানো হয়েছে';
  }

  @override
  String get authVerifyButton => 'যাচাই করুন';

  @override
  String get authResendOtp => 'OTP পুনরায় পাঠান';

  @override
  String get authOtpResent => 'OTP সফলভাবে পুনরায় পাঠানো হয়েছে';

  @override
  String get authDidntReceive => 'পাননি?';

  @override
  String authResendIn(int seconds) {
    return '${seconds}s এ পুনরায় পাঠান';
  }

  @override
  String get authSignOut => 'সাইন আউট';

  @override
  String authSignedInAs(String name) {
    return '$name হিসেবে সাইন ইন করা আছে';
  }

  @override
  String get authSkip => 'এখন এড়িয়ে যান';

  @override
  String get authSyncingData => 'Syncing your dataâ¦';

  @override
  String get authDataSynced => 'সমস্ত ডেটা ক্লাউডে সিঙ্ক হয়েছে';

  @override
  String get syncUnsyncedBanner =>
      'সিঙ্ক না হওয়া পরিবর্তন — সিঙ্ক করতে ইন্টারনেটে সংযুক্ত হন।';

  @override
  String get syncCloudWinsTitle => 'স্থানীয় ডেটা প্রতিস্থাপন করবেন?';

  @override
  String get syncCloudWinsBody =>
      'সাইন ইন করলে আপনার সমস্ত স্থানীয় ডেটা ক্লাউড ব্যাকআপ দিয়ে প্রতিস্থাপিত হবে। এটি পূর্বাবস্থায় ফেরানো যাবে না।';

  @override
  String get offlineBar => 'ইন্টারনেট সংযোগ নেই';

  @override
  String get firstRunTitle => 'KhataPro-তে স্বাগতম!';

  @override
  String get firstRunBody =>
      'গ্রাহকরা কত বকেয়া আছে তা ট্র্যাক করুন — কাগজ দরকার নেই।';

  @override
  String get firstRunStep1 => 'একজন গ্রাহক যোগ করুন';

  @override
  String get firstRunStep2 => 'পেমেন্ট রেকর্ড করুন';

  @override
  String get firstRunStep3 => 'রিমাইন্ডার পাঠান';

  @override
  String get firstRunDismiss => 'বুঝেছি';

  @override
  String get reportsFilterCustomer => 'সকল গ্রাহক';

  @override
  String get reportsFilterByCustomer => 'গ্রাহক দ্বারা ফিল্টার করুন';

  @override
  String reportsCustomerSelected(String name) {
    return '$name-এর রিপোর্ট';
  }

  @override
  String get appLockSectionTitle => 'নিরাপত্তা';

  @override
  String get appLockTileTitle => 'অ্যাপ লক';

  @override
  String get appLockTileSubtitle => 'খুলতে বায়োমেট্রিক বা PIN প্রয়োজন';

  @override
  String get appLockSetPin => 'PIN সেট করুন';

  @override
  String get pinSetupTitle => 'PIN তৈরি করুন';

  @override
  String get pinSetupSubtitle =>
      'বায়োমেট্রিক ব্যর্থ হলে বিকল্প হিসেবে ব্যবহার হবে';

  @override
  String get pinConfirmTitle => 'আপনার PIN নিশ্চিত করুন';

  @override
  String get pinMismatch => 'PIN মিলছে না। আবার চেষ্টা করুন।';

  @override
  String get pinIncorrect => 'ভুল PIN। আবার চেষ্টা করুন।';

  @override
  String get pinEnterTitle => 'আপনার PIN লিখুন';

  @override
  String get pinForgot => 'PIN ভুলে গেছেন? রিসেট করতে সাইন ইন করুন';

  @override
  String get biometricReason => 'KhataPro আনলক করুন';

  @override
  String get appLockDisabledInfo => 'অ্যাপ লক নিষ্ক্রিয়';

  @override
  String get notifPermDenied =>
      'বিজ্ঞপ্তির অনুমতি প্রত্যাখ্যান করা হয়েছে। রিমাইন্ডার পেতে সেটিংসে এটি সক্ষম করুন।';
}
