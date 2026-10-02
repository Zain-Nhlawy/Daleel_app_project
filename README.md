# Daleel 🏠

**Daleel** is a Flutter-based apartment rental and management application that connects property owners with users looking for apartments.

The application provides a complete flow for discovering apartments, viewing their details, booking rentals, managing contracts, and communicating with property owners.

## ✨ Features

###  Apartment Discovery

* Browse available apartments
* Search and filter apartments
* View nearby apartments
* Explore popular and highly-rated apartments
* View detailed apartment information
* Save apartments to favorites
* View apartment images, location, price, and specifications
* Read and add reviews and comments

###  Booking & Contracts

* Select rental dates using an interactive calendar
* Book available apartments
* View current and previous rental contracts
* Track contract status
* Request contract modifications
* Approve or reject contract edit requests
* View contract details and remaining rental time

###  Property Management

Property owners can:

* Add new apartments
* Upload multiple apartment images
* Select the apartment location
* Specify price, area, floor, bedrooms, and bathrooms
* Add descriptions and apartment status
* Edit existing apartment information
* Manage their listed properties

New apartment listings are submitted for approval before becoming available.

###  Chat & Communication

* User-to-user chat
* View conversations
* Send messages
* Communicate between renters and property owners

###  Notifications

The application supports both:

* Firebase Cloud Messaging (FCM)
* Local notifications

Users can receive notifications related to application activities and updates.

###  User Profile

Users can:

* View and edit their profile
* Manage their listed apartments
* View favorite apartments
* View contract history
* Manage application settings

###  Localization

The application supports multiple languages:

* 🇸🇾 Arabic
* 🇬🇧 English
* 🇫🇷 French

The UI is designed to support localized content and RTL layouts.

---

##  Architecture

The project uses a **feature-oriented layered architecture**, separating the application into:

```text
lib/
├── controllers/
├── core/
│   ├── network/
│   └── storage/
├── cubit/
├── models/
├── repository/
├── services/
├── screen/
├── widget/
└── main.dart
```

The project separates UI screens, business logic, API services, models, repositories, and reusable widgets to keep the application maintainable and scalable.

---

## 🛠️ Tech Stack

* **Flutter / Dart**
* **Flutter BLoC / Cubit**
* **Provider**
* **Dio** — REST API communication
* **GetIt** — Dependency Injection
* **Flutter Secure Storage** — Secure token storage
* **Firebase Authentication**
* **Cloud Firestore**
* **Firebase Cloud Messaging**
* **Flutter Local Notifications**
* **Hive** — Local data storage
* **Google Fonts**
* **Flutter Map & LatLong** — Maps and locations
* **Geocoding** — Location information
* **Image Picker** — Apartment image uploads
* **Lottie** — Animations

---

##  Authentication & Security

The application uses authenticated API requests with secure local token storage.

Sensitive authentication data is stored using `flutter_secure_storage`, while the networking layer handles API communication through a centralized Dio client.

---

##  Getting Started

### Prerequisites

* Flutter SDK
* Dart SDK
* Android Studio / VS Code
* Android or iOS development environment

### Installation

```bash
git clone https://github.com/Zain-Nhlawy/Daleel_app_project.git
cd Daleel_app_project
flutter pub get
```

Create a `.env` file and configure the required API environment variables.

Then run:

```bash
flutter run
```

---

## 👨‍💻 Author

**Zain Nhlawy**

**Loulia Alshaar**

Information Engineering Students & Flutter Developers
