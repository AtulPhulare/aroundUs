import 'package:around_us/src/utils/theme/app_colors.dart';
import 'package:around_us/src/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class _MyGroup {
  final String emoji, name, lastMessage, time;
  final int unread;
  final Color tagColor;
  const _MyGroup({
    required this.emoji,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unread,
    required this.tagColor,
  });
}

const _myGroups = [
  _MyGroup(
    emoji: '⚽',
    name: 'Volleyball in Kandivali',
    lastMessage: 'Anyone free this Saturday?',
    time: '9:42 AM',
    unread: 3,
    tagColor: AppColors.tagBlue,
  ),
  _MyGroup(
    emoji: '🎸',
    name: 'Guitar Enthusiasts',
    lastMessage: 'New tab shared by Ravi',
    time: 'Yesterday',
    unread: 0,
    tagColor: AppColors.tagPurple,
  ),
  _MyGroup(
    emoji: '📚',
    name: 'Book Club Bandra',
    lastMessage: 'Next book: Atomic Habits',
    time: 'Mon',
    unread: 1,
    tagColor: AppColors.tagYellow,
  ),
];

class GroupListScreen extends StatelessWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final t = AppTextStyles.of(context);

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Groups', style: t.heading.copyWith(fontSize: 28)),
                  Text('Groups you have joined', style: t.subHeading),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                itemCount: _myGroups.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) => _GroupTile(group: _myGroups[i]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.createGroup),
        backgroundColor: AppColors.orange,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          'Create',
          style: TextStyle(fontFamily: 'Sora', 
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _GroupTile extends StatelessWidget {
  final _MyGroup group;
  const _GroupTile({required this.group});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.groupChat),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: c.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: group.tagColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: group.tagColor.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(group.emoji, style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: const TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    group.lastMessage,
                    style: TextStyle(
                      fontFamily: 'Sora',
                      fontSize: 12,
                      color: c.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  group.time,
                  style: TextStyle(
                    fontFamily: 'Sora',
                    fontSize: 11,
                    color: c.textHint,
                  ),
                ),
                const SizedBox(height: 6),
                if (group.unread > 0)
                  Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                      color: AppColors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${group.unread}',
                        style: const TextStyle(
                          fontFamily: 'Sora',
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
