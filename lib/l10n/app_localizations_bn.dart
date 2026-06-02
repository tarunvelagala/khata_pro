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
  String get summaryIncomeLabel => 'আপনি পাবেন';

  @override
  String get summaryExpenseLabel => 'আপনি দেবেন';

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
  String get customerDetailOwesYou => 'আপনাকে দিতে হবে';

  @override
  String get customerDetailYouOwe => 'আপনি দিতে হবে';

  @override
  String get customerDetailSettled => 'সমতা';

  @override
  String get customerDetailNoEntries => 'এখনো কোনো লেনদেন নেই';

  @override
  String get customerDetailNoEntriesBody =>
      'এই গ্রাহকের প্রথম লেনদেন রেকর্ড করুন।';

  @override
  String get customerDetailAddFirstEntry => 'প্রথম এন্ট্রি যোগ করুন';

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
  String get addEntryNoteLabel => 'নোট (ঐচ্ছিক)';

  @override
  String get addEntrySave => 'সংরক্ষণ করুন';

  @override
  String get addEntryAmountRequired => 'পরিমাণ লিখুন';

  @override
  String get addEntryAmountInvalid => 'সঠিক পরিমাণ লিখুন';

  @override
  String get retryButton => 'পুনরায় চেষ্টা করুন';

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
}
