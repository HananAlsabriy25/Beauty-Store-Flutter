import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return android;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are not configured for this platform.',
    );
  }

  // تم جلب الإعدادات المطابقة لـ لقطة الشاشة بدقة متناهية
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDZXe98v8qW9h7wZbVWelSbrrTbSQb2jzU',
    appId: '1:556519530926:web:c3f4f55bb167183229683f',
    messagingSenderId: '556519530926',
    projectId: 'beauty-store-d8557',
    authDomain: 'beauty-store-d8557.firebaseapp.com',
    storageBucket: 'beauty-store-d8557.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZXe98v8qW9h7wZbVWelSbrrTbSQb2jzU',
    appId: '1:556519530926:web:c3f4f55bb167183229683f', 
    messagingSenderId: '556519530926',
    projectId: 'beauty-store-d8557',
    storageBucket: 'beauty-store-d8557.firebasestorage.app',
  );
}