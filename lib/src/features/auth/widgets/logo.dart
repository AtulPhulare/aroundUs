import 'package:flutter/material.dart';
import 'package:around_us/src/utils/theme/app_colors.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.orangeLight,
          ),
          child: const Icon(
            Icons.location_on_rounded,
            color: AppColors.orange,
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'around us',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: c.textPrimary,
            letterSpacing: -.5,
          ),
        ),
      ],
    );
  }
}
