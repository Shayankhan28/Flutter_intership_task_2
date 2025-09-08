# Task Management App - Firebase & Flutter

## 📱 App Overview

This is a comprehensive Task Management application built with Flutter and Firebase. The app features user authentication (email/password and phone number), task posting, and real-time data synchronization.

## ✨ Features

- **User Authentication**
  - Email/Password Signup & Login
  - Phone Number Authentication with OTP
  - Automatic session management

- **Task Management**
  - Create new tasks/posts
  - View all tasks in real-time
  - Firebase Realtime Database integration

- **User Interface**
  - Modern, responsive UI design
  - Smooth animations and transitions
  - Intuitive navigation

## 🛠️ Technical Stack

- **Frontend**: Flutter SDK
- **Backend**: Firebase
  - Firebase Authentication
  - Firebase Realtime Database
- **State Management**: Provider (as per updated implementation)
- **Additional Packages**:
  - Lottie for animations
  - Animated Text Kit for text animations
  - Google Fonts for typography

## 📁 Project Structure

```
lib/
├── firebase_services/
│   └── splash_service.dart
├── post/
│   ├── add_post.dart
│   └── post.dart
├── providers/
│   ├── auth_provider.dart
│   └── post_provider.dart
├── ui/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── login_with_number.dart
│   │   ├── signup_screen.dart
│   │   └── verifyauthcode.dart
│   └── splash_screen.dart
├── util/
│   └── utills.dart
├── wigdetss/
│   └── buttons.dart
└── main.dart
```

## ⚠️ Important Note

**This app will not run on your device directly** due to Firebase configuration dependencies. The Firebase configuration files (`google-services.json` for Android and `GoogleService-Info.plist` for iOS) are not included in the source code as they contain sensitive project-specific information.

When creating a copy of this project or downloading the zip file, you will encounter errors related to:
- Missing Firebase configuration files
- API key validation issues
- Firebase project mismatch errors

## 🔧 Setup Instructions (For Development)

If you want to run this app:

1. **Create a new Firebase project** at [Firebase Console](https://console.firebase.google.com/)
2. **Enable Authentication** methods:
   - Email/Password
   - Phone Number
3. **Create a Realtime Database** with appropriate security rules
4. **Register your app** in Firebase project settings
5. **Download configuration files** and place them in:
   - `android/app/google-services.json` (Android)
   - `ios/Runner/GoogleService-Info.plist` (iOS)
6. **Update package names** in Android and iOS configurations to match your Firebase project
7. **Run** `flutter pub get` and `flutter run`

## 🎥 Demonstration

Since the app cannot be run directly from the shared code, I will provide a video demonstration that shows:
- App functionality and features
- User interface and navigation flow
- Real-time database operations
- Authentication processes

## 📋 Requirements

- Flutter SDK 3.0.0 or higher
- Dart 2.17.0 or higher
- Android Studio/VSCode with Flutter extension
- Physical device or emulator with Android/iOS

## 🔐 Security Notes

- The app uses Firebase security rules for data protection
- Authentication tokens are managed by Firebase Auth
- Sensitive API keys are stored in environment-specific configuration files

## 📞 Support

For any questions or issues regarding the app functionality or setup, please refer to the video demonstration or contact the development team.

---

**Note**: This README assumes the Provider state management implementation has been correctly added to the project as per the previous refactoring instructions.