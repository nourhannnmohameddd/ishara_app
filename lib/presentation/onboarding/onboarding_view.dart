import 'package:flutter/material.dart';

import '../../shared/widgets/widgets.dart';
import 'onboarding_viewmodel.dart';

/// Onboarding screen. UI only; no validation or navigation. All logic in [OnboardingViewModel].
class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key, required this.viewModel});

  final OnboardingViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return AppScaffold(
          title: 'Onboarding',
          body: Center(child: Text('Onboarding')),
        );
      },
    );
  }
}
