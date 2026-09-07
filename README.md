# Shop App

A Flutter mini e-commerce application built for learning and practicing Flutter application architecture, state management, local persistence, authentication, localization, theming, networking, and common mobile UI/UX edge cases.

## Overview
    
This project is a client-side Flutter application that consumes the DummyJSON API for authentication and product data.

The project does not include a custom backend. Product data, authentication, and refresh-token behavior are demonstrated using DummyJSON.

## Features

1. Authentication

- Login with DummyJSON credentials
- Persist access and refresh tokens securely
- Restore authentication state when the app starts
- Automatic session-expiration handling
- Logout flow

2. Products

- Product listing
- Product search
- Product detail
- Favorite products
- Favorite persistence using SQLite
- Remote data with local cache fallback
- Loading, empty, and error states
- Broken-image handling

3. UI / UX

- Material 3 UI
- Light / Dark theme switching
- Theme preference persistence
- Vietnamese / English localization
- Search input handling
- Banner slider
- Offline indicator
- SafeArea handling
- Scrollable product layout
- Basic landscape/orientation edge-case testing
- Keyboard-friendly login form

4. Additional Features

- WebView for allowed DummyJSON content
- Firebase Cloud Messaging initialization
- Deep-link support for product details

## Tech Stack

- Flutter
- Dart
- Provider
- Dio
- GoRouter
- Easy Localization
- GetIt
- fpdart 
- json_serializable
- SharedPreferences
- flutter_secure_storage
- SQLite / sqflite
- connectivity_plus
- image_picker 
- Firebase Core
- Firebase Messaging
- webview_flutter

## Architecture

- The project uses a feature-based structure with separation between presentation, domain, and data layers.

lib/
├── core/
│   ├── database/
│   ├── di/
│   ├── error/
│   ├── localization/
│   ├── network/
│   ├── notifications/
│   ├── providers/
│   ├── routes/
│   ├── storage/
│   └── widgets/
│
├── enums/
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── favorite/
│   │   └── presentation/
│   │
│   ├── navigation/
│   │   └── presentation/
│   │
│   ├── product/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── profile/
│   │   └── presentation/
│   │
│   └── webview/
│       └── presentation/
│
├── firebase_options.dart
└── main.dart

## Data flow

UI
 ↓
Provider
 ↓
Use Case
 ↓
Repository
 ↓
Remote Data Source / Local Data Source
 ↓
API / SQLite

The domain layer contains entities, repository contracts, and use cases. Data-layer implementations handle API and local database access.

## State Management

The project uses Provider and ChangeNotifier.

Provider state is intentionally scoped where possible to reduce unnecessary widget rebuilds.

For example, product favorites use a narrow Selector<ProductProvider, bool> so changing one favorite does not require the entire product card to listen to all product-provider state.

The product grid also listens only to the product state and product list it needs.

## Networking

- Dio is used as the HTTP client.

- The project includes:
   + Base API configuration
   + Request timeouts
   + Authentication header injection
   + HTTP error handling
   + Access-token refresh flow
   + Session-expiration callback

- Base API: https://dummyjson.com

## API Endpoints

- Login

POST /auth/login

- Current User

GET /auth/me

- Products

GET /products

- Product Detail

GET /products/{id}

- Refresh Token

POST /auth/refresh

## Local Storage

Two storage approaches are used for different purposes.

## SharedPreferences

Used for small non-sensitive preferences:

- Theme mode
- Avatar data
- Language preference

## Secure Storage

Used for authentication credentials/tokens:

- Access token
- Refresh token

## SQLite

Used for structured product data:

- Cached products
- Favorite product IDs
- Favorite product queries

## Localization

The application supports:

- English (en)
- Vietnamese (vi)

Translation files are stored in:

assets/translations/
├── en.json
└── vi.json

User-facing text is generally accessed through LocaleKeys and Easy Localization.

## Theme

The application supports:

- Light theme
- Dark theme

The selected theme is persisted locally and restored when the application starts.

## Routing

Navigation is handled with GoRouter.

The application uses a StatefulShellRoute.indexedStack for the main bottom-navigation structure.

Product details use a parameterized route:
/product/:id

Example:
/product/1

The project also supports the custom deep-link scheme:
shopapp://app/product/1

## Offline / Cache Behavior

When the product API request fails, the repository attempts to load cached products from SQLite.

This provides a basic offline fallback:

Remote API
   │
   ├── Success → update SQLite cache → show remote data
   │
   └── Failure → read SQLite cache
                    │
                    ├── Cache exists → show cached data
                    └── Cache empty → show error

The application also displays an offline banner when connectivity is unavailable.

## WebView

The project includes a WebView screen.

For safety, navigation is restricted to:

https://dummyjson.com
https://www.dummyjson.com

Other URLs are blocked.

## Firebase Notifications

Firebase Cloud Messaging is initialized for notification handling.

The project includes:
- Notification permission request
- FCM token retrieval
- Token refresh listener
- Foreground notification listener
- Background notification handler
- Notification-open handling
- Initial notification handling

Notification data can contain a route that is passed to GoRouter.

## Development Setup
### Requirements

Make sure the following are installed:

- Flutter SDK
- Dart SDK
- Android Studio or an Android development environment
- Android SDK
- Java / JDK compatible with the Flutter project

Check Flutter setup:
flutter doctor -v

## Installation

- Clone the repository and enter the project directory:
git clone <repository-url>
cd exercise_5_8_26

- Install dependencies:
flutter pub get

- Generate JSON serialization files when needed:
dart run build_runner build --delete-conflicting-outputs

- Check connected devices:
flutter devices

- Run the application:
flutter run

## Test Login Account

The application currently uses an existing DummyJSON account for demonstration.

username: emilys
password: emilyspass

## Code Quality Checks

- Format the project:
dart format .

- Run static analysis:
flutter analyze

- Run tests:
flutter test

## Build
### Debug

- Used during normal development:
flutter run

### Profile

- Used for performance analysis:
flutter run --profile

### Release APK

- Build a release APK:
flutter build apk --release

The current Android project uses the debug signing configuration for local release builds. This is suitable for local learning/testing only and is not a production Play Store signing configuration.

## Android App Bundle

- Build an AAB for distribution:
flutter build appbundle --release

Production release signing should be configured with a dedicated keystore and secure signing credentials before publishing.

## Project Limitations

- The project uses DummyJSON instead of a custom backend.
- Registration is currently a UI demonstration and does not create a real account.
- Authentication is intended for learning/demo purposes.
- Production-grade release signing has not been configured.
- The application currently focuses on a portrait-oriented mobile experience.
- Firebase notification behavior depends on valid Firebase project configuration.
- Some profile actions are placeholders for future features.
- Product images and product data depend on the external DummyJSON service.

## Future Improvements

Potential future improvements include:

- Real backend integration
- Real user registration
- Product categories and filtering
- Shopping cart
- Checkout flow
- Order history
- Production authentication/security
- More comprehensive automated tests
- More extensive responsive layouts for tablets and landscape mode
- Improved centralized error mapping
- Production release signing and CI/CD

## Development Notes

This project was developed as a Flutter learning/internship exercise with a focus on understanding:

- Flutter widget composition and constraints
- State management with Provider
- Feature-based architecture
- Repository and use-case patterns
- Dependency injection with GetIt
- Functional error handling with Either
- Local persistence
- Networking
- Authentication/session management
- Localization
- Dynamic theming
- Performance profiling with Flutter DevTools
- UI/UX edge-case handling
- Release build concepts