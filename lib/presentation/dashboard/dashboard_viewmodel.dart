import '../../core/base/base_viewmodel.dart';
import '../../core/navigation/app_router.dart';

/// Dashboard logic only. Navigation here; never in View.
class DashboardViewModel extends BaseViewModel {
  void goBackToLogin() {
    AppRouter.pushNamedAndRemoveUntil(
      AppRoutes.login,
      (route) => false,
    );
  }
}
