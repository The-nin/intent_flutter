# exercise8_5_25

A new Flutter mini project.

## Tech Stack

- Flutter
- Dart
- Provider
- Dio
- json_serializable
- SharedPreferences
- DummyJSON API(MockApi)

## Getting Started

-Install dependencies:
flutter pub get

-Generate JSON serialization files:
dart run build_runner build --delete-conflicting-outputs

-Check available devices:
flutter devices

-Run:
flutter run

-Checking code:
dart format .
flutter analyze

## Using exist account on DummyJSON API for login

    username: emilys
    password: emilyspass

## API using in this aplication

- Login: POST https://dummyjson.com/auth/login
- Products: GET https://dummyjson.com/products
- Product: GET https://dummyjson.com/products/{id}

## Deep link demo

The app accepts the custom URL scheme below and opens the product detail route:

    shopapp://app/product/1

Android is configured through the VIEW intent filter in `AndroidManifest.xml`.
iOS is configured through `CFBundleURLTypes` in `Info.plist`.

The deep link opens the product route only after authentication. If the user is
logged out, the router redirects to Login first.
