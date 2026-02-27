import '../../core/base/base_viewmodel.dart';
import '../../core/navigation/app_router.dart';
import '../../core/utils/validators.dart';

/// Login logic only. Validation and navigation here; never in View.
class LoginViewModel extends BaseViewModel {
  String? validateEmail(String? value) => Validators.email(value);
  String? validatePassword(String? value) => Validators.password(value);

  void onLogin(String? email, String? password) {
    clearError();
    final emailError = Validators.email(email);
    final passwordError = Validators.password(password);
    if (emailError != null || passwordError != null) {
      setError(emailError ?? passwordError);
      return;
    }
    setBusy(true);
    // TODO: call auth repository, then navigate via AppRouter
    setBusy(false);
    AppRouter.pushReplacementNamed<void>(AppRoutes.onboarding);
  }
}
