# LeakPeek

Flutter + Firebase app scaffold with auth, breach check flow, Firestore history, and Firebase Functions stub.

## Quick start (Web)

```
flutter pub get
flutter run -d chrome
```

## Connect to Firebase

1. Install Node.js and Firebase CLI: `npm i -g firebase-tools`
2. Activate FlutterFire CLI: `dart pub global activate flutterfire_cli`
3. Configure: `flutterfire configure --project=<your-project> --platforms=android,web --android-package-name=<your.package>`

## Local emulators (optional)

- Toggle `useEmulators` in `lib/env.dart` to `true`
- Run `firebase emulators:start`

## Security

- Firestore rules in `firestore.rules` restrict access per user
- Queries are hashed (SHA-256) before being written to history
