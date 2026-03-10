import 'package:flutter/material.dart';
import 'package:around_us/src/utils/theme/app_colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider(color: AppColors.border)),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            "or",
            style: TextStyle(color: AppColors.muted, fontSize: 13),
          ),
        ),

        Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }
}
