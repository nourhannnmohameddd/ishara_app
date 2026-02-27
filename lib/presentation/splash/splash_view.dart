import 'package:flutter/material.dart';

import '../../shared/widgets/widgets.dart';
import 'splash_viewmodel.dart';

/// Splash screen. UI only; no validation or navigation.
class SplashView extends StatelessWidget {
  const SplashView({super.key, required this.viewModel});

  final SplashViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return AppScaffold(
          body: Center(child: Text('Splash')),
        );
      },
    );
  }
}
