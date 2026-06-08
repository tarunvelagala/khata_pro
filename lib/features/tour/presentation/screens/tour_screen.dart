import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_dimensions.dart';
import '../../../../core/constants/prefs_keys.dart';
import '../../../../core/widgets/illustration_frame.dart';
import '../../../../core/widgets/kp_back_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/dot_indicator.dart';
import '../widgets/ledger_phone_illustration.dart';
import '../widgets/offline_safety_illustration.dart';
import '../widgets/reminder_card_illustration.dart';
import '../widgets/tour_slide.dart';

// ── File-private layout constants ─────────────────────────────────────────────
abstract final class _Dims {
  static const double dotBottomPadding = 16.0;
}

class TourScreen extends ConsumerStatefulWidget {
  const TourScreen({super.key});

  @override
  ConsumerState<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends ConsumerState<TourScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  static const int _pageCount = 3;
  static const Duration _pageDuration = Duration(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.tourSeen, true);
    if (!mounted) return;
    context.push('/auth/sign-in');
  }

  void _onCta() {
    if (_currentPage < _pageCount - 1) {
      if (MediaQuery.disableAnimationsOf(context)) {
        _pageController.jumpToPage(_currentPage + 1);
      } else {
        _pageController.nextPage(
          duration: _pageDuration,
          curve: Curves.easeInOut,
        );
      }
    } else {
      _complete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isLast = _currentPage == _pageCount - 1;    final slides = [
      TourSlide(
        illustration: const IllustrationFrame(child: LedgerPhoneIllustration()),
        headline: l10n.tourHeadline1,
        body: l10n.tourBody1,
      ),
      TourSlide(
        illustration: const IllustrationFrame(child: ReminderCardIllustration()),
        headline: l10n.tourHeadline2,
        body: l10n.tourBody2,
      ),
      TourSlide(
        illustration: const IllustrationFrame(child: OfflineSafetyIllustration()),
        headline: l10n.tourHeadline3,
        body: l10n.tourBody3,
      ),
    ];

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: KpBackButton(
          onPressed: () {
            if (_currentPage > 0) {
              _pageController.previousPage(
                duration: _pageDuration,
                curve: Curves.easeInOut,
              );
            } else {
              context.go('/settings/language');
            }
          },
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: Platform.isIOS
                    ? const BouncingScrollPhysics()
                    : const ClampingScrollPhysics(),
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: slides,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: _Dims.dotBottomPadding),
              child: DotIndicator(currentPage: _currentPage, count: _pageCount),
            ),
            Builder(
              builder: (ctx) {
                final bottom = MediaQuery.paddingOf(ctx).bottom;
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppDimensions.buttonPaddingH,
                    AppDimensions.buttonPaddingV / 2,
                    AppDimensions.buttonPaddingH,
                    AppDimensions.buttonPaddingV / 2 + bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _onCta,
                          child: Text(isLast ? l10n.tourGetStarted : l10n.tourNext),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.buttonStackGap),
                      TextButton(
                        onPressed: _complete,
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.zero,
                        ),
                        child: Text(l10n.tourSkip),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

