import 'dart:io';

/// URL base del gateway. Overrideable por --dart-define=API_BASE_URL=...
/// Default: emulador Android usa 10.0.2.2 (el localhost del host);
/// desktop/iOS simulator usan localhost directo.
abstract final class Env {
  static const String _defined = String.fromEnvironment('API_BASE_URL');

  static String get apiBaseUrl {
    if (_defined.isNotEmpty) return _defined;
    if (Platform.isAndroid) return 'http://10.0.2.2';
    return 'http://localhost';
  }
}
