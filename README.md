# Deutsch Duo

A Flutter application for learning German with your partner. Complete topics, earn points, and compete on the leaderboard while receiving notifications about your partner's progress.

## Features

- **Authentication**: Secure login with Firebase Auth
- **Dashboard**: View your progress, next topic, and available learning materials
- **Topic Completion**: Complete topics to earn points and track progress
- **Live Leaderboard**: Real-time leaderboard showing all users ranked by score
- **Notifications**: Receive notifications when your partner completes topics (coming soon)
- **Modern UI**: Beautiful, animated interface with Google Fonts and Font Awesome icons

## Tech Stack

- **Frontend**: Flutter with Dart
- **State Management**: Riverpod
- **Backend**: Firebase
  - Authentication: Firebase Auth
  - Database: Cloud Firestore
  - Notifications: Firebase Cloud Messaging
  - Functions: Firebase Cloud Functions (for notifications)
- **UI Libraries**: 
  - Google Fonts
  - Font Awesome Flutter
  - Flutter Animate

## Project Structure

```
lib/
├── core/
│   ├── auth_gate.dart
│   └── services/
│       └── notification_service.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   └── auth_repository.dart
│   │   ├── providers/
│   │   │   └── auth_providers.dart
│   │   └── presentation/
│   │       └── login_screen.dart
│   ├── dashboard/
│   │   ├── data/
│   │   │   └── topics_repository.dart
│   │   ├── providers/
│   │   │   └── topics_provider.dart
│   │   └── presentation/
│   │       ├── dashboard_screen.dart
│   │       └── topic_detail_screen.dart
│   ├── leaderboard/
│   │   ├── data/
│   │   │   └── leaderboard_repository.dart
│   │   ├── providers/
│   │   │   └── leaderboard_provider.dart
│   │   └── presentation/
│   │       └── leaderboard_screen.dart
│   └── notifications/
│       └── presentation/
│           └── notifications_screen.dart
├── shared/
│   ├── models/
│   │   ├── user_model.dart
│   │   └── topic_model.dart
│   └── widgets/
│       └── shell.dart
└── main.dart
```

## Setup Instructions

### Prerequisites

1. Install Flutter SDK (version 3.8.1 or higher)
2. Install Firebase CLI
3. Have a Firebase project set up

### 1. Clone and Setup

```bash
git clone <repository-url>
cd deutsch_duo
flutter pub get
```

### 2. Firebase Configuration

1. Run `flutterfire configure` to set up Firebase
2. This will create the necessary configuration files

### 3. Firestore Database Setup

Create the following collections in your Firestore database:

#### Users Collection
Create documents with the following fields:
- `uid` (string): Firebase Auth UID
- `name` (string): User's display name
- `email` (string): User's email
- `score` (number): User's total score (start with 0)
- `fcmToken` (string): FCM token for notifications (leave empty initially)
- `lastActive` (timestamp): Last active timestamp

Example user documents:
```
users/user1_uid
{
  "uid": "user1_uid",
  "name": "Alice",
  "email": "user1@deutschduo.com",
  "score": 0,
  "fcmToken": "",
  "lastActive": null
}

users/user2_uid
{
  "uid": "user2_uid", 
  "name": "Bob",
  "email": "user2@deutschduo.com",
  "score": 0,
  "fcmToken": "",
  "lastActive": null
}
```

#### Topics Collection
Create documents with the following fields:
- `title` (string): Topic title
- `level` (number): Difficulty level
- `order` (number): Display order
- `pointsValue` (number): Points earned for completion
- `description` (string, optional): Topic description

Example topic documents:
```
topics/topic1
{
  "title": "Greetings",
  "level": 1,
  "order": 1,
  "pointsValue": 10,
  "description": "Learn basic German greetings"
}

topics/topic2
{
  "title": "Family",
  "level": 1,
  "order": 2,
  "pointsValue": 15,
  "description": "Family vocabulary and relationships"
}

topics/topic3
{
  "title": "Food",
  "level": 2,
  "order": 3,
  "pointsValue": 20,
  "description": "Food and dining vocabulary"
}
```

### 4. Firebase Authentication Setup

1. Enable Email/Password authentication in Firebase Console
2. Create test users:
   - Email: `user1@deutschduo.com`, Password: `password123`
   - Email: `user2@deutschduo.com`, Password: `password123`

### 5. Run the Application

```bash
flutter run
```

## Usage

1. **Login**: Use the demo credentials provided on the login screen
2. **Dashboard**: View your progress and available topics
3. **Complete Topics**: Tap on any topic to view details and complete it
4. **Leaderboard**: Check your ranking against other users
5. **Notifications**: View upcoming notification features

## Firebase Cloud Functions (Optional)

For full notification functionality, deploy the following Cloud Functions:

### Setup Functions

```bash
firebase init functions
cd functions
npm install
```

### Deploy Functions

```bash
firebase deploy --only functions
```

The functions will handle:
- Sending notifications when users complete topics
- Daily inactivity reminders
- Partner activity notifications

## Development Notes

- The app uses Riverpod for state management
- All Firebase operations are handled through repositories
- UI animations are powered by Flutter Animate
- The app follows a clean architecture pattern with feature-based organization

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.
