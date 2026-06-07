import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/services/catalog_image_service.dart';

final customerImageProvider =
    NotifierProvider.family<CustomerImageNotifier, List<String>, String>(
  (customerId) => CustomerImageNotifier(customerId),
);

class CustomerImageNotifier extends Notifier<List<String>> {
  CustomerImageNotifier(this._customerId);

  final String _customerId;
  String get _subdir => 'customer_images/$_customerId';

  @override
  List<String> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    final paths = await CatalogImageService.list(_subdir);
    state = paths;
  }

  Future<void> addImage(ImageSource source) async {
    final path = await CatalogImageService.pickAndStore(
      source,
      subdir: _subdir,
      crop: true,
    );
    if (path == null) return;
    state = [...state, path];
  }

  Future<void> deleteImage(String path) async {
    await CatalogImageService.delete(path);
    state = state.where((p) => p != path).toList();
  }
}
