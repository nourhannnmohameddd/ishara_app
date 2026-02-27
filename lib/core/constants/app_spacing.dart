/// 8px-based spacing grid. Use in layout and shared widgets.
abstract class AppSpacing {
  AppSpacing._();

  static const double base = 8.0;

  static const double xs = 4.0;   // 0.5 * base
  static const double small = 8.0;  // 1 * base
  static const double medium = 16.0; // 2 * base
  static const double large = 24.0; // 3 * base
  static const double xl = 32.0;    // 4 * base
}
