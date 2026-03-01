import 'package:flutter/material.dart';

import '../constants/app_spacing.dart';

/// Base scaffold with consistent padding and theme. Uses [AppTheme] via [Theme.of] and [AppSpacing].
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.title,
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.bodyPadding,
    this.useSafeArea = true,
  });

  final String? title;
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  /// When null, uses [AppSpacing.medium] on all sides. Use [EdgeInsets.zero] for full-bleed (e.g. splash).
  final EdgeInsets? bodyPadding;
  /// When false, body is not wrapped in [SafeArea]. Use for full-screen layouts (e.g. splash).
  final bool useSafeArea;

  @override
  Widget build(BuildContext context) {
    final padding = bodyPadding ?? const EdgeInsets.all(AppSpacing.medium);
    final bodyContent = Padding(
      padding: padding,
      child: body ?? const SizedBox.shrink(),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar ??
          (title != null
              ? AppBar(
                  title: Text(title!),
                  backgroundColor: Colors.white,
                )
              : null),
      body: useSafeArea
          ? SafeArea(child: bodyContent)
          : bodyContent,
      floatingActionButton: floatingActionButton,
    );
  }
}
