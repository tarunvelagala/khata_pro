import 'package:flutter/material.dart';

import '../constants/app_dimensions.dart';
import '../theme/app_colors.dart';

const double _kSearchIconSize  = 20.0;
const double _kSearchShadowBlur = 8.0;

// ── Widget ────────────────────────────────────────────────────────────────────

/// Pill-shaped search field with an optional drop shadow.
///
/// Manages its own clear-button visibility internally — callers only supply
/// the [controller], [hint], and [onChanged] callback.
///
/// Set [showShadow] to false when the field appears on a surface that already
/// provides elevation context (e.g. inside a modal picker appbar area).
/// Set [autofocus] to true when the screen's primary purpose is searching.
class KpSearchBar extends StatefulWidget {
  const KpSearchBar({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.autofocus  = false,
    this.showShadow = true,
  });

  final TextEditingController controller;
  final String                 hint;
  final ValueChanged<String>   onChanged;
  final bool                   autofocus;
  final bool                   showShadow;

  @override
  State<KpSearchBar> createState() => _KpSearchBarState();
}

class _KpSearchBarState extends State<KpSearchBar> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void didUpdateWidget(KpSearchBar old) {
    super.didUpdateWidget(old);
    if (old.controller != widget.controller) {
      old.controller.removeListener(_onControllerChanged);
      widget.controller.addListener(_onControllerChanged);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    final hasText = widget.controller.text.isNotEmpty;
    if (hasText != _hasText) setState(() => _hasText = hasText);
  }

  void _clear() {
    widget.controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final field = TextField(
      controller:  widget.controller,
      autofocus:   widget.autofocus,
      onChanged:   widget.onChanged,
      decoration:  InputDecoration(
        hintText: widget.hint,
        prefixIcon: Icon(
          Icons.search_rounded,
          size:  _kSearchIconSize,
          color: cs.onSurfaceVariant,
        ),
        suffixIcon: _hasText
            ? IconButton(
                icon:     const Icon(Icons.close_rounded),
                iconSize: _kSearchIconSize,
                color:    cs.onSurfaceVariant,
                onPressed: _clear,
              )
            : null,
        filled:    true,
        fillColor: cs.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
          borderSide:   BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
          borderSide:   BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
          borderSide:   BorderSide(
            color: cs.primary,
            width: AppDimensions.borderFocused,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.inputPaddingH,
          vertical:   AppDimensions.inputPaddingV / 2,
        ),
      ),
    );

    if (!widget.showShadow) return field;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
        boxShadow: [
          BoxShadow(
            color:      AppColors.shadowCard,
            blurRadius: _kSearchShadowBlur,
            offset:     const Offset(0, AppDimensions.shadowOffsetCard),
          ),
        ],
      ),
      child: field,
    );
  }
}

// ── Mixin ─────────────────────────────────────────────────────────────────────

/// Provides [searchController], [searchQuery], [onSearchChanged], and
/// [clearSearch] to any [State] that needs a search bar.
///
/// Filter logic and auto-navigate behaviour are intentionally left to the
/// mixing-in class — they differ per screen.
mixin SmartSearchMixin<T extends StatefulWidget> on State<T> {
  final searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearchChanged(String v) {
    setState(() => searchQuery = v);
  }

  void clearSearch() {
    searchController.clear();
    setState(() => searchQuery = '');
  }
}
