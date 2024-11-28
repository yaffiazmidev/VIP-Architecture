# VIP Architecture Movie App

An iOS application built using the VIP (View-Interactor-Presenter) clean architecture pattern to showcase movie listings.

## Architecture Overview

The app follows the VIP (View-Interactor-Presenter) architecture pattern, which is a variant of Clean Architecture specifically designed for iOS applications. This pattern promotes:

- Separation of concerns
- Testability
- Maintainability
- Single responsibility principle

### Core Components

#### View (MovieListController & MovieListView)
- Handles UI logic and user interactions
- Displays movie listings in a collection view
- Delegates business logic to the Interactor
- Receives formatted data from the Presenter

#### Interactor (MovieListInteractor)
- Contains business logic
- Handles data operations
- Communicates with external services
- Processes data and sends it to the Presenter

#### Presenter (MovieListPresenter)
- Formats data for display
- Handles presentation logic
- Prepares data received from Interactor for the View
- Contains no business logic

### Features

1. Movie List
   - Displays a list of now playing movies
   - Handles movie selection
   - Supports pagination
   - Shows movie posters and titles

### Core Components

The project includes several core components:

1. Networking
   - HTTPClient for API communication
   - Authenticated HTTP client decorator
   - URL session-based implementation

2. Image Loading
   - Asynchronous image loading
   - Memory-efficient image caching
   - Support for remote image URLs

3. Data Models
   - NowPlayingItem for movie data
   - View models for UI representation
   - API configuration management

### UI Components

The app follows Apple's Human Interface Guidelines([1](https://developer.apple.com/design/tips/)) with:

- Minimum touch targets of 44x44 points
- Proper text sizing and contrast
- Consistent spacing and alignment
- High-resolution image support

## Getting Started

### Prerequisites

- Xcode 15.0+
- iOS 17.5+
- Swift 5.0+

### Installation

1. Clone the repository
2. Open `VIP-Architecture.xcodeproj` in Xcode
3. Build and run the project

### Configuration

The app requires an API key for movie data. Add your key to `APIConfig.plist`:
