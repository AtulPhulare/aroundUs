import 'package:around_us/src/utils/theme/app_colors.dart';
import 'package:around_us/src/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final t = AppTextStyles.of(context);

    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text('Profile', style: t.heading.copyWith(fontSize: 28)),
              const SizedBox(height: 24),

              // ── Avatar Card ──────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.orange, Color(0xFFFF8A65)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.orange.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 84,
                          height: 84,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.25),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person_rounded,
                              size: 44,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 28,
                          width: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: c.shadow, blurRadius: 6),
                            ],
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            size: 14,
                            color: AppColors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Alex Johnson',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'alex@example.com',
                      style: TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                    const SizedBox(height: 14),
                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _StatChip(label: 'Groups', value: '3'),
                        const SizedBox(width: 24),
                        _StatChip(label: 'Members', value: '86'),
                        const SizedBox(width: 24),
                        _StatChip(label: 'Posts', value: '12'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // ── Interests ────────────────────────────
              _SectionCard(
                children: [
                  _SectionHeader(
                    icon: Icons.star_outline_rounded,
                    label: 'Your Interests',
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['⚽ Football', '🎸 Music', '📚 Reading']
                        .map(
                          (t) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.orangeLight,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              t,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.orange,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ── Settings ─────────────────────────────
              _SectionCard(
                children: [
                  _SectionHeader(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                  ),
                  const SizedBox(height: 4),
                  _SettingsTile(
                    icon: Icons.person_outline_rounded,
                    iconColor: Colors.blue,
                    label: 'Edit Profile',
                    onTap: () {},
                  ),
                  const _Divider(),
                  _SettingsTile(
                    icon: Icons.groups_outlined,
                    iconColor: Colors.green,
                    label: 'My Groups',
                    onTap: () => Get.toNamed(AppRoutes.groupList),
                  ),
                  const _Divider(),
                  _SettingsTile(
                    icon: Icons.notifications_outlined,
                    iconColor: Colors.purple,
                    label: 'Notifications',
                    onTap: () => Get.toNamed(AppRoutes.notifications),
                  ),
                  const _Divider(),
                  _SettingsTile(
                    icon: Icons.shield_outlined,
                    iconColor: Colors.teal,
                    label: 'Privacy & Security',
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ── Logout ───────────────────────────────
              _SectionCard(
                children: [
                  _SettingsTile(
                    icon: Icons.logout_rounded,
                    iconColor: AppColors.orange,
                    label: 'Logout',
                    isDestructive: true,
                    showArrow: false,
                    onTap: () => Get.offAllNamed(AppRoutes.login),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Sub-widgets ──────────────────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.white70),
        ),
      ],
    );
  }
}

class _SectionCard extends StatelessWidget {
  final List<Widget> children;
  const _SectionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final t = AppTextStyles.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: c.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: c.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;
  const _SectionHeader({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final t = AppTextStyles.of(context);
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.orange),
        const SizedBox(width: 8),
        Text(
          label,
          style: t.body.copyWith(fontWeight: FontWeight.w800, fontSize: 14),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final bool isDestructive;
  final bool showArrow;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final t = AppTextStyles.of(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: t.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDestructive ? c.surface : c.border,
                ),
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: c.textHint,
              ),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Container(
      height: 1,
      margin: const EdgeInsets.only(left: 42),
      color: c.border,
    );
  }
}
