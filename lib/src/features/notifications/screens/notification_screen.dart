import 'package:around_us/src/utils/theme/app_colors.dart';
import 'package:around_us/src/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notifications',
                    style: AppTextStyles.heading.copyWith(fontSize: 28),
                  ),
                  Text(
                    'Stay up to date with your groups',
                    style: AppTextStyles.subHeading,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                children: [
                  _notifSection('Today', [
                    _NotifData(
                      icon: Icons.message_rounded,
                      color: AppColors.tagBlue,
                      title: 'New message in Volleyball',
                      subtitle: 'Rahul: "Anyone free this Saturday?"',
                      time: '9:42 AM',
                      onTap: () => Get.toNamed(AppRoutes.groupChat),
                    ),
                    _NotifData(
                      icon: Icons.group_add_rounded,
                      color: AppColors.tagGreen,
                      title: 'Priya joined your group',
                      subtitle: 'Volleyball in Kandivali +1 member',
                      time: '8:15 AM',
                      onTap: () {},
                    ),
                  ]),
                  const SizedBox(height: 20),
                  _notifSection('Yesterday', [
                    _NotifData(
                      icon: Icons.explore_rounded,
                      color: AppColors.tagPurple,
                      title: 'New group nearby',
                      subtitle: 'Guitar Enthusiasts — Andheri, 2km away',
                      time: '6:30 PM',
                      onTap: () {},
                    ),
                    _NotifData(
                      icon: Icons.check_circle_rounded,
                      color: AppColors.tagYellow,
                      title: 'Request approved',
                      subtitle: 'You joined Book Club Bandra',
                      time: '11:00 AM',
                      onTap: () {},
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _notifSection(String label, List<_NotifData> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            label,
            style: AppTextStyles.body.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.muted,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...items.map(
          (n) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _NotifCard(data: n),
          ),
        ),
      ],
    );
  }
}

class _NotifData {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String time;
  final VoidCallback onTap;

  const _NotifData({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.onTap,
  });
}

class _NotifCard extends StatelessWidget {
  final _NotifData data;
  const _NotifCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: data.onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: data.color,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(data.icon, color: AppColors.dark, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    data.subtitle,
                    style: AppTextStyles.subHeading.copyWith(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              data.time,
              style: AppTextStyles.subHeading.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
