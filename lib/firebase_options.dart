import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: 'AIzaSyDMyMtDE0eOxnmttk34iXEsCLTZiWNTrKk',
      appId: '1:757001235490:android:baa7266f05f02832782e7b',
      messagingSenderId: '757001235490',
      projectId: 'swagstyles-2e553',
      storageBucket: 'swagstyles-2e553.appspot.com',
    );
  }
}
