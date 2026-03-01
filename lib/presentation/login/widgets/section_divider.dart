import 'package:flutter/material.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Divider with centered text "or continue with". Thin lines on both sides.
class SectionDivider extends StatelessWidget {
  const SectionDivider({
    super.key,
    this.text = 'or continue with',
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.large,
        bottom: AppSpacing.medium,
      ),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: AppColors.inactiveDot,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
            child: Text(
              text,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.text),
            ),
          ),
          Expanded(
            child: Divider(
              color: AppColors.inactiveDot,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
