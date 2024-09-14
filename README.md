# toMime

A fun miming game to play with friends built with Flutter.

## Requirements

- [Flutter](https://docs.flutter.dev/get-started/install)

## How to run

1. Clone the repository:
   ```bash
   git clone https://github.com/jorbush/toMime.git
   cd toMime
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```bash
lib/
├── dummy_data.dart        # Sample data used in the game
├── main.dart              # Entry point of the app
├── models/                # Data models used in the app
│   ├── card.dart          # Model representing a card
│   ├── collection.dart    # Model representing a collection of cards
│   └── player.dart        # Model representing a player
├── providers/             # State management using Provider pattern
│   ├── collections.dart   # Provider for managing card collections
│   └── players.dart       # Provider for managing players
├── screens/               # UI screens
│   ├── end.dart           # End screen showing results
│   ├── form.dart          # Form for creating a new game
│   ├── game.dart          # Main game screen
│   ├── home.dart          # Home screen
│   └── settings.dart      # Settings screen
└── widgets/               # Reusable UI components
    ├── end/
    │   ├── result_item.dart       # Individual result item widget
    │   └── results_list.dart      # List of results widget
    ├── form/
    │   ├── game_modes.dart        # Widget for selecting game modes
    │   ├── new_game.dart          # Widget for creating a new game
    │   ├── player_item.dart       # Widget for displaying a player
    │   └── players_list.dart      # Widget for listing players
    ├── game/
    │   ├── list_solve.dart        # Widget for solving the mimed actions
    │   └── player_info.dart       # Widget for displaying player info
    └── utils/
        ├── cartoon_text.dart      # Custom text styling widget
        ├── confirm_dialog.dart    # Widget for confirmation dialogs
        ├── header_back.dart       # Header with back button
        ├── outlined_cartoon_button.dart  # Custom button with outline style
        └── outlined_icon.dart     # Custom icon widget with outline style
```

## Features

- **Multiple Game Modes**: Choose from various game modes to keep the fun going.
- **Player Management**: Add or remove players easily.
- **Scoring System**: Track the score of each team or player during the game.
- **Fun UI**: The app features a cartoon-like UI to make the game more engaging.

## State Management

The app uses the **Provider Pattern** for managing the state of the game. This ensures that the state of the players, collections, and game progress is efficiently handled and updated across the application.

## Documentation

The documentation for the project can be found in the `docs` directory. It includes the following files:

- `dalle.md`: Contains the DALL-E prompt used for generating the cartoon images used in the app.
- `database_structure.md`: Describes the database structure that will be used for storing user and collection information.
