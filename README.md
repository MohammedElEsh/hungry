# 🍔 Hungry - Food Delivery App

A modern, feature-rich Flutter food delivery application with authentication, user profiles, product customization, cart management, and seamless checkout experience.

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## 📱 Features

### 🔐 Authentication

- **User Login & Registration** - Secure authentication with JWT tokens
- **Auto-Login** - Automatic session restoration on app restart
- **Guest Mode** - Browse the app without creating an account
- **Profile Management** - Update user details, profile picture, and payment cards

### 🏠 Home & Browse

- **Dynamic Categories** - Browse by All, Fast Food, Pizza, Burgers, Sushi
- **Product Grid** - Beautiful grid layout with food items
- **Skeleton Loading** - Smooth loading experience with shimmer effects
- **Pull-to-Refresh** - Refresh content with a simple swipe

### 🍕 Product Customization

- **Spice Level Slider** - Customize your preferred spice level
- **Toppings Selection** - Choose from tomatoes, onions, pickles, bacon
- **Side Options** - Add fries, coleslaw, salad, or onion rings
- **Real-time Price Updates** - See total price update as you customize

### 🛒 Shopping Cart

- **Add to Cart** - Seamlessly add customized items
- **Cart Management** - View, edit, and remove cart items
- **Order Summary** - Clear breakdown of items and total cost

### 💳 Checkout & Payment

- **Multiple Payment Methods** - Support for various payment options
- **Saved Cards** - Securely save payment cards for faster checkout
- **Order Summary** - Review your order before confirming

### 👤 User Profile

- **Profile Picture Upload** - Upload and update profile images
- **Editable Information** - Update name, email, address
- **Card Management** - Add and manage debit/credit cards
- **Logout** - Secure session termination

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                          # Core utilities and shared components
│   ├── components/                # Reusable UI components
│   │   ├── custom_bottom_nav_bar.dart
│   │   └── custom_button.dart
│   ├── constants/                 # App constants
│   │   └── api_endpoints.dart
│   ├── network/                   # Network layer
│   │   ├── api_service.dart       # HTTP service wrapper
│   │   ├── dio_client.dart        # Dio configuration
│   │   ├── api_exceptions.dart    # Error handling
│   │   └── api_error.dart         # Error model
│   └── utils/                     # Utilities
│       ├── app_router.dart        # Navigation configuration
│       ├── app_colors.dart        # Color palette
│       ├── styles.dart            # Text styles
│       ├── validators.dart        # Form validators
│       ├── pref_helper.dart       # SharedPreferences helper
│       ├── alerts.dart            # Banner notifications
│       └── assets.dart            # Asset paths
│
├── features/                      # Feature modules
│   ├── auth/                      # Authentication feature
│   │   ├── data/
│   │   │   ├── models/            # Data models
│   │   │   └── repositories/      # Data repositories
│   │   └── presentation/
│   │       ├── views/             # Screens
│   │       └── widgets/           # Feature-specific widgets
│   │
│   ├── splash/                    # Splash screen
│   ├── home/                      # Home & browse
│   ├── product/                   # Product details & customization
│   ├── cart/                      # Shopping cart
│   ├── checkout/                  # Checkout & payment
│   ├── profile/                   # User profile
│   └── orders/                    # Order history
│
└── main.dart                      # App entry point
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `>=3.9.2`
- Dart SDK: `>=3.0.0`
- Android Studio / VS Code with Flutter extensions
- An Android/iOS device or emulator

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/hungry.git
   cd hungry
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate launcher icons** (optional)

   ```bash
   flutter pub run flutter_launcher_icons
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 📦 Dependencies

### UI & Design

- **flutter_screenutil** `^5.9.3` - Responsive UI sizing
- **google_fonts** `^6.3.2` - Custom fonts (Luckiest Guy, Roboto)
- **font_awesome_flutter** `^10.12.0` - Icon library
- **gap** `^3.0.1` - Spacing widgets
- **skeletonizer** `^2.1.1` - Loading skeleton animations
- **alert_banner** `^1.0.1` - Toast notifications

### Navigation

- **go_router** `^17.0.0` - Declarative routing

### Network & Storage

- **dio** `^5.9.0` - HTTP client
- **shared_preferences** `^2.5.3` - Local storage

### Media

- **image_picker** `^1.2.1` - Image selection from gallery

---

## 🎨 Design System

### Color Palette

```dart
Primary:    #121223  // Dark navy
Secondary:  #fd7522  // Orange
White:      #ffffff
Black:      #000000
Grey:       #9e9e9e

// Feedback Colors
Error:      #d32f2f  // Red
Success:    #388e3c  // Green
Warning:    #ffa000  // Amber
Info:       #1976d2  // Blue
```

### Typography

- **Display**: Luckiest Guy (60, 45, 32)
- **Headline**: Roboto (32, 28, 24)
- **Title**: Roboto (18, 16, 14)
- **Body**: Roboto (16, 14, 12)
- **Label**: Roboto (14, 12, 11)

---

## 🌐 API Integration

### Base URL

```
https://sonic-zdi0.onrender.com/api
```

### Endpoints

#### Authentication

- `POST /login` - User login
- `POST /register` - User registration
- `POST /logout` - User logout
- `GET /profile` - Get user profile
- `POST /update-profile` - Update user profile (with image upload)

### Authentication Flow

1. User logs in → Receives JWT token
2. Token saved in SharedPreferences
3. Dio interceptor auto-attaches token to all requests
4. On 401 response → Token cleared, user redirected to login

---

## 🔧 Configuration

### Update API Base URL

Edit `lib/core/network/dio_client.dart`:

```dart
final Dio _dio = Dio(
  BaseOptions(
    baseUrl: 'YOUR_API_BASE_URL',
    headers: {
      'Content-Type': 'application/json',
    },
  ),
);
```

### Customize App Colors

Edit `lib/core/utils/app_colors.dart`:

```dart
static const Color primary = Color(0xff121223);
static const Color secondary = Color(0xfffd7522);
```

---

## 📸 Screenshots

<!-- Add your app screenshots here -->

_Coming soon..._

---

## 🧪 Testing

Run tests with:

```bash
flutter test
```

---

## 🛠️ Build

### Android APK

```bash
flutter build apk --release
```

### iOS IPA

```bash
flutter build ios --release
```

---

## 📝 Project Structure Highlights

### State Management

- Uses **StatefulWidget** for local state management
- Repository pattern for data layer
- Centralized error handling

### Navigation

- **GoRouter** for declarative routing
- Named routes in `AppRouter` class
- Deep linking support ready

### Network Layer

- **Dio** with interceptors for authentication
- Automatic token management
- Comprehensive error handling with user-friendly messages

### Form Validation

- Custom validators for email and password
- Real-time validation feedback
- Error banner notifications

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Your Name**

- GitHub: [@yourusername](https://github.com/yourusername)
- Email: your.email@example.com

---

## 🙏 Acknowledgments

- [Flutter Documentation](https://docs.flutter.dev/)
- [Material Design 3](https://m3.material.io/)
- [Google Fonts](https://fonts.google.com/)

---

## 📞 Support

For support, email your.email@example.com or open an issue in the repository.

---

**Made with ❤️ using Flutter**
