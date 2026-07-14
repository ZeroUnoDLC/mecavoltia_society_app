import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

/// URL base del gateway. Precedencia:
///   1. --dart-define=API_BASE_URL=... (CI, builds especiales)
///   2. assets/config.env → API_BASE_URL (editable sin tocar comandos)
///   3. Default por plataforma: emulador Android 10.0.2.2, resto localhost
abstract final class Env {
  static const String _defined = String.fromEnvironment('API_BASE_URL');

  static String get apiBaseUrl {
    if (_defined.isNotEmpty) return _defined;

    final fromFile =
        dotenv.isInitialized ? (dotenv.env['API_BASE_URL']?.trim() ?? '') : '';
    if (fromFile.isNotEmpty) return fromFile;

    if (Platform.isAndroid) return 'http://10.0.2.2';
    return 'http://localhost';
  }
}
