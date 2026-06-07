import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/prefs_keys.dart';

class AppLockState {
  const AppLockState({
    this.enabled = false,
    this.pinSet = false,
  });

  final bool enabled;
  final bool pinSet;

  AppLockState copyWith({bool? enabled, bool? pinSet}) => AppLockState(
        enabled: enabled ?? this.enabled,
        pinSet:  pinSet  ?? this.pinSet,
      );
}

class AppLockNotifier extends AsyncNotifier<AppLockState> {
  @override
  Future<AppLockState> build() async {
    final prefs = await SharedPreferences.getInstance();
    return AppLockState(
      enabled: prefs.getBool(PrefsKeys.appLockEnabled) ?? false,
      pinSet:  prefs.getString(PrefsKeys.appLockPinHash) != null,
    );
  }

  Future<void> setEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PrefsKeys.appLockEnabled, value);
    final current = state.asData?.value ?? const AppLockState();
    state = AsyncData(current.copyWith(enabled: value));
  }

  Future<void> setPin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    final hash  = sha256.convert(utf8.encode(pin)).toString();
    await prefs.setString(PrefsKeys.appLockPinHash, hash);
    final current = state.asData?.value ?? const AppLockState();
    state = AsyncData(current.copyWith(pinSet: true));
  }

  Future<bool> verifyPin(String pin) async {
    final prefs    = await SharedPreferences.getInstance();
    final stored   = prefs.getString(PrefsKeys.appLockPinHash);
    if (stored == null) return false;
    final incoming = sha256.convert(utf8.encode(pin)).toString();
    return incoming == stored;
  }

  Future<void> clearPin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PrefsKeys.appLockPinHash);
    await prefs.setBool(PrefsKeys.appLockEnabled, false);
    state = const AsyncData(AppLockState());
  }
}

final appLockProvider =
    AsyncNotifierProvider<AppLockNotifier, AppLockState>(
  AppLockNotifier.new,
);
