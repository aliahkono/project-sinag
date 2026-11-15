import 'package:flutter/material.dart';

import '../../app/buildings.dart';
import '../../app/roles.dart';
import '../../app/routes.dart';
import '../../widgets/sinag_widgets.dart';

/// 03 · My access — Figma frame 97:82
///
/// Shows the role the LGU assigned to this account and what each role can
/// see. "Continue as EEC Officer" opens 04 · Buildings to choose a building
/// first (or 05 · Dashboard if one is already chosen); "Select building"
/// opens 04 · Buildings.
///
/// Layout, top to bottom:
///   1. "Your assigned access" card
///   2. "Continue as EEC Officer" (main)
///   3. "What each role can see" table (tap a row to preview that role)
///   4. "Permissions are assigned" info card
///   5. "Select building"
class MyAccessScreen extends StatelessWidget {
  const MyAccessScreen({super.key});

  /// Rows of the "What each role can see" card:
  /// (role, what it can see, screen that previews it).
  static const _roles = [
    ('Focal person', 'Scan · review · follow up', Routes.focalWorkspace),
    ('Facility manager', 'Alerts · appliances', Routes.facilityWorkspace),
    ('EEC Officer', 'Everything + rules / reports', Routes.dashboard),
    (
      'Mayor / department head',
      'Summary · rankings only',
      Routes.leadershipSummary,
    ),
    ('DOE / DILG', 'Read-only if LGU allows', Routes.doeDilgSummary),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);

    return SinagPage(
      header: SinagHeader.auth,
      eyebrow: 'ACCESS & PERMISSIONS',
      title: 'My access',
      children: [
        // 1. Assigned role
        const Panel(
          children: [
            PanelTitle('Your assigned access'),
            PanelText('City Hall Complex · LGU account'),
            Tag('EEC OFFICER · FULL BUILDING ACCESS'),
            BodyText(
              'All monitoring, alerts, alert rules, data review and report '
              'exports.',
              strong: true,
            ),
          ],
        ),

        // 2. Main action: start the app (clears the sign-in screens)
        PrimaryButton(
          'Continue as EEC Officer',
          onPressed: () {
            SinagSession.role = SinagRole.eecOfficer;
            // A building must be chosen first: show all buildings. Once one
            // is chosen, go straight to the Dashboard.
            if (selectedBuilding.value == null) {
              nav.pushNamed(Routes.buildings);
            } else {
              nav.pushNamedAndRemoveUntil(Routes.dashboard, (_) => false);
            }
          },
        ),

        // 3. Role table
        Panel(
          children: [
            const PanelTitle('What each role can see'),
            for (final (role, access, route) in _roles)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => nav.pushNamed(route),
                child: KeyValue(role, access),
              ),
          ],
        ),

        // 4. Info
        const Panel(
          tone: PanelTone.info,
          children: [
            PanelTitle('Permissions are assigned'),
            PanelText(
              'Contact your LGU administrator to change your role. External '
              'access is off until the LGU grants it.',
            ),
          ],
        ),

        // 5. Pick a building first
        SecondaryButton(
          'Select building',
          onPressed: () => nav.pushNamed(Routes.buildings),
        ),
      ],
    );
  }
}
