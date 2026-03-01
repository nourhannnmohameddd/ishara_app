import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/widgets/app_scaffold.dart';
import 'splash_viewmodel.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key, required this.viewModel});

  final SplashViewModel viewModel;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  static const double _webBreakpoint = 600;
  static const double _largeWebBreakpoint = 1200;

  static const double _logoMaxWidthWeb = 300;
  static const double _logoMaxWidthLargeWeb = 360;

  static const double _contentMaxWidth = 420;

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
          useSafeArea: true, // ✅ Fixed
          body: GestureDetector(
            onTap: () => widget.viewModel.skip(),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  final double imageWidth;
                  if (width < _webBreakpoint) {
                    imageWidth = width * 0.5;
                  } else if (width > _largeWebBreakpoint) {
                    imageWidth = _logoMaxWidthLargeWeb;
                  } else {
                    imageWidth = _logoMaxWidthWeb;
                  }

                  return Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: _contentMaxWidth,
                      ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // ✅ centered
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
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
            ),
          ),
        );
      },
    );
  }
}