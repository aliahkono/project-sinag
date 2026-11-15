# SINAG

Systematic Information Network for Auditing Government-energy — a Flutter mobile app
implementing the 31 screens of the Project SINAG Figma design ("revised" page).

## Folder structure

```
lib/
├── main.dart                 Starting point: runs SinagApp
├── app/
│   ├── app.dart              SinagApp (MaterialApp, theme, first screen)
│   ├── routes.dart           Route names, one per Figma screen (01–31)
│   └── route_table.dart      Which screen each route opens
├── theme/
│   ├── sinag_theme.dart      ← import this one; it exports the three below
│   ├── colors.dart           SinagColors: every colour in the design
│   ├── text_styles.dart      SinagText: every text style (Inter)
│   └── app_theme.dart        buildSinagTheme()
├── widgets/
│   ├── sinag_widgets.dart    ← import this one; it exports everything below
│   ├── page_layout.dart      SinagPage: header + heading + list of cards
│   ├── auth_header.dart      Centred logo (sign-in screens)
│   ├── top_app_bar.dart      Logo · building picker · bell · settings
│   ├── back_button.dart      ‹ back arrow (shown when there's a previous screen)
│   ├── bottom_nav.dart       Dashboard · Scanner · Reports
│   ├── tabs.dart             RoleNav (role bottom bar), PageTabs
│   ├── panel.dart            Panel (card) + PanelTone (card colours)
│   ├── texts.dart            PanelTitle, PanelText, Tag, Note, Caption, …
│   ├── buttons.dart          PrimaryButton, SecondaryButton, SmallButton
│   ├── inputs.dart           SinagField, OptionChips
│   ├── data_display.dart     KeyValue, progress bar, load chart, timeline
│   └── snack.dart            showSinagSnack (short message)
└── screens/                  one file per screen, named after the screen
    ├── access/               01 Sign in · 02 Verify · 03 My access · 04 Buildings
    ├── dashboard/            05 Dashboard
    ├── bills/                06 Scan bill · 07 Review bill
    ├── appliances/           08 Appliances · 09 Appliance detail
    ├── alerts/               10 Notify · 11 Alerts · 12 Alert detail ·
    │                         13 Close alert · 31 Resolved alerts
    ├── rules/                14 Alert rules · 15 Work calendar ·
    │                         16 Overtime & events · 23 Learning mode
    ├── workspaces/           17 Focal workspace · 18 Facility workspace
    ├── eec_tools/            19 Reports · 20 Meters · 21 Report meter fault ·
    │                         22 Data review queue · 24 Morning summary
    ├── management/           25 Inventory · 26 Operating changes ·
    │                         27 Sharing · 28 Activity log
    └── summaries/            29 Leadership summary · 30 DOE / DILG summary
```

Every screen file starts with a comment giving its Figma number, frame id and what
the screen is for. Screens 01–05 also list their layout top to bottom, with
matching numbered comments in the code.

Roles: `lib/app/roles.dart` holds the three roles (EEC Officer, focal person,
facility manager) and their bottom-bar tabs. Screens shared by several roles
(Alerts, Appliances and their detail screens) show the bar of the current role.

## How a screen is built

```dart
SinagPage(
  eyebrow: 'ACCESS · STEP 1 OF 2',   // small label above the title
  title: 'Sign in',
  header: SinagHeader.auth,          // or SinagHeader.app (default)
  children: [                        // the cards, top to bottom
    Panel(children: [PanelTitle('…'), PanelText('…')]),
    PrimaryButton('Sign in securely', onPressed: …),
  ],
)
```

## Run

Needs Flutter with Dart 3.13 or newer.

```bash
flutter pub get
flutter run
```

## Test

```bash
flutter test
```

Every route is rendered on a 402px-wide phone and checked for layout errors.
