import 'package:flutter/material.dart';

import '../../core/widgets/app_scaffold.dart';
import 'dashboard_viewmodel.dart';

/// Dashboard screen. Minimal structure; back to Login only.
class DashboardView extends StatelessWidget {
  const DashboardView({super.key, required this.viewModel});

  final DashboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return AppScaffold(
          title: 'Dashboard',
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: viewModel.goBackToLogin,
          ),
          body: const SizedBox.shrink(),
        );
      },
    );
  }
}
