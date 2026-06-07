import '../../presentation/providers/profile_provider.dart';

extension UserProfileName on UserProfile? {
  String get businessName {
    final p = this;
    if (p == null) return 'KhataPro';
    if (p.shopName?.isNotEmpty == true) return p.shopName!;
    if (p.name.isNotEmpty) return p.name;
    return 'KhataPro';
  }
}
