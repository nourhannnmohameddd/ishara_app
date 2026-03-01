import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/widgets/widgets.dart';
import 'onboarding_viewmodel.dart';

/// Onboarding screens. UI only; no validation or navigation.
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key, required this.viewModel});

  final OnboardingViewModel viewModel;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  static const double _maxContentWidth = 420;
  static const double _imageHeightFraction = 0.6;
  static const double _cardHeightFraction = 0.4;
  static const double _cardOverlapOffset = 24;
  static const double _webBreakpoint = 600;

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  bool _isWeb(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= _webBreakpoint;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: LayoutBuilder(
            builder: (context, constraints) {
              final contentWidth = _isWeb(context)
                  ? _maxContentWidth
                  : constraints.maxWidth;
              final contentHeight = constraints.maxHeight;
              final imageHeight = contentHeight * _imageHeightFraction;
              //final cardHeight = contentHeight * _cardHeightFraction;

              final stack = Stack(
                clipBehavior: Clip.none,
                children: [
                  // Image first (bottom layer).
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: imageHeight,
                    child: PageView.builder(
                      controller: widget.viewModel.pageController,
                      itemCount: OnboardingViewModel.pages.length,
                      onPageChanged: widget.viewModel.setCurrentIndex,
                      itemBuilder: (context, index) {
                        final slide =
                            OnboardingViewModel.pages[index];
                        return Image.asset(
                          slide.imagePath,
                          fit: BoxFit.cover,
                          width: contentWidth,
                          height: imageHeight,
                        );
                      },
                    ),
                  ),
                  // BottomCard second so it renders on top of the image.
                  Positioned(
                    top: imageHeight - _cardOverlapOffset,
                    left: 0,
                    right: 0,
                    bottom: 0,

                    child: _BottomCard(viewModel: widget.viewModel),
                  ),
                ],
              );

              final content = SizedBox(
                width: contentWidth,
                height: contentHeight,
                child: stack,
              );

              return _isWeb(context)
                  ? Center(child: content)
                  : content;
            },
          ),
        );
      },
    );
  }
}

class _BottomCard extends StatelessWidget {
  const _BottomCard({required this.viewModel});

  final OnboardingViewModel viewModel;

  static const double _cardTopRadius = 32;
  static const double _cardPaddingHorizontal = 24;
  static const double _cardPaddingVertical = 28; // slightly refined

  static const double _dotActiveWidth = 24;
  static const double _dotActiveHeight = 6;
  static const double _dotActiveRadius = 3;
  static const double _dotInactiveSize = 6;

  @override
  Widget build(BuildContext context) {
    final slide = OnboardingViewModel.pages[viewModel.currentIndex];

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(_cardTopRadius),
          topRight: Radius.circular(_cardTopRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: _cardPaddingHorizontal,
        vertical: _cardPaddingVertical,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// 🔹 TEXT AREA (natural height)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          slide.title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.headlineLarge,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          slide.description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.bodyLarge,
                        ),
                      ],
                    ),
                    /// 🔹 Minimum space + flexible gap before dots
                    const SizedBox(height: 24),
                    const Spacer(),
                    /// 🔹 DOTS (minimum spacing above)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          OnboardingViewModel.pages.length,
                          (index) {
                            final isActive = index == viewModel.currentIndex;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: isActive
                                    ? _dotActiveWidth
                                    : _dotInactiveSize,
                                height: isActive
                                    ? _dotActiveHeight
                                    : _dotInactiveSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    isActive
                                        ? _dotActiveRadius
                                        : _dotInactiveSize / 2,
                                  ),
                                  color: isActive
                                      ? AppColors.primary
                                      : AppColors.inactiveDot,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    /// 🔹 SIGN UP
                    PrimaryButton(
                      label: 'Sign Up',
                      onPressed: viewModel.onSignUpPressed,
                    ),
                    const SizedBox(height: 8),
                    /// 🔹 LOGIN
                    _HoverLoginButton(
                      onPressed: viewModel.goToLogin,
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
/// 🔹 Separate widget for hover behavior (View layer only)
class _HoverLoginButton extends StatefulWidget {
  const _HoverLoginButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_HoverLoginButton> createState() => _HoverLoginButtonState();
}

class _HoverLoginButtonState extends State<_HoverLoginButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: widget.onPressed,
          child: Text(
            'Login',
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}