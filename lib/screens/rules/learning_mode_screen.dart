import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/routes.dart';
import '../../theme/sinag_theme.dart';
import '../../widgets/sinag_widgets.dart';

/// 23 · Learning mode — Figma frame 97:669
///
/// Run the alert rules silently for a few weeks to see what would have fired,
/// before turning on real notifications.
class LearningModeScreen extends StatefulWidget {
  const LearningModeScreen({super.key});

  @override
  State<LearningModeScreen> createState() => _LearningModeScreenState();
}

class _LearningModeScreenState extends State<LearningModeScreen> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return SinagPage(
      eyebrow: 'EEC OFFICER · CALIBRATION',
      title: 'Learning mode',
      bottomBar: const SinagBottomNav(current: SinagTab.dashboard),
      about: const [
        'While learning mode is on, meter readings continue but no push, SMS '
            'or escalation is sent. The log records the alerts that would '
            'have fired.',
        'At the end of the window, review the rules before turning on live '
            'notifications.',
      ],
      children: [
        Panel(
          tone: PanelTone.info,
          children: [
            const PanelTitle('Learning mode'),
            PanelText(
              _enabled
                  ? 'Observing · notifications paused'
                  : 'Preview state · ready to enable',
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text('Enable learning mode', style: SinagText.button),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => setState(() => _enabled = !_enabled),
                  child: _enabled
                      ? const _ToggleOn()
                      : SvgPicture.asset(
                          'assets/images/toggle_off.svg',
                          width: 48,
                          height: 28,
                        ),
                ),
              ],
            ),
            Note(
              _enabled
                  ? 'ON · Observing 16 Nov–06 Dec 2026'
                  : 'OFF · No current observation session',
              strong: true,
              color: SinagColors.muted,
            ),
          ],
        ),
        const SinagField(
          label: 'Observation window',
          initialValue: '2 weeks   [3 weeks]   4 weeks',
        ),
        const SinagField(
          label: 'Planned dates',
          initialValue: '16 Nov–06 Dec 2026 · 3 weeks',
        ),
        PrimaryButton(
          'Start 3-week learning period',
          onPressed: () {
            setState(() => _enabled = true);
            showSinagSnack(context, 'Learning period started');
          },
        ),
        Panel(
          children: [
            const PanelTitle('Last trial: 2 would-be alerts'),
            const PanelText('19 Oct–01 Nov · completed'),
            SecondaryButton(
              'Review thresholds',
              onPressed: () =>
                  Navigator.of(context).pushNamed(Routes.alertRules),
            ),
            const MoreDetails(
              label: 'See the log',
              children: [
                KeyValue('22 Oct · AC-03', 'Would notify 18:30'),
                Note('2.4 kW · aircon threshold 0.10 kW'),
                KeyValue('26 Oct · LT-02', 'Would escalate 19:00'),
                Note('0.9 kW · no overtime record'),
                KeyValue('29 Oct · IT-01', 'Suppressed · 24/7 load'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// "On" counterpart of the Figma toggle asset (same 48×28 geometry).
class _ToggleOn extends StatelessWidget {
  const _ToggleOn();

  @override
  Widget build(BuildContext context) => Container(
    width: 48,
    height: 28,
    padding: const EdgeInsets.all(3),
    alignment: Alignment.centerRight,
    decoration: BoxDecoration(
      color: SinagColors.navy,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    ),
  );
}
