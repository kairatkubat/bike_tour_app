 // File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKleqWctwc4FkC6zE6nAJ-lguM5Q4OExw',
    appId: '1:386390089162:android:72b5197fe143773bcd8333',
    messagingSenderId: '386390089162',
    projectId: 'flutter-tour-app-ce2db',
    databaseURL: 'https://flutter-tour-app-ce2db-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-tour-app-ce2db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaUOF8M1a4QS93kSPawZMHau8Nxh888LU',
    appId: '1:386390089162:ios:a80dd715b844805ecd8333',
    messagingSenderId: '386390089162',
    projectId: 'flutter-tour-app-ce2db',
    databaseURL: 'https://flutter-tour-app-ce2db-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-tour-app-ce2db.appspot.com',
    iosClientId: '386390089162-eggsb9b3p10ei8nicjnv88dd2og0rpaq.apps.googleusercontent.com',
    iosBundleId: 'com.example.udemythree',
  );
}
