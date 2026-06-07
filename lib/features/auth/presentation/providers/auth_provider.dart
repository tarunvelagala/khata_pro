import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/app_user.dart';

class AuthNotifier extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() async {
    // Listen to Firebase auth state changes and rebuild.
    ref.onDispose(
      fb.FirebaseAuth.instance.authStateChanges().listen((user) {
        state = AsyncData(user == null ? null : AppUser.fromFirebase(user));
      }).cancel,
    );
    final user = fb.FirebaseAuth.instance.currentUser;
    return user == null ? null : AppUser.fromFirebase(user);
  }

  Future<void> signOut() => fb.FirebaseAuth.instance.signOut();
}

final authProvider = AsyncNotifierProvider<AuthNotifier, AppUser?>(
  AuthNotifier.new,
);
