import 'package:flutter/material.dart';
import 'package:around_us/src/utils/theme/app_colors.dart';

class SignupLinkWidget extends StatelessWidget {
  const SignupLinkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Center(
      child: RichText(
        text: TextSpan(
          text: "New here? ",
          style: TextStyle(color: c.textSecondary, fontSize: 14),
          children: [
            TextSpan(
              text: "Create account",
              style: TextStyle(
                color: AppColors.orange,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
