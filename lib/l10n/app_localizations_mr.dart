// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appName => 'खाता प्रो';

  @override
  String get appTagline => 'खाता प्रो डिजिटल बही खाता';

  @override
  String get tourHeadline1 => 'प्रत्येक रुपया ट्रॅक करा';

  @override
  String get tourBody1 =>
      'ग्राहक जोडा, त्यांचे आणि तुमचे उधार नोंदवा. शिल्लक लगेच अपडेट होते.';

  @override
  String get tourHeadline2 => 'सहज रिमाइंडर पाठवा';

  @override
  String get tourBody2 =>
      'WhatsApp किंवा SMS वर एका टॅपमध्ये पेमेंट रिमाइंडर पाठवा. व्हिजिटिंग कार्ड देखील जोडा.';

  @override
  String get tourHeadline3 => 'तुमचा डेटा, नेहमी सुरक्षित';

  @override
  String get tourBody3 =>
      'सर्वकाही तुमच्या फोनमध्ये खाजगीरित्या साठवले आहे. कोणतेही खाते लागत नाही. ऑफलाइनही काम करते.';

  @override
  String get tourNext => 'पुढे';

  @override
  String get tourGetStarted => 'सुरू करा';

  @override
  String get tourSkip => 'वगळा';

  @override
  String get tourSwipeHint => 'स्वाइप करा';

  @override
  String get languageScreenTitle => 'भाषा निवडा';

  @override
  String get languageScreenSubtitle =>
      'पसंतीची भाषा निवडा. बदल लगेच लागू होईल.';

  @override
  String get languageContinueButton => 'पुढे चला';

  @override
  String get languageSkipButton => 'आत्ता नाही';

  @override
  String get balanceCardLabel => 'एकूण शिल्लक';

  @override
  String get balanceShowTooltip => 'शिल्लक दाखवा';

  @override
  String get balanceHideTooltip => 'शिल्लक लपवा';

  @override
  String get summaryIncomeLabel => 'तुम्हाला मिळणार';

  @override
  String get summaryExpenseLabel => 'तुम्हाला द्यायचे';

  @override
  String get homeCustomersHeader => 'ग्राहक';

  @override
  String get homeAddEntryTooltip => 'नोंद जोडा';

  @override
  String get homeEmptyTitle => 'अजून कोणतेही ग्राहक नाहीत';

  @override
  String get homeEmptyBody => 'पेमेंट ट्रॅक करण्यासाठी पहिला ग्राहक जोडा.';

  @override
  String get homeEmptyAddCustomer => 'ग्राहक जोडा';

  @override
  String get navHome => 'मुख्यपृष्ठ';

  @override
  String get navCustomers => 'ग्राहक';

  @override
  String get navMore => 'अधिक';

  @override
  String get navReports => 'अहवाल';

  @override
  String get navSettings => 'सेटिंग्ज';

  @override
  String get appBarNotificationsTooltip => 'सूचना';

  @override
  String get appBarGreetingMorning => 'शुभ सकाळ';

  @override
  String get appBarGreetingAfternoon => 'शुभ दुपार';

  @override
  String get appBarGreetingEvening => 'शुभ संध्याकाळ';

  @override
  String get quickActionAddCustomer => 'ग्राहक जोडा';

  @override
  String get quickActionGenerateBill => 'बिल तयार करा';

  @override
  String get quickActionSendReminder => 'रिमाइंडर पाठवा';

  @override
  String get quickActionRecordPayment => 'पेमेंट नोंदवा';

  @override
  String get homeRecentTransactions => 'अलीकडील व्यवहार';

  @override
  String get homeSeeAll => 'सर्व पहा';

  @override
  String get homeAddEntry => 'नोंद जोडा';

  @override
  String get customersSearch => 'ग्राहक शोधा...';

  @override
  String get customersAddButton => 'ग्राहक जोडा';

  @override
  String customersNoResults(String query) {
    return '\"$query\" साठी कोणतेही निकाल नाहीत';
  }

  @override
  String txnTimeMinutesAgo(int minutes) {
    return '$minutes मिनिटांपूर्वी';
  }

  @override
  String txnTimeToday(String time) {
    return 'आज, $time';
  }

  @override
  String txnTimeYesterday(String time) {
    return 'काल, $time';
  }

  @override
  String get txnTypeReceived => 'मिळाले';

  @override
  String get txnTypePaid => 'दिले';
}
