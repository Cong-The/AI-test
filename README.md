# Flutter Login Example

A Flutter project demonstrating a login screen implementation using Clean Architecture and BLoC pattern.

## Features

- Clean Architecture implementation
- BLoC state management
- Login and Sign Up UI
- Unit tests and Widget tests
- Mock implementations for testing

## Getting Started

1. Clone the repository:
```
git clone https://github.com/Cong-The/AI-test.git
```

2. Install dependencies:
```
flutter pub get
```

3. Run the app:
```
flutter run
```

## Testing

Generate mock files and run tests:
```
flutter pub run build_runner build --delete-conflicting-outputs
flutter test
```

## Project Structure

```
lib/
├── core/               # Core functionality
│   ├── constants/      # App constants
│   ├── error/          # Error handling
│   ├── network/        # Network related
│   ├── usecases/       # Base use cases
│   └── utils/          # Utility functions
└── features/
    └── auth/           # Authentication feature
        ├── data/       # Data layer
        ├── domain/     # Domain layer
        └── presentation/ # UI layer
```

## Screenshots

The app includes a modern login UI with:
- Email and password inputs
- Remember me option
- Social login buttons
- Toggle between login and signup
