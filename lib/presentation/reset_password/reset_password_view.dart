import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../shared/widgets/widgets.dart';
import 'reset_password_viewmodel.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key, required this.viewModel});

  final ResetPasswordViewModel viewModel;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return AppScaffold(
          title: null,
          bodyPadding: EdgeInsets.zero,
          useSafeArea: true,
          body: Container(
            color: Colors.white,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.medium,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                            /// 🔹 Top spacing
                            const SizedBox(height: AppSpacing.large),

                            /// 🔹 Arrow + Title in same row
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  onPressed:
                                      widget.viewModel.onBackPressed,
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),

                                const SizedBox(width: AppSpacing.small),

                                Expanded(
                                  child: Text(
                                    'Reset your Password',
                                    style: AppTextStyles.headlineLarge.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: AppSpacing.medium),

                            /// 🔹 Description
                            Text(
                              'Please enter your email and we will send you an OTP code in the next step to reset your password.',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.text,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.xl),

                            /// 🔹 Email Label
                            Text(
                              'Email address',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.text,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.small),

                            /// 🔹 Email Field
                            CustomTextField(
                              controller: _emailController,
                              label: null,
                              keyboardType:
                                  TextInputType.emailAddress,
                              onChanged: (_) =>
                                  widget.viewModel.clearEmailError(),
                              errorText:
                                  widget.viewModel.emailError,
                            ),

                            /// 🔹 Push button to bottom
                            const Spacer(),

                            /// 🔹 Continue Button
                            PrimaryButton(
                              label: 'Continue',
                              isLoading:
                                  widget.viewModel.isBusy,
                              onPressed: () =>
                                  widget.viewModel.onContinuePressed(
                                _emailController.text,
                              ),
                            ),

                            const SizedBox(height: AppSpacing.xl),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}