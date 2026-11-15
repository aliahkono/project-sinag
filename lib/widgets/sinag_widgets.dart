/// One import for every shared SINAG widget:
///
///     import '../../widgets/sinag_widgets.dart';
///
/// | File               | What's inside                                        |
/// |--------------------|------------------------------------------------------|
/// | page_layout.dart   | SinagPage (header + heading + panels), withGaps      |
/// | auth_header.dart   | AuthHeader: centred logo (sign-in screens)           |
/// | top_app_bar.dart   | SinagTopAppBar: logo, building, bell, settings       |
/// | back_button.dart   | SinagBackButton: ‹ arrow in both header bars         |
/// | wordmark.dart      | SinagWordmark: sun symbol + "SINAG" (Cinzel)         |
/// | bottom_nav.dart    | SinagBottomNav: Dashboard · Scanner · Reports        |
/// | tabs.dart          | RoleNav (role bottom bar), PageTabs (in-page tabs)   |
/// | panel.dart         | Panel (card) and PanelTone (card colours)            |
/// | texts.dart         | PanelTitle, PanelText, Tag, Note, Caption, BodyText, |
/// |                    | TextLink                                             |
/// | buttons.dart       | PrimaryButton, SecondaryButton, SmallButton,         |
/// |                    | SmallButtonRow                                       |
/// | inputs.dart        | SinagField (text box), OptionChips                   |
/// | data_display.dart  | KeyValue, SinagProgressBar, LoadBarChart,            |
/// |                    | TimelineRow                                          |
/// | disclosure.dart    | MoreDetails (See details), InfoButton (ⓘ),           |
/// |                    | PanelTitleWithInfo, showInfoSheet                    |
/// | snack.dart         | showSinagSnack (short message)                       |
library;

export 'auth_header.dart';
export 'back_button.dart';
export 'bottom_nav.dart';
export 'buttons.dart';
export 'data_display.dart';
export 'disclosure.dart';
export 'inputs.dart';
export 'page_layout.dart';
export 'panel.dart';
export 'snack.dart';
export 'tabs.dart';
export 'texts.dart';
export 'top_app_bar.dart';
export 'wordmark.dart';
