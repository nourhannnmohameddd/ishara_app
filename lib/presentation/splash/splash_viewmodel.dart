import '../../core/base/base_viewmodel.dart';
import '../../core/navigation/app_router.dart';

/// Splash logic only. Startup and navigation here; never in View.
class SplashViewModel extends BaseViewModel {
  /// Waits then navigates to onboarding. Call from View's initState.
  Future<void> initialize() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    await AppRouter.pushReplacementNamed(AppRoutes.onboarding);
  }

  /// Tap-to-skip: navigate to onboarding immediately.
  void skip() {
    AppRouter.pushReplacementNamed(AppRoutes.onboarding);
  }
}
