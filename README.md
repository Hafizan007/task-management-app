# Task Management App

A modern Flutter application demonstrating Clean Architecture and BLoC pattern implementation for efficient task management.

## Key Features
- Complete Task Management (Create, Read, Update, Delete)
- Secure Authentication
- Offline Functionality
- Real-time Data Sync

## Architecture Overview
The app follows Clean Architecture principles with three main layers:

- **Domain Layer**: Core business logic, use cases, entities
- **Data Layer**: Repository implementations, data sources
- **Presentation Layer**: UI components, BLoC state management

## Technology Stack
- State Management: `flutter_bloc`
- DI: `get_it` + `injectable`
- Storage: `sqflite`
- API Client: `dio`
- Navigation: `auto_route`
- Code Gen: `build_runner`, `freezed`

## Project Structure
```
lib/
├── app/
│   ├── config/
│   ├── core/
│   └── features/
│       ├── auth/
│       └── task_management/
└── main.dart
```

## Installation
- Add [Flutter](https://flutter.dev/docs/get-started/install 'Flutter') to your machine (Flutter version 3.24.2)
- Open this project folder with Terminal/CMD
- Ensure there's no cache/build leftover by running `flutter clean` in the Terminal
- Run in the Terminal `flutter packages get`


# run this project by command line
```
flutter run \
  --flavor dev \
  -d <deviceId> \
  --target lib/main.dart \
  --debug \
  --hot \
  --dart-define=ENVIRONMENT=development
```

# run this project in vscode 

configure launch.json in .vscode folder
```
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "appmanagement-dev-debug",
      "request": "launch",
      "type": "dart",
      "program": "lib/main.dart",
      "flutterMode": "debug",
      "args": [
        "--flavor",
        "dev",
        "--dart-define",
        "chrome",
        "DEBUG_MODE=DEBUG_ONLY",
      ]
    }
  ]
}
```

## Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/auth/domain/usecases/login_usecase_test.dart

```

## Test Structure
```
test/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── task_management/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── helpers/
    └── test_helper.dart
```







