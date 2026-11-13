# SINAG

Systematic Information Network for Auditing Government-energy — a Flutter mobile app
implementing the 31 screens of the Project SINAG Figma design ("revised" page).

## Structure

- `lib/theme/` — colours and Inter text styles from the design
- `lib/widgets/` — shared components (headers, bottom nav, panels, buttons, fields, charts)
- `lib/screens/` — the 31 screens, grouped by area; each class notes its Figma frame
- `lib/app/routes.dart` — one named route per screen
- `assets/images/` — logo and icon assets exported from Figma

## Run

```bash
flutter pub get
flutter run
```

## Test

```bash
flutter test
```

Every route is rendered on a 402px-wide phone and checked for layout errors.
