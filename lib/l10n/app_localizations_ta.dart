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
}
