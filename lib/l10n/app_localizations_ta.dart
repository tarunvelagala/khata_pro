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
  String get summaryIncomeLabel => 'உங்களுக்கு வர வேண்டியது';

  @override
  String get summaryExpenseLabel => 'நீங்கள் கொடுக்க வேண்டியது';

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
  String get customerDetailOwesYou => 'உங்களுக்கு கொடுக்க வேண்டும்';

  @override
  String get customerDetailYouOwe => 'நீங்கள் கொடுக்க வேண்டும்';

  @override
  String get customerDetailSettled => 'தீர்வு செய்யப்பட்டது';

  @override
  String get customerDetailNoEntries => 'இன்னும் பதிவுகள் இல்லை';

  @override
  String get customerDetailNoEntriesBody =>
      'இந்த வாடிக்கையாளரின் முதல் பரிவர்த்தனையை பதிவு செய்யுங்கள்.';

  @override
  String get customerDetailAddFirstEntry => 'முதல் பதிவை சேர்க்கவும்';

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
  String get addEntryNoteLabel => 'குறிப்பு (விருப்பமானது)';

  @override
  String get addEntrySave => 'சேமிக்கவும்';

  @override
  String get addEntryAmountRequired => 'தொகையை உள்ளிடவும்';

  @override
  String get addEntryAmountInvalid => 'சரியான தொகை உள்ளிடவும்';

  @override
  String get retryButton => 'மீண்டும் முயற்சி';

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
}
