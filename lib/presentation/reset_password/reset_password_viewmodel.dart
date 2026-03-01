import '../../core/base/base_viewmodel.dart';
import '../../core/navigation/app_router.dart';
import '../../core/utils/validators.dart';

/// Reset password logic only. Validation and navigation here; never in View.
class ResetPasswordViewModel extends BaseViewModel {
  String? _emailError;
  String? get emailError => _emailError;

  void onContinuePressed(String? email) {
    _emailError = Validators.email(email);
    notifyListeners();
    if (_emailError != null) return;
    setBusy(true);
    // TODO: call auth repository, then navigate via AppRouter
    setBusy(false);
    AppRouter.pop();
  }

  void clearEmailError() {
    if (_emailError == null) return;
    _emailError = null;
    notifyListeners();
  }

  void onBackPressed() {
    AppRouter.pop();
  }
}
