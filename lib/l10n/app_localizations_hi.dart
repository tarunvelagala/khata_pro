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

  @override
  String get addCustomerTitle => 'ग्राहक जोड़ें';

  @override
  String get addCustomerNameLabel => 'ग्राहक का नाम';

  @override
  String get addCustomerNameHint => 'जैसे रवि कुमार';

  @override
  String get addCustomerPhoneLabel => 'फ़ोन नंबर';

  @override
  String get addCustomerPhoneHint => 'जैसे 9876543210';

  @override
  String get addCustomerShopLabel => 'दुकान / व्यवसाय का नाम';

  @override
  String get addCustomerShopHint => 'जैसे रवि जनरल स्टोर';

  @override
  String get addCustomerBalanceLabel => 'शुरुआती बकाया';

  @override
  String get addCustomerBalanceHint => '0';

  @override
  String get addCustomerDirectionTheyOwe => 'उन्हें देना है';

  @override
  String get addCustomerDirectionIOwe => 'मुझे देना है';

  @override
  String get addCustomerSave => 'ग्राहक सहेजें';

  @override
  String get addCustomerError => 'सहेजा नहीं जा सका। फिर से प्रयास करें।';

  @override
  String get addCustomerDuplicate =>
      'इस नाम, फ़ोन और दुकान वाला ग्राहक पहले से मौजूद है।';

  @override
  String get addCustomerNameRequired => 'नाम आवश्यक है';

  @override
  String get addCustomerNameTooLong => 'नाम 80 अक्षरों से कम होना चाहिए';

  @override
  String get addCustomerPhoneInvalid => 'वैध फ़ोन नंबर दर्ज करें (10–15 अंक)';

  @override
  String get addCustomerBalanceInvalid => 'वैध राशि दर्ज करें';

  @override
  String get customerDetailOwesYou => 'आपको देना है';

  @override
  String get customerDetailYouOwe => 'आपको देना है';

  @override
  String get customerDetailSettled => 'बराबर';

  @override
  String get customerDetailNoEntries => 'अभी कोई लेन-देन नहीं';

  @override
  String get customerDetailNoEntriesBody =>
      'इस ग्राहक का पहला लेन-देन दर्ज करें।';

  @override
  String get customerDetailAddFirstEntry => 'पहला लेन-देन जोड़ें';

  @override
  String get addEntryTitle => 'एंट्री जोड़ें';

  @override
  String get addEntryGave => 'आपने दिया';

  @override
  String get addEntryReceived => 'आपको मिला';

  @override
  String get addEntryAmountLabel => 'राशि';

  @override
  String get addEntryAmountHint => '0';

  @override
  String get addEntryNoteLabel => 'नोट (वैकल्पिक)';

  @override
  String get addEntrySave => 'सहेजें';

  @override
  String get addEntryAmountRequired => 'राशि दर्ज करें';

  @override
  String get addEntryAmountInvalid => 'वैध राशि दर्ज करें';

  @override
  String get retryButton => 'पुनः प्रयास करें';

  @override
  String get dateToday => 'आज';

  @override
  String get dateYesterday => 'कल';

  @override
  String get txnDirectionGave => 'आपने दिया';

  @override
  String get txnDirectionReceived => 'आपने पाया';

  @override
  String get offlineSafeLabel => 'ऑफ़लाइन सुरक्षित';

  @override
  String get offlinePropertyPrivate => 'निजी';

  @override
  String get offlinePropertyOffline => 'ऑफ़लाइन';

  @override
  String get offlinePropertySecure => 'सुरक्षित';

  @override
  String get editCustomerTitle => 'ग्राहक संपादित करें';

  @override
  String get editEntryTitle => 'एंट्री संपादित करें';

  @override
  String get deleteConfirmTitle => 'हटाएं?';

  @override
  String get deleteCustomerConfirmBody =>
      'यह ग्राहक और उनके सभी लेनदेन स्थायी रूप से हटा दिए जाएंगे।';

  @override
  String get deleteTxnConfirmBody => 'यह एंट्री स्थायी रूप से हटा दी जाएगी।';

  @override
  String get deleteAction => 'हटाएं';

  @override
  String get cancelAction => 'रद्द करें';
}
