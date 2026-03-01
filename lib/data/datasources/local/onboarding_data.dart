import '../../models/onboarding_model.dart';

/// Local onboarding content. ViewModels and UI must not hardcode slide data.
class OnboardingLocalDataSource {
  OnboardingLocalDataSource._();

  static List<OnboardingModel> getOnboardingPages() {
    return [
      const OnboardingModel(
        title: 'Welcome to Ishara',
        description:
            'Instantly translate Arabic Sign Language into clear speech so you can connect effortlessly with anyone around you',
        imagePath: 'assets/images/onboarding1.jpg',
      ),
      const OnboardingModel(
        title: 'Speak Without Barriers',
        description:
            'Our AI-powered recognition makes your hand signs heard — in real-time, accurate, and natural conversations.',
        imagePath: 'assets/images/onboarding2.jpg',
      ),
      const OnboardingModel(
        title: 'Smart, Fast and Inclusive',
        description:
            'Video call, chat and communicate confidently anywhere using automatic ArSL translation and voice output.',
        imagePath: 'assets/images/onboarding3.jpg',
      ),
    ];
  }
}
