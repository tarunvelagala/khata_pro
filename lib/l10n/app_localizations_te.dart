// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appName => 'ఖాతా ప్రో';

  @override
  String get appTagline => 'ఖాతా ప్రో డిజిటల్ బహి ఖాతా';

  @override
  String get tourHeadline1 => 'ప్రతి రూపాయి ట్రాక్ చేయండి';

  @override
  String get tourBody1 =>
      'కస్టమర్లను జోడించండి, అప్పులు నమోదు చేయండి. బ్యాలెన్స్ వెంటనే అప్‌డేట్ అవుతుంది.';

  @override
  String get tourHeadline2 => 'సులభంగా రిమైండర్లు పంపండి';

  @override
  String get tourBody2 =>
      'WhatsApp లేదా SMS ద్వారా ఒక్క ట్యాప్‌లో పేమెంట్ రిమైండర్లు పంపండి. విజిటింగ్ కార్డ్ కూడా జోడించవచ్చు.';

  @override
  String get tourHeadline3 => 'మీ డేటా, ఎల్లప్పుడూ సురక్షితం';

  @override
  String get tourBody3 =>
      'అన్నీ మీ ఫోన్‌లో ప్రైవేట్‌గా నిల్వ చేయబడతాయి. ఖాతా అవసరం లేదు. ఆఫ్‌లైన్‌లో కూడా పని చేస్తుంది.';

  @override
  String get tourNext => 'తర్వాత';

  @override
  String get tourGetStarted => 'ప్రారంభించండి';

  @override
  String get tourSkip => 'దాటవేయి';

  @override
  String get tourSwipeHint => 'స్వైప్ చేయండి';

  @override
  String get languageScreenTitle => 'భాష ఎంచుకోండి';

  @override
  String get languageScreenSubtitle =>
      'మీకు ఇష్టమైన భాష ఎంచుకోండి. మార్పు వెంటనే వర్తిస్తుంది.';

  @override
  String get languageContinueButton => 'కొనసాగించు';

  @override
  String get languageSkipButton => 'ఇప్పుడు వద్దు';

  @override
  String get balanceCardLabel => 'మొత్తం బాకీ';

  @override
  String get balanceShowTooltip => 'బ్యాలెన్స్ చూపించు';

  @override
  String get balanceHideTooltip => 'బ్యాలెన్స్ దాచు';

  @override
  String get summaryIncomeLabel => 'మీరు ఇచ్చారు';

  @override
  String get summaryExpenseLabel => 'మీరు అందుకున్నారు';

  @override
  String get homeCustomersHeader => 'కస్టమర్లు';

  @override
  String get homeAddEntryTooltip => 'ఎంట్రీ జోడించు';

  @override
  String get homeEmptyTitle => 'ఇంకా కస్టమర్లు లేరు';

  @override
  String get homeEmptyBody =>
      'చెల్లింపులు ట్రాక్ చేయడానికి మొదటి కస్టమర్‌ని జోడించండి.';

  @override
  String get homeEmptyAddCustomer => 'కస్టమర్ జోడించు';

  @override
  String get navHome => 'హోమ్';

  @override
  String get navCustomers => 'కస్టమర్లు';

  @override
  String get navMore => 'మరిన్ని';

  @override
  String get navReports => 'నివేదికలు';

  @override
  String get navSettings => 'సెట్టింగులు';

  @override
  String get appBarNotificationsTooltip => 'నోటిఫికేషన్లు';

  @override
  String get appBarGreetingMorning => 'శుభోదయం';

  @override
  String get appBarGreetingAfternoon => 'శుభ మధ్యాహ్నం';

  @override
  String get appBarGreetingEvening => 'శుభ సాయంత్రం';

  @override
  String get quickActionAddCustomer => 'కస్టమర్ జోడించు';

  @override
  String get quickActionGenerateBill => 'బిల్లు తయారు చేయి';

  @override
  String get quickActionSendReminder => 'రిమైండర్ పంపండి';

  @override
  String get quickActionRecordPayment => 'చెల్లింపు నమోదు చేయి';

  @override
  String get homeRecentTransactions => 'ఇటీవలి లావాదేవీలు';

  @override
  String get homeSeeAll => 'అన్నీ చూడు';

  @override
  String get homeAddEntry => 'ఎంట్రీ జోడించు';

  @override
  String get homeNoTransactions => 'ఇంకా లావాదేవీలు లేవు';

  @override
  String get customersSearch => 'కస్టమర్లను వెతకండి...';

  @override
  String get customersAddButton => 'కస్టమర్ జోడించు';

  @override
  String customersNoResults(String query) {
    return '\"$query\" కు ఫలితాలు లేవు';
  }

  @override
  String txnTimeMinutesAgo(int minutes) {
    return '$minutes నిమిషాల క్రితం';
  }

  @override
  String txnTimeToday(String time) {
    return 'ఈరోజు, $time';
  }

  @override
  String txnTimeYesterday(String time) {
    return 'నిన్న, $time';
  }

  @override
  String get txnTypeReceived => 'స్వీకరించారు';

  @override
  String get txnTypePaid => 'చెల్లించారు';

  @override
  String get txnColGave => 'మీరు ఇచ్చారు';

  @override
  String get txnColGot => 'మీరు అందుకున్నారు';

  @override
  String get addCustomerTitle => 'కస్టమర్‌ని జోడించు';

  @override
  String get addCustomerNameLabel => 'కస్టమర్ పేరు';

  @override
  String get addCustomerNameHint => 'ఉదా. రవి కుమార్';

  @override
  String get addCustomerPhoneLabel => 'ఫోన్ నంబర్';

  @override
  String get addCustomerPhoneHint => 'ఉదా. 9876543210';

  @override
  String get addCustomerShopLabel => 'దుకాణం / వ్యాపార పేరు';

  @override
  String get addCustomerShopHint => 'ఉదా. రవి జనరల్ స్టోర్';

  @override
  String get addCustomerBalanceLabel => 'ప్రారంభ బ్యాలెన్స్';

  @override
  String get addCustomerBalanceHint => '0';

  @override
  String get addCustomerDirectionTheyOwe => 'వారు నాకు ఇవ్వాలి';

  @override
  String get addCustomerDirectionIOwe => 'నేను వారికి ఇవ్వాలి';

  @override
  String get addCustomerSave => 'కస్టమర్‌ని సేవ్ చేయి';

  @override
  String get addCustomerError => 'సేవ్ చేయలేదు. మళ్ళీ ప్రయత్నించు.';

  @override
  String get addCustomerDuplicate =>
      'ఈ పేరు, ఫోన్ మరియు షాప్ తో ఒక కస్టమర్ ఇప్పటికే ఉన్నారు.';

  @override
  String get addCustomerNameRequired => 'పేరు అవసరం';

  @override
  String get addCustomerNameTooLong => 'పేరు 80 అక్షరాల కంటే తక్కువగా ఉండాలి';

  @override
  String get addCustomerPhoneInvalid =>
      'చెల్లుబాటు అయ్యే ఫోన్ నంబర్ నమోదు చేయండి (10–15 అంకెలు)';

  @override
  String get addCustomerBalanceInvalid =>
      'చెల్లుబాటు అయ్యే మొత్తం నమోదు చేయండి';

  @override
  String get customerDetailOwesYou => 'మీరు ఇచ్చారు';

  @override
  String get customerDetailYouOwe => 'మీరు అందుకున్నారు';

  @override
  String get customerDetailSettled => 'సమతుల్యం';

  @override
  String get customerDetailNoEntries => 'ఇంకా లావాదేవీలు లేవు';

  @override
  String get customerDetailNoEntriesBody =>
      'ఈ కస్టమర్ యొక్క మొదటి లావాదేవీని నమోదు చేయండి.';

  @override
  String get addEntryTitle => 'ఎంట్రీ జోడించు';

  @override
  String get addEntryGave => 'మీరు ఇచ్చారు';

  @override
  String get addEntryReceived => 'మీరు అందుకున్నారు';

  @override
  String get addEntryAmountLabel => 'మొత్తం';

  @override
  String get addEntryAmountHint => '0';

  @override
  String get addEntryNoteLabel => 'వివరణ (ఐచ్ఛికం)';

  @override
  String get addEntrySave => 'సేవ్ చేయి';

  @override
  String get addEntryAmountRequired => 'మొత్తం నమోదు చేయండి';

  @override
  String get addEntryAmountInvalid => 'చెల్లుబాటు అయ్యే మొత్తం నమోదు చేయండి';

  @override
  String get retryButton => 'మళ్ళీ ప్రయత్నించండి';

  @override
  String get errorGeneric => 'ఏదో తప్పు జరిగింది';

  @override
  String get dateToday => 'ఈరోజు';

  @override
  String get dateYesterday => 'నిన్న';

  @override
  String get txnDirectionGave => 'మీరు ఇచ్చారు';

  @override
  String get txnDirectionReceived => 'మీరు అందుకున్నారు';

  @override
  String get offlineSafeLabel => 'ఆఫ్‌లైన్ సురక్షితం';

  @override
  String get offlinePropertyPrivate => 'ప్రైవేట్';

  @override
  String get offlinePropertyOffline => 'ఆఫ్‌లైన్';

  @override
  String get offlinePropertySecure => 'సురక్షితం';

  @override
  String get editCustomerTitle => 'కస్టమర్‌ని సవరించు';

  @override
  String get editEntryTitle => 'ఎంట్రీ సవరించు';

  @override
  String get contactsImportButton => 'కాంటాక్ట్స్ నుండి దిగుమతి చేయండి';

  @override
  String get contactsSyncToggle => 'ఫోన్ కాంటాక్ట్స్‌లో సేవ్ చేయండి';

  @override
  String get contactsSynced => 'కాంటాక్ట్స్‌తో సమకాలీకరించబడింది';

  @override
  String get contactsPermissionDenied => 'కాంటాక్ట్స్ అనుమతి నిరాకరించబడింది';

  @override
  String get deleteConfirmTitle => 'తొలగించాలా?';

  @override
  String get deleteCustomerConfirmBody =>
      'ఈ కస్టమర్ మరియు వారి అన్ని లావాదేవీలు శాశ్వతంగా తొలగించబడతాయి.';

  @override
  String get deleteTxnConfirmBody => 'ఈ ఎంట్రీ శాశ్వతంగా తొలగించబడుతుంది.';

  @override
  String get deleteAction => 'తొలగించు';

  @override
  String get cancelAction => 'రద్దు';

  @override
  String get reportsFilterMonth => 'ఈ నెల';

  @override
  String get reportsFilterYear => 'ఈ సంవత్సరం';

  @override
  String get reportsFilterAll => 'అన్ని సమయాల్లో';

  @override
  String get reportsTotalGave => 'మొత్తం ఇచ్చింది';

  @override
  String get reportsTotalGot => 'మొత్తం అందుకున్నది';

  @override
  String get reportsNetBalance => 'నికర నిల్వ';

  @override
  String get reportsColCustomer => 'కస్టమర్';

  @override
  String get reportsColGave => 'ఇచ్చింది';

  @override
  String get reportsColGot => 'అందుకున్నది';

  @override
  String get reportsColNet => 'నికర';

  @override
  String get reportsEmpty => 'ఈ కాలంలో లావాదేవీలు లేవు';

  @override
  String get reportsDownloadPdf => 'PDF షేర్ చేయండి';

  @override
  String get reportsFilterHint => 'కాలయాపన ఎంచుకోండి';

  @override
  String get reportsPdfTitle => 'KhataPro స్టేట్‌మెంట్';

  @override
  String reportsPdfPeriod(String period) {
    return 'కాలం: $period';
  }

  @override
  String get settingsTitle => 'సెట్టింగ్‌లు';

  @override
  String get settingsLanguage => 'భాష';

  @override
  String get settingsLanguageSubtitle => 'యాప్ భాషను మార్చండి';

  @override
  String get settingsAboutSection => 'గురించి';

  @override
  String get settingsVersion => 'వెర్షన్';

  @override
  String get settingsPrivacyPolicy => 'గోప్యతా విధానం';

  @override
  String get settingsRateApp => 'KhataPro రేట్ చేయండి';

  @override
  String get recordPaymentPickerTitle => 'కస్టమర్‌ని ఎంచుకోండి';

  @override
  String get recordPaymentPickerHint => 'కస్టమర్లను వెతకండి...';

  @override
  String get profileSetupTitle => 'మీ గురించి';

  @override
  String get profileSetupSubtitle =>
      'మీ అనుభవాన్ని వ్యక్తిగతీకరించడంలో సహాయం చేయండి.';

  @override
  String get profileNameLabel => 'మీ పేరు';

  @override
  String get profileNameHint => 'ఉదా. రవి కుమార్';

  @override
  String get profileNameRequired => 'పేరు అవసరం';

  @override
  String get profileNameTooLong => 'పేరు 80 అక్షరాల కంటే తక్కువగా ఉండాలి';

  @override
  String get profileShopLabel => 'వ్యాపారం / దుకాణం పేరు';

  @override
  String get profileShopHint => 'ఉదా. రవి జనరల్ స్టోర్';

  @override
  String get profileContinueButton => 'కొనసాగించు';

  @override
  String get profileScreenTitle => 'నా ప్రొఫైల్';

  @override
  String get profileEditButton => 'సవరించు';

  @override
  String get profileAuthSection => 'ఖాతా';

  @override
  String get profileSignInButton =>
      'సమకాలీకరణ మరియు బ్యాకప్ కోసం సైన్ ఇన్ చేయండి';

  @override
  String get reminderNoPhone => 'ఈ కస్టమర్ ఫోన్ నంబర్ సేవ్ చేయబడలేదు';

  @override
  String get reminderNoBalance => 'ఈ కస్టమర్‌కు ఎటువంటి బకాయి లేదు';

  @override
  String get reminderShareUnavailable =>
      'మెసేజింగ్ యాప్ కనుగొనబడలేదు. సందేశాన్ని కాపీ చేసి మాన్యువల్‌గా పంపండి.';

  @override
  String get copyAction => 'కాపీ చేయి';

  @override
  String get reminderSent => 'WhatsApp తెరుచుకుంటోంది…';

  @override
  String get reminderSendButton => 'రిమైండర్ పంపండి';

  @override
  String reminderMessage(String name, String amount, String business) {
    return 'నమస్కారం $name, మీకు ₹$amount బకాయి ఉంది. దయచేసి వీలైనంత త్వరగా చెల్లించండి. – $business';
  }

  @override
  String get catalogSectionTitle => 'విజిటింగ్ కార్డులు & క్యాటలాగ్';

  @override
  String get catalogAddPhoto => 'ఫోటో చేర్చండి';

  @override
  String get catalogTakePhoto => 'ఫోటో తీయండి';

  @override
  String get catalogChooseGallery => 'గ్యాలరీ నుండి ఎంచుకోండి';

  @override
  String get catalogDeleteConfirm => 'ఈ చిత్రాన్ని తీసివేయాలా?';

  @override
  String get reminderAttachTitle => 'కార్డ్ జోడించాలా?';

  @override
  String get reminderSendWithImage => 'చిత్రంతో పంపండి';

  @override
  String get reminderSendWithoutImage => 'చిత్రం లేకుండా పంపండి';

  @override
  String get generateBillTitle => 'బిల్లు రూపొందించు';

  @override
  String get billScreenTitle => 'ఖాతా వివరణ';

  @override
  String get billPeriodMonth => 'ఈ నెల';

  @override
  String get billPeriodYear => 'ఈ సంవత్సరం';

  @override
  String get billPeriodAll => 'అన్ని సమయాలు';

  @override
  String get billPeriodCustom => 'కస్టమ్';

  @override
  String billPeriodLabel(String from, String to) {
    return '$from – $to';
  }

  @override
  String get billColDate => 'తేదీ';

  @override
  String get billColNote => 'వివరణ';

  @override
  String get billColGave => 'ఇచ్చాను';

  @override
  String get billColGot => 'తీసుకున్నాను';

  @override
  String get billTotalGave => 'మొత్తం ఇచ్చాను';

  @override
  String get billTotalGot => 'మొత్తం తీసుకున్నాను';

  @override
  String get billNetBalance => 'బకాయి మొత్తం';

  @override
  String get billYouAreOwed => 'మీకు రావలసి ఉంది';

  @override
  String get billYouOwe => 'మీరు చెల్లించవలసి ఉంది';

  @override
  String get billEmpty => 'ఈ కాలంలో లావాదేవీలు లేవు';

  @override
  String get billShareButton => 'PDF గా షేర్ చేయండి';

  @override
  String get billCustomRange => 'తేదీ పరిధి ఎంచుకోండి';

  @override
  String get billFilterHint => 'కాలయాపన ఎంచుకోండి';

  @override
  String get backupSectionTitle => 'డేటా';

  @override
  String get backupTileTitle => 'డేటా బ్యాకప్ చేయండి';

  @override
  String get backupTileSubtitle =>
      'అన్ని కస్టమర్లు & లావాదేవీలను ఎగుమతి చేయండి';

  @override
  String get restoreTileTitle => 'బ్యాకప్ నుండి పునరుద్ధరించండి';

  @override
  String get restoreTileSubtitle =>
      'బ్యాకప్ ఫైల్ నుండి అన్ని డేటాను భర్తీ చేయండి';

  @override
  String get restoreConfirmTitle => 'అన్ని డేటాను భర్తీ చేయాలా?';

  @override
  String get restoreConfirmBody =>
      'ఇది మీ ప్రస్తుత డేటా మొత్తాన్ని బ్యాకప్‌తో శాశ్వతంగా భర్తీ చేస్తుంది. దీన్ని రద్దు చేయలేరు.';

  @override
  String get restoreSuccess => 'డేటా విజయవంతంగా పునరుద్ధరించబడింది';

  @override
  String get restoreError =>
      'బ్యాకప్ పునరుద్ధరించలేకపోయాము. ఫైల్ చెల్లుబాటు కానిది లేదా పాడైందని ఉండవచ్చు.';

  @override
  String get remindersSectionTitle => 'రిమైండర్లు';

  @override
  String get defaultReminderTitle => 'డిఫాల్ట్ రిమైండర్';

  @override
  String get defaultReminderSubtitle =>
      'కొత్త కస్టమర్లకు స్వయంచాలకంగా వర్తిస్తుంది';

  @override
  String get defaultReminderSheetHint =>
      'కొత్త కస్టమర్‌ను జోడించేటప్పుడు ముందే ఎంచుకోబడుతుంది. ప్రతి కస్టమర్ రిమైండర్ విడిగా సెట్ చేయబడుతుంది.';

  @override
  String get setReminderTitle => 'రిమైండర్ సెట్ చేయండి';

  @override
  String get reminderFrequencyNone => 'ఏదీ లేదు';

  @override
  String get reminderFrequencyWeekly => 'వారానికోసారి';

  @override
  String get reminderFrequencyFortnightly => 'ప్రతి 2 వారాలు';

  @override
  String get reminderFrequencyMonthly => 'నెలవారీ';

  @override
  String get reminderModeRecurring => 'పదే పదే';

  @override
  String get reminderModeOnDate => 'ఒక తేదీన';

  @override
  String get reminderDateLabel => 'రిమైండర్ తేదీ';

  @override
  String get reminderDateHint => 'తేదీ ఎంచుకోండి';

  @override
  String get reminderDatePast => 'దయచేసి భవిష్యత్తు తేదీ ఎంచుకోండి';

  @override
  String get reminderTimeMorning => 'ఉదయం · 9 గంటలు';

  @override
  String get reminderTimeAfternoon => 'మధ్యాహ్నం · 1 గంట';

  @override
  String get reminderTimeEvening => 'సాయంత్రం · 6 గంటలు';

  @override
  String reminderActiveChip(String freq) {
    return '$freq రిమైండర్';
  }

  @override
  String get reminderNotifTitle => 'చెల్లింపు రిమైండర్';

  @override
  String reminderNotifBody(String name, String amount) {
    return '$name ₹$amount బాకీ ఉంది — రిమైండర్ పంపడానికి నొక్కండి';
  }

  @override
  String get authSignInTitle => 'సమకాలీకరణ మరియు బ్యాకప్ కోసం సైన్ ఇన్ చేయండి';

  @override
  String get authSignInSubtitle =>
      'మీ డేటా అన్ని పరికరాల్లో సురక్షితంగా ఉంటుంది';

  @override
  String get authPhoneButton => 'ఫోన్‌తో కొనసాగించండి';

  @override
  String get authGoogleButton => 'Google తో కొనసాగించండి';

  @override
  String get authOrDivider => 'లేదా';

  @override
  String get authPhoneStepTitle => 'మీ ఫోన్ నంబర్ నమోదు చేయండి';

  @override
  String get authPhoneStepSubtitle =>
      'మీ నంబర్‌ను ధృవీకరించడానికి కోడ్ పంపుతాము';

  @override
  String get authPhoneLabel => 'ఫోన్ నంబర్';

  @override
  String get authPhoneHint => '+91 98765 43210';

  @override
  String get authSendOtpButton => 'OTP పంపండి';

  @override
  String get authOtpTitle => 'OTP నమోదు చేయండి';

  @override
  String get authOtpLabel => '6 అంకెల కోడ్';

  @override
  String authOtpSubtitle(String phone) {
    return '$phone కి పంపబడింది';
  }

  @override
  String get authVerifyButton => 'ధృవీకరించండి';

  @override
  String get authResendOtp => 'OTP మళ్ళీ పంపండి';

  @override
  String get authOtpResent => 'OTP విజయవంతంగా మళ్ళీ పంపబడింది';

  @override
  String get authDidntReceive => 'అందలేదా?';

  @override
  String authResendIn(int seconds) {
    return '${seconds}s లో మళ్ళీ పంపండి';
  }

  @override
  String get authSignOut => 'సైన్ అవుట్';

  @override
  String authSignedInAs(String name) {
    return '$name గా సైన్ ఇన్ చేయబడింది';
  }

  @override
  String get authSkip => 'ఇప్పుడు దాటవేయండి';

  @override
  String get authSyncingData => 'Syncing your dataâ¦';

  @override
  String get authDataSynced => 'అన్ని డేటా క్లౌడ్‌కు సమకాలీకరించబడింది';

  @override
  String get syncUnsyncedBanner =>
      'సమకాలీకరించని మార్పులు — సమకాలీకరించడానికి ఇంటర్నెట్‌కు కనెక్ట్ అవ్వండి.';

  @override
  String get syncCloudWinsTitle => 'స్థానిక డేటాను భర్తీ చేయాలా?';

  @override
  String get syncCloudWinsBody =>
      'సైన్ ఇన్ చేయడం వల్ల మీ అన్ని స్థానిక డేటా క్లౌడ్ బ్యాకప్‌తో భర్తీ అవుతుంది. దీన్ని రద్దు చేయడం సాధ్యం కాదు.';

  @override
  String get offlineBar => 'ఇంటర్నెట్ కనెక్షన్ లేదు';

  @override
  String get firstRunTitle => 'KhataPro కి స్వాగతం!';

  @override
  String get firstRunBody =>
      'కస్టమర్లు ఎంత బకాయి ఉన్నారో ట్రాక్ చేయండి — కాగితం అవసరం లేదు.';

  @override
  String get firstRunStep1 => 'కస్టమర్‌ను జోడించండి';

  @override
  String get firstRunStep2 => 'చెల్లింపు నమోదు చేయండి';

  @override
  String get firstRunStep3 => 'రిమైండర్ పంపండి';

  @override
  String get firstRunDismiss => 'అర్థమైంది';

  @override
  String get reportsFilterCustomer => 'అన్ని కస్టమర్లు';

  @override
  String get reportsFilterByCustomer => 'కస్టమర్ ద్వారా ఫిల్టర్ చేయండి';

  @override
  String reportsCustomerSelected(String name) {
    return '$name నివేదిక';
  }

  @override
  String get appLockSectionTitle => 'భద్రత';

  @override
  String get appLockTileTitle => 'యాప్ లాక్';

  @override
  String get appLockTileSubtitle => 'తెరవడానికి బయోమెట్రిక్ లేదా PIN అవసరం';

  @override
  String get appLockSetPin => 'PIN సెట్ చేయండి';

  @override
  String get pinSetupTitle => 'PIN సృష్టించండి';

  @override
  String get pinSetupSubtitle =>
      'బయోమెట్రిక్ విఫలమైతే ప్రత్యామ్నాయంగా ఉపయోగించబడుతుంది';

  @override
  String get pinConfirmTitle => 'మీ PIN నిర్ధారించండి';

  @override
  String get pinMismatch => 'PIN లు సరిపోలలేదు. మళ్ళీ ప్రయత్నించండి.';

  @override
  String get pinIncorrect => 'తప్పుడు PIN. మళ్ళీ ప్రయత్నించండి.';

  @override
  String get pinEnterTitle => 'మీ PIN నమోదు చేయండి';

  @override
  String get pinForgot => 'PIN మర్చిపోయారా? రీసెట్ చేయడానికి సైన్ ఇన్ చేయండి';

  @override
  String get biometricReason => 'KhataPro అన్‌లాక్ చేయండి';

  @override
  String get appLockDisabledInfo => 'యాప్ లాక్ నిష్క్రియం';

  @override
  String get notifPermDenied =>
      'నోటిఫికేషన్ అనుమతి తిరస్కరించబడింది. రిమైండర్లు పొందడానికి సెట్టింగ్‌లలో దాన్ని ప్రారంభించండి.';
}
