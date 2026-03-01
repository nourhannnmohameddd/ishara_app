import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../shared/widgets/widgets.dart';
import 'login_viewmodel.dart';

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
          title: 'Login',
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
                label: 'Password',
                obscureText: true,
                onChanged: (_) => widget.viewModel.clearError(),
                errorText: null,
              ),
              SizedBox(height: AppSpacing.medium),
              PrimaryButton(
                label: 'Login',
                isLoading: widget.viewModel.isBusy,
                onPressed: () => widget.viewModel.onLogin(
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
