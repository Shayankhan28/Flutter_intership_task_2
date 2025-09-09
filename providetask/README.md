
# Flutter Firebase Task App

A **Flutter-based task management application** that allows users to **add, view, search, and delete tasks**. The app uses **Firebase Realtime Database** for storage and **Provider** for state management, ensuring a smooth and reactive user experience.

---

## Features

* **User Authentication:** Firebase Authentication for user login and management.
* **Add Tasks:** Users can add tasks easily using the input field with a floating button.
* **View Tasks:** All tasks are displayed in a clean list format.
* **Delete Tasks:** Remove any task from the list and Firebase database with a single tap.
* **Search Functionality:** Search tasks in real-time.
* **State Management:** Uses Provider for efficient state updates without affecting UI logic.



## Getting Started

### Prerequisites

* Flutter SDK >= 3.0
* Dart >= 3.0
* Firebase project setup with:

  * Firebase Authentication
  * Firebase Realtime Database

---

### Installation

1. **Clone the repository:**

```bash
git clone <your-repo-url>
cd <project-folder>
```

2. **Install dependencies:**

```bash
flutter pub get
```

3. **Configure Firebase:**

* Add `google-services.json` for Android and `GoogleService-Info.plist` for iOS.
* Update `firebase_options.dart` using FlutterFire CLI:

```bash
flutterfire configure
```

4. **Run the app:**

```bash
flutter run
```

---

## Project Structure

```
lib/
│
├── ui/                 # Screens & Widgets
│   ├── postscreen.dart
│   └── add_post.dart
│
├── task_provider.dart   # Provider for managing tasks
├── util/               # Utility functions (e.g., toaster messages)
└── main.dart           # Entry point
```

---

## State Management

This project uses **Provider** for managing task state:

* **TaskProvider:**

  * Loads tasks from Firebase for the logged-in user.
  * Adds new tasks to Firebase.
  * Deletes tasks from Firebase.
  * Notifies UI on changes automatically.

---

## Firebase Database Structure

```
UserData
  └─ userUID
      ├─ taskID1: { "Task": "Buy groceries" }
      ├─ taskID2: { "Task": "Read a book" }
      └─ ...
```

---

## Dependencies

* `firebase_core`
* `firebase_auth`
* `firebase_database`
* `provider`
* `fluttertoast` *(or your custom toaster utility)*

---

## Usage

1. Log in with a Firebase-authenticated user.
2. Add tasks using the **Add Task** input and floating button.
3. Delete tasks with the trash icon.
4. Search tasks using the search bar.

---

## Contributing

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -m 'Add feature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Create a Pull Request.

---

## License

MIT License © Muhammad Shayan khan


