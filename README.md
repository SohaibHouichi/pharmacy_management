# PharmaSI

A Flutter mobile app for pharmacy inventory and sales management, built against the
Pharmacy REST API. Runs on Android and iOS.

---

## Features

| Area | What it does |
|---|---|
| **Authentication** | Login with validation, token in secure storage, logout clears the session |
| **Dashboard** | Total medicines, low-stock list, today's sales count and revenue |
| **Medicines** | Paginated list with search, add / edit / delete with confirmation, detail view |
| **Sales** | Invoice list and details, multi-item sale with automatic totals (cash only) |
| **Inventory** | Low-stock, expiring-soon and expired alerts; update stock quantity |

Every screen handles **loading, error and empty** states.

---

## Tech stack

| | |
|---|---|
| Framework | Flutter 3.47.1 (stable) |
| Language | Dart 3.13.1 |
| State management | [GetX](https://pub.dev/packages/get) |
| HTTP | [Dio](https://pub.dev/packages/dio) |
| Functional error handling | [dartz](https://pub.dev/packages/dartz) |
| Secure storage | [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) |
| Debug logging | [pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger) |
| Architecture | Feature-first Clean Architecture |

---

## Setup

### Requirements

- Flutter **3.47.1** or newer (Dart 3.13+)
- Android SDK 36 with licences accepted, or Xcode for iOS

```bash
flutter --version
flutter doctor
```

If `flutter doctor` reports unaccepted Android licences:

```bash
flutter doctor --android-licenses
```

Chrome and Visual Studio warnings can be ignored — this project targets Android and
iOS only.

### Install

```bash
git clone <https://github.com/SohaibHouichi/pharmacy_management>
cd pharmacy_management
flutter pub get
```

### Run

```bash
flutter devices
flutter run
```

---

## Building a release APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

Smaller per-architecture builds:

```bash
flutter build apk --release --split-per-abi
```

iOS:

```bash
flutter build ios --release
```

---

## Project structure

```
lib/
├── app/                      # Routes, middleware, initial bindings
├── core/                     # Shared across features
│   ├── constant/
│   ├── domain/               # Paginated<T>, ExpiryStatus
│   ├── error/                # Exceptions, Failures, guard()
│   ├── network/              # Dio client, interceptors, ApiResponse<T>
│   ├── services/             # SessionService
│   ├── shared/               # Reusable widgets, dialogs, status config
│   ├── storage/              # Secure token storage
│   ├── theme/                # Colors, fonts, ThemeData
│   └── utils/                # Validators, mixins, JSON helpers
└── features/
    ├── auth/
    ├── dashboard/
    ├── inventory/
    ├── main/                 # Bottom-nav shell
    ├── medicines/
    ├── sales/
    └── splash/
```

Each feature contains three layers:

```
feature/
├── data/          data_source · models (requests/responses/mappers) · repository
├── domain/        entity · repository contract · usecase
└── presentation/  bindings · controllers · pages · widgets
```

---

## Architecture summary

**Feature-first Clean Architecture.** Dependencies point inward — presentation and
data both depend on domain, and domain depends on nothing. The domain layer has no
Flutter or GetX imports, so business rules stay testable.

**GetX for three specific things:** granular reactive rebuilds via `.obs` and `Obx`;
dependency injection scoped to route lifetime through bindings; and navigation
without `BuildContext`, so controllers own routing decisions.

**Errors as values.** Data sources throw typed exceptions, repositories convert them
to `Failure` via `guard()` and return `Either<Failure, T>`, and controllers handle
both branches with `.fold()`. A 422 response carries its field errors through to the
form; a global interceptor handles 401 anywhere in the app.

**One shell, lazy tabs.** A single `Scaffold` owns the app bar and bottom navigation.
Tabs build on first visit and stay alive, so scroll position survives switching.
Forms and detail screens are pushed as separate routes.

See `ARCHITECTURE.pdf` for the full explanation.

---

## Known limitations

- No offline caching; the app requires a network connection.
- No unit or widget tests.
- The sales list is not paginated (the endpoint supports it; the UI loads page 1).
- Biometric login is stubbed in the UI but not implemented.

---

## API notes

- Payment method is cash only, enforced client-side and validated by the server.
- Invoice totals come from the server response, not client calculation.
- Medicine quantity is set on creation only; later changes go through
  `POST /inventory/stock`, which takes an **absolute** quantity, not a delta.
- `per_page` is capped at 50 by the API and clamped in the data source.
