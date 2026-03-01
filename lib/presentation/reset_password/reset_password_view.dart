import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../shared/widgets/widgets.dart';
import 'reset_password_viewmodel.dart';

/// Reset password screen. UI only; no validation or navigation. All logic in [ResetPasswordViewModel].
class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key, required this.viewModel});

  final ResetPasswordViewModel viewModel;

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
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
          title: 'Reset Password',
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.viewModel.errorMessage != null)
                Text(widget.viewModel.errorMessage!),
              CustomTextField(
                controller: _emailController,
                label: 'Email',
                onChanged: (_) => widget.viewModel.clearError(),
                errorText: null,
              ),
              CustomTextField(
                controller: _passwordController,
                label: 'New Password',
                obscureText: true,
                onChanged: (_) => widget.viewModel.clearError(),
                errorText: null,
              ),
              SizedBox(height: AppSpacing.medium),
              PrimaryButton(
                label: 'Submit',
                isLoading: widget.viewModel.isBusy,
                onPressed: () => widget.viewModel.onSubmit(
                  _emailController.text,
                  _passwordController.text,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
