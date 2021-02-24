import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class ImageUploadService {
  static final _ref = FirebaseStorage.instance.ref("user_profile_picture");

  static Future<String> getImageUrl(File image) async {
    if (image == null) return "";
    String imageUrl = "";
    String imagePath = path.basename(image.path);
    UploadTask upload = _ref.child(imagePath).putFile(image);
    await upload.whenComplete(() async {
      imageUrl = await _ref.child(imagePath).getDownloadURL();
    });
    return imageUrl;
  }
}
