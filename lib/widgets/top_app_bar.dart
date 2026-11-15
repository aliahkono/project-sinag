import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/buildings.dart';
import '../app/roles.dart';
import '../app/routes.dart';
import '../theme/sinag_theme.dart';
import 'back_button.dart';
import 'snack.dart';
import 'wordmark.dart';

/// Figma component "TopAppBar" (101:54), shown after sign-in:
///
///     ‹ [logo]          VIEWING      🔔  ⚙
///                       Building A ▾
///
/// - ‹           → previous screen (only shown when there is one)
/// - logo        → back to the Dashboard
/// - building    → dropdown of buildings; the current one is ticked
/// - bell        → 10 · Notify (the latest after-hours notification)
/// - settings    → My access
class SinagTopAppBar extends StatelessWidget {
  const SinagTopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    return Container(
      height: 68,
      decoration: const BoxDecoration(
        color: SinagColors.lightBlueTint, // light blue (Figma: appBar)
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          // Back arrow (only when there is a previous screen).
          if (SinagBackButton.isAvailable(context)) ...[
            const SizedBox(width: 4),
            const SinagBackButton(),
          ] else
            const SizedBox(width: 1),
          _Logo(
            onTap: () =>
                nav.pushNamedAndRemoveUntil(Routes.dashboard, (_) => false),
          ),
          // The building name takes the space left over and shrinks on
          // narrow phones instead of pushing the icons off-screen.
          Expanded(
            child: const Align(
              alignment: Alignment.centerRight,
              child: _BuildingPicker(),
            ),
          ),
          const SizedBox(width: 15),
          _Bell(onTap: () => nav.pushNamed(Routes.notify)),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () => nav.pushNamed(Routes.myAccess),
            child: SvgPicture.asset(
              'assets/images/ic_settings.svg',
              width: 20.1,
              height: 20,
            ),
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: const Padding(
      padding: EdgeInsets.only(left: 8),
      // Sun symbol + "SINAG" in Cinzel (Figma used a picture with the word
      // baked in: sinag_logo_bar.png).
      child: SinagWordmark(symbolHeight: 40, fontSize: 16, gap: 5),
    ),
  );
}

/// "VIEWING / Building A ▾" — shows the building currently being looked at.
/// Tapping it opens a dropdown of all buildings with the current one ticked
/// and highlighted, plus "See all buildings" (04 · Buildings).
///
/// Before any building is chosen it reads "Select building ›" and opens the
/// full Buildings screen instead — the dropdown only appears once a
/// building has been picked there.
class _BuildingPicker extends StatelessWidget {
  const _BuildingPicker();

  /// Value returned by the dropdown for "See all buildings".
  static const _seeAll = '_all';

  Future<void> _openDropdown(BuildContext context) async {
    final current = selectedBuilding.value;
    if (current == null) {
      // No building yet: show all buildings to choose from first.
      Navigator.of(context).pushNamed(Routes.buildings);
      return;
    }
    final box = context.findRenderObject()! as RenderBox;
    final overlay =
        Overlay.of(context).context.findRenderObject()! as RenderBox;
    // Open just below the picker, lined up with its right edge.
    final topLeft = box.localToGlobal(
      Offset(0, box.size.height),
      ancestor: overlay,
    );
    final bottomRight = box.localToGlobal(
      box.size.bottomRight(Offset.zero),
      ancestor: overlay,
    );

    final picked = await showMenu<String>(
      context: context,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      position: RelativeRect.fromRect(
        Rect.fromPoints(topLeft, bottomRight),
        Offset.zero & overlay.size,
      ),
      items: [
        for (final b in sinagBuildings)
          PopupMenuItem<String>(
            value: b.id,
            padding: EdgeInsets.zero,
            child: _BuildingOption(building: b, selected: b.id == current.id),
          ),
        const PopupMenuDivider(),
        PopupMenuItem<String>(
          value: _seeAll,
          child: Text('See all buildings', style: SinagText.link),
        ),
      ],
    );
    if (picked == null || !context.mounted) return;
    if (picked == _seeAll) {
      Navigator.of(context).pushNamed(Routes.buildings);
      return;
    }
    final building = sinagBuildings.firstWhere((b) => b.id == picked);
    final home = SinagSession.homeRoute;
    final onHome = ModalRoute.of(context)?.settings.name == home;
    // Already looking at this building's main screen: nothing to do.
    if (building.id == current.id && onHome) return;

    // Switch building, then open the role's main screen for it (Dashboard,
    // Focal workspace or Facility workspace) as a fresh start.
    selectedBuilding.value = building;
    if (building.id != current.id) {
      showSinagSnack(context, 'Now viewing ${building.name}');
    }
    Navigator.of(context).pushNamedAndRemoveUntil(home, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    // Rebuilds whenever the selected building changes.
    return ValueListenableBuilder<Building?>(
      valueListenable: selectedBuilding,
      builder: (context, building, _) => Tooltip(
        message: building?.name ?? 'Choose a building',
        child: Semantics(
          button: true,
          label: building == null
              ? 'Select building'
              : 'Building: ${building.name}. Change building',
          excludeSemantics: true,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _openDropdown(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Flexible: on narrow phones the name is shortened.
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          building == null ? 'NO BUILDING' : 'VIEWING',
                          style: SinagText.eyebrow,
                        ),
                        Text(
                          building?.label ?? 'Select building',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: SinagText.button,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  // ▾ = opens the dropdown; › = opens the Buildings screen.
                  building == null
                      ? const Icon(
                          Icons.chevron_right,
                          size: 18,
                          color: SinagColors.navy,
                        )
                      : SvgPicture.asset(
                          'assets/images/chevron_down.svg',
                          width: 10,
                          height: 5,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One building in the dropdown. The current building is highlighted the
/// same way as a selected tab: solid navy with white text, a tick, and
/// "Currently viewing" underneath.
class _BuildingOption extends StatelessWidget {
  const _BuildingOption({required this.building, required this.selected});
  final Building building;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final nameColor = selected ? Colors.white : SinagColors.navy;
    final noteColor = selected ? SinagColors.navOnNavy : SinagColors.muted;
    return Semantics(
      selected: selected,
      child: Container(
        width: 268,
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? SinagColors.navy : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 26,
              child: selected
                  ? const Icon(
                      Icons.check_circle,
                      size: 18,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.circle_outlined,
                      size: 18,
                      color: SinagColors.border,
                    ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    building.name,
                    style: SinagText.kvValue.copyWith(
                      color: nameColor,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                  Text(
                    selected
                        ? 'CURRENTLY VIEWING · ${building.tier}'
                        : building.tier,
                    style: SinagText.caption.copyWith(color: noteColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bell icon with a red dot for unread alerts.
class _Bell extends StatelessWidget {
  const _Bell({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    // Tooltip also gives screen readers the name "Notifications".
    return Tooltip(message: 'Notifications', child: _bell());
  }

  Widget _bell() {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 16,
        height: 20,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SvgPicture.asset(
              'assets/images/ic_bell.svg',
              width: 16,
              height: 20,
            ),
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: SinagColors.danger,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
