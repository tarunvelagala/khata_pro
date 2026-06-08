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
  String get scrollForMore => 'Scroll for more';

  @override
  String get balanceCardLabel => 'कुल बकाया';

  @override
  String get balanceShowTooltip => 'बकाया दिखाएं';

  @override
  String get balanceHideTooltip => 'बकाया छुपाएं';

  @override
  String get summaryIncomeLabel => 'आपने दिया';

  @override
  String get summaryExpenseLabel => 'आपको मिला';

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
  String get homeNoTransactions => 'अभी तक कोई लेन-देन नहीं';

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
  String get txnColGave => 'आपने दिया';

  @override
  String get txnColGot => 'आपको मिला';

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
  String get customerDetailOwesYou => 'आपने दिया';

  @override
  String get customerDetailYouOwe => 'आपको मिला';

  @override
  String get customerDetailSettled => 'बराबर';

  @override
  String get customerDetailNoEntries => 'अभी कोई लेन-देन नहीं';

  @override
  String get customerDetailNoEntriesBody =>
      'इस ग्राहक का पहला लेन-देन दर्ज करें।';

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
  String get addEntryNoteLabel => 'विवरण (वैकल्पिक)';

  @override
  String get addEntrySave => 'सहेजें';

  @override
  String get addEntryAmountRequired => 'राशि दर्ज करें';

  @override
  String get addEntryAmountInvalid => 'वैध राशि दर्ज करें';

  @override
  String get retryButton => 'पुनः प्रयास करें';

  @override
  String get errorGeneric => 'कुछ गलत हो गया';

  @override
  String get dateToday => 'आज';

  @override
  String get dateYesterday => 'कल';

  @override
  String get txnDirectionGave => 'आपने दिया';

  @override
  String get txnDirectionReceived => 'आपको मिला';

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
  String get contactsImportButton => 'कॉन्टैक्ट से आयात करें';

  @override
  String get contactsSyncToggle => 'फ़ोन कॉन्टैक्ट में सेव करें';

  @override
  String get contactsSynced => 'कॉन्टैक्ट से सिंक है';

  @override
  String get contactsPermissionDenied => 'कॉन्टैक्ट की अनुमति नहीं मिली';

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

  @override
  String get restoreAction => 'पुनर्स्थापित करें';

  @override
  String get reportsFilterMonth => 'इस महीने';

  @override
  String get reportsFilterYear => 'इस साल';

  @override
  String get reportsFilterAll => 'सभी समय';

  @override
  String get reportsTotalGave => 'कुल दिया';

  @override
  String get reportsTotalGot => 'कुल लिया';

  @override
  String get reportsNetBalance => 'शुद्ध शेष';

  @override
  String get reportsColCustomer => 'ग्राहक';

  @override
  String get reportsColGave => 'दिया';

  @override
  String get reportsColGot => 'लिया';

  @override
  String get reportsColNet => 'शुद्ध';

  @override
  String get reportsWillReceive => 'आप पाएंगे';

  @override
  String get reportsWillPay => 'आप देंगे';

  @override
  String get reportsEmpty => 'इस अवधि में कोई लेनदेन नहीं';

  @override
  String get reportsDownloadPdf => 'PDF शेयर करें';

  @override
  String get reportsFilterHint => 'अवधि के अनुसार फ़िल्टर करें';

  @override
  String get reportsPdfTitle => 'KhataPro विवरण';

  @override
  String reportsPdfPeriod(String period) {
    return 'अवधि: $period';
  }

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsLanguageSubtitle => 'ऐप की भाषा बदलें';

  @override
  String get settingsAboutSection => 'के बारे में';

  @override
  String get settingsVersion => 'संस्करण';

  @override
  String get settingsPrivacyPolicy => 'गोपनीयता नीति';

  @override
  String get settingsRateApp => 'KhataPro को रेट करें';

  @override
  String get recordPaymentPickerTitle => 'ग्राहक चुनें';

  @override
  String get recordPaymentPickerHint => 'ग्राहक खोजें...';

  @override
  String get profileSetupTitle => 'आपके बारे में';

  @override
  String get profileSetupSubtitle =>
      'हमें आपका अनुभव बेहतर बनाने में मदद करें।';

  @override
  String get profileNameLabel => 'आपका नाम';

  @override
  String get profileNameHint => 'जैसे रवि कुमार';

  @override
  String get profileNameRequired => 'नाम आवश्यक है';

  @override
  String get profileNameTooLong => 'नाम 80 अक्षरों से कम होना चाहिए';

  @override
  String get profileShopLabel => 'व्यवसाय / दुकान का नाम';

  @override
  String get profileShopHint => 'जैसे रवि जनरल स्टोर';

  @override
  String get profileContinueButton => 'जारी रखें';

  @override
  String get profileScreenTitle => 'मेरी प्रोफ़ाइल';

  @override
  String get profileEditButton => 'संपादित करें';

  @override
  String get profileAuthSection => 'खाता';

  @override
  String get profileSignInButton => 'सिंक और बैकअप के लिए साइन इन करें';

  @override
  String get reminderNoPhone => 'इस ग्राहक का फ़ोन नंबर सेव नहीं है';

  @override
  String get reminderNoBalance => 'इस ग्राहक का कोई बकाया नहीं है';

  @override
  String get reminderShareUnavailable =>
      'कोई मैसेजिंग ऐप नहीं मिला। संदेश कॉपी करें और मैन्युअली भेजें।';

  @override
  String get copyAction => 'कॉपी करें';

  @override
  String get reminderSent => 'WhatsApp खुल रहा है…';

  @override
  String get reminderSendButton => 'रिमाइंडर भेजें';

  @override
  String reminderMessage(String name, String amount, String business) {
    return 'नमस्ते $name, आपका ₹$amount का बकाया है। कृपया जल्द से जल्द भुगतान करें। – $business';
  }

  @override
  String get catalogSectionTitle => 'विजिटिंग कार्ड और कैटलॉग';

  @override
  String get catalogAddPhoto => 'फोटो जोड़ें';

  @override
  String get catalogTakePhoto => 'फोटो खींचें';

  @override
  String get catalogChooseGallery => 'गैलरी से चुनें';

  @override
  String get catalogDeleteConfirm => 'यह छवि हटाएं?';

  @override
  String get reminderAttachTitle => 'कार्ड संलग्न करें?';

  @override
  String get reminderSendWithImage => 'छवि के साथ भेजें';

  @override
  String get reminderSendWithoutImage => 'बिना छवि के भेजें';

  @override
  String get generateBillTitle => 'बिल बनाएं';

  @override
  String get billScreenTitle => 'खाता विवरण';

  @override
  String get billPeriodMonth => 'इस माह';

  @override
  String get billPeriodYear => 'इस साल';

  @override
  String get billPeriodAll => 'सभी समय';

  @override
  String get billPeriodCustom => 'कस्टम';

  @override
  String billPeriodLabel(String from, String to) {
    return '$from – $to';
  }

  @override
  String get billColDate => 'तारीख';

  @override
  String get billColNote => 'विवरण';

  @override
  String get billColGave => 'दिया';

  @override
  String get billColGot => 'मिला';

  @override
  String get billTotalGave => 'कुल दिया';

  @override
  String get billTotalGot => 'कुल मिला';

  @override
  String get billNetBalance => 'बकाया राशि';

  @override
  String get billYouAreOwed => 'आपको मिलना है';

  @override
  String get billYouOwe => 'आपको देना है';

  @override
  String get billEmpty => 'इस अवधि में कोई लेनदेन नहीं';

  @override
  String get billShareButton => 'PDF के रूप में शेयर करें';

  @override
  String get billCustomRange => 'तारीख सीमा चुनें';

  @override
  String get billFilterHint => 'अवधि के अनुसार फ़िल्टर करें';

  @override
  String get backupSectionTitle => 'डेटा';

  @override
  String get backupTileTitle => 'डेटा बैकअप करें';

  @override
  String get backupTileSubtitle => 'सभी ग्राहक और लेनदेन निर्यात करें';

  @override
  String get restoreTileTitle => 'बैकअप से पुनर्स्थापित करें';

  @override
  String get restoreTileSubtitle => 'बैकअप फ़ाइल से सभी डेटा बदलें';

  @override
  String get restoreConfirmTitle => 'सभी डेटा बदलें?';

  @override
  String get restoreConfirmBody =>
      'यह आपके सभी मौजूदा डेटा को बैकअप से स्थायी रूप से बदल देगा। इसे पूर्ववत नहीं किया जा सकता।';

  @override
  String get restoreSuccess => 'डेटा सफलतापूर्वक पुनर्स्थापित किया गया';

  @override
  String get restoreError =>
      'बैकअप पुनर्स्थापित नहीं हो सका। फ़ाइल अमान्य या दूषित हो सकती है।';

  @override
  String get backupExportError =>
      'बैकअप निर्यात नहीं हो सका। कृपया पुनः प्रयास करें।';

  @override
  String get backupEmptyError =>
      'बैकअप के लिए कोई डेटा नहीं है। पहले ग्राहक जोड़ें।';

  @override
  String get remindersSectionTitle => 'रिमाइंडर';

  @override
  String get defaultReminderTitle => 'डिफ़ॉल्ट रिमाइंडर';

  @override
  String get defaultReminderSubtitle => 'नए ग्राहकों पर अपने आप लागू होता है';

  @override
  String get defaultReminderSheetHint =>
      'नया ग्राहक जोड़ते समय पहले से चुना जाता है। हर ग्राहक का रिमाइंडर अलग से सेट होता है।';

  @override
  String get setReminderTitle => 'रिमाइंडर सेट करें';

  @override
  String get setReminderSave => 'रिमाइंडर सेट करें';

  @override
  String get reminderFrequencyNone => 'कोई नहीं';

  @override
  String get reminderFrequencyWeekly => 'साप्ताहिक';

  @override
  String get reminderFrequencyFortnightly => 'हर 2 सप्ताह';

  @override
  String get reminderFrequencyMonthly => 'मासिक';

  @override
  String get reminderModeRecurring => 'बार-बार';

  @override
  String get reminderModeOnDate => 'एक तारीख पर';

  @override
  String get reminderDateLabel => 'रिमाइंडर तारीख';

  @override
  String get reminderDateHint => 'तारीख चुनें';

  @override
  String get reminderDatePast => 'कृपया भविष्य की तारीख चुनें';

  @override
  String get reminderTimeMorning => 'सुबह · 9 बजे';

  @override
  String get reminderTimeAfternoon => 'दोपहर · 1 बजे';

  @override
  String get reminderTimeEvening => 'शाम · 6 बजे';

  @override
  String reminderActiveChip(String freq) {
    return '$freq रिमाइंडर';
  }

  @override
  String get reminderNotifTitle => 'भुगतान रिमाइंडर';

  @override
  String reminderNotifBody(String name, String amount) {
    return '$name पर ₹$amount बकाया है — रिमाइंडर भेजने के लिए टैप करें';
  }

  @override
  String get authSignInTitle => 'सिंक और बैकअप के लिए साइन इन करें';

  @override
  String get authSignInSubtitle => 'आपका डेटा सभी डिवाइस पर सुरक्षित रहता है';

  @override
  String get authPhoneButton => 'फ़ोन से जारी रखें';

  @override
  String get authGoogleButton => 'Google से जारी रखें';

  @override
  String get authOrDivider => 'या';

  @override
  String get authPhoneStepTitle => 'अपना फ़ोन नंबर दर्ज करें';

  @override
  String get authPhoneStepSubtitle =>
      'हम आपका नंबर सत्यापित करने के लिए एक कोड भेजेंगे';

  @override
  String get authPhoneLabel => 'फ़ोन नंबर';

  @override
  String get authPhoneHint => '+91 98765 43210';

  @override
  String get authSendOtpButton => 'OTP भेजें';

  @override
  String get authOtpTitle => 'OTP दर्ज करें';

  @override
  String get authOtpLabel => '6 अंकों का कोड';

  @override
  String authOtpSubtitle(String phone) {
    return '$phone पर भेजा गया';
  }

  @override
  String get authVerifyButton => 'सत्यापित करें';

  @override
  String get authResendOtp => 'OTP फिर भेजें';

  @override
  String get authOtpResent => 'OTP सफलतापूर्वक फिर भेजा गया';

  @override
  String get authDidntReceive => 'नहीं मिला?';

  @override
  String authResendIn(int seconds) {
    return '${seconds}s में फिर भेजें';
  }

  @override
  String get authSignOut => 'साइन आउट';

  @override
  String authSignedInAs(String name) {
    return '$name के रूप में साइन इन';
  }

  @override
  String get authSkip => 'अभी छोड़ें';

  @override
  String get authSyncingData => 'आपका डेटा सिंक हो रहा है…';

  @override
  String get authDataSynced => 'सभी डेटा क्लाउड में सिंक हो गया';

  @override
  String get guestBannerBody => 'Sign in to back up your data across devices';

  @override
  String get guestBannerCta => 'Sign in';

  @override
  String get syncUnsyncedBanner =>
      'असिंक्ड परिवर्तन — सिंक करने के लिए इंटरनेट से जुड़ें।';

  @override
  String get syncCloudWinsTitle => 'स्थानीय डेटा बदलें?';

  @override
  String get syncCloudWinsBody =>
      'साइन इन करने पर आपका सारा स्थानीय डेटा क्लाउड बैकअप से बदल जाएगा। इसे पूर्ववत नहीं किया जा सकता।';

  @override
  String get offlineBar => 'इंटरनेट कनेक्शन नहीं है';

  @override
  String get firstRunTitle => 'KhataPro में आपका स्वागत है!';

  @override
  String get firstRunBody =>
      'ट्रैक करें कि ग्राहक आप पर कितना बकाया है — कागज़ की ज़रूरत नहीं।';

  @override
  String get firstRunStep1 => 'ग्राहक जोड़ें';

  @override
  String get firstRunStep2 => 'भुगतान दर्ज करें';

  @override
  String get firstRunStep3 => 'रिमाइंडर भेजें';

  @override
  String get firstRunDismiss => 'समझ गया';

  @override
  String get reportsFilterCustomer => 'सभी ग्राहक';

  @override
  String get reportsFilterByCustomer => 'ग्राहक से फ़िल्टर करें';

  @override
  String reportsCustomerSelected(String name) {
    return '$name की रिपोर्ट';
  }

  @override
  String get appLockSectionTitle => 'सुरक्षा';

  @override
  String get appLockTileTitle => 'ऐप लॉक';

  @override
  String get appLockTileSubtitle =>
      'खोलने के लिए बायोमेट्रिक या PIN की आवश्यकता है';

  @override
  String get appLockSetPin => 'PIN सेट करें';

  @override
  String get pinSetupTitle => 'PIN बनाएं';

  @override
  String get pinSetupSubtitle =>
      'बायोमेट्रिक विफल होने पर फॉलबैक के रूप में उपयोग होगा';

  @override
  String get pinConfirmTitle => 'अपना PIN पुष्टि करें';

  @override
  String get pinMismatch => 'PIN मेल नहीं खाते। पुन: प्रयास करें।';

  @override
  String get pinIncorrect => 'गलत PIN। पुन: प्रयास करें।';

  @override
  String get pinEnterTitle => 'अपना PIN दर्ज करें';

  @override
  String get pinForgot => 'PIN भूल गए? रीसेट करने के लिए साइन इन करें';

  @override
  String get biometricReason => 'KhataPro अनलॉक करें';

  @override
  String get appLockDisabledInfo => 'ऐप लॉक अक्षम है';

  @override
  String get notifPermDenied =>
      'नोटिफ़िकेशन की अनुमति अस्वीकृत। रिमाइंडर पाने के लिए सेटिंग में इसे चालू करें।';

  @override
  String get permContactsTitle => 'संपर्क की अनुमति दें';

  @override
  String get permContactsBody =>
      'KhataPro ग्राहक विवरण स्वचालित रूप से भरने के लिए संपर्कों की आवश्यकता है।';

  @override
  String get permNotifTitle => 'सूचनाओं की अनुमति दें';

  @override
  String get permNotifBody =>
      'सही समय पर भुगतान रिमाइंडर पाने के लिए सूचनाएं सक्षम करें।';

  @override
  String get permCameraTitle => 'कैमरा और फ़ोटो की अनुमति दें';

  @override
  String get permCameraBody =>
      'KhataPro विज़िटिंग कार्ड संलग्न करने के लिए कैमरा या गैलरी की आवश्यकता है।';

  @override
  String get permAllowButton => 'अनुमति दें';

  @override
  String get permOpenSettings => 'सेटिंग खोलें';

  @override
  String get permNotNow => 'अभी नहीं';
}
