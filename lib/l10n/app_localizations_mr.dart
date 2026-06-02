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

  @override
  String get addCustomerTitle => 'ग्राहक जोडा';

  @override
  String get addCustomerNameLabel => 'ग्राहकाचे नाव';

  @override
  String get addCustomerNameHint => 'उदा. रवी कुमार';

  @override
  String get addCustomerPhoneLabel => 'फोन नंबर';

  @override
  String get addCustomerPhoneHint => 'उदा. 9876543210';

  @override
  String get addCustomerShopLabel => 'दुकान / व्यवसायाचे नाव';

  @override
  String get addCustomerShopHint => 'उदा. रवी जनरल स्टोअर';

  @override
  String get addCustomerBalanceLabel => 'प्रारंभिक शिल्लक';

  @override
  String get addCustomerBalanceHint => '0';

  @override
  String get addCustomerDirectionTheyOwe => 'त्यांनी मला द्यायचे आहे';

  @override
  String get addCustomerDirectionIOwe => 'मी त्यांना द्यायचे आहे';

  @override
  String get addCustomerSave => 'ग्राहक जतन करा';

  @override
  String get addCustomerError => 'जतन करता आले नाही. पुन्हा प्रयत्न करा.';

  @override
  String get addCustomerDuplicate =>
      'या नाव, फोन आणि दुकानासह ग्राहक आधीच अस्तित्वात आहे.';

  @override
  String get addCustomerNameRequired => 'नाव आवश्यक आहे';

  @override
  String get addCustomerNameTooLong => 'नाव ८० अक्षरांपेक्षा कमी असावे';

  @override
  String get addCustomerPhoneInvalid => 'वैध फोन नंबर प्रविष्ट करा (10–15 अंक)';

  @override
  String get addCustomerBalanceInvalid => 'वैध रक्कम प्रविष्ट करा';

  @override
  String get customerDetailOwesYou => 'तुम्हाला द्यायचे आहे';

  @override
  String get customerDetailYouOwe => 'तुम्ही द्यायचे आहे';

  @override
  String get customerDetailSettled => 'बरोबर';

  @override
  String get customerDetailNoEntries => 'अजून कोणतेही व्यवहार नाहीत';

  @override
  String get customerDetailNoEntriesBody =>
      'या ग्राहकाचा पहिला व्यवहार नोंदवा.';

  @override
  String get customerDetailAddFirstEntry => 'पहिली नोंद जोडा';

  @override
  String get addEntryTitle => 'नोंद जोडा';

  @override
  String get addEntryGave => 'तुम्ही दिले';

  @override
  String get addEntryReceived => 'तुम्हाला मिळाले';

  @override
  String get addEntryAmountLabel => 'रक्कम';

  @override
  String get addEntryAmountHint => '0';

  @override
  String get addEntryNoteLabel => 'नोट (पर्यायी)';

  @override
  String get addEntrySave => 'जतन करा';

  @override
  String get addEntryAmountRequired => 'रक्कम प्रविष्ट करा';

  @override
  String get addEntryAmountInvalid => 'वैध रक्कम प्रविष्ट करा';

  @override
  String get retryButton => 'पुन्हा प्रयत्न करा';

  @override
  String get dateToday => 'आज';

  @override
  String get dateYesterday => 'काल';

  @override
  String get txnDirectionGave => 'तुम्ही दिले';

  @override
  String get txnDirectionReceived => 'तुम्हाला मिळाले';

  @override
  String get offlineSafeLabel => 'ऑफलाइन सुरक्षित';

  @override
  String get offlinePropertyPrivate => 'खाजगी';

  @override
  String get offlinePropertyOffline => 'ऑफलाइन';

  @override
  String get offlinePropertySecure => 'सुरक्षित';

  @override
  String get editCustomerTitle => 'ग्राहक संपादित करा';

  @override
  String get editEntryTitle => 'नोंद संपादित करा';

  @override
  String get deleteConfirmTitle => 'हटवायचे?';

  @override
  String get deleteCustomerConfirmBody =>
      'हा ग्राहक आणि त्यांचे सर्व व्यवहार कायमचे हटवले जातील.';

  @override
  String get deleteTxnConfirmBody => 'ही नोंद कायमची हटवली जाईल.';

  @override
  String get deleteAction => 'हटवा';

  @override
  String get cancelAction => 'रद्द करा';
}
