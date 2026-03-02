import '../../core/base/base_viewmodel.dart';
import '../../core/navigation/app_router.dart';
import '../../data/datasources/local/onboarding_data.dart';
import '../../data/models/onboarding_model.dart';

/// Onboarding logic only. Navigation and state here; never in View.
/// PageController is owned by the View; this ViewModel only holds currentIndex.
class OnboardingViewModel extends BaseViewModel {
  static final List<OnboardingModel> pages =
      OnboardingLocalDataSource.getOnboardingPages();

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  bool get isLastPage => _currentIndex >= pages.length - 1;

  void setCurrentIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }

  void goToPage(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (_currentIndex >= pages.length - 1) return;
    _currentIndex++;
    notifyListeners();
  }

  void goToLogin() {
    AppRouter.pushReplacementNamed(AppRoutes.login);
  }

  void goToSplash() {
    AppRouter.pushReplacementNamed(AppRoutes.splash);
  }

  void mapsToSignUp() {
    AppRouter.pushNamed(AppRoutes.signUp);
  }
}
