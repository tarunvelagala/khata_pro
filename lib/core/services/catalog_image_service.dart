import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

abstract final class CatalogImageService {
  static final _picker = ImagePicker();
  static const _uuid   = Uuid();

  /// Picks an image from [source], optionally crops it, compresses it,
  /// copies it to [subdir] under app documents, and returns the persisted
  /// path. Returns null if the user cancels.
  static Future<String?> pickAndStore(
    ImageSource source, {
    String subdir = 'catalog',
    bool crop = false,
  }) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 90);
    if (picked == null) return null;

    String sourcePath = picked.path;

    if (crop) {
      final cropped = await ImageCropper().cropImage(
        sourcePath: sourcePath,
        uiSettings: [
          AndroidUiSettings(toolbarTitle: ''),
          IOSUiSettings(title: ''),
        ],
      );
      if (cropped == null) return null;
      sourcePath = cropped.path;
    }

    final docDir  = await getApplicationDocumentsDirectory();
    final destDir = Directory('${docDir.path}/$subdir');
    if (!destDir.existsSync()) destDir.createSync(recursive: true);

    final destPath = '${destDir.path}/${_uuid.v4()}.jpg';
    final result = await FlutterImageCompress.compressAndGetFile(
      sourcePath,
      destPath,
      quality: 80,
      minWidth: 800,
      minHeight: 600,
    );
    if (result == null) {
      // Compress failed — copy original
      await File(sourcePath).copy(destPath);
    }
    return destPath;
  }

  /// Lists all stored image paths under [subdir].
  static Future<List<String>> list(String subdir) async {
    final docDir = await getApplicationDocumentsDirectory();
    final dir    = Directory('${docDir.path}/$subdir');
    if (!dir.existsSync()) return [];
    return dir
        .listSync()
        .whereType<File>()
        .map((f) => f.path)
        .toList()
      ..sort();
  }

  /// Deletes the file at [path]. Returns true if deleted, false otherwise.
  static Future<bool> delete(String path) async {
    try {
      final file = File(path);
      if (file.existsSync()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }
}
