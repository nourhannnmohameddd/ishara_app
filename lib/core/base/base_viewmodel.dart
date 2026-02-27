import 'package:flutter/foundation.dart';

/// Base for all ViewModels. Logic only; no UI.
/// Views listen via ChangeNotifier. No validation or navigation in Views.
abstract class BaseViewModel extends ChangeNotifier {
  bool _isBusy = false;
  bool get isBusy => _isBusy;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setBusy(bool value) {
    if (_isBusy == value) return;
    _isBusy = value;
    notifyListeners();
  }

  void setError(String? message) {
    if (_errorMessage == message) return;
    _errorMessage = message;
    notifyListeners();
  }

  void clearError() {
    if (_errorMessage == null) return;
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _errorMessage = null;
    super.dispose();
  }
}
