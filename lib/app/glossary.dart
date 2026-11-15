/// Explanations shown in the ⓘ panels. Kept in one place so every screen
/// explains things the same way.
class Glossary {
  Glossary._();

  /// What the "Measured / Estimated / Computed" labels on numbers mean.
  static const dataLabels = [
    'Measured: read from a meter or a bill.',
    'Estimated: worked out from the equipment inventory (rated watts × hours '
        'used).',
    'Computed: calculated from measured or estimated figures, e.g. cost at '
        '₱11/kWh.',
  ];

  /// SINAG only watches and notifies; it never switches equipment.
  static const noRemoteControl =
      'SINAG never switches equipment on or off. A person checks the unit and '
      'records what they did.';

  static const needsInternet =
      'Live readings need internet. Photos and SMS replies work offline and '
      'sync later.';
}
