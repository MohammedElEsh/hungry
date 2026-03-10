# Hungry

<p align="center">
  <strong>A modern Flutter food ordering application</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
</p>

---

## Overview

**Hungry** is a cross-platform mobile application built with Flutter that enables users to browse menus, customize meals, manage their cart, and place food orders with a seamless user experience.

## Features

| Feature | Description |
|---------|-------------|
| **Authentication** | Login, signup, guest mode, and social sign-in (Google, Apple) |
| **Home** | Category-based product browsing with search |
| **Product Details** | Customize items with toppings, side options, and spice level |
| **Favorites** | Save and manage favorite products (registered users) |
| **Cart** | Add items, adjust quantities, view summary |
| **Checkout** | Multiple payment methods with order summary |
| **Orders** | View order history and track status; local notifications for updates |
| **Profile** | Manage account, payment methods, and profile data |
| **Localization** | Multi-language support via easy_localization |

## Tech Stack

| Category | Packages |
|----------|----------|
| **Framework** | Flutter (Material 3), Dart ^3.9.2 |
| **Routing** | [go_router](https://pub.dev/packages/go_router) |
| **State** | [flutter_bloc](https://pub.dev/packages/flutter_bloc), [equatable](https://pub.dev/packages/equatable) |
| **DI** | [get_it](https://pub.dev/packages/get_it) |
| **Networking** | [Dio](https://pub.dev/packages/dio) |
| **Storage** | [shared_preferences](https://pub.dev/packages/shared_preferences), [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage), [Hive](https://pub.dev/packages/hive) |
| **Localization** | [easy_localization](https://pub.dev/packages/easy_localization) |
| **Auth** | [google_sign_in](https://pub.dev/packages/google_sign_in), [sign_in_with_apple](https://pub.dev/packages/sign_in_with_apple) |
| **UI** | [Google Fonts](https://pub.dev/packages/google_fonts), [flutter_screenutil](https://pub.dev/packages/flutter_screenutil), [Skeletonizer](https://pub.dev/packages/skeletonizer), [Font Awesome](https://pub.dev/packages/font_awesome_flutter), [gap](https://pub.dev/packages/gap), [alert_banner](https://pub.dev/packages/alert_banner) |
| **Media** | [cached_network_image](https://pub.dev/packages/cached_network_image), [image_picker](https://pub.dev/packages/image_picker) |
| **Other** | [connectivity_plus](https://pub.dev/packages/connectivity_plus), [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications), [url_launcher](https://pub.dev/packages/url_launcher), [Sentry](https://pub.dev/packages/sentry_flutter) |

## Project Structure

Folder skeleton only (no file names):

```
lib/
├── core/
│   ├── analytics/
│   ├── animations/
│   ├── auth/
│   ├── cache/
│   ├── components/
│   ├── config/
│   ├── constants/
│   ├── di/
│   ├── domain/
│   ├── error/
│   ├── hive/
│   ├── interceptors/
│   ├── logger/
│   ├── network/
│   ├── notifications/
│   ├── router/
│   ├── storage/
│   ├── theme/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── cubit/
│   │       ├── handlers/
│   │       ├── listeners/
│   │       ├── screens/
│   │       ├── views/
│   │       └── widgets/
│   ├── cart/

│   ├── home/

│   ├── orders/
│
│   ├── product/
│
│   └── profile/
│
├── onboarding/
│   └── presentation/
│       └── screens/
└── splash/
    └── presentation/
        ├── views/
        └── widgets/
```

## Prerequisites

- **Flutter SDK** ≥ 3.9.2
- **Dart SDK** ^3.9.2

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/your-username/hungry.git
cd hungry
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Generate code (if needed)

```bash
flutter pub run build_runner build
```

### 4. Run the app

```bash
# List available devices
flutter devices

# Run on default device
flutter run

# Run on a specific device
flutter run -d <device_id>
```

### Build for production

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release
```

## Configuration

The app connects to a backend API. The base URL is defined in `lib/core/config/app_config.dart` (default: `https://sonic-zdi0.onrender.com/api/`). To override at run or build time:

```bash
flutter run --dart-define=API_BASE_URL=https://your-api.com/api/
```

## License

This project is available under a license of your choice. Update this section according to your licensing model.

---

<p align="center">
  Built with Flutter
</p>
