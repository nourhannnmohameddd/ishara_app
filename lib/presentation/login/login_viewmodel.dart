import '../../core/base/base_viewmodel.dart';
import '../../core/navigation/app_router.dart';
import '../../core/utils/validators.dart';

/// Login logic only. Validation and navigation here; never in View.
class LoginViewModel extends BaseViewModel {
  String? _emailError;
  String? get emailError => _emailError;

  String? _passwordError;
  String? get passwordError => _passwordError;

  void login(String? email, String? password) {
    _emailError = Validators.email(email);
    _passwordError = Validators.password(password);
    notifyListeners();
    if (_emailError != null || _passwordError != null) return;

    setBusy(true);
    // TODO: call auth repository, then navigate via AppRouter
    setBusy(false);
    AppRouter.pushReplacementNamed(AppRoutes.dashboard);
  }

  void clearEmailError() {
    if (_emailError == null) return;
    _emailError = null;
    notifyListeners();
  }

  void clearPasswordError() {
    if (_passwordError == null) return;
    _passwordError = null;
    notifyListeners();
  }

  void mapsToResetPassword() {
    AppRouter.pushNamed(AppRoutes.resetPassword);
  }

  void signInWithApple() {
    // TODO: sign in with Apple
  }

  void signInWithGoogle() {
    // TODO: sign in with Google
  }

  void signInWithFacebook() {
    // TODO: sign in with Facebook
  }
}
