import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentService {
  static Future<void> init() async {
    if (kReleaseMode) {
      await dotenv.load(fileName: ".env.production");
    } else {
      await dotenv.load(fileName: ".env.development");
    }

    debugPrint('Init Environment Service');
  }
}
