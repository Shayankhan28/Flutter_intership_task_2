# User Profile App

A Flutter application that displays user profiles with smooth animations and a clean UI. The app fetches user data from a local JSON file and presents it in an elegant interface with shimmer effects for loading states.

## Features

- **Local JSON Data**: Loads user data from a local JSON file instead of external APIs
- **Shimmer Effects**: Beautiful loading animations for profile images and text
- **Navigation**: Smooth navigation between home screen and profile details
- **Responsive Design**: Adapts to different screen sizes
- **Clean Architecture**: Well-organized project structure with separation of concerns

## Project Structure

```
apitask/
├── lib/
│   ├── ApiFetching/
│   │   └── Fetch_api.dart      # Data fetching logic
│   ├── models/
│   │   └── model.dart          # Data models
│   ├── Routings/
│   │   ├── routename.dart      # Route names
│   │   └── routes.dart         # Route generator
│   ├── screen/
│   │   ├── homescreen.dart     # Home screen with user list
│   │   └── profilescreen.dart  # Profile detail screen
│   └── main.dart               # App entry point
├── assets/
│   └── json/
│       └── users.json          # Local user data
└── pubspec.yaml                # Dependencies and assets
```

## Installation

1. Clone or download the project
2. Ensure you have Flutter installed on your machine
3. Run `flutter pub get` to install dependencies
4. Make sure the JSON file is properly referenced in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/json/users.json
```

5. Run the app with `flutter run`

## Dependencies

This project uses the following packages:

- `http`: For HTTP requests (though currently using local data)
- `shimmer`: For beautiful loading animations

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0
  shimmer: ^2.0.0
```

## How to Use

1. **Home Screen**: The app opens to a list of users fetched from the local JSON file
2. **User Selection**: Tap on any user to view their detailed profile
3. **Profile Screen**: View the user's avatar, first name, last name, and email
4. **Loading States**: Enjoy smooth shimmer animations while content loads

## Data Model

The app uses a structured data model:

- `Model`: Main container with pagination info and user list
- `Data`: Individual user data (id, email, names, avatar)
- `Support`: Support information (not currently used with local data)

## Routing

The app uses named routing with argument passing:

- `homescreen`: Main screen with user list
- `profilescreen`: Detail screen with user information

## Customization

### Adding More Users

Edit `assets/json/users.json` to add more users following the same format:

```json
{
  "id": 51,
  "email": "newuser@example.com",
  "first_name": "New",
  "last_name": "User",
  "avatar": "https://example.com/avatar.jpg"
}
```

### Modifying Shimmer Effects

Adjust the shimmer properties in `profilescreen.dart`:

```dart
Shimmer.fromColors(
  baseColor: Colors.grey[300]!,
  highlightColor: Colors.grey[100]!,
  period: Duration(seconds: 2), // Adjust animation speed
  child: YourWidget(),
)
```

### Styling Changes

Modify the UI components in either:
- `homescreen.dart` for the list view
- `profilescreen.dart` for the detail view

## Future Enhancements

Potential improvements for this project:

1. Add pull-to-refresh functionality
2. Implement search/filter for users
3. Add favorite/star functionality
4. Implement local database persistence
5. Add theme switching (light/dark mode)

## Contributing

Feel free to fork this project and submit pull requests for any improvements.

## License

This project is open source and available under the MIT License.