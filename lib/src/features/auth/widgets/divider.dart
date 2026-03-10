import 'package:flutter/material.dart';
import 'package:around_us/src/utils/theme/app_colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Row(
      children: [
        Expanded(child: Divider(color: c.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            'or',
            style: TextStyle(color: c.textSecondary, fontSize: 13),
          ),
        ),
        Expanded(child: Divider(color: c.border)),
      ],
    );
  }
}
