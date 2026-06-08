import 'package:flutter/material.dart';

import '../../core/constants/app_dimensions.dart';
import '../../core/theme/app_colors.dart';

// File-private layout constants.
abstract final class _Dims {
  static const double searchShadowBlur = 8.0;
}

/// Pill-shaped search field with an internal clear button.
///
/// Manages its own clear-button visibility — callers only supply [controller],
/// [hint], and [onChanged].  Set [showShadow] false on elevated surfaces.
/// Set [autofocus] true when searching is the screen's primary purpose.
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
    final colorScheme = Theme.of(context).colorScheme;

    final field = TextField(
      controller: widget.controller,
      autofocus:  widget.autofocus,
      onChanged:  widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: Icon(
          Icons.search_rounded,
          size:  AppDimensions.iconSizeSmall,
          color: colorScheme.onSurfaceVariant,
        ),
        suffixIcon: _hasText
            ? IconButton(
                icon:     const Icon(Icons.close_rounded),
                iconSize: AppDimensions.iconSizeSmall,
                color:    colorScheme.onSurfaceVariant,
                onPressed: _clear,
              )
            : null,
        filled:    true,
        fillColor: colorScheme.surfaceContainerLow,
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
          borderSide: BorderSide(
            color: colorScheme.primary,
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
            blurRadius: _Dims.searchShadowBlur,
            offset:     const Offset(0, AppDimensions.shadowOffsetCard),
          ),
        ],
      ),
      child: field,
    );
  }
}

/// Provides [searchController], [searchQuery], [onSearchChanged], and
/// [clearSearch] to any [State] that needs a search bar.
mixin SmartSearchMixin<T extends StatefulWidget> on State<T> {
  final searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearchChanged(String value) {
    setState(() => searchQuery = value);
  }

  void clearSearch() {
    searchController.clear();
    setState(() => searchQuery = '');
  }
}
