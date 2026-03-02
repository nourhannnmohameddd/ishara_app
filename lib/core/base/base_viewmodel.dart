import 'package:flutter/foundation.dart';

/// View state for loading and error handling.
enum ViewState {
  idle,
  loading,
  error,
}

/// Base for all ViewModels. Logic only; no UI.
/// Views listen via ChangeNotifier. No validation or navigation in Views.
abstract class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  String? _errorMessage;

  ViewState get state => _state;
  bool get isLoading => _state == ViewState.loading;
  bool get hasError => _state == ViewState.error;
  String? get errorMessage => _errorMessage;

  /// For backward compatibility with views that use [isBusy].
  bool get isBusy => isLoading;

  void setState(ViewState newState) {
    if (_state == newState) return;
    _state = newState;
    notifyListeners();
  }

  void setBusy(bool value) {
    final newState = value ? ViewState.loading : ViewState.idle;
    if (_state == newState) return;
    _state = newState;
    notifyListeners();
  }

  void setError(String message) {
    _errorMessage = message;
    _state = ViewState.error;
    notifyListeners();
  }

  void clearError() {
    if (_errorMessage == null) return;
    _errorMessage = null;
    _state = ViewState.idle;
    notifyListeners();
  }

  @override
  void dispose() {
    _errorMessage = null;
    super.dispose();
  }
}
