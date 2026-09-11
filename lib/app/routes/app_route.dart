/// Route names for the whole app.
///
/// The path expresses the hierarchy: anything under `/main` is pushed above
/// the shell, and the segment after it names the tab it belongs to. So
/// `/main/medicines/form` reads as "the medicine form, opened from the
/// medicines tab, on top of the shell".
///
/// The four tabs have no routes of their own — they are rendered inside the
/// shell's `LazyIndexedStack`, not navigated to.
abstract class AppRoute {
  const AppRoute._();

  // ─── Entry ──────────────────────────────────────────────
  static const String splash = '/splash';
  static const String login = '/login';

  // ─── Shell — owns the app bar, bottom nav and the four tabs ─
  static const String main = '/main';

  // ─── Pushed above the shell ─────────────────────────────
  static const String medicineForm = '$main/medicines/form';
  static const String medicineDetail = '$main/medicines/detail';

  static const String saleForm = '$main/sales/form';
  static const String saleDetail = '$main/sales/detail';

  static const String inventoryForm = '$main/inventory/stock';
}