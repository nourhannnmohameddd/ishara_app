import '../../core/base/base_viewmodel.dart';
import '../../core/navigation/app_router.dart';
import '../../data/models/onboarding_model.dart';

/// Onboarding logic only. Navigation here; never in View.
class OnboardingViewModel extends BaseViewModel {
  List<OnboardingModel> get slides => _slides;
  final List<OnboardingModel> _slides = const [];

  void onNext() {
    // TODO: advance page or AppRouter.pushReplacementNamed(AppRoutes.login);
  }
}
