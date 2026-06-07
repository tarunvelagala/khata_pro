import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/prefs_keys.dart';
import '../../../../core/services/sync_service.dart';

const _kProfileKey = 'user_profile';

class UserProfile {
  const UserProfile({
    required this.name,
    this.shopName,
    this.catalogImagePaths = const [],
  });

  final String       name;
  final String?      shopName;
  final List<String> catalogImagePaths;

  UserProfile copyWith({
    String?       name,
    String?       shopName,
    List<String>? catalogImagePaths,
  }) => UserProfile(
    name:               name               ?? this.name,
    shopName:           shopName           ?? this.shopName,
    catalogImagePaths:  catalogImagePaths  ?? this.catalogImagePaths,
  );
}

class ProfileNotifier extends AsyncNotifier<UserProfile?> {
  @override
  Future<UserProfile?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final raw   = prefs.getString(_kProfileKey);
    if (raw == null) return null;
    final map   = jsonDecode(raw) as Map<String, dynamic>;
    final paths = (map['catalogImages'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [];
    return UserProfile(
      name:              map['name']     as String,
      shopName:          map['shopName'] as String?,
      catalogImagePaths: paths,
    );
  }

  Future<void> save(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _kProfileKey,
      jsonEncode({
        'name':          profile.name,
        'shopName':      profile.shopName,
        'catalogImages': profile.catalogImagePaths,
      }),
    );
    await prefs.setBool(PrefsKeys.profileSetupDone, true);
    state = AsyncData(profile);
    unawaited(ref.read(syncServiceProvider).pushProfile(profile));
  }

  Future<void> addCatalogImage(String path) async {
    final current = state.value;
    if (current == null) return;
    await save(current.copyWith(
      catalogImagePaths: [...current.catalogImagePaths, path],
    ));
  }

  Future<void> removeCatalogImage(String path) async {
    final current = state.value;
    if (current == null) return;
    await save(current.copyWith(
      catalogImagePaths: current.catalogImagePaths
          .where((p) => p != path)
          .toList(),
    ));
  }
}

final profileProvider =
    AsyncNotifierProvider<ProfileNotifier, UserProfile?>(ProfileNotifier.new);
