import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimensions.dart';

abstract final class _Dims {
  static const double dotSize    = 14.0;
  static const double dotSpacing = 20.0;
  static const double padH       = 40.0;
  static const double keyHeight  = 64.0;
  static const double keyGap     = 8.0;
  static const double dotsGap    = 32.0;
}

/// Displays a 4-dot PIN indicator and a number pad.
/// Calls [onComplete] with the 4-digit string once all 4 digits are entered.
class PinEntry extends StatefulWidget {
  const PinEntry({
    super.key,
    required this.onComplete,
    this.errorText,
    this.subtitle,
  });

  final void Function(String pin) onComplete;
  final String? errorText;
  final String? subtitle;

  @override
  State<PinEntry> createState() => _PinEntryState();
}

class _PinEntryState extends State<PinEntry> {
  String _digits = '';

  void _append(String d) {
    if (_digits.length >= 4) return;
    setState(() => _digits += d);
    if (_digits.length == 4) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onComplete(_digits);
      });
    }
  }

  void _backspace() {
    if (_digits.isEmpty) return;
    setState(() => _digits = _digits.substring(0, _digits.length - 1));
  }

  void reset() => setState(() => _digits = '');

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.subtitle != null)
          Text(
            widget.subtitle!,
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: _Dims.dotsGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (i) {
            final filled = i < _digits.length;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: _Dims.dotSpacing / 2),
              child: AnimatedContainer(
                duration: AppDimensions.animShort,
                width: _Dims.dotSize,
                height: _Dims.dotSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: filled ? cs.primary : Colors.transparent,
                  border: Border.all(
                    color: filled ? cs.primary : cs.outline,
                    width: 2,
                  ),
                ),
              ),
            );
          }),
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: 12),
          Text(
            widget.errorText!,
            style: tt.bodySmall?.copyWith(color: cs.error),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: _Dims.dotsGap),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _Dims.padH),
          child: Column(
            children: [
              for (final row in [
                ['1', '2', '3'],
                ['4', '5', '6'],
                ['7', '8', '9'],
                ['', '0', '⌫'],
              ])
                Padding(
                  padding: const EdgeInsets.only(bottom: _Dims.keyGap),
                  child: Row(
                    children: row.map((key) {
                      if (key.isEmpty) return const Expanded(child: SizedBox());
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: _Dims.keyGap / 2),
                          child: SizedBox(
                            height: _Dims.keyHeight,
                            child: TextButton(
                              onPressed: key == '⌫'
                                  ? _backspace
                                  : () => _append(key),
                              style: TextButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor:
                                    cs.surfaceContainerHighest,
                                foregroundColor: cs.onSurface,
                              ),
                              child: key == '⌫'
                                  ? Icon(Icons.backspace_outlined,
                                      size: AppDimensions.iconSizeMedium,
                                      color: cs.onSurfaceVariant)
                                  : Text(key,
                                      style: tt.headlineSmall?.copyWith(
                                        color: cs.onSurface,
                                      )),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
