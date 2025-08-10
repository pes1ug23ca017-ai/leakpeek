// Temporary placeholder; will be replaced by FlutterFire CLI.
// Keeping this file allows the app to compile before configuration.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return const FirebaseOptions(
          apiKey: 'REPLACE_ME',
          appId: 'REPLACE_ME',
          messagingSenderId: 'REPLACE_ME',
          projectId: 'REPLACE_ME',
        );
      case TargetPlatform.iOS:
        return const FirebaseOptions(
          apiKey: 'REPLACE_ME',
          appId: 'REPLACE_ME',
          messagingSenderId: 'REPLACE_ME',
          projectId: 'REPLACE_ME',
          iosBundleId: 'REPLACE_ME',
        );
      case TargetPlatform.macOS:
        return const FirebaseOptions(
          apiKey: 'REPLACE_ME',
          appId: 'REPLACE_ME',
          messagingSenderId: 'REPLACE_ME',
          projectId: 'REPLACE_ME',
          iosBundleId: 'REPLACE_ME',
        );
      case TargetPlatform.windows:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
        return const FirebaseOptions(
          apiKey: 'REPLACE_ME',
          appId: 'REPLACE_ME',
          messagingSenderId: 'REPLACE_ME',
          projectId: 'REPLACE_ME',
        );
    }
  }
}


