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
| **Authentication** | Login, signup, and guest mode support |
| **Home** | Category-based product browsing with search |
| **Product Details** | Customize items with toppings, side options, and spice level |
| **Favorites** | Save and manage favorite products (registered users) |
| **Cart** | Add items, adjust quantities, view summary |
| **Checkout** | Multiple payment methods with order summary |
| **Orders** | View order history and track status |
| **Profile** | Manage account, payment methods, and profile data |

## Tech Stack

- **Framework**: Flutter (Material 3)
- **Routing**: [go_router](https://pub.dev/packages/go_router)
- **Networking**: [Dio](https://pub.dev/packages/dio)
- **State & Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences)
- **UI**: [Google Fonts](https://pub.dev/packages/google_fonts), [flutter_screenutil](https://pub.dev/packages/flutter_screenutil), [Skeletonizer](https://pub.dev/packages/skeletonizer), [Font Awesome](https://pub.dev/packages/font_awesome_flutter)
- **Media**: [cached_network_image](https://pub.dev/packages/cached_network_image), [image_picker](https://pub.dev/packages/image_picker)

## Project Structure

```
lib/
├── core/               # Shared utilities, network, constants
│   ├── components/
│   ├── constants/
│   ├── network/
│   └── utils/
├── features/
│   ├── auth/           # Login, signup, authentication
│   ├── cart/           # Shopping cart
│   ├── checkout/       # Payment & order placement
│   ├── home/           # Categories, products, favorites
│   ├── orders/         # Order history
│   ├── product/        # Product detail & customization
│   ├── profile/        # User profile & settings
│   └── splash/         # Splash screen
└── main.dart
```

## Prerequisites

- **Flutter SDK** ≥ 3.9.2
- **Dart SDK** ≥ 3.9.2

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

### 3. Run the app

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

The app connects to a backend API. The base URL is configured in `lib/core/network/dio_client.dart`. No additional environment setup is required for basic usage.

## License

This project is available under a license of your choice. Update this section according to your licensing model.

---

<p align="center">
  Built with Flutter
</p>
