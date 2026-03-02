import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../shared/widgets/widgets.dart';
import 'login_viewmodel.dart';
import 'widgets/section_divider.dart';
import 'widgets/social_auth_row.dart';

/// Login screen. UI only; no validation or navigation. All logic in [LoginViewModel].
class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        return AppScaffold(
          title: null,
          bodyPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                            const SizedBox(height: AppSpacing.xxxl),
                            Text(
                              'Login',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.headlineLarge.copyWith(color: AppColors.primary),
                            ),
                            const SizedBox(height: AppSpacing.small),
                            Text(
                              'Enter your email and password',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.text),
                            ),
                            const SizedBox(height: AppSpacing.xxl),
                            CustomTextField(
                              controller: _emailController,
                              label: 'Enter your email address',
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (_) => widget.viewModel.clearEmailError(),
                              errorText: widget.viewModel.emailError,
                            ),
                            const SizedBox(height: AppSpacing.medium),
                            CustomTextField(
                              controller: _passwordController,
                              label: 'Enter your password',
                              obscureText: true,
                              onChanged: (_) => widget.viewModel.clearPasswordError(),
                              errorText: widget.viewModel.passwordError,
                            ),
                            const SizedBox(height: AppSpacing.small),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () => widget.viewModel.mapsToResetPassword(),
                                child: Text(
                                  'Forget password?',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.primary,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xxl),
                            const SectionDivider(),
                            const SizedBox(height: AppSpacing.large),
                            SocialAuthRow(
                            onApplePressed: () => widget.viewModel.signInWithApple(),
                            onGooglePressed: () => widget.viewModel.signInWithGoogle(),
                            onFacebookPressed: () => widget.viewModel.signInWithFacebook(),
                            ),
                            const Spacer(),
                            PrimaryButton(
                              label: 'Continue',
                              isLoading: widget.viewModel.isBusy,
                              onPressed: () => widget.viewModel.login(
                                _emailController.text,
                                _passwordController.text,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xl),
                          ],
                            ),
                          ),
                        ),
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
