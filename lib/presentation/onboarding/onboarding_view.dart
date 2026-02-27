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
  static const double _webMaxWidth = 500;
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
        final content = ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: _isWeb(context) ? _webMaxWidth : double.infinity,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: PageView.builder(
                  controller: widget.viewModel.pageController,
                  itemCount: OnboardingViewModel.pages.length,
                  onPageChanged: widget.viewModel.setCurrentIndex,
                  itemBuilder: (context, index) {
                    final slide = OnboardingViewModel.pages[index];
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.large,
                        ),
                        child: Image.asset(
                          slide.imagePath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 4,
                child: _BottomCard(viewModel: widget.viewModel),
              ),
            ],
          ),
        );

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: _isWeb(context) ? Center(child: content) : content,
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
  static const double _dotHeight = 8;
  static const double _dotBorderRadius = 4;
  static const double _dotActiveWidth = 24;
  static const double _dotInactiveWidth = 8;

  @override
  Widget build(BuildContext context) {
    final slide = OnboardingViewModel.pages[viewModel.currentIndex];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(_cardTopRadius),
          topRight: Radius.circular(_cardTopRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            slide.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.medium),
          Text(
            slide.description,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.large),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(OnboardingViewModel.pages.length, (index) {
              final isActive = index == viewModel.currentIndex;
              return GestureDetector(
                onTap: () => viewModel.setCurrentIndex(index),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isActive ? _dotActiveWidth : _dotInactiveWidth,
                    height: _dotHeight,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(_dotBorderRadius),
                      color: isActive
                          ? AppColors.primary
                          : AppColors.inactiveDot,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.large),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              label: 'Sign Up',
              onPressed: viewModel.onSignUpPressed,
            ),
          ),
          const SizedBox(height: AppSpacing.small),
          TextButton(
            onPressed: viewModel.goToLogin,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
