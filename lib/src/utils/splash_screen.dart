import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../routes/app_routes.dart';
import 'theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulse;
  late final AnimationController _content;

  late final Animation<double> _logoFade;
  late final Animation<Offset> _logoSlide;
  late final Animation<double> _chipsFade;
  late final Animation<Offset> _chipsSlide;
  late final Animation<double> _taglineFade;

  static const _interests = [
    '⚽ Sports',
    '🎸 Music',
    '🎨 Art',
    '🍕 Food',
    '✈️ Travel',
    '📚 Reading',
  ];

  @override
  void initState() {
    super.initState();

    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _content = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();

    _logoFade = CurvedAnimation(
      parent: _content,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
    _logoSlide = Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _content,
            curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
          ),
        );

    _chipsFade = CurvedAnimation(
      parent: _content,
      curve: const Interval(0.45, 0.85, curve: Curves.easeOut),
    );
    _chipsSlide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _content,
            curve: const Interval(0.45, 0.85, curve: Curves.easeOutCubic),
          ),
        );

    _taglineFade = CurvedAnimation(
      parent: _content,
      curve: const Interval(0.75, 1.0, curve: Curves.easeOut),
    );

    Future.delayed(
      const Duration(seconds: 3),
      () => Get.offAllNamed(AppRoutes.login),
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: c.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, __) => CustomPaint(
              painter: _PulsePainter(_pulse.value, c.background),
              size: Size(size.width, size.height),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),

                FadeTransition(
                  opacity: _logoFade,
                  child: SlideTransition(
                    position: _logoSlide,
                    child: Column(
                      children: [
                        Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: AppColors.orangeLight,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.orange.withValues(alpha: 0.25),
                                blurRadius: 32,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.location_on_rounded,
                            color: AppColors.orange,
                            size: 44,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'around us',
                          style: GoogleFonts.outfit(
                            fontSize: 44,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -2,
                            color: c.textPrimary,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                FadeTransition(
                  opacity: _chipsFade,
                  child: SlideTransition(
                    position: _chipsSlide,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: _interests
                            .map((tag) => _InterestChip(label: tag))
                            .toList(),
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                FadeTransition(
                  opacity: _taglineFade,
                  child: Column(
                    children: [
                      Text(
                        'Find people who share your vibe, nearby.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: c.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 28),
                      const _LoadingDots(),
                    ],
                  ),
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  final String label;
  const _InterestChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final c = AppColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: c.shadow, blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: c.textPrimary,
        ),
      ),
    );
  }
}

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) {
            final delay = i / 3.0;
            final t = (_ctrl.value - delay).clamp(0.0, 1.0);
            final scale = 1.0 + 0.4 * (t < 0.5 ? t * 2 : (1 - t) * 2);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _PulsePainter extends CustomPainter {
  final double progress;
  final Color bg;
  _PulsePainter(this.progress, this.bg);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    for (int i = 0; i < 4; i++) {
      final t = ((progress + i * 0.25) % 1.0);
      final radius = t * (size.shortestSide * 0.65);
      final opacity = (1.0 - t) * 0.18;
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..color = AppColors.orange.withValues(alpha: opacity)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}
