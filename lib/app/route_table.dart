import 'package:flutter/widgets.dart';

// One file per screen, in folders by area (see README).
import '../screens/access/buildings_screen.dart';
import '../screens/access/my_access_screen.dart';
import '../screens/access/sign_in_screen.dart';
import '../screens/access/verify_screen.dart';
import '../screens/alerts/alert_detail_screen.dart';
import '../screens/alerts/alerts_screen.dart';
import '../screens/alerts/close_alert_screen.dart';
import '../screens/alerts/notify_screen.dart';
import '../screens/alerts/resolved_alerts_screen.dart';
import '../screens/appliances/appliance_detail_screen.dart';
import '../screens/appliances/appliances_screen.dart';
import '../screens/bills/review_bill_screen.dart';
import '../screens/bills/scan_bill_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/eec_tools/data_review_screen.dart';
import '../screens/eec_tools/meters_screen.dart';
import '../screens/eec_tools/morning_summary_screen.dart';
import '../screens/eec_tools/report_meter_fault_screen.dart';
import '../screens/eec_tools/reports_screen.dart';
import '../screens/management/activity_log_screen.dart';
import '../screens/management/inventory_screen.dart';
import '../screens/management/operating_changes_screen.dart';
import '../screens/management/sharing_screen.dart';
import '../screens/rules/alert_rules_screen.dart';
import '../screens/rules/learning_mode_screen.dart';
import '../screens/rules/overtime_events_screen.dart';
import '../screens/rules/work_calendar_screen.dart';
import '../screens/summaries/doe_dilg_summary_screen.dart';
import '../screens/summaries/leadership_summary_screen.dart';
import '../screens/workspaces/facility_workspace_screen.dart';
import '../screens/workspaces/focal_workspace_screen.dart';
import 'routes.dart';

/// Which screen each route opens. Route names live in routes.dart.
final Map<String, WidgetBuilder> sinagRoutes = {
  // Access (sign-in flow)
  Routes.signIn: (_) => const SignInScreen(), // 01
  Routes.verify: (_) => const VerifyScreen(), // 02
  Routes.myAccess: (_) => const MyAccessScreen(), // 03
  Routes.buildings: (_) => const BuildingsScreen(), // 04
  // Home
  Routes.dashboard: (_) => const DashboardScreen(), // 05
  // Bills
  Routes.scanBill: (_) => const ScanBillScreen(), // 06
  Routes.reviewBill: (_) => const ReviewBillScreen(), // 07
  // Live load
  Routes.appliances: (_) => const AppliancesScreen(), // 08
  Routes.applianceDetail: (_) => const ApplianceDetailScreen(), // 09
  // After-hours alerts
  Routes.notify: (_) => const NotifyScreen(), // 10
  Routes.alerts: (_) => const AlertsScreen(), // 11
  Routes.alertDetail: (_) => const AlertDetailScreen(), // 12
  Routes.closeAlert: (_) => const CloseAlertScreen(), // 13
  // Rules
  Routes.alertRules: (_) => const AlertRulesScreen(), // 14
  Routes.workCalendar: (_) => const WorkCalendarScreen(), // 15
  Routes.overtimeEvents: (_) => const OvertimeEventsScreen(), // 16
  // Role workspaces
  Routes.focalWorkspace: (_) => const FocalWorkspaceScreen(), // 17
  Routes.facilityWorkspace: (_) => const FacilityWorkspaceScreen(), // 18
  // EEC Officer tools
  Routes.reports: (_) => const ReportsScreen(), // 19
  Routes.meters: (_) => const MetersScreen(), // 20
  Routes.reportMeterFault: (_) => const ReportMeterFaultScreen(), // 21
  Routes.dataReview: (_) => const DataReviewScreen(), // 22
  Routes.learningMode: (_) => const LearningModeScreen(), // 23
  Routes.morningSummary: (_) => const MorningSummaryScreen(), // 24
  // Management
  Routes.inventory: (_) => const InventoryScreen(), // 25
  Routes.operatingChanges: (_) => const OperatingChangesScreen(), // 26
  Routes.sharing: (_) => const SharingScreen(), // 27
  Routes.activityLog: (_) => const ActivityLogScreen(), // 28
  // Read-only views
  Routes.leadershipSummary: (_) => const LeadershipSummaryScreen(), // 29
  Routes.doeDilgSummary: (_) => const DoeDilgSummaryScreen(), // 30
  Routes.resolvedAlerts: (_) => const ResolvedAlertsScreen(), // 31
};
