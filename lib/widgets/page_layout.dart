import 'package:flutter/material.dart';

import '../app/roles.dart';
import '../app/tab_slide.dart';
import '../theme/sinag_theme.dart';
import 'auth_header.dart';
import 'disclosure.dart';
import 'top_app_bar.dart';

/// Which header a screen shows at the top.
enum SinagHeader {
  /// Centred logo only. Used before sign-in is finished (screens 01–04).
  auth,

  /// Logo, building picker, bell and settings. Used everywhere else.
  app,
}

/// The layout every SINAG screen shares. In Figma each screen is:
///
///     Header           (AuthHeader or TopAppBar)
///     Screen body      22px padding, scrolls
///       Page heading     eyebrow + title, 6px apart
///       (16px gap)
///       Feature panels   your `children`, 14px apart
///     Bottom bar       optional (bottom navigation)
///
/// A screen only has to give the eyebrow, title and the list of panels.
class SinagPage extends StatefulWidget {
  const SinagPage({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.children,
    this.header = SinagHeader.app,
    this.bottomBar,
    this.eyebrowColor,
    this.role,
    this.about = const [],
  });

  /// "About this screen" notes. When given, an ⓘ shows next to the title
  /// and opens them in a panel. Keeps footnotes off the main screen.
  final List<String> about;

  /// Set on a role's own screens (e.g. Dashboard → EEC Officer). While this
  /// screen is showing, the user counts as working in that role, so shared
  /// screens opened from here show that role's bottom bar.
  final SinagRole? role;

  /// Small all-caps label above the title, e.g. "ACCESS · STEP 1 OF 2".
  final String eyebrow;

  /// Optional colour for the eyebrow (default grey).
  final Color? eyebrowColor;

  /// Big page title, e.g. "Sign in".
  final String title;

  /// The cards, fields and buttons of the screen, top to bottom.
  final List<Widget> children;

  final SinagHeader header;
  final Widget? bottomBar;

  /// Smoothly scrolls the current screen back to the top. Used when the
  /// user taps the tab for the screen they are already on.
  static void scrollToTop(BuildContext context) {
    final controller = context
        .dependOnInheritedWidgetOfExactType<_PageScrollScope>()
        ?.controller;
    if (controller == null || !controller.hasClients) return;
    controller.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  State<SinagPage> createState() => _SinagPageState();
}

class _SinagPageState extends State<SinagPage> {
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ModalRoute.of also rebuilds this page when the user comes back to it,
    // so returning to e.g. the Dashboard switches back to the EEC role.
    final isShowing = ModalRoute.of(context)?.isCurrent ?? true;
    if (widget.role != null && isShowing) SinagSession.role = widget.role!;

    // The scope lets the bottom bar reach this page's scroll position.
    return _PageScrollScope(
      controller: _scroll,
      child: Scaffold(
        backgroundColor: SinagColors.background,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              widget.header == SinagHeader.auth
                  ? const AuthHeader()
                  : const SinagTopAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scroll,
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.eyebrow,
                        style: SinagText.eyebrow.copyWith(
                          color: widget.eyebrowColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.title,
                              style: SinagText.pageTitle,
                            ),
                          ),
                          if (widget.about.isNotEmpty) ...[
                            const SizedBox(width: 4),
                            InfoButton(
                              title: 'About ${widget.title}',
                              lines: widget.about,
                              size: 20,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...withGaps(widget.children, 14),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: widget.bottomBar == null
            ? null
            : SafeArea(top: false, child: widget.bottomBar!),
      ),
    );
  }
}

/// Passes the page's scroll controller down to its tabs.
class _PageScrollScope extends InheritedWidget {
  const _PageScrollScope({required this.controller, required super.child});
  final ScrollController controller;

  @override
  bool updateShouldNotify(_PageScrollScope old) => old.controller != controller;
}

/// Puts a vertical space of [gap] pixels between each widget in [children].
List<Widget> withGaps(List<Widget> children, double gap) {
  final out = <Widget>[];
  for (var i = 0; i < children.length; i++) {
    if (i > 0) out.add(SizedBox(height: gap));
    out.add(children[i]);
  }
  return out;
}

/// What happens when the user taps any tab (bottom bar, role bar, or the
/// Open / Resolved tabs):
///
/// - Already on that tab's screen → scroll back to the top.
/// - Otherwise → open the tab's screen. With [startFresh] (bottom bar and
///   role bar), the history is cleared so there's no back arrow, because
///   these are top-level sections. Without it (in-page tabs), the screens
///   swap in place and the back arrow still goes to where the user came from.
///
/// [direction] makes the new screen slide in from the side the user is
/// moving towards: +1 = tapped a tab to the right (slides in from the
/// right), -1 = tapped a tab to the left (from the left), 0 = no slide.
void openTab(
  BuildContext context,
  String route, {
  required bool startFresh,
  int direction = 0,
}) {
  final current = ModalRoute.of(context)?.settings.name;
  if (current == route) {
    SinagPage.scrollToTop(context);
    return;
  }
  final nav = Navigator.of(context);
  final slide = TabSlide(direction.sign);
  if (startFresh) {
    nav.pushNamedAndRemoveUntil(route, (_) => false, arguments: slide);
  } else {
    nav.pushReplacementNamed(route, arguments: slide);
  }
}

/// Which side the new screen slides in from when going from tab [from] to
/// tab [to] in a bar of [count] tabs: +1 = from the right (screen moves
/// left), -1 = from the left (screen moves right), 0 = no slide (nothing
/// highlighted, or the same tab).
///
/// Bills is the left tab, Review the middle, Alerts the right:
///
///     Bills → Review    from the left  (screen moves right)
///     Alerts → Review   from the right (screen moves left)
///     Review → Alerts   from the right (screen moves left)
///     Review → Bills    from the left  (screen moves right)
///     Bills → Alerts    from the left  (screen moves right)
///     Alerts → Bills    from the right (screen moves left)
///
/// Switches with the middle tab come in from the outer tab's side;
/// switches between the two outer tabs come in from the side you left.
int tabDirection(int from, int to, {required int count}) {
  if (from < 0 || from == to) return 0;
  final middle = count.isOdd ? count ~/ 2 : -1;
  if (to == middle) return (from - to).sign; // from where you came from
  if (from == middle) return (to - from).sign; // from where you're going
  return (from - to).sign; // outer ↔ outer: from the side you left
}
