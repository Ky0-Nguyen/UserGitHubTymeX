# UserGitHubTymeX

UserGitHubTymeX is a SwiftUI-based iOS application that allows users to browse and view details of GitHub users. This project demonstrates modern iOS development practices, including MVVM architecture, API integration, and efficient data management.

## Features

- Display a list of GitHub users
- View detailed information about each user
- Infinite scrolling for user list
- Caching mechanism for improved performance
- Responsive UI adapting to different screen sizes

## Architecture

The app follows the MVVM (Model-View-ViewModel) architecture:

- **Models**: `User` and `UserDetail` structs represent the data structures.
- **Views**: SwiftUI views like `UserListView` and `UserDetailView` handle the UI.
- **ViewModel**: `UserViewModel` manages the business logic and data flow.

## Key Components

1. **UserListView**: Displays a scrollable list of GitHub users.
2. **UserDetailView**: Shows detailed information about a selected user.
3. **UserViewModel**: Handles data fetching, caching, and state management.
4. **UserService**: Manages API calls to the GitHub API.
5. **CacheManager**: Provides in-memory caching for improved performance.

## Data Flow

1. The app loads cached users on startup.
2. As the user scrolls, more users are fetched from the GitHub API.
3. Tapping a user navigates to their detailed view.
4. User details are fetched and cached for quick access.

## Caching Strategy

- User list is cached to provide immediate content on app launch.
- Individual user details are cached to reduce API calls and improve load times.

## Future Improvements

- Implement error handling and retry mechanisms
- Add unit and UI tests
- Enhance UI with animations and transitions
- Implement search functionality for users

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Installation

1. Clone the repository
2. Open `UserGitHubTymeX.xcodeproj` in Xcode
3. Build and run the project on your simulator or device

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the [MIT License](LICENSE).
