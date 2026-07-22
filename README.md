# Floreo Quiz App

A Flutter Web quiz application that loads quiz questions from local assets, persists quiz progress using Hive, and lets users navigate through questions using the selector and previous/next controls.

## Features

- Flutter Web application
- Local quiz progress persistence using Hive
- Question navigation with number selector and previous/next buttons
- Locked answers after selection
- Correct answer highlighted in green
- Incorrectly selected answer highlighted in red
- Explanation shown after answering
- Highlighted answered questions in the selector
- Responsive UI designed to closely follow the provided layout across screen sizes

## Project Requirements

Before you begin, make sure you have the following installed:

- Flutter SDK (recommended: latest stable)
- Dart SDK bundled with Flutter
- Chrome or another browser for web testing

## Setup Instructions

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd floreo_quiz_app
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app in Flutter Web mode:

   ```bash
   flutter run -d chrome
   ```

4. To build the production web version:

   ```bash
   flutter build web
   ```

5. The generated web output will be available in the `build/web` directory.

## Local Storage

This application uses Hive to store the user’s quiz progress locally in the browser environment for Flutter Web.

## Project Structure

- `lib/` — application source code
- `assets/quiz_data.json` — quiz question dataset
- `web/` — Flutter web entry files
- `test/` — widget tests

## MVC Architecture

The project follows a simple MVC structure inside the `lib/` folder:

### Model
The Model layer contains the quiz data objects and persistence model.

- `lib/models/quiz_question_model.dart` — defines the structure of each quiz question.
- `lib/models/quiz_progress_model.dart` — defines the saved quiz progress state for local persistence.

### View
The View layer contains the UI screen and reusable widgets.

- `lib/views/home_page.dart` — renders the quiz screen, question card, answer options, navigation buttons, and selector.
- `lib/widgets/k_filled_button.dart` — reusable button widget used in the UI.

### Controller
The Controller layer contains application logic and state management.

- `lib/controllers/quiz_controller.dart` — loads questions, tracks the current question, stores selected answers, and exposes state changes using `ChangeNotifier`.

### Service / Persistence Layer
The service layer handles storage operations.

- `lib/services/quiz_storage.dart` — saves and retrieves quiz progress using Hive.

### Supporting Layers

- `lib/constants/` — shared theme and color constants.
- `lib/config/responsive_helper.dart` — responsive layout helper.
- `lib/main.dart` — application entry point, initializes the app and local database.

This architecture keeps the UI separate from business logic, while the storage service handles persistence without mixing it into the screen widget.

## Notes

- The app reads quiz content from `assets/quiz_data.json`.
- If you are running on a different platform, the same project can also be tested in mobile or desktop mode.
- If you want to serve the built web app locally, you can use any static file server such as:

  ```bash
  cd build/web
  python -m http.server 8080
  ```

Then open `http://localhost:8080` in your browser.

