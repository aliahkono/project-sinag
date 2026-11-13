import 'package:flutter/material.dart';

import 'app/routes.dart';
import 'screens/access_screens.dart';
import 'screens/alert_screens.dart';
import 'screens/appliance_screens.dart';
import 'screens/bill_screens.dart';
import 'screens/dashboard_screens.dart';
import 'screens/data_screens.dart';
import 'screens/management_screens.dart';
import 'screens/rules_screens.dart';
import 'screens/workspace_screens.dart';
import 'theme/sinag_theme.dart';

void main() => runApp(const SinagApp());

/// Every screen from the Figma "revised" page, keyed by route.
final Map<String, WidgetBuilder> sinagRoutes = {
  Routes.signIn: (_) => const SignInScreen(),
  Routes.verify: (_) => const VerifyScreen(),
  Routes.myAccess: (_) => const MyAccessScreen(),
  Routes.buildings: (_) => const BuildingsScreen(),
  Routes.dashboard: (_) => const DashboardScreen(),
  Routes.scanBill: (_) => const ScanBillScreen(),
  Routes.reviewBill: (_) => const ReviewBillScreen(),
  Routes.appliances: (_) => const AppliancesScreen(),
  Routes.applianceDetail: (_) => const ApplianceDetailScreen(),
  Routes.notify: (_) => const NotifyScreen(),
  Routes.alerts: (_) => const AlertsScreen(),
  Routes.alertDetail: (_) => const AlertDetailScreen(),
  Routes.closeAlert: (_) => const CloseAlertScreen(),
  Routes.alertRules: (_) => const AlertRulesScreen(),
  Routes.workCalendar: (_) => const WorkCalendarScreen(),
  Routes.overtimeEvents: (_) => const OvertimeEventsScreen(),
  Routes.focalWorkspace: (_) => const FocalWorkspaceScreen(),
  Routes.facilityWorkspace: (_) => const FacilityWorkspaceScreen(),
  Routes.reports: (_) => const ReportsScreen(),
  Routes.meters: (_) => const MetersScreen(),
  Routes.reportMeterFault: (_) => const ReportMeterFaultScreen(),
  Routes.dataReview: (_) => const DataReviewScreen(),
  Routes.learningMode: (_) => const LearningModeScreen(),
  Routes.morningSummary: (_) => const MorningSummaryScreen(),
  Routes.inventory: (_) => const InventoryScreen(),
  Routes.operatingChanges: (_) => const OperatingChangesScreen(),
  Routes.sharing: (_) => const SharingScreen(),
  Routes.activityLog: (_) => const ActivityLogScreen(),
  Routes.leadershipSummary: (_) => const LeadershipSummaryScreen(),
  Routes.doeDilgSummary: (_) => const DoeDilgSummaryScreen(),
  Routes.resolvedAlerts: (_) => const ResolvedAlertsScreen(),
};

class SinagApp extends StatelessWidget {
  const SinagApp({super.key, this.initialRoute = Routes.signIn});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SINAG',
      debugShowCheckedModeBanner: false,
      theme: buildSinagTheme(),
      initialRoute: initialRoute,
      routes: sinagRoutes,
    );
  }
}
