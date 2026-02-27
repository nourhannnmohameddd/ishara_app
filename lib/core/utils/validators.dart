/// Centralized validation. Used only by ViewModels; never in Views.
abstract class Validators {
  Validators._();

  /// RFC 5322–style email validation (practical subset).
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return _requiredMessage('Email');
    const pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(pattern).hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  /// Password validation: non-empty, min length 8.
  static String? password(String? value, {int minLength = 8}) {
    if (value == null || value.isEmpty) return _requiredMessage('Password');
    if (value.length < minLength) return 'Password must be at least $minLength characters';
    return null;
  }

  /// Required field (non-empty after trim).
  static String? required(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) return _requiredMessage(fieldName);
    return null;
  }

  static String _requiredMessage(String fieldName) => '$fieldName is required';
}
