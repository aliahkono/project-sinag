import 'routes.dart';

/// The roles that see their own bottom bar.
enum SinagRole {
  /// Dashboard · Scanner · Reports
  eecOfficer,

  /// Bills · Review · Alerts
  focalPerson,

  /// Alerts · Appliances
  facilityManager,
}

/// Which role the user is currently working as.
///
/// Each role's home screens tell [SinagPage] their role (e.g. the Dashboard
/// is the EEC Officer's, Focal workspace is the focal person's). Screens
/// shared by several roles — Alerts, Appliances and their detail screens —
/// read this to show the matching bottom bar.
class SinagSession {
  SinagSession._();

  static SinagRole role = SinagRole.eecOfficer;

  /// The current role's main screen. Opened after switching building.
  static String get homeRoute => switch (role) {
    SinagRole.eecOfficer => Routes.dashboard,
    SinagRole.focalPerson => Routes.focalWorkspace,
    SinagRole.facilityManager => Routes.facilityWorkspace,
  };
}

/// Focal person's bottom bar: (label, route) per tab.
const focalNav = [
  ('Bills', Routes.scanBill),
  ('Review', Routes.reviewBill),
  ('Alerts', Routes.alerts),
];

/// Facility manager's bottom bar: (label, route) per tab.
const facilityNav = [
  ('Alerts', Routes.alerts),
  ('Appliances', Routes.appliances),
];
