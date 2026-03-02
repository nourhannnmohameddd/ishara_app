import 'package:flutter/material.dart';

import '../../core/widgets/app_scaffold.dart';
import 'signup_viewmodel.dart';

/// Sign-up screen. UI only; no validation or navigation. All logic in [SignUpViewModel].
class SignUpView extends StatelessWidget {
  const SignUpView({super.key, required this.viewModel});

  final SignUpViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return AppScaffold(
          title: 'Create Account',
          body: Center(
            child: Text('Sign Up Screen Placeholder'),
          ),
        );
      },
    );
  }
}
