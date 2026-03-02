import 'package:flutter/material.dart';

import '../../core/widgets/app_scaffold.dart';
import '../../presentation/login/login_view.dart';
import '../../presentation/login/login_viewmodel.dart';
import '../../presentation/onboarding/onboarding_view.dart';
import '../../presentation/onboarding/onboarding_viewmodel.dart';
import '../../presentation/reset_password/reset_password_view.dart';
import '../../presentation/reset_password/reset_password_viewmodel.dart';
import '../../presentation/signup/signup_view.dart';
import '../../presentation/signup/signup_viewmodel.dart';
import '../../presentation/splash/splash_view.dart';
import '../../presentation/splash/splash_viewmodel.dart';
import 'route_constants.dart';

/// Route names. Navigation is performed only from ViewModels via [AppRouter].
/// Paths are defined in [RouteConstants].
abstract class AppRoutes {
  static const String splash = RouteConstants.splash;
  static const String onboarding = RouteConstants.onboarding;
  static const String login = RouteConstants.login;
  static const String resetPassword = RouteConstants.resetPassword;
  static const String signUp = RouteConstants.signUp;
  static const String dashboard = RouteConstants.dashboard;
  static const String otp = RouteConstants.otp;
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
      case RouteConstants.splash:
        return _materialRoute(settings, SplashView(viewModel: SplashViewModel()));
      case RouteConstants.onboarding:
        return _materialRoute(settings, OnboardingView(viewModel: OnboardingViewModel()));
      case RouteConstants.login:
        return _materialRoute(settings, LoginView(viewModel: LoginViewModel()));
      case RouteConstants.resetPassword:
        return _materialRoute(settings, ResetPasswordView(viewModel: ResetPasswordViewModel()));
      case RouteConstants.signUp:
        return _materialRoute(settings, SignUpView(viewModel: SignUpViewModel()));
      case RouteConstants.dashboard:
        return _materialRoute(
          settings,
          Builder(
            builder: (context) {
              final theme = Theme.of(context);
              return AppScaffold(
                title: 'Dashboard',
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: theme.appBarTheme.foregroundColor ??
                      theme.colorScheme.onSurface,
                  onPressed: () => AppRouter.pushNamedAndRemoveUntil(
                    AppRoutes.login,
                    (route) => false,
                  ),
                ),
                body: Center(
                  child: Text('Dashboard Screen'),
                ),
              );
            },
          ),
        );
      case RouteConstants.otp:
        return _materialRoute(
          settings,
          AppScaffold(
            title: 'OTP Verification',
            body: Center(
              child: Text('OTP Screen Placeholder'),
            ),
          ),
        );
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
