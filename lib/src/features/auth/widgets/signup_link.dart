import 'package:flutter/material.dart';
import 'package:around_us/src/utils/theme/app_colors.dart';

class SignupLinkWidget extends StatelessWidget {
  const SignupLinkWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: const TextSpan(
          text: "New here? ",
          style: TextStyle(color: AppColors.muted, fontSize: 14),
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
