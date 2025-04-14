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

### Test Coverage

To generate test coverage reports, you need to have LCOV installed:

**On Windows:**
```
choco install lcov
```

**On macOS:**
```
brew install lcov
```

**On Linux:**
```
sudo apt-get install lcov
```

Then run the coverage script:

**On Windows:**
```
coverage.bat
```

**On macOS/Linux:**
```
sh coverage.sh
```

This will:
1. Run all tests with coverage enabled
2. Generate an HTML report
3. Open the report in your default browser

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
