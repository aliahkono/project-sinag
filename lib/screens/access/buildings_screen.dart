import 'package:flutter/material.dart';

import '../../app/buildings.dart';
import '../../app/roles.dart';
import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 04 · Buildings — Figma frame 97:96
///
/// Lets the user pick which building of the LGU to look at. After sign-in no
/// building is chosen yet, so every card shows "Select …". Once one is
/// chosen it is marked "SELECTED" with the navy "Open" button and the others
/// get "Switch to …". Either way the role's main screen opens next
/// (Dashboard, Focal or Facility workspace; demo data, so every building
/// shows Building A's figures).
///
/// Layout, top to bottom:
///   1. Intro + search field
///   2. One card per building (see [_BuildingCard])
///   3. Note about per-building permissions
class BuildingsScreen extends StatelessWidget {
  const BuildingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void open(Building building) {
      selectedBuilding.value = building;
      Navigator.of(context)
          .pushNamedAndRemoveUntil(SinagSession.homeRoute, (_) => false);
    }

    // Rebuilds when the selected building changes.
    return ValueListenableBuilder<Building?>(
      valueListenable: selectedBuilding,
      builder: (context, current, _) => SinagPage(
        header: SinagHeader.auth,
        eyebrow: 'JURISDICTION',
        title: 'Buildings',
        children: [
          // 1. Intro + search
          BodyText(
            current == null
                ? 'Choose a building in your LGU to continue.'
                : 'Choose a building in your LGU.',
          ),
          const SinagField(
            label: 'Search buildings',
            initialValue: 'City Hall',
          ),

          // 2. Buildings
          for (final building in sinagBuildings)
            _BuildingCard(
              building: building,
              isSelected: building.id == current?.id,
              noneSelected: current == null,
              onOpen: () => open(building),
            ),

          // 3. Note
          const Note(
            'Your role and sharing permissions apply separately to each '
            'building.',
          ),
        ],
      ),
    );
  }
}

/// One building card: name, description, tier tag, one detail row and a
/// button. The selected building's tag starts with "SELECTED" (green) and
/// it gets the navy "Open …" button; the others get an outlined
/// "Switch to …" button. Before any building is chosen, every card gets
/// an outlined "Select …" button.
class _BuildingCard extends StatelessWidget {
  const _BuildingCard({
    required this.building,
    required this.isSelected,
    required this.noneSelected,
    required this.onOpen,
  });

  final Building building;
  final bool isSelected;

  /// True when no building has been chosen yet.
  final bool noneSelected;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final tagColor = isSelected
        ? SinagColors.success
        : switch (building.tierTone) {
            TierTone.normal => SinagColors.navy,
            TierTone.warning => SinagColors.warning,
          };
    return Semantics(
      selected: isSelected,
      // The selected building's card is light blue with a blue border.
      child: Panel(
        tone: isSelected ? PanelTone.lightBlue : PanelTone.white,
        children: [
          PanelTitle(building.name),
          PanelText(building.description),
          Tag(
            isSelected ? 'SELECTED · ${building.tier}' : building.tier,
            color: tagColor,
          ),
          KeyValue(building.detail.$1, building.detail.$2),
          isSelected
              ? PrimaryButton('Open ${building.shortName}', onPressed: onOpen)
              : SecondaryButton(
                  noneSelected
                      ? 'Select ${building.shortName}'
                      : 'Switch to ${building.shortName}',
                  onPressed: onOpen,
                ),
        ],
      ),
    );
  }
}
