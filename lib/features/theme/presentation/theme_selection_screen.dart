import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/theme_provider.dart';

class ThemeSelectionScreen extends ConsumerWidget {
  const ThemeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final colorScheme = Theme.of(context).colorScheme;

    // Design tokens matched to Stitch HTML:
    // primary-fixed = #d6e3ff (light blue tint for selected bg & icon boxes)
    // primary = #004d99 (dark navy for borders, button, icon color)
    // on-surface = #1a1c1c (dark card icon background when unselected)
    // surface-container-lowest = #ffffff (unselected card bg)
    // surface = #f9f9f9 / background = #f2f3f5

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F5),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 64, 24, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── App Icon & Branding ──
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD6E3FF), // primary-fixed
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.menu_book,
                      size: 40,
                      color: Color(0xFF004D99), // primary
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'KhataMitra',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: const Color(0xFF004D99), // primary
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Choose your theme',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 40),

                  // ── Theme Cards ──
                  _ThemeCard(
                    title: 'Light',
                    subtitle: 'Bright white background',
                    icon: Icons.light_mode,
                    mode: ThemeMode.light,
                    currentMode: themeMode,
                    // selected: bg=primary-fixed, icon-box=white
                    // unselected: would be white card / primary-fixed icon box
                    iconBoxColorSelected: Colors.white,
                    iconBoxColorUnselected: const Color(0xFFD6E3FF),
                    onTap: () => ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.light),
                  ),
                  const SizedBox(height: 16),
                  _ThemeCard(
                    title: 'Dark',
                    subtitle: 'Easy on the eyes at night',
                    icon: Icons.dark_mode,
                    mode: ThemeMode.dark,
                    currentMode: themeMode,
                    // Dark card: icon-box always uses on-surface (dark) with white icon
                    iconBoxColorSelected: Colors.white,
                    iconBoxColorUnselected: const Color(0xFF1A1C1C), // on-surface
                    iconColorUnselected: Colors.white,
                    onTap: () => ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.dark),
                  ),
                  const SizedBox(height: 16),
                  _ThemeCard(
                    title: 'System Default',
                    subtitle: 'Follows your phone setting',
                    icon: Icons.contrast,
                    mode: ThemeMode.system,
                    currentMode: themeMode,
                    // System card: icon-box uses primary-fixed (light blue)
                    iconBoxColorSelected: Colors.white,
                    iconBoxColorUnselected: const Color(0xFFD6E3FF),
                    onTap: () => ref.read(themeModeProvider.notifier).setThemeMode(ThemeMode.system),
                  ),

                  const SizedBox(height: 48),

                  // ── Decorative Bento Grid ──
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 128,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFA0F399), // secondary-container
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: 8,
                                width: 64,
                                margin: const EdgeInsets.only(bottom: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC2C6D4).withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(99),
                                ),
                              ),
                              Container(
                                height: 8,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFC2C6D4).withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(99),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 128,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.4),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Icon(
                            Icons.brush_outlined,
                            size: 48,
                            color: Color(0x66C2C6D4), // outline-variant / 40
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Sticky Footer ──
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFFF2F3F5),
                      Color(0xE6F2F3F5),
                      Colors.transparent,
                    ],
                    stops: [0, 0.7, 1],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () => context.go('/language'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004D99), // primary
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 56),
                    shape: const StadiumBorder(),
                    elevation: 4,
                    shadowColor: const Color(0xFF004D99).withValues(alpha: 0.3),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final ThemeMode mode;
  final ThemeMode currentMode;
  final Color iconBoxColorSelected;
  final Color iconBoxColorUnselected;
  final Color? iconColorUnselected;
  final VoidCallback onTap;

  const _ThemeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.mode,
    required this.currentMode,
    required this.iconBoxColorSelected,
    required this.iconBoxColorUnselected,
    this.iconColorUnselected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentMode == mode;
    const primaryFixed = Color(0xFFD6E3FF);
    const primary = Color(0xFF004D99);
    const onSurface = Color(0xFF1A1C1C);
    const outlineVariant = Color(0xFFC2C6D4);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? primaryFixed : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? primary : outlineVariant.withValues(alpha: 0.3),
            width: isSelected ? 2.0 : 1.5,
          ),
        ),
        child: Row(
          children: [
            // Icon box
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? iconBoxColorSelected : iconBoxColorUnselected,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? primary
                    : (iconColorUnselected ?? primary),
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            // Labels
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: onSurface,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF424752), // on-surface-variant
                        ),
                  ),
                ],
              ),
            ),
            // Checkmark
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
