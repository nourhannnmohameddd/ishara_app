import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_spacing.dart';

/// Centered row of social auth icons (24x24) with 24px spacing. Each icon is tappable.
/// Uses SVG assets; PNG paths (apple.png, google.png, facebook.png) can be used if added.
class SocialAuthRow extends StatelessWidget {
  const SocialAuthRow({
    super.key,
    required this.onApplePressed,
    required this.onGooglePressed,
    required this.onFacebookPressed,
  });

  final VoidCallback onApplePressed;
  final VoidCallback onGooglePressed;
  final VoidCallback onFacebookPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(
          assetPath: 'assets/icons/apple.svg',
          onTap: onApplePressed,
          size: AppSpacing.large,
        ),
        const SizedBox(width: AppSpacing.large),
        _SocialIcon(
          assetPath: 'assets/icons/google.svg',
          onTap: onGooglePressed,
          size: AppSpacing.large,
        ),
        const SizedBox(width: AppSpacing.large),
        _SocialIcon(
          assetPath: 'assets/icons/facebook.svg',
          onTap: onFacebookPressed,
          size: AppSpacing.large,
        ),
      ],
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({
    required this.assetPath,
    required this.onTap,
    required this.size,
  });

  final String assetPath;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        assetPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    );
  }
}
