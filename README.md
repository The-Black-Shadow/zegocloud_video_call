# ZegoCloud Video Call Starter

A professional Flutter starter template for building video and audio calling applications using ZegoCloud's UIKit. This project provides a complete implementation of one-on-one and group calling features with offline call invitation support, making it easy to integrate real-time communication into your Flutter apps.

## 🌟 Features

- ✅ **One-on-One Video/Audio Calls** - Crystal clear video and audio calling
- ✅ **Group Video/Audio Calls** - Support for multiple participants
- ✅ **Offline Call Invitations** - Receive call notifications even when app is closed
- ✅ **Call Minimization** - Continue using other features while on a call
- ✅ **Custom Avatars** - Personalized user experience
- ✅ **Environment Variables** - Secure credential management with `.env` file
- ✅ **Android & iOS Support** - Full cross-platform compatibility
- ✅ **Production Ready** - Clean architecture and professional code structure

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- Flutter SDK (>=2.16.2 <4.0.0) or FVM for Flutter version management
- Dart SDK
- Android Studio / Xcode (for mobile development)
- A ZegoCloud account ([Sign up here](https://console.zegocloud.com))
- (Optional) [FVM](https://fvm.app/) - Flutter Version Management

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/The-Black-Shadow/zegocloud_video_call.git
cd zegocloud_video_call
```

### 2. (Optional) Install FVM

This project uses FVM (Flutter Version Management) for consistent Flutter versions across teams. If you want to use FVM:

**Install FVM:**
```bash
# macOS/Linux
brew tap leoafarias/fvm
brew install fvm

# Windows (using Chocolatey)
choco install fvm

# Or install globally via pub
dart pub global activate fvm
```

**Use the project's Flutter version:**
```bash
fvm use
```

Then use `fvm flutter` instead of `flutter` for all commands.

### 3. Install Dependencies

```bash
flutter pub get
# or if using FVM
# fvm flutter pub get
```

### 4. Configure ZegoCloud Credentials

1. Get your `App ID` and `App Sign` from [ZegoCloud Console](https://console.zegocloud.com)

2. Create a `.env` file in the project root:

```env
ZEGO_APP_ID=your_app_id_here
ZEGO_APP_SIGN=your_app_sign_here
```

> **Important:** Never commit your `.env` file to version control. It's already added to `.gitignore`

### 5. Run the Application

```bash
flutter run
# or if using FVM
# fvm flutter run
```

## 📁 Project Structure

```
zegocloud_video_call/
├── android/                    # Android native code
├── ios/                        # iOS native code
├── lib/
│   ├── common.dart            # Shared utilities and widgets
│   ├── constants.dart         # App constants and route names
│   ├── home_page.dart         # Home screen with call functionality
│   ├── login_page.dart        # User authentication screen
│   ├── login_service.dart     # Login logic and ZegoCloud initialization
│   ├── main.dart              # App entry point
│   ├── my_app.dart            # Main app widget configuration
│   └── util.dart              # Helper functions
├── assets/
│   └── image/                 # App images and assets
├── .env                       # Environment variables (create this)
├── .env.example              # Example environment file
├── pubspec.yaml              # Dependencies and project config
└── README.md                 # This file
```

## 🎯 Use Cases

This starter template is perfect for building:

- 📞 **Telehealth Apps** - Remote doctor consultations
- 👥 **Social Networking** - Video chat features
- 💼 **Remote Work Tools** - Team video conferencing
- 🎓 **E-Learning Platforms** - Virtual classrooms
- 🎮 **Gaming Communities** - Voice/video chat while gaming
- 👨‍👩‍👧‍👦 **Family Connect Apps** - Stay in touch with loved ones

## 🔧 Configuration

### Android Setup

1. **Minimum SDK Version**: Edit `android/app/build.gradle`

```gradle
minSdkVersion 21
compileSdkVersion 33
```

2. **Permissions**: Already configured in `AndroidManifest.xml`
   - Camera, Microphone, Internet, Bluetooth, and more

3. **ProGuard Rules**: Code obfuscation prevention is already configured

### iOS Setup

1. **Deployment Target**: iOS 11.0 or higher

2. **Permissions**: Already configured in `Info.plist`
   - Camera Usage
   - Microphone Usage

3. **Build Settings**:
   - Build Libraries for Distribution → NO
   - iOS Deployment Target → 11 or greater

## 🔔 Enable Offline Call Notifications (Optional)

To receive call invitations when the app is closed:

### For iOS:

1. Contact [ZegoCloud Technical Support](https://discord.gg/ExaKJvBbxy)
2. Follow the [iOS Offline Notification Setup Guide](https://youtu.be/rzdRY8bDqdo)
3. Configure APNs certificates in [Apple Developer Console](https://developer.apple.com)

### For Android:

1. Add Firebase Messaging to `android/app/build.gradle`:

```gradle
implementation 'com.google.firebase:firebase-messaging:21.1.0'
```

2. Create `keep.xml` in `app/src/main/res/raw/`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources xmlns:tools="http://schemas.android.com/tools"
    tools:keep="@raw/*">
</resources>
```

3. Download `google-services.json` from [Firebase Console](https://console.firebase.google.com/)
4. Follow the [Android Offline Notification Setup Guide](https://youtu.be/mhetL3MTKsE)

## 💻 How to Use

### Login

1. Launch the app
2. Enter a phone number (used as User ID)
3. Enter any password (for testing purposes)
4. Click "Sign In"

### Making Calls

**One-on-One Call:**
1. Enter the invitee's User ID
2. Click the video or audio button

**Group Call:**
1. Enter multiple User IDs separated by commas
2. Click the video or audio button

### During a Call

- Toggle camera/microphone
- Switch between front/rear camera
- Minimize the call window
- Hang up

## 🛠️ Key Dependencies

```yaml
dependencies:
  zego_uikit: ^2.28.23
  zego_uikit_signaling_plugin: ^2.8.15
  zego_uikit_prebuilt_call: ^4.17.9
  flutter_dotenv: ^5.1.0
  shared_preferences: ^2.2.3
```

## 📝 Environment Variables

This project uses `flutter_dotenv` for secure credential management.

**Create `.env` file:**
```env
ZEGO_APP_ID=1234567890
ZEGO_APP_SIGN=your_64_character_app_sign_here
```

**Access in code:**
```dart
int.parse(dotenv.env['ZEGO_APP_ID'] ?? '0')
dotenv.env['ZEGO_APP_SIGN'] ?? ''
```

## 🔒 Security Best Practices

- ✅ `.env` is in `.gitignore` - credentials won't be committed
- ✅ Use environment variables for all sensitive data
- ✅ Never hardcode API keys in source code
- ✅ Regenerate credentials if accidentally exposed

## 🐛 Troubleshooting

### Build Errors

**Problem**: Gradle build fails  
**Solution**: Ensure `minSdkVersion` is 21 and `compileSdkVersion` is 33

**Problem**: iOS build fails  
**Solution**: Check deployment target is iOS 11+ and pod install is complete

### Runtime Issues

**Problem**: Can't receive calls  
**Solution**: Verify App ID and App Sign are correct in `.env`

**Problem**: Camera/microphone not working  
**Solution**: Check permissions are granted in device settings

### Environment Variables

**Problem**: `.env` not loading  
**Solution**: Ensure `await dotenv.load(fileName: ".env");` is in `main()`

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- [ZegoCloud](https://www.zegocloud.com/) for their excellent SDK
- Flutter team for the amazing framework
- All contributors who help improve this starter template

## 📞 Support

- [ZegoCloud Documentation](https://docs.zegocloud.com/)
- [ZegoCloud Discord](https://discord.gg/ExaKJvBbxy)
- [Issue Tracker](https://github.com/yourusername/zegocloud-video-call-starter/issues)

## 🚀 What's Next?

- [ ] Add screen sharing functionality
- [ ] Implement chat messaging
- [ ] Add recording features
- [ ] Create admin dashboard
- [ ] Add analytics and monitoring

## 🔀 Branches

This repository has two main branches:

### `main` Branch (Current)
- Vanilla Flutter implementation
- StatefulWidget with setState
- Simple and straightforward
- Perfect for beginners

### `getx_implement` Branch
- GetX state management
- Clean architecture with MVC pattern
- Reactive programming
- Better for scalable applications
- Recommended for production apps

Choose the branch that best fits your project needs!

---

**Built with ❤️ using Flutter and ZegoCloud**

*Star ⭐ this repo if you find it helpful!*
