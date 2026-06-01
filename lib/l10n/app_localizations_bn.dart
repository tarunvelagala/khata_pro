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
}
