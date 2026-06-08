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
  String get scrollForMore => 'Scroll for more';

  @override
  String get balanceCardLabel => 'एकूण शिल्लक';

  @override
  String get balanceShowTooltip => 'शिल्लक दाखवा';

  @override
  String get balanceHideTooltip => 'शिल्लक लपवा';

  @override
  String get summaryIncomeLabel => 'तुम्ही दिले';

  @override
  String get summaryExpenseLabel => 'तुम्हाला मिळाले';

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
  String get homeNoTransactions => 'अद्याप कोणतेही व्यवहार नाहीत';

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
  String get txnColGave => 'तुम्ही दिले';

  @override
  String get txnColGot => 'तुम्हाला मिळाले';

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
  String get customerDetailOwesYou => 'तुम्ही दिले';

  @override
  String get customerDetailYouOwe => 'तुम्हाला मिळाले';

  @override
  String get customerDetailSettled => 'बरोबर';

  @override
  String get customerDetailNoEntries => 'अजून कोणतेही व्यवहार नाहीत';

  @override
  String get customerDetailNoEntriesBody =>
      'या ग्राहकाचा पहिला व्यवहार नोंदवा.';

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
  String get addEntryNoteLabel => 'वर्णन (पर्यायी)';

  @override
  String get addEntrySave => 'जतन करा';

  @override
  String get addEntryAmountRequired => 'रक्कम प्रविष्ट करा';

  @override
  String get addEntryAmountInvalid => 'वैध रक्कम प्रविष्ट करा';

  @override
  String get retryButton => 'पुन्हा प्रयत्न करा';

  @override
  String get errorGeneric => 'काहीतरी चुकले';

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
  String get contactsImportButton => 'कॉन्टॅक्टमधून आयात करा';

  @override
  String get contactsSyncToggle => 'फोन कॉन्टॅक्टमध्ये जतन करा';

  @override
  String get contactsSynced => 'कॉन्टॅक्टशी सिंक झाले';

  @override
  String get contactsPermissionDenied => 'कॉन्टॅक्ट परवानगी नाकारली';

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

  @override
  String get restoreAction => 'पुनर्संचयित करा';

  @override
  String get reportsFilterMonth => 'या महिन्यात';

  @override
  String get reportsFilterYear => 'या वर्षी';

  @override
  String get reportsFilterAll => 'सर्व वेळ';

  @override
  String get reportsTotalGave => 'एकूण दिले';

  @override
  String get reportsTotalGot => 'एकूण मिळाले';

  @override
  String get reportsNetBalance => 'निव्वळ शिल्लक';

  @override
  String get reportsColCustomer => 'ग्राहक';

  @override
  String get reportsColGave => 'दिले';

  @override
  String get reportsColGot => 'मिळाले';

  @override
  String get reportsColNet => 'निव्वळ';

  @override
  String get reportsWillReceive => 'तुम्हाला मिळेल';

  @override
  String get reportsWillPay => 'तुम्ही द्याल';

  @override
  String get reportsEmpty => 'या कालावधीत कोणतेही व्यवहार नाहीत';

  @override
  String get reportsDownloadPdf => 'PDF शेअर करा';

  @override
  String get reportsFilterHint => 'कालावधी निवडा';

  @override
  String get reportsPdfTitle => 'KhataPro विवरण';

  @override
  String reportsPdfPeriod(String period) {
    return 'कालावधी: $period';
  }

  @override
  String get settingsTitle => 'सेटिंग्ज';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsLanguageSubtitle => 'अ‍ॅपची भाषा बदला';

  @override
  String get settingsAboutSection => 'माहिती';

  @override
  String get settingsVersion => 'आवृत्ती';

  @override
  String get settingsPrivacyPolicy => 'गोपनीयता धोरण';

  @override
  String get settingsRateApp => 'KhataPro ला रेटिंग द्या';

  @override
  String get recordPaymentPickerTitle => 'ग्राहक निवडा';

  @override
  String get recordPaymentPickerHint => 'ग्राहक शोधा...';

  @override
  String get profileSetupTitle => 'तुमच्याबद्दल';

  @override
  String get profileSetupSubtitle => 'तुमचा अनुभव वैयक्तिक बनवण्यास मदत करा.';

  @override
  String get profileNameLabel => 'तुमचे नाव';

  @override
  String get profileNameHint => 'उदा. रवी कुमार';

  @override
  String get profileNameRequired => 'नाव आवश्यक आहे';

  @override
  String get profileNameTooLong => 'नाव ८० अक्षरांपेक्षा कमी असावे';

  @override
  String get profileShopLabel => 'व्यवसाय / दुकानाचे नाव';

  @override
  String get profileShopHint => 'उदा. रवी जनरल स्टोअर';

  @override
  String get profileContinueButton => 'पुढे चला';

  @override
  String get profileScreenTitle => 'माझी प्रोफाइल';

  @override
  String get profileEditButton => 'संपादित करा';

  @override
  String get profileAuthSection => 'खाते';

  @override
  String get profileSignInButton => 'सिंक आणि बॅकअपसाठी साइन इन करा';

  @override
  String get reminderNoPhone => 'या ग्राहकाचा फोन नंबर जतन केलेला नाही';

  @override
  String get reminderNoBalance => 'या ग्राहकाची कोणतीही थकबाकी नाही';

  @override
  String get reminderShareUnavailable =>
      'कोणतेही मेसेजिंग अॅप सापडले नाही. संदेश कॉपी करा आणि मॅन्युअली पाठवा.';

  @override
  String get copyAction => 'कॉपी करा';

  @override
  String get reminderSent => 'WhatsApp उघडत आहे…';

  @override
  String get reminderSendButton => 'स्मरणपत्र पाठवा';

  @override
  String reminderMessage(String name, String amount, String business) {
    return 'नमस्कार $name, तुमची ₹$amount थकबाकी आहे. कृपया लवकरात लवकर भरा. – $business';
  }

  @override
  String get catalogSectionTitle => 'व्हिजिटिंग कार्ड आणि कॅटलॉग';

  @override
  String get catalogAddPhoto => 'फोटो जोडा';

  @override
  String get catalogTakePhoto => 'फोटो काढा';

  @override
  String get catalogChooseGallery => 'गॅलरीतून निवडा';

  @override
  String get catalogDeleteConfirm => 'ही प्रतिमा काढायची?';

  @override
  String get reminderAttachTitle => 'कार्ड जोडायचे?';

  @override
  String get reminderSendWithImage => 'प्रतिमेसह पाठवा';

  @override
  String get reminderSendWithoutImage => 'प्रतिमेशिवाय पाठवा';

  @override
  String get generateBillTitle => 'बिल तयार करा';

  @override
  String get billScreenTitle => 'खाते विवरण';

  @override
  String get billPeriodMonth => 'या महिन्यात';

  @override
  String get billPeriodYear => 'या वर्षी';

  @override
  String get billPeriodAll => 'सर्व वेळ';

  @override
  String get billPeriodCustom => 'सानुकूल';

  @override
  String billPeriodLabel(String from, String to) {
    return '$from – $to';
  }

  @override
  String get billColDate => 'तारीख';

  @override
  String get billColNote => 'वर्णन';

  @override
  String get billColGave => 'दिले';

  @override
  String get billColGot => 'मिळाले';

  @override
  String get billTotalGave => 'एकूण दिले';

  @override
  String get billTotalGot => 'एकूण मिळाले';

  @override
  String get billNetBalance => 'थकबाकी रक्कम';

  @override
  String get billYouAreOwed => 'तुम्हाला मिळायचे आहे';

  @override
  String get billYouOwe => 'तुम्हाला द्यायचे आहे';

  @override
  String get billEmpty => 'या कालावधीत कोणतेही व्यवहार नाहीत';

  @override
  String get billShareButton => 'PDF म्हणून शेअर करा';

  @override
  String get billCustomRange => 'तारीख श्रेणी निवडा';

  @override
  String get billFilterHint => 'कालावधी निवडा';

  @override
  String get backupSectionTitle => 'डेटा';

  @override
  String get backupTileTitle => 'डेटा बॅकअप करा';

  @override
  String get backupTileSubtitle => 'सर्व ग्राहक आणि व्यवहार निर्यात करा';

  @override
  String get restoreTileTitle => 'बॅकअपमधून पुनर्संचयित करा';

  @override
  String get restoreTileSubtitle => 'बॅकअप फाइलमधून सर्व डेटा बदला';

  @override
  String get restoreConfirmTitle => 'सर्व डेटा बदलायचा?';

  @override
  String get restoreConfirmBody =>
      'यामुळे तुमचा सध्याचा सर्व डेटा बॅकअपने कायमस्वरूपी बदलला जाईल. हे पूर्ववत करता येणार नाही.';

  @override
  String get restoreSuccess => 'डेटा यशस्वीरित्या पुनर्संचयित केला';

  @override
  String get restoreError =>
      'बॅकअप पुनर्संचयित करता आले नाही. फाइल अवैध किंवा दूषित असू शकते.';

  @override
  String get backupExportError =>
      'बॅकअप निर्यात करता आले नाही. कृपया पुन्हा प्रयत्न करा.';

  @override
  String get backupEmptyError => 'बॅकअप करण्यासाठी डेटा नाही. आधी ग्राहक जोडा.';

  @override
  String get remindersSectionTitle => 'स्मरणपत्रे';

  @override
  String get defaultReminderTitle => 'डीफॉल्ट स्मरणपत्र';

  @override
  String get defaultReminderSubtitle => 'नवीन ग्राहकांना आपोआप लागू होते';

  @override
  String get defaultReminderSheetHint =>
      'नवीन ग्राहक जोडताना आधीच निवडले जाते. प्रत्येक ग्राहकाचे स्मरणपत्र वेगळे सेट केले जाते.';

  @override
  String get setReminderTitle => 'स्मरणपत्र सेट करा';

  @override
  String get setReminderSave => 'स्मरणपत्र सेट करा';

  @override
  String get reminderFrequencyNone => 'काहीही नाही';

  @override
  String get reminderFrequencyWeekly => 'साप्ताहिक';

  @override
  String get reminderFrequencyFortnightly => 'दर 2 आठवडे';

  @override
  String get reminderFrequencyMonthly => 'मासिक';

  @override
  String get reminderModeRecurring => 'वारंवार';

  @override
  String get reminderModeOnDate => 'एखाद्या तारखेला';

  @override
  String get reminderDateLabel => 'स्मरणपत्र तारीख';

  @override
  String get reminderDateHint => 'तारीख निवडा';

  @override
  String get reminderDatePast => 'कृपया भविष्यातील तारीख निवडा';

  @override
  String get reminderTimeMorning => 'सकाळ · ९ वाजता';

  @override
  String get reminderTimeAfternoon => 'दुपार · १ वाजता';

  @override
  String get reminderTimeEvening => 'संध्याकाळ · ६ वाजता';

  @override
  String reminderActiveChip(String freq) {
    return '$freq स्मरणपत्र';
  }

  @override
  String get reminderNotifTitle => 'पेमेंट स्मरणपत्र';

  @override
  String reminderNotifBody(String name, String amount) {
    return '$name कडे ₹$amount थकबाकी आहे — स्मरणपत्र पाठवण्यासाठी टॅप करा';
  }

  @override
  String get authSignInTitle => 'सिंक आणि बॅकअपसाठी साइन इन करा';

  @override
  String get authSignInSubtitle => 'तुमचा डेटा सर्व डिव्हाइसवर सुरक्षित राहतो';

  @override
  String get authPhoneButton => 'फोनसह सुरू ठेवा';

  @override
  String get authGoogleButton => 'Google सह सुरू ठेवा';

  @override
  String get authOrDivider => 'किंवा';

  @override
  String get authPhoneStepTitle => 'तुमचा फोन नंबर प्रविष्ट करा';

  @override
  String get authPhoneStepSubtitle =>
      'तुमचा नंबर सत्यापित करण्यासाठी आम्ही एक कोड पाठवू';

  @override
  String get authPhoneLabel => 'फोन नंबर';

  @override
  String get authPhoneHint => '+91 98765 43210';

  @override
  String get authSendOtpButton => 'OTP पाठवा';

  @override
  String get authOtpTitle => 'OTP प्रविष्ट करा';

  @override
  String get authOtpLabel => '6 अंकी कोड';

  @override
  String authOtpSubtitle(String phone) {
    return '$phone वर पाठवले';
  }

  @override
  String get authVerifyButton => 'सत्यापित करा';

  @override
  String get authResendOtp => 'OTP पुन्हा पाठवा';

  @override
  String get authOtpResent => 'OTP यशस्वीरित्या पुन्हा पाठवले';

  @override
  String get authDidntReceive => 'मिळाले नाही?';

  @override
  String authResendIn(int seconds) {
    return '${seconds}s मध्ये पुन्हा पाठवा';
  }

  @override
  String get authSignOut => 'साइन आउट';

  @override
  String authSignedInAs(String name) {
    return '$name म्हणून साइन इन केले आहे';
  }

  @override
  String get authSkip => 'आत्ता वगळा';

  @override
  String get authSyncingData => 'Syncing your dataâ¦';

  @override
  String get authDataSynced => 'सर्व डेटा क्लाउडवर सिंक झाला';

  @override
  String get guestBannerBody => 'Sign in to back up your data across devices';

  @override
  String get guestBannerCta => 'Sign in';

  @override
  String get syncUnsyncedBanner =>
      'सिंक न झालेले बदल — सिंक करण्यासाठी इंटरनेटशी जोडा.';

  @override
  String get syncCloudWinsTitle => 'स्थानिक डेटा बदलायचा का?';

  @override
  String get syncCloudWinsBody =>
      'साइन इन केल्यावर तुमचा सर्व स्थानिक डेटा क्लाउड बॅकअपने बदलला जाईल. हे पूर्ववत करता येणार नाही.';

  @override
  String get offlineBar => 'इंटरनेट कनेक्शन नाही';

  @override
  String get firstRunTitle => 'KhataPro मध्ये आपले स्वागत!';

  @override
  String get firstRunBody =>
      'ग्राहक किती देणे लागतात ते ट्रॅक करा — कागदाची गरज नाही.';

  @override
  String get firstRunStep1 => 'ग्राहक जोडा';

  @override
  String get firstRunStep2 => 'पेमेंट नोंदवा';

  @override
  String get firstRunStep3 => 'स्मरणपत्र पाठवा';

  @override
  String get firstRunDismiss => 'समजलं';

  @override
  String get reportsFilterCustomer => 'सर्व ग्राहक';

  @override
  String get reportsFilterByCustomer => 'ग्राहकानुसार फिल्टर करा';

  @override
  String reportsCustomerSelected(String name) {
    return '$name चा अहवाल';
  }

  @override
  String get appLockSectionTitle => 'सुरक्षा';

  @override
  String get appLockTileTitle => 'अॅप लॉक';

  @override
  String get appLockTileSubtitle => 'उघडण्यासाठी बायोमेट्रिक किंवा PIN आवश्यक';

  @override
  String get appLockSetPin => 'PIN सेट करा';

  @override
  String get pinSetupTitle => 'PIN तयार करा';

  @override
  String get pinSetupSubtitle =>
      'बायोमेट्रिक अयशस्वी झाल्यास पर्याय म्हणून वापरला जाईल';

  @override
  String get pinConfirmTitle => 'तुमचा PIN पुष्टी करा';

  @override
  String get pinMismatch => 'PIN जुळत नाहीत. पुन्हा प्रयत्न करा.';

  @override
  String get pinIncorrect => 'चुकीचा PIN. पुन्हा प्रयत्न करा.';

  @override
  String get pinEnterTitle => 'तुमचा PIN प्रविष्ट करा';

  @override
  String get pinForgot => 'PIN विसरलात? रीसेट करण्यासाठी साइन इन करा';

  @override
  String get biometricReason => 'KhataPro अनलॉक करा';

  @override
  String get appLockDisabledInfo => 'अॅप लॉक अक्षम आहे';

  @override
  String get notifPermDenied =>
      'सूचना परवानगी नाकारली. स्मरणपत्रे मिळवण्यासाठी सेटिंग्जमध्ये ते सक्रिय करा.';

  @override
  String get permContactsTitle => 'संपर्कांना परवानगी द्या';

  @override
  String get permContactsBody =>
      'ग्राहकांचे तपशील आपोआप भरण्यासाठी KhataPro ला संपर्क प्रवेश आवश्यक आहे.';

  @override
  String get permNotifTitle => 'सूचनांना परवानगी द्या';

  @override
  String get permNotifBody =>
      'योग्य वेळी पेमेंट स्मरणपत्रे मिळवण्यासाठी सूचना सक्षम करा.';

  @override
  String get permCameraTitle => 'कॅमेरा आणि फोटोंना परवानगी द्या';

  @override
  String get permCameraBody =>
      'व्हिजिटिंग कार्ड जोडण्यासाठी KhataPro ला कॅमेरा किंवा गॅलरी प्रवेश आवश्यक आहे.';

  @override
  String get permAllowButton => 'परवानगी द्या';

  @override
  String get permOpenSettings => 'सेटिंग्ज उघडा';

  @override
  String get permNotNow => 'आत्ता नको';
}
