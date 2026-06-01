// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'खाता प्रो';

  @override
  String get appTagline => 'खाता प्रो डिजिटल बही खाता';

  @override
  String get tourHeadline1 => 'हर रुपया ट्रैक करें';

  @override
  String get tourBody1 =>
      'ग्राहक जोड़ें, उनका उधार और आपका उधार रिकॉर्ड करें। बैलेंस तुरंत अपडेट होता है।';

  @override
  String get tourHeadline2 => 'आसानी से रिमाइंडर भेजें';

  @override
  String get tourBody2 =>
      'WhatsApp या SMS से एक टैप में पेमेंट रिमाइंडर भेजें। विज़िटिंग कार्ड भी अटैच करें।';

  @override
  String get tourHeadline3 => 'आपका डेटा, हमेशा सुरक्षित';

  @override
  String get tourBody3 =>
      'सब कुछ आपके फोन में प्राइवेट रूप से स्टोर है। कोई अकाउंट नहीं चाहिए। ऑफलाइन भी काम करता है।';

  @override
  String get tourNext => 'आगे';

  @override
  String get tourGetStarted => 'शुरू करें';

  @override
  String get tourSkip => 'छोड़ें';

  @override
  String get tourSwipeHint => 'स्वाइप करें';

  @override
  String get languageScreenTitle => 'भाषा चुनें';

  @override
  String get languageScreenSubtitle =>
      'अपनी पसंदीदा भाषा चुनें। बदलाव तुरंत लागू होगा।';

  @override
  String get languageContinueButton => 'जारी रखें';

  @override
  String get languageSkipButton => 'अभी नहीं';

  @override
  String get balanceCardLabel => 'कुल बकाया';

  @override
  String get balanceShowTooltip => 'बकाया दिखाएं';

  @override
  String get balanceHideTooltip => 'बकाया छुपाएं';

  @override
  String get summaryIncomeLabel => 'आपको मिलेगा';

  @override
  String get summaryExpenseLabel => 'आपको देना है';

  @override
  String get homeCustomersHeader => 'ग्राहक';

  @override
  String get homeAddEntryTooltip => 'एंट्री जोड़ें';

  @override
  String get homeEmptyTitle => 'अभी कोई ग्राहक नहीं';

  @override
  String get homeEmptyBody => 'भुगतान ट्रैक करने के लिए पहला ग्राहक जोड़ें।';

  @override
  String get homeEmptyAddCustomer => 'ग्राहक जोड़ें';

  @override
  String get navHome => 'होम';

  @override
  String get navCustomers => 'ग्राहक';

  @override
  String get navMore => 'अधिक';

  @override
  String get navReports => 'रिपोर्ट';

  @override
  String get navSettings => 'सेटिंग्स';

  @override
  String get appBarNotificationsTooltip => 'सूचनाएं';

  @override
  String get appBarGreetingMorning => 'शुभ प्रभात';

  @override
  String get appBarGreetingAfternoon => 'शुभ दोपहर';

  @override
  String get appBarGreetingEvening => 'शुभ संध्या';

  @override
  String get quickActionAddCustomer => 'ग्राहक जोड़ें';

  @override
  String get quickActionGenerateBill => 'बिल बनाएं';

  @override
  String get quickActionSendReminder => 'रिमाइंडर भेजें';

  @override
  String get quickActionRecordPayment => 'भुगतान दर्ज करें';

  @override
  String get homeRecentTransactions => 'हाल के लेनदेन';

  @override
  String get homeSeeAll => 'सभी देखें';

  @override
  String get homeAddEntry => 'एंट्री जोड़ें';

  @override
  String get customersSearch => 'ग्राहक खोजें...';

  @override
  String get customersAddButton => 'ग्राहक जोड़ें';

  @override
  String customersNoResults(String query) {
    return '\"$query\" के लिए कोई परिणाम नहीं';
  }

  @override
  String txnTimeMinutesAgo(int minutes) {
    return '$minutes मिनट पहले';
  }

  @override
  String txnTimeToday(String time) {
    return 'आज, $time';
  }

  @override
  String txnTimeYesterday(String time) {
    return 'कल, $time';
  }

  @override
  String get txnTypeReceived => 'मिला';

  @override
  String get txnTypePaid => 'दिया';
}
