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
  String get summaryIncomeLabel => 'మీకు రావాలి';

  @override
  String get summaryExpenseLabel => 'మీరు ఇవ్వాలి';

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
}
