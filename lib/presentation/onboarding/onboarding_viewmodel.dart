import 'package:flutter/material.dart';

import '../../core/base/base_viewmodel.dart';
import '../../core/navigation/app_router.dart';
import '../../data/models/onboarding_model.dart';

/// Onboarding logic only. Navigation and state here; never in View.
class OnboardingViewModel extends BaseViewModel {
  OnboardingViewModel() : pageController = PageController(initialPage: 0);

  static const List<OnboardingModel> pages = [
    OnboardingModel(
      title: 'Welcome to Ishara',
      description:
          'Instantly translate Arabic Sign Language into clear speech so you can connect effortlessly with anyone around you',
      imagePath: 'assets/images/onboarding1.jpg',
    ),
    OnboardingModel(
      title: 'Speak Without Barriers',
      description:
          'Our AI-powered recognition makes your hand signs heard — in real-time, accurate, and natural conversations.',
      imagePath: 'assets/images/onboarding2.jpg',
    ),
    OnboardingModel(
      title: 'Smart,Fast and Inclusive',
      description:
          'Video call, chat and communicate confidently anywhere using automatic ArSL translation and voice output.',
      imagePath: 'assets/images/onboarding3.jpg',
    ),
  ];

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

  void onSignUpPressed() {
    if (isLastPage) {
      goToLogin();
    } else {
      nextPage();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
