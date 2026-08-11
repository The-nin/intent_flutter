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
