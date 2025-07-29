# AI Travel Planner App

A modern Flutter app that helps users plan their trips using AI-powered recommendations and clean architecture principles.

## Features

- **AI-Powered Trip Planning**: Get personalized trip recommendations based on your interests and budget
- **Trip Management**: Create, view, and manage your trips with beautiful UI
- **Destination Search**: Search and discover new destinations
- **Travel Advice**: Get helpful travel tips and advice for your destinations
- **Modern UI**: Beautiful, responsive design with smooth animations

## Architecture

This app follows **Clean Architecture** principles with three main layers:

### Domain Layer
- **Entities**: Core business objects (Trip, Destination, Activity)
- **Repositories**: Abstract interfaces for data access
- **Use Cases**: Business logic and operations

### Data Layer
- **Models**: Data transfer objects with JSON serialization
- **Data Sources**: Local storage (SharedPreferences) and remote APIs
- **Repository Implementations**: Concrete implementations of domain repositories

### Presentation Layer
- **Blocs**: State management using flutter_bloc
- **Pages**: UI screens and navigation
- **Widgets**: Reusable UI components

## Tech Stack

- **Flutter**: UI framework
- **Bloc**: State management
- **Freezed**: Immutable data classes and union types
- **Dio**: HTTP client for API calls
- **SharedPreferences**: Local data storage
- **Google Fonts**: Typography
- **Build Runner**: Code generation

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd travel_planner
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate code (required for freezed):
```bash
flutter packages pub run build_runner build
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── domain/
│   ├── entities/          # Core business objects
│   ├── repositories/      # Abstract interfaces
│   └── usecases/         # Business logic
├── data/
│   ├── datasources/       # Data access layer
│   ├── models/           # Data transfer objects
│   └── repositories/     # Repository implementations
└── presentation/
    ├── blocs/            # State management
    ├── pages/            # UI screens
    └── widgets/          # Reusable components
```

## Key Features Explained

### 1. Clean Architecture
The app follows clean architecture principles with clear separation of concerns:
- **Domain Layer**: Contains business logic and is independent of external frameworks
- **Data Layer**: Handles data operations and external dependencies
- **Presentation Layer**: Manages UI and user interactions

### 2. Bloc State Management
Uses flutter_bloc for predictable state management:
- **TripBloc**: Manages trip-related state (loading, loaded, error)
- **AiPlannerBloc**: Handles AI planning functionality

### 3. Code Generation
Leverages build_runner for automatic code generation:
- **Freezed**: Generates immutable data classes with copyWith methods
- **JSON Serialization**: Automatic JSON parsing and serialization

### 4. Modern UI Design
Features a beautiful, modern interface with:
- Gradient backgrounds and shadows
- Smooth animations and transitions
- Responsive design for different screen sizes
- Google Fonts for typography

## Usage

### Creating a Trip
1. Tap the "New Trip" button on the home screen
2. Fill in trip details (name, description, destination, dates, budget)
3. Save the trip to add it to your collection

### Using AI Planner
1. Tap the "AI Travel Planner" button on the home screen
2. Search for destinations or select your interests
3. Get personalized recommendations and travel advice

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and ensure code quality
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Acknowledgments

- Flutter team for the amazing framework
- Bloc team for state management
- Freezed team for code generation
- Google Fonts for typography 