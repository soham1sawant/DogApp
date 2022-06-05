// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDzUDLjAmVHenzxKtZv8e4MgqtfY3v92Mg',
    appId: '1:814135160215:android:6620aec551f812158b28d2',
    messagingSenderId: '814135160215',
    projectId: 'dogapp-eb42c',
    storageBucket: 'dogapp-eb42c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDUD78Gvrvnlri6cl579j-IW3-U5ZhOAOU',
    appId: '1:814135160215:ios:68f60cedeae5c7cf8b28d2',
    messagingSenderId: '814135160215',
    projectId: 'dogapp-eb42c',
    storageBucket: 'dogapp-eb42c.appspot.com',
    iosClientId: '814135160215-s9v2u92nkentbl2eb5embphjgs86jhti.apps.googleusercontent.com',
    iosBundleId: 'com.dogapp.app',
  );
}