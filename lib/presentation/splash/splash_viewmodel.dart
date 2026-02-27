import '../../core/base/base_viewmodel.dart';
import '../../core/navigation/app_router.dart';

/// Splash logic only. Startup and navigation here; never in View.
class SplashViewModel extends BaseViewModel {
  /// Waits 3 seconds then navigates to onboarding. Call from View's initState.
  Future<void> initialize() async {
    await Future<void>.delayed(const Duration(seconds: 100));
    await AppRouter.pushReplacementNamed(AppRoutes.onboarding);
  }
}
