import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  late final Animation<double> _pulseFade;
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

    // Pulse rings — runs forever
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Content reveal — one-shot, 1.4 s total
    _content = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();

    _pulseFade = CurvedAnimation(parent: _pulse, curve: Curves.easeInOut);

    // Logo slides up and fades in early
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

    // Chips appear after logo
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

    // Tagline last
    _taglineFade = CurvedAnimation(
      parent: _content,
      curve: const Interval(0.75, 1.0, curve: Curves.easeOut),
    );

    // Navigate after 3 s using GetX — safe, no context needed
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _pulse.dispose();
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // ── Pulse rings centred on screen ──────────
          AnimatedBuilder(
            animation: _pulse,
            builder: (_, __) => CustomPaint(
              painter: _PulsePainter(_pulse.value),
              size: Size(size.width, size.height),
            ),
          ),

          // ── Main content column ─────────────────────
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),

                // Logo + wordmark
                FadeTransition(
                  opacity: _logoFade,
                  child: SlideTransition(
                    position: _logoSlide,
                    child: Column(
                      children: [
                        // Icon badge
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
                        const Text(
                          'around us',
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -2,
                            color: AppColors.dark,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // Interest chips
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

                // Tagline + dots
                FadeTransition(
                  opacity: _taglineFade,
                  child: Column(
                    children: const [
                      Text(
                        'Find people who share your vibe, nearby.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.muted,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 28),
                      _LoadingDots(),
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

// ── Sub-widgets ──────────────────────────────────────────────────────────────

class _InterestChip extends StatelessWidget {
  final String label;
  const _InterestChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.dark,
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

// ── Pulse Painter ────────────────────────────────────────────────────────────

class _PulsePainter extends CustomPainter {
  final double progress;
  _PulsePainter(this.progress);

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
