import '../../core/base/base_viewmodel.dart';
import '../../core/navigation/app_router.dart';

/// Splash logic only. Startup and navigation here; never in View.
class SplashViewModel extends BaseViewModel {
  void onReady() {
    // TODO: check auth/prefs, then navigate via AppRouter (e.g. AppRouter.pushReplacementNamed(AppRoutes.login));
  }
}
