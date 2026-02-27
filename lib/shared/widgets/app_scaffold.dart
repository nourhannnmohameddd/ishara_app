import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

/// Base scaffold with consistent padding and theme. Uses [AppTheme] via [Theme.of] and [AppSpacing].
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.title,
    this.body,
    this.appBar,
    this.floatingActionButton,
  });

  final String? title;
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? (title != null ? AppBar(title: Text(title!)) : null),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: body ?? const SizedBox.shrink(),
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
