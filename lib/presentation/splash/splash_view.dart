import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/widgets/app_scaffold.dart';
import 'splash_viewmodel.dart';

/// Splash screen. UI only; no validation or navigation.
class SplashView extends StatefulWidget {
  const SplashView({super.key, required this.viewModel});

  final SplashViewModel viewModel;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  static const double _logoWidthFraction = 0.35;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return AppScaffold(
          bodyPadding: EdgeInsets.zero,
          useSafeArea: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              final imageWidth = constraints.maxWidth * _logoWidthFraction;
              return Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: imageWidth,
                        child: Image.asset(
                          'assets/images/logoT.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.large),
                      Text(
                        'Making Every\nConversation Possible',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
