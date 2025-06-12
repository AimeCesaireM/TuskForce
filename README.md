# TuskForce Flutter App

TuskForce is a powerful, cross-platform Flutter application that blends a discovery platform for
products and services with intuitive personal task management. Built using Flutter’s robust UI
toolkit, Firebase services, and optimized image caching strategies, TuskForce is production-ready
and highlights engineering best practices.

---

## 🚀 Overview

TuskForce is designed for versatility:

* **Discover** page for browsing curated content
* **Products** and **Services** pages with listings
* A modular **Task** widget (TuskWidget)
* A personal dashboard in **My Stuff**
* **Google OAuth2 Sign-In** with Firebase authentication
* Scalable, maintainable code architecture with stateful widgets and reusable components

---

## 🎯 Features

✅ Google OAuth2 login via Firebase Auth  
✅ NoSQL database management via Firebase Firestore  
✅ Cached network images for reduced load times and smooth UI performance  
✅ Modular, maintainable file structure  
✅ Custom components like `TuskWidget` for task tracking  
✅ Consistent design system with reusable frames and responsive layouts

---

## 🛠️ Tech Stack

* **Language**: Dart
* **Framework**: Flutter 3.x+
* **Backend Services**:

    * Firebase Authentication (with Google OAuth2)
    * Firebase Cloud Firestore (NoSQL DB for user/task data)
* **UI**:

    * CachedNetworkImage for fast image rendering
    * Material Design + custom theming
* **State Management**: Ready for Provider, Riverpod, or Bloc

---

## 🔐 Authentication & Storage

TuskForce uses Firebase’s authentication framework to provide seamless **Google Sign-In via OAuth2**,   
ensuring fast and secure onboarding for users. Once authenticated, user-specific data—such as
personal tasks,  
 bookmarks, or service preferences—is stored and retrieved from **Firebase Firestore**, a scalable NoSQL cloud database.

This enables persistent state and personalized experiences across devices.

---

## 🖼️ UI Highlights

* `CachedNetworkImage` is implemented throughout the Discover, Products, and Services screens to
  ensure:

    * Faster image load times
    * Reduced network overhead
    * Improved offline performance

Each screen and widget is crafted with performance in mind, providing smooth transitions and
intuitive interactions.

---

## 📥 Getting Started

1. **Clone the repository**

```bash
git clone https://github.com/AimeCesaireM/tusk_force.git
cd tusk_force
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Configure Firebase**

* Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
* Set up Firestore rules and OAuth2 credentials in the Firebase console

4. **Run the app**

```bash
flutter run
```

---

## 🧠 Why TuskForce Stands Out

This project demonstrates:

* OAuth2 integration and secure user identity management
* Clean and modular architecture suited for scale
* Practical, production-ready UI performance strategies
* Custom reusable widgets for productivity
* Clean design and strong use of Flutter’s compositional model

---

## 📜 License

MIT License. Fork and build your own force with TuskForce.
