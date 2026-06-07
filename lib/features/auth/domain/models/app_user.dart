import 'package:firebase_auth/firebase_auth.dart' as fb;

class AppUser {
  const AppUser({
    required this.uid,
    this.displayName,
    this.phoneNumber,
    this.email,
    this.photoUrl,
  });

  final String uid;
  final String? displayName;
  final String? phoneNumber;
  final String? email;
  final String? photoUrl;

  factory AppUser.fromFirebase(fb.User user) => AppUser(
    uid: user.uid,
    displayName: user.displayName,
    phoneNumber: user.phoneNumber,
    email: user.email,
    photoUrl: user.photoURL,
  );

  String get displayLabel =>
      displayName?.isNotEmpty == true
          ? displayName!
          : phoneNumber ?? email ?? uid;
}
