import 'package:flutter/foundation.dart';

/// How a building's monitoring-tier label is coloured when it isn't selected.
enum TierTone { normal, warning }

/// One building in the LGU (demo data from the Figma Buildings screen).
class Building {
  const Building({
    required this.id,
    required this.name,
    required this.shortName,
    required this.label,
    required this.description,
    required this.tier,
    required this.detail,
    this.tierTone = TierTone.normal,
  });

  final String id;

  /// Full name, e.g. "City Hall Complex – Building A".
  final String name;

  /// Shortest name, used on buttons ("Open Building A", "Switch to Annex").
  final String shortName;

  /// Name shown in the top bar and screen labels, e.g. "Annex Building".
  final String label;

  /// e.g. "Main administrative offices".
  final String description;

  /// Monitoring tier label, e.g. "TIER 3 · LIVE METERS".
  final String tier;
  final TierTone tierTone;

  /// (label, value) row shown on its card, e.g. ('Last reading', '12 Nov').
  final (String, String) detail;
}

/// All buildings, in the order they are listed.
const sinagBuildings = [
  Building(
    id: 'a',
    name: 'City Hall Complex – Building A',
    shortName: 'Building A',
    label: 'Building A',
    description: 'Main administrative offices',
    tier: 'TIER 3 · LIVE METERS',
    detail: ('Last reading', '12 Nov · 09:40'),
  ),
  Building(
    id: 'b',
    name: 'City Hall Complex – Building B',
    shortName: 'Building B',
    label: 'Building B',
    description: 'Legislative offices',
    tier: 'TIER 2 · NOVEMBER BILL-ONLY',
    detail: ('Status', 'Meter failed · 10 Nov'),
  ),
  Building(
    id: 'annex',
    name: 'Annex Building',
    shortName: 'Annex',
    label: 'Annex Building',
    description: 'Records and storage',
    tier: 'TIER 1 · BILL-ONLY',
    tierTone: TierTone.warning,
    detail: ('Latest bill', 'October 2026'),
  ),
];

/// The building the user is currently looking at, or null before they have
/// chosen one. After sign-in the user must pick a building on the Buildings
/// screen first; until then the top bar shows "Select building" instead of
/// the dropdown. Widgets that show it (the top bar and the Buildings screen)
/// listen to this and update as soon as it changes.
///
/// Note: the screens' demo data still describes Building A whichever
/// building is selected.
final selectedBuilding = ValueNotifier<Building?>(null);

/// Name for screen labels, e.g. "BUILDING B", or "NO BUILDING SELECTED".
String selectedBuildingTag() =>
    selectedBuilding.value?.label.toUpperCase() ?? 'NO BUILDING SELECTED';
