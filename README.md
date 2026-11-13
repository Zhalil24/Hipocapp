# HipocApp Mobile

Flutter client for HipocApp. It talks to the
[backend API](https://github.com/Zhalil24/hipocapp-backend) over REST and to its SignalR hub for chat.

## Requirements

- Flutter (stable channel)
- Android Studio or Xcode for running on a device or emulator
- A running HipocApp backend

## Setup

1. Create the env files. They are ignored by git:

   ```
   module/gen/assets/env/.dev.env
   module/gen/assets/env/.prod.env
   ```

   Each file contains the API address:

   ```
   BASE_URL=http://10.0.2.2:5000
   ```

   `10.0.2.2` is the host machine as seen from the Android emulator. Debug builds use
   `.dev.env`, release builds use `.prod.env`.

2. Install packages and generate code:

   ```bash
   flutter pub get
   cd module/gen && dart run build_runner build --delete-conflicting-outputs && cd ../..
   dart run build_runner build --delete-conflicting-outputs
   ```

   Run the generators again after changing env files, models or routes.

3. Run:

   ```bash
   flutter run
   ```

## Project layout

| Folder | Purpose |
|---|---|
| `lib/feature` | Screens, one folder per feature (view, view model, widgets) |
| `lib/product` | App-wide code: services, navigation, state, cache, theme, SignalR |
| `module/core` | Cache infrastructure |
| `module/gen` | Generated assets, env configuration and API models |
| `module/widgets` | Shared widgets |
| `module/common` | Shared package wrappers (e.g. custom image) |

## Checks

```bash
flutter analyze
flutter test
```
