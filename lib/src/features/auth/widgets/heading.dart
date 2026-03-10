import 'package:flutter/material.dart';
import 'package:around_us/src/utils/theme/app_colors.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome\nback 👋",
          style: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.w900,
            color: c.textPrimary,
            letterSpacing: -1.5,
            height: 1.1,
          ),
        ),

        SizedBox(height: 10),

        Text(
          "Sign in to see what's happening around you.",
          style: TextStyle(fontSize: 14.5, color: c.textSecondary, height: 1.5),
        ),
      ],
    );
  }
}
