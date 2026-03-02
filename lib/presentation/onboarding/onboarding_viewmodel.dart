import 'package:flutter/material.dart';

import '../../core/base/base_viewmodel.dart';
import '../../core/navigation/app_router.dart';
import '../../data/datasources/local/onboarding_data.dart';
import '../../data/models/onboarding_model.dart';

/// Onboarding logic only. Navigation and state here; never in View.
class OnboardingViewModel extends BaseViewModel {
  OnboardingViewModel() : pageController = PageController(initialPage: 0);

  static final List<OnboardingModel> pages =
      OnboardingLocalDataSource.getOnboardingPages();

  final PageController pageController;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  bool get isLastPage => _currentIndex >= pages.length - 1;

  void setCurrentIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    if (pageController.hasClients &&
        (pageController.page?.round() ?? -1) != index) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    notifyListeners();
  }

  void goToPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void nextPage() {
    if (_currentIndex >= pages.length - 1) return;
    _currentIndex++;
    if (pageController.hasClients) {
      pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
