import 'package:flutter/material.dart';

import '../../presentation/login/login_view.dart';
import '../../presentation/login/login_viewmodel.dart';
import '../../presentation/onboarding/onboarding_view.dart';
import '../../presentation/onboarding/onboarding_viewmodel.dart';
import '../../presentation/reset_password/reset_password_view.dart';
import '../../presentation/reset_password/reset_password_viewmodel.dart';
import '../../presentation/splash/splash_view.dart';
import '../../presentation/splash/splash_viewmodel.dart';

/// Route names. Navigation is performed only from ViewModels via [AppRouter].
abstract class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String resetPassword = '/reset-password';
}

/// Central navigation. ViewModels use this; Views must not navigate.
class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState? get _navigator => navigatorKey.currentState;

  static Future<void> pushNamed(String routeName, {Object? arguments}) async {
    await (_navigator?.pushNamed(routeName, arguments: arguments) ?? Future.value());
  }

  static Future<void> pushReplacementNamed(String routeName, {Object? arguments, Object? result}) async {
    await (_navigator?.pushReplacementNamed(routeName, arguments: arguments, result: result) ?? Future.value());
  }

  static void pop([Object? result]) {
    _navigator?.pop(result);
  }

  static Future<void> pushNamedAndRemoveUntil(String routeName, RoutePredicate predicate, {Object? arguments}) async {
    await (_navigator?.pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments) ?? Future.value());
  }

  /// Route generation. Used by MaterialApp.onGenerateRoute only.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return _materialRoute(settings, SplashView(viewModel: SplashViewModel()));
      case AppRoutes.onboarding:
        return _materialRoute(settings, OnboardingView(viewModel: OnboardingViewModel()));
      case AppRoutes.login:
        return _materialRoute(settings, LoginView(viewModel: LoginViewModel()));
      case AppRoutes.resetPassword:
        return _materialRoute(settings, ResetPasswordView(viewModel: ResetPasswordViewModel()));
      default:
        return null;
    }
  }

  static MaterialPageRoute<T> _materialRoute<T>(RouteSettings settings, Widget page) {
    return MaterialPageRoute<T>(
      settings: settings,
      builder: (_) => page,
    );
  }
}
