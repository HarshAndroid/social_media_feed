// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB_K_vTWg530P6PtZQ43TqL03FmWZVVitQ',
    appId: '1:12348027969:web:41732163772d653dd482c0',
    messagingSenderId: '12348027969',
    projectId: 'social-media-feed-2f8df',
    authDomain: 'social-media-feed-2f8df.firebaseapp.com',
    storageBucket: 'social-media-feed-2f8df.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXEIij9SSkWL3wktXc1WnuS_oo6o5kGyE',
    appId: '1:12348027969:android:cbcd65c96a767e8cd482c0',
    messagingSenderId: '12348027969',
    projectId: 'social-media-feed-2f8df',
    storageBucket: 'social-media-feed-2f8df.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBpKOrd0wmoOh8Fdp4ABP1jw0RsDKxiPI8',
    appId: '1:12348027969:ios:4d8ab3bf4de24fdbd482c0',
    messagingSenderId: '12348027969',
    projectId: 'social-media-feed-2f8df',
    storageBucket: 'social-media-feed-2f8df.firebasestorage.app',
    iosBundleId: 'com.harshRajpurohit.socialMediaFeed',
  );
}
