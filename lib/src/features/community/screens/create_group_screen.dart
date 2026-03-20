import 'package:around_us/src/utils/common/common_button.dart';
import 'package:around_us/src/utils/common/common_text_field.dart';
import 'package:around_us/src/utils/theme/app_colors.dart';
import 'package:around_us/src/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  final _nameCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();

  final List<String> _categories = [
    'Sports',
    'Music',
    'Art',
    'Food',
    'Travel',
    'Reading',
    'Gaming',
    'Fitness',
  ];
  String? _selectedCategory;

  final List<String> _emojis = [
    '⚽',
    '🎸',
    '🎨',
    '🍕',
    '✈️',
    '📚',
    '🎮',
    '🏋️',
    '🎭',
    '🌿',
    '☕',
    '🐶',
  ];
  String _selectedEmoji = '⚽';

  bool _isPrivate = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, .06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _locationCtrl.dispose();
    super.dispose();
  }

  void _handleCreate() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _loading = false);
      Get.offNamed(AppRoutes.groupChat);
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final t = AppTextStyles.of(context);
    return Scaffold(
      backgroundColor: c.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Column(
              children: [
                // ── App Bar ──────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            color: c.card,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.05),
                              width: 0.5,
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Create Group',
                        style: t.heading.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Emoji Picker ─────────────────────
                        _sectionLabel('Group Icon'),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 52,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _emojis.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 10),
                            itemBuilder: (_, i) {
                              final isSelected = _emojis[i] == _selectedEmoji;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedEmoji = _emojis[i]),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.orange.withValues(alpha: 0.1)
                                        : c.card,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.orange
                                          : Colors.white.withValues(alpha: 0.05),
                                      width: isSelected ? 1.5 : 0.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _emojis[i],
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ── Group Name ────────────────────────
                        _sectionLabel('Group Name'),
                        const SizedBox(height: 10),
                        CommonTextField(
                          controller: _nameCtrl,
                          hint: 'e.g. Volleyball in Kandivali',
                          icon: Icons.group_rounded,
                        ),

                        const SizedBox(height: 18),

                        // ── Description ───────────────────────
                        _sectionLabel('Description'),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: c.inputFill,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.05),
                              width: 0.5,
                            ),
                          ),
                          child: TextField(
                            controller: _descCtrl,
                            maxLines: 4,
                            style: const TextStyle(
                              fontFamily: 'Sora',
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: 'What is this group about?',
                              hintStyle: TextStyle(
                                fontFamily: 'Sora',
                                color: c.textHint.withValues(alpha: 0.3),
                                fontSize: 14,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(bottom: 58),
                                child: Icon(
                                  Icons.description_outlined,
                                  color: c.textSecondary,
                                  size: 18,
                                ),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // ── Category ──────────────────────────
                        _sectionLabel('Category'),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _categories.map((cat) {
                            final isSelected = _selectedCategory == cat;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedCategory = cat),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.orange
                                      : c.card,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.orange
                                        : Colors.white.withValues(alpha: 0.05),
                                    width: 0.5,
                                  ),
                                ),
                                child: Text(
                                  cat,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : c.textSecondary,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 18),

                        // ── Location ──────────────────────────
                        _sectionLabel('Location'),
                        const SizedBox(height: 10),
                        CommonTextField(
                          controller: _locationCtrl,
                          hint: 'e.g. Kandivali, Mumbai',
                          icon: Icons.location_on_outlined,
                        ),

                        const SizedBox(height: 18),

                        // ── Visibility Toggle ─────────────────
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: c.card,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.05),
                              width: 0.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: _isPrivate
                                      ? AppColors.tagPurple
                                      : AppColors.tagGreen,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  _isPrivate
                                      ? Icons.lock_outline_rounded
                                      : Icons.lock_open_rounded,
                                  color: _isPrivate
                                      ? Colors.purple
                                      : Colors.green,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _isPrivate
                                          ? 'Private Group'
                                          : 'Public Group',
                                      style: t.body.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      _isPrivate
                                          ? 'Members approved by admin'
                                          : 'Anyone can join instantly',
                                      style: t.subHeading.copyWith(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: _isPrivate,
                                onChanged: (v) =>
                                    setState(() => _isPrivate = v),
                                activeColor: AppColors.orange,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        CommonButton(
                          title: 'Create Group',
                          loading: _loading,
                          onTap: _handleCreate,
                        ),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: AppTextStyles.of(
        context,
      ).body.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
    );
  }
}
