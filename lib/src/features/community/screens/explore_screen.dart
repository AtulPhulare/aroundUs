import 'package:around_us/src/utils/theme/app_colors.dart';
import 'package:around_us/src/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

// ──────────────────────────────────────────
// Data model (local mock)
// ──────────────────────────────────────────
class _GroupData {
  final String emoji;
  final String name;
  final String category;
  final String location;
  final int members;
  final Color tagColor;

  const _GroupData({
    required this.emoji,
    required this.name,
    required this.category,
    required this.location,
    required this.members,
    required this.tagColor,
  });
}

const _mockGroups = [
  _GroupData(
    emoji: '⚽',
    name: 'Volleyball in Kandivali',
    category: 'Sports',
    location: 'Kandivali, Mumbai',
    members: 28,
    tagColor: AppColors.tagBlue,
  ),
  _GroupData(
    emoji: '🎸',
    name: 'Guitar Enthusiasts',
    category: 'Music',
    location: 'Andheri, Mumbai',
    members: 14,
    tagColor: AppColors.tagPurple,
  ),
  _GroupData(
    emoji: '📚',
    name: 'Book Club Bandra',
    category: 'Reading',
    location: 'Bandra, Mumbai',
    members: 21,
    tagColor: AppColors.tagYellow,
  ),
  _GroupData(
    emoji: '🎨',
    name: 'Art & Sketching',
    category: 'Art',
    location: 'Juhu, Mumbai',
    members: 9,
    tagColor: AppColors.tagPink,
  ),
  _GroupData(
    emoji: '🚴',
    name: 'Cycling Crew',
    category: 'Sports',
    location: 'Powai, Mumbai',
    members: 35,
    tagColor: AppColors.tagGreen,
  ),
  _GroupData(
    emoji: '☕',
    name: 'Coffee Lovers',
    category: 'Food',
    location: 'Colaba, Mumbai',
    members: 17,
    tagColor: AppColors.tagRed,
  ),
];

// ──────────────────────────────────────────
// Screen
// ──────────────────────────────────────────
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<String> _categories = [
    'All',
    'Sports',
    'Music',
    'Art',
    'Food',
    'Reading',
    'Travel',
  ];
  String _selectedCat = 'All';
  final _searchCtrl = TextEditingController();
  String _query = '';

  List<_GroupData> get _filtered => _mockGroups.where((g) {
    final matchesCat = _selectedCat == 'All' || g.category == _selectedCat;
    final matchesQ =
        _query.isEmpty || g.name.toLowerCase().contains(_query.toLowerCase());
    return matchesCat && matchesQ;
  }).toList();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Explore Groups',
                          style: AppTextStyles.heading.copyWith(fontSize: 28),
                        ),
                        Text(
                          'Discover nearby communities',
                          style: AppTextStyles.subHeading,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.createGroup),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.orange.withOpacity(0.35),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.add_rounded, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Search ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _query = v),
                  decoration: const InputDecoration(
                    hintText: 'Search groups near you...',
                    hintStyle: TextStyle(color: AppColors.hint, fontSize: 14),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: AppColors.muted,
                      size: 22,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ── Category Filter ──────────────────────
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) {
                  final isSelected = _categories[i] == _selectedCat;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCat = _categories[i]),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.orange
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.orange.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : const [
                                BoxShadow(
                                  color: AppColors.shadow,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Text(
                        _categories[i],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : AppColors.muted,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 18),

            // ── Group Cards ──────────────────────────
            Expanded(
              child: _filtered.isEmpty
                  ? Center(
                      child: Text(
                        'No groups found',
                        style: AppTextStyles.subHeading,
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (_, i) => _GroupCard(group: _filtered[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  final _GroupData group;
  const _GroupCard({required this.group});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.groupChat),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: group.tagColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(group.emoji, style: const TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: AppTextStyles.body.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        size: 12,
                        color: AppColors.muted,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          group.location,
                          style: AppTextStyles.subHeading.copyWith(
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: group.tagColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          group.category,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dark,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.people_outline_rounded,
                        size: 13,
                        color: AppColors.muted,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        '${group.members} members',
                        style: AppTextStyles.subHeading.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: AppColors.orangeLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Join',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.orange,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
