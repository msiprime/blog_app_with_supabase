import 'dart:io' show File;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;

Future<File?> pickImage() async {
  try {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (xFile != null) {
      return File(xFile.path);
    } else {
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    return null;
  }
}
