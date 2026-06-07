// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appName => 'கணக்கு ப்ரோ';

  @override
  String get appTagline => 'கணக்கு ப்ரோ டிஜிட்டல் பஹி கணக்கு';

  @override
  String get tourHeadline1 => 'ஒவ்வொரு ரூபாயையும் கண்காணியுங்கள்';

  @override
  String get tourBody1 =>
      'வாடிக்கையாளர்களை சேர்க்கவும், கடன் பதிவு செய்யவும். இருப்பு உடனடியாக புதுப்பிக்கப்படும்.';

  @override
  String get tourHeadline2 => 'எளிதாக நினைவூட்டல் அனுப்புங்கள்';

  @override
  String get tourBody2 =>
      'WhatsApp அல்லது SMS மூலம் ஒரே தட்டில் தொகை நினைவூட்டல் அனுப்புங்கள். விஸிட்டிங் கார்டும் இணைக்கலாம்.';

  @override
  String get tourHeadline3 => 'உங்கள் தரவு, எப்போதும் பாதுகாப்பானது';

  @override
  String get tourBody3 =>
      'எல்லாம் உங்கள் ஃபோனில் தனிப்பட்ட முறையில் சேமிக்கப்படுகிறது. கணக்கு தேவையில்லை. ஆஃப்லைனிலும் வேலை செய்யும்.';

  @override
  String get tourNext => 'அடுத்து';

  @override
  String get tourGetStarted => 'தொடங்குங்கள்';

  @override
  String get tourSkip => 'தவிர்';

  @override
  String get tourSwipeHint => 'ஸ்வைப் செய்யுங்கள்';

  @override
  String get languageScreenTitle => 'மொழி தேர்ந்தெடுக்கவும்';

  @override
  String get languageScreenSubtitle =>
      'விருப்பமான மொழியை தேர்வு செய்யுங்கள். மாற்றம் உடனடியாக பயன்படுத்தப்படும்.';

  @override
  String get languageContinueButton => 'தொடர்க';

  @override
  String get languageSkipButton => 'இப்போது வேண்டாம்';

  @override
  String get balanceCardLabel => 'மொத்த இருப்பு';

  @override
  String get balanceShowTooltip => 'இருப்பு காட்டு';

  @override
  String get balanceHideTooltip => 'இருப்பு மறை';

  @override
  String get summaryIncomeLabel => 'நீங்கள் கொடுத்தீர்கள்';

  @override
  String get summaryExpenseLabel => 'நீங்கள் பெற்றீர்கள்';

  @override
  String get homeCustomersHeader => 'வாடிக்கையாளர்கள்';

  @override
  String get homeAddEntryTooltip => 'பதிவு சேர்க்கவும்';

  @override
  String get homeEmptyTitle => 'இன்னும் வாடிக்கையாளர்கள் இல்லை';

  @override
  String get homeEmptyBody =>
      'பணம் கண்காணிக்க முதல் வாடிக்கையாளரை சேர்க்கவும்.';

  @override
  String get homeEmptyAddCustomer => 'வாடிக்கையாளர் சேர்க்கவும்';

  @override
  String get navHome => 'முகப்பு';

  @override
  String get navCustomers => 'வாடிக்கையாளர்கள்';

  @override
  String get navMore => 'மேலும்';

  @override
  String get navReports => 'அறிக்கைகள்';

  @override
  String get navSettings => 'அமைப்புகள்';

  @override
  String get appBarNotificationsTooltip => 'அறிவிப்புகள்';

  @override
  String get appBarGreetingMorning => 'காலை வணக்கம்';

  @override
  String get appBarGreetingAfternoon => 'மதிய வணக்கம்';

  @override
  String get appBarGreetingEvening => 'மாலை வணக்கம்';

  @override
  String get quickActionAddCustomer => 'வாடிக்கையாளர் சேர்க்கவும்';

  @override
  String get quickActionGenerateBill => 'பில் உருவாக்கவும்';

  @override
  String get quickActionSendReminder => 'நினைவூட்டல் அனுப்பவும்';

  @override
  String get quickActionRecordPayment => 'பணம் பதிவு செய்யவும்';

  @override
  String get homeRecentTransactions => 'சமீபத்திய பரிவர்த்தனைகள்';

  @override
  String get homeSeeAll => 'அனைத்தும் காண்க';

  @override
  String get homeAddEntry => 'பதிவு சேர்க்கவும்';

  @override
  String get homeNoTransactions => 'இன்னும் பரிவர்த்தனைகள் இல்லை';

  @override
  String get customersSearch => 'வாடிக்கையாளர்களை தேடுங்கள்...';

  @override
  String get customersAddButton => 'வாடிக்கையாளர் சேர்க்கவும்';

  @override
  String customersNoResults(String query) {
    return '\"$query\" க்கு எந்த முடிவும் இல்லை';
  }

  @override
  String txnTimeMinutesAgo(int minutes) {
    return '$minutes நிமிடம் முன்பு';
  }

  @override
  String txnTimeToday(String time) {
    return 'இன்று, $time';
  }

  @override
  String txnTimeYesterday(String time) {
    return 'நேற்று, $time';
  }

  @override
  String get txnTypeReceived => 'பெற்றது';

  @override
  String get txnTypePaid => 'கொடுத்தது';

  @override
  String get txnColGave => 'நீங்கள் கொடுத்தீர்கள்';

  @override
  String get txnColGot => 'நீங்கள் பெற்றீர்கள்';

  @override
  String get addCustomerTitle => 'வாடிக்கையாளரை சேர்க்கவும்';

  @override
  String get addCustomerNameLabel => 'வாடிக்கையாளர் பெயர்';

  @override
  String get addCustomerNameHint => 'எ.கா. ரவி குமார்';

  @override
  String get addCustomerPhoneLabel => 'தொலைபேசி எண்';

  @override
  String get addCustomerPhoneHint => 'எ.கா. 9876543210';

  @override
  String get addCustomerShopLabel => 'கடை / வணிக பெயர்';

  @override
  String get addCustomerShopHint => 'எ.கா. ரவி ஜெனரல் ஸ்டோர்';

  @override
  String get addCustomerBalanceLabel => 'ஆரம்ப இருப்பு';

  @override
  String get addCustomerBalanceHint => '0';

  @override
  String get addCustomerDirectionTheyOwe => 'அவர்கள் எனக்கு கொடுக்க வேண்டும்';

  @override
  String get addCustomerDirectionIOwe => 'நான் அவர்களுக்கு கொடுக்க வேண்டும்';

  @override
  String get addCustomerSave => 'வாடிக்கையாளரை சேமிக்கவும்';

  @override
  String get addCustomerError => 'சேமிக்கவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get addCustomerDuplicate =>
      'இந்த பெயர், தொலைபேசி மற்றும் கடையுடன் வாடிக்கையாளர் ஏற்கனவே உள்ளார்.';

  @override
  String get addCustomerNameRequired => 'பெயர் தேவை';

  @override
  String get addCustomerNameTooLong =>
      'பெயர் 80 எழுத்துகளுக்கு குறைவாக இருக்க வேண்டும்';

  @override
  String get addCustomerPhoneInvalid =>
      'சரியான தொலைபேசி எண் உள்ளிடவும் (10–15 இலக்கங்கள்)';

  @override
  String get addCustomerBalanceInvalid => 'சரியான தொகை உள்ளிடவும்';

  @override
  String get customerDetailOwesYou => 'நீங்கள் கொடுத்தீர்கள்';

  @override
  String get customerDetailYouOwe => 'நீங்கள் பெற்றீர்கள்';

  @override
  String get customerDetailSettled => 'தீர்வு செய்யப்பட்டது';

  @override
  String get customerDetailNoEntries => 'இன்னும் பதிவுகள் இல்லை';

  @override
  String get customerDetailNoEntriesBody =>
      'இந்த வாடிக்கையாளரின் முதல் பரிவர்த்தனையை பதிவு செய்யுங்கள்.';

  @override
  String get addEntryTitle => 'பதிவு சேர்க்கவும்';

  @override
  String get addEntryGave => 'நீங்கள் கொடுத்தீர்கள்';

  @override
  String get addEntryReceived => 'நீங்கள் பெற்றீர்கள்';

  @override
  String get addEntryAmountLabel => 'தொகை';

  @override
  String get addEntryAmountHint => '0';

  @override
  String get addEntryNoteLabel => 'விளக்கம் (விருப்பமானது)';

  @override
  String get addEntrySave => 'சேமிக்கவும்';

  @override
  String get addEntryAmountRequired => 'தொகையை உள்ளிடவும்';

  @override
  String get addEntryAmountInvalid => 'சரியான தொகை உள்ளிடவும்';

  @override
  String get retryButton => 'மீண்டும் முயற்சி';

  @override
  String get errorGeneric => 'ஏதோ தவறு நேர்ந்தது';

  @override
  String get dateToday => 'இன்று';

  @override
  String get dateYesterday => 'நேற்று';

  @override
  String get txnDirectionGave => 'நீங்கள் கொடுத்தீர்கள்';

  @override
  String get txnDirectionReceived => 'நீங்கள் பெற்றீர்கள்';

  @override
  String get offlineSafeLabel => 'ஆஃப்லைன் பாதுகாப்பானது';

  @override
  String get offlinePropertyPrivate => 'தனிப்பட்டது';

  @override
  String get offlinePropertyOffline => 'ஆஃப்லைன்';

  @override
  String get offlinePropertySecure => 'பாதுகாப்பானது';

  @override
  String get editCustomerTitle => 'வாடிக்கையாளரை திருத்து';

  @override
  String get editEntryTitle => 'உள்ளீட்டை திருத்து';

  @override
  String get contactsImportButton => 'தொடர்புகளிலிருந்து இறக்கு';

  @override
  String get contactsSyncToggle => 'தொலைபேசி தொடர்புகளில் சேமி';

  @override
  String get contactsSynced => 'தொடர்புகளுடன் ஒத்திசைக்கப்பட்டது';

  @override
  String get contactsPermissionDenied => 'தொடர்பு அனுமதி மறுக்கப்பட்டது';

  @override
  String get deleteConfirmTitle => 'நீக்கவா?';

  @override
  String get deleteCustomerConfirmBody =>
      'இந்த வாடிக்கையாளர் மற்றும் அவர்களின் அனைத்து பரிவர்த்தனைகளும் நிரந்தரமாக நீக்கப்படும்.';

  @override
  String get deleteTxnConfirmBody => 'இந்த உள்ளீடு நிரந்தரமாக நீக்கப்படும்.';

  @override
  String get deleteAction => 'நீக்கு';

  @override
  String get cancelAction => 'ரத்து';

  @override
  String get reportsFilterMonth => 'இந்த மாதம்';

  @override
  String get reportsFilterYear => 'இந்த ஆண்டு';

  @override
  String get reportsFilterAll => 'எல்லா நேரமும்';

  @override
  String get reportsTotalGave => 'மொத்தம் கொடுத்தது';

  @override
  String get reportsTotalGot => 'மொத்தம் பெற்றது';

  @override
  String get reportsNetBalance => 'நிகர இருப்பு';

  @override
  String get reportsColCustomer => 'வாடிக்கையாளர்';

  @override
  String get reportsColGave => 'கொடுத்தது';

  @override
  String get reportsColGot => 'பெற்றது';

  @override
  String get reportsColNet => 'நிகர';

  @override
  String get reportsEmpty => 'இந்த காலத்தில் பரிவர்த்தனைகள் இல்லை';

  @override
  String get reportsDownloadPdf => 'PDF பகிர்க';

  @override
  String get reportsFilterHint => 'காலகட்டம் தேர்ந்தெடுக்கவும்';

  @override
  String get reportsPdfTitle => 'KhataPro அறிக்கை';

  @override
  String reportsPdfPeriod(String period) {
    return 'காலம்: $period';
  }

  @override
  String get settingsTitle => 'அமைப்புகள்';

  @override
  String get settingsLanguage => 'மொழி';

  @override
  String get settingsLanguageSubtitle => 'பயன்பாட்டு மொழியை மாற்றவும்';

  @override
  String get settingsAboutSection => 'பற்றி';

  @override
  String get settingsVersion => 'பதிப்பு';

  @override
  String get settingsPrivacyPolicy => 'தனியுரிமைக் கொள்கை';

  @override
  String get settingsRateApp => 'KhataPro-ஐ மதிப்பிடுங்கள்';

  @override
  String get recordPaymentPickerTitle => 'வாடிக்கையாளரை தேர்ந்தெடுக்கவும்';

  @override
  String get recordPaymentPickerHint => 'வாடிக்கையாளர்களை தேடுங்கள்...';

  @override
  String get profileSetupTitle => 'உங்களைப் பற்றி';

  @override
  String get profileSetupSubtitle => 'உங்கள் அனுபவத்தை தனிப்பயனாக்க உதவுங்கள்.';

  @override
  String get profileNameLabel => 'உங்கள் பெயர்';

  @override
  String get profileNameHint => 'எ.கா. ரவி குமார்';

  @override
  String get profileNameRequired => 'பெயர் தேவை';

  @override
  String get profileNameTooLong =>
      'பெயர் 80 எழுத்துகளுக்கு குறைவாக இருக்க வேண்டும்';

  @override
  String get profileShopLabel => 'வணிகம் / கடை பெயர்';

  @override
  String get profileShopHint => 'எ.கா. ரவி ஜெனரல் ஸ்டோர்';

  @override
  String get profileContinueButton => 'தொடர்க';

  @override
  String get profileScreenTitle => 'என் சுயவிவரம்';

  @override
  String get profileEditButton => 'திருத்து';

  @override
  String get profileAuthSection => 'கணக்கு';

  @override
  String get profileSignInButton =>
      'ஒத்திசைவு மற்றும் காப்புப்பிரதிக்கு உள்நுழைக';

  @override
  String get reminderNoPhone =>
      'இந்த வாடிக்கையாளரின் தொலைபேசி எண் சேமிக்கப்படவில்லை';

  @override
  String get reminderNoBalance => 'இந்த வாடிக்கையாளருக்கு நிலுவைத் தொகை இல்லை';

  @override
  String get reminderShareUnavailable =>
      'செய்தியிடல் பயன்பாடு இல்லை. செய்தியை நகலெடுத்து கைமுறையாக அனுப்பவும்.';

  @override
  String get copyAction => 'நகலெடு';

  @override
  String get reminderSent => 'WhatsApp திறக்கிறது…';

  @override
  String get reminderSendButton => 'நினைவூட்டல் அனுப்பு';

  @override
  String reminderMessage(String name, String amount, String business) {
    return 'வணக்கம் $name, உங்களுக்கு ₹$amount நிலுவை உள்ளது. தயவுசெய்து விரைவில் செலுத்துங்கள். – $business';
  }

  @override
  String get catalogSectionTitle => 'வணிக அட்டைகள் & கேட்டலாக்';

  @override
  String get catalogAddPhoto => 'புகைப்படம் சேர்க்கவும்';

  @override
  String get catalogTakePhoto => 'புகைப்படம் எடுக்கவும்';

  @override
  String get catalogChooseGallery => 'கேலரியிலிருந்து தேர்வு செய்யவும்';

  @override
  String get catalogDeleteConfirm => 'இந்த படத்தை நீக்கவும்?';

  @override
  String get reminderAttachTitle => 'அட்டையை இணைக்கவும்?';

  @override
  String get reminderSendWithImage => 'படத்துடன் அனுப்பவும்';

  @override
  String get reminderSendWithoutImage => 'படம் இல்லாமல் அனுப்பவும்';

  @override
  String get generateBillTitle => 'பில் உருவாக்கவும்';

  @override
  String get billScreenTitle => 'கணக்கு அறிக்கை';

  @override
  String get billPeriodMonth => 'இந்த மாதம்';

  @override
  String get billPeriodYear => 'இந்த ஆண்டு';

  @override
  String get billPeriodAll => 'எல்லா நேரமும்';

  @override
  String get billPeriodCustom => 'தனிப்பயன்';

  @override
  String billPeriodLabel(String from, String to) {
    return '$from – $to';
  }

  @override
  String get billColDate => 'தேதி';

  @override
  String get billColNote => 'விவரம்';

  @override
  String get billColGave => 'கொடுத்தது';

  @override
  String get billColGot => 'பெற்றது';

  @override
  String get billTotalGave => 'மொத்தம் கொடுத்தது';

  @override
  String get billTotalGot => 'மொத்தம் பெற்றது';

  @override
  String get billNetBalance => 'நிலுவை தொகை';

  @override
  String get billYouAreOwed => 'உங்களுக்கு வர வேண்டியது';

  @override
  String get billYouOwe => 'நீங்கள் கொடுக்க வேண்டியது';

  @override
  String get billEmpty => 'இந்த காலகட்டத்தில் பரிவர்த்தனைகள் இல்லை';

  @override
  String get billShareButton => 'PDF ஆக பகிர்க';

  @override
  String get billCustomRange => 'தேதி வரம்பை தேர்ந்தெடுக்கவும்';

  @override
  String get billFilterHint => 'காலகட்டம் தேர்ந்தெடுக்கவும்';

  @override
  String get backupSectionTitle => 'தரவு';

  @override
  String get backupTileTitle => 'தரவை காப்புப்பிரதி எடுக்கவும்';

  @override
  String get backupTileSubtitle =>
      'அனைத்து வாடிக்கையாளர்கள் & பரிவர்த்தனைகளை ஏற்றுமதி செய்யவும்';

  @override
  String get restoreTileTitle => 'காப்புப்பிரதியிலிருந்து மீட்டமைக்கவும்';

  @override
  String get restoreTileSubtitle =>
      'காப்புப்பிரதி கோப்பிலிருந்து அனைத்து தரவையும் மாற்றவும்';

  @override
  String get restoreConfirmTitle => 'அனைத்து தரவையும் மாற்றவுமா?';

  @override
  String get restoreConfirmBody =>
      'இது உங்கள் தற்போதைய தரவை காப்புப்பிரதியுடன் நிரந்தரமாக மாற்றும். இதை செயல்தவிர்க்க முடியாது.';

  @override
  String get restoreSuccess => 'தரவு வெற்றிகரமாக மீட்டமைக்கப்பட்டது';

  @override
  String get restoreError =>
      'காப்புப்பிரதியை மீட்டமைக்க முடியவில்லை. கோப்பு தவறானது அல்லது சிதைந்திருக்கலாம்.';

  @override
  String get remindersSectionTitle => 'நினைவூட்டல்கள்';

  @override
  String get defaultReminderTitle => 'இயல்புநிலை நினைவூட்டல்';

  @override
  String get defaultReminderSubtitle =>
      'புதிய வாடிக்கையாளர்களுக்கு தானாகவே பொருந்தும்';

  @override
  String get defaultReminderSheetHint =>
      'புதிய வாடிக்கையாளரை சேர்க்கும்போது முன்பே தேர்ந்தெடுக்கப்படும். ஒவ்வொரு வாடிக்கையாளரின் நினைவூட்டலும் தனித்தனியாக அமைக்கப்படுகிறது.';

  @override
  String get setReminderTitle => 'நினைவூட்டல் அமை';

  @override
  String get reminderFrequencyNone => 'எதுவுமில்லை';

  @override
  String get reminderFrequencyWeekly => 'வாராந்திரம்';

  @override
  String get reminderFrequencyFortnightly => 'ஒவ்வொரு 2 வாரமும்';

  @override
  String get reminderFrequencyMonthly => 'மாதந்தோறும்';

  @override
  String get reminderModeRecurring => 'மீண்டும் மீண்டும்';

  @override
  String get reminderModeOnDate => 'ஒரு தேதியில்';

  @override
  String get reminderDateLabel => 'நினைவூட்டல் தேதி';

  @override
  String get reminderDateHint => 'தேதி தேர்ந்தெடுக்கவும்';

  @override
  String get reminderDatePast => 'எதிர்கால தேதியை தேர்ந்தெடுக்கவும்';

  @override
  String get reminderTimeMorning => 'காலை · 9 மணி';

  @override
  String get reminderTimeAfternoon => 'மதியம் · 1 மணி';

  @override
  String get reminderTimeEvening => 'மாலை · 6 மணி';

  @override
  String reminderActiveChip(String freq) {
    return '$freq நினைவூட்டல்';
  }

  @override
  String get reminderNotifTitle => 'கட்டண நினைவூட்டல்';

  @override
  String reminderNotifBody(String name, String amount) {
    return '$name ₹$amount நிலுவையில் உள்ளது — நினைவூட்டல் அனுப்ப தட்டவும்';
  }

  @override
  String get authSignInTitle =>
      'ஒத்திசைவு மற்றும் காப்புப்பிரதிக்கு உள்நுழையவும்';

  @override
  String get authSignInSubtitle =>
      'உங்கள் தரவு அனைத்து சாதனங்களிலும் பாதுகாப்பாக இருக்கும்';

  @override
  String get authPhoneButton => 'தொலைபேசியுடன் தொடரவும்';

  @override
  String get authGoogleButton => 'Google உடன் தொடரவும்';

  @override
  String get authOrDivider => 'அல்லது';

  @override
  String get authPhoneStepTitle => 'உங்கள் தொலைபேசி எண்ணை உள்ளிடவும்';

  @override
  String get authPhoneStepSubtitle =>
      'உங்கள் எண்ணை சரிபார்க்க ஒரு குறியீடு அனுப்புவோம்';

  @override
  String get authPhoneLabel => 'தொலைபேசி எண்';

  @override
  String get authPhoneHint => '+91 98765 43210';

  @override
  String get authSendOtpButton => 'OTP அனுப்பு';

  @override
  String get authOtpTitle => 'OTP உள்ளிடவும்';

  @override
  String get authOtpLabel => '6 இலக்க குறியீடு';

  @override
  String authOtpSubtitle(String phone) {
    return '$phone க்கு அனுப்பப்பட்டது';
  }

  @override
  String get authVerifyButton => 'சரிபார்க்கவும்';

  @override
  String get authResendOtp => 'OTP மீண்டும் அனுப்பு';

  @override
  String get authOtpResent => 'OTP வெற்றிகரமாக மீண்டும் அனுப்பப்பட்டது';

  @override
  String get authDidntReceive => 'கிடைக்கவில்லையா?';

  @override
  String authResendIn(int seconds) {
    return '${seconds}s இல் மீண்டும் அனுப்பு';
  }

  @override
  String get authSignOut => 'வெளியேறு';

  @override
  String authSignedInAs(String name) {
    return '$name ஆக உள்நுழைந்துள்ளீர்கள்';
  }

  @override
  String get authSkip => 'இப்போது தவிர்க்கவும்';

  @override
  String get authSyncingData => 'Syncing your dataâ¦';

  @override
  String get authDataSynced => 'அனைத்து தரவும் கிளவுடில் ஒத்திசைக்கப்பட்டது';

  @override
  String get syncUnsyncedBanner =>
      'ஒத்திசைக்கப்படாத மாற்றங்கள் — ஒத்திசைக்க இணையத்துடன் இணைக்கவும்.';

  @override
  String get syncCloudWinsTitle => 'உள்ளூர் தரவை மாற்றவுமா?';

  @override
  String get syncCloudWinsBody =>
      'உள்நுழைவதால் உங்கள் அனைத்து உள்ளூர் தரவும் கிளவுட் காப்புப்பிரதியால் மாற்றப்படும். இதை செயல்தவிர்க்க முடியாது.';

  @override
  String get offlineBar => 'இணைய இணைப்பு இல்லை';

  @override
  String get firstRunTitle => 'KhataPro க்கு வரவேற்கிறோம்!';

  @override
  String get firstRunBody =>
      'வாடிக்கையாளர்கள் எவ்வளவு கடன்பட்டார்கள் என்று கண்காணிக்கவும் — காகிதம் தேவையில்லை.';

  @override
  String get firstRunStep1 => 'வாடிக்கையாளரை சேர்க்கவும்';

  @override
  String get firstRunStep2 => 'பணம் பதிவு செய்யவும்';

  @override
  String get firstRunStep3 => 'நினைவூட்டல் அனுப்பவும்';

  @override
  String get firstRunDismiss => 'புரிந்தது';

  @override
  String get reportsFilterCustomer => 'அனைத்து வாடிக்கையாளர்கள்';

  @override
  String get reportsFilterByCustomer => 'வாடிக்கையாளரால் வடிகட்டவும்';

  @override
  String reportsCustomerSelected(String name) {
    return '$name அறிக்கை';
  }

  @override
  String get appLockSectionTitle => 'பாதுகாப்பு';

  @override
  String get appLockTileTitle => 'ஆப் லாக்';

  @override
  String get appLockTileSubtitle => 'திறக்க பயோமெட்ரிக் அல்லது PIN தேவை';

  @override
  String get appLockSetPin => 'PIN அமைக்கவும்';

  @override
  String get pinSetupTitle => 'PIN உருவாக்கவும்';

  @override
  String get pinSetupSubtitle => 'பயோமெட்ரிக் தோல்வியுற்றால் மாற்றாக பயன்படும்';

  @override
  String get pinConfirmTitle => 'உங்கள் PIN உறுதிப்படுத்தவும்';

  @override
  String get pinMismatch => 'PIN பொருந்தவில்லை. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get pinIncorrect => 'தவறான PIN. மீண்டும் முயற்சிக்கவும்.';

  @override
  String get pinEnterTitle => 'உங்கள் PIN உள்ளிடவும்';

  @override
  String get pinForgot => 'PIN மறந்தீர்களா? மீட்டமைக்க உள்நுழைக';

  @override
  String get biometricReason => 'KhataPro திறக்கவும்';

  @override
  String get appLockDisabledInfo => 'ஆப் லாக் முடக்கப்பட்டது';

  @override
  String get notifPermDenied =>
      'அறிவிப்பு அனுமதி மறுக்கப்பட்டது. நினைவூட்டல்கள் பெற அமைப்புகளில் இயக்கவும்.';
}
