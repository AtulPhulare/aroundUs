import 'package:around_us/src/utils/common/common_button.dart';
import 'package:around_us/src/utils/common/common_text_field.dart';
import 'package:around_us/src/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _obscure = true;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() => _loading = false);
      Get.offAllNamed(AppRoutes.main);
    }
  }

  // ─── Helpers ──────────────────────────────────────────────────────────────

  Widget _ambientBlob({
    required Alignment alignment,
    required Color color,
    required double size,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, Colors.transparent]),
        ),
      ),
    );
  }

  Widget _logoPill() {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 6, 14, 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withOpacity(0.12), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon circle
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.orangeStart, AppColors.orangeEnd],
              ),
            ),
            child: const Icon(Icons.location_on, size: 12, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Text(
            'AROUND US',
            style: TextStyle(
              fontFamily: 'Sora',
              fontSize: 12,
              color: AppColors.dark.textSecondary,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _heroLine('Good'),
        Row(
          children: [
            _heroLine('to see '),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.orangeStart, AppColors.orangeEnd],
              ).createShader(bounds),
              child: const Text(
                'you',
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 54,
                  height: 1.0,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  letterSpacing: -2,
                ),
              ),
            ),
          ],
        ),
        _heroLine('again.', opacity: 0.25),
      ],
    );
  }

  Widget _heroLine(String text, {double opacity = 1.0}) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Sora',
        fontSize: 54,
        height: 1.0,
        fontWeight: FontWeight.w400,
        color: Colors.white.withOpacity(opacity),
        letterSpacing: -2,
      ),
    );
  }

  Widget _inputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Sora',
          fontSize: 11,
          color: AppColors.dark.textHint,
          letterSpacing: 1.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }



  Widget _divider() {
    return Row(
      children: [
        Expanded(
          child: Container(height: 0.5, color: Colors.white.withOpacity(0.10)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'or continue with',
            style: TextStyle(
              fontFamily: 'Sora',
              fontSize: 12, 
              color: AppColors.dark.textHint
            ),
          ),
        ),
        Expanded(
          child: Container(height: 0.5, color: Colors.white.withOpacity(0.10)),
        ),
      ],
    );
  }

  Widget _socialButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.dark.inputFill,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.dark.border, width: 0.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 17, color: AppColors.dark.textSecondary),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Sora',
                  fontSize: 13,
                  color: AppColors.dark.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Stack(
              children: [
                // Ambient glow blobs
                _ambientBlob(
                  alignment: const Alignment(1.4, -1.3),
                  color: AppColors.orangeStart.withOpacity(0.22),
                  size: 280,
                ),
                _ambientBlob(
                  alignment: const Alignment(-1.6, -0.6),
                  color: AppColors.orangeEnd.withOpacity(0.10),
                  size: 220,
                ),

                // Main scroll
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 28),

                      // ── Logo pill ──────────────────────────────────────
                      _logoPill(),
                      const SizedBox(height: 36),

                      // ── Hero heading ──────────────────────────────────
                      _heroHeading(),
                      const SizedBox(height: 18),

                      Text(
                        "Sign in to discover what's\nhappening near you right now.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.38),
                          height: 1.65,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ── Form card ─────────────────────────────────────
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.dark.card,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.07),
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email
                            _inputLabel('EMAIL'),
                            CommonTextField(
                              controller: _emailCtrl,
                              hint: 'hello@email.com',
                              icon: Icons.mail_outline_rounded,
                            ),
                            const SizedBox(height: 16),

                            // Password
                            _inputLabel('PASSWORD'),
                            CommonTextField(
                              controller: _passwordCtrl,
                              hint: '••••••••',
                              icon: Icons.lock_outline_rounded,
                              obscure: _obscure,
                              suffix: GestureDetector(
                                onTap: () =>
                                    setState(() => _obscure = !_obscure),
                                child: Icon(
                                  _obscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.white.withOpacity(0.3),
                                  size: 18,
                                ),
                              ),
                            ),

                            // Forgot
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  padding: EdgeInsets.zero,
                                ),
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    fontFamily: 'Sora',
                                    fontSize: 12,
                                    color: AppColors.orangeEnd,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),

                            // Sign in button
                            CommonButton(
                              title: 'Sign in',
                              loading: _loading,
                              onTap: _handleLogin,
                            ),
                            const SizedBox(height: 20),

                            // Divider
                            _divider(),
                            const SizedBox(height: 16),

                            // Social row
                            Row(
                              children: [
                                _socialButton(
                                  icon: Icons.g_mobiledata_rounded,
                                  label: 'Google',
                                  onTap: _handleLogin,
                                ),
                                const SizedBox(width: 10),
                                _socialButton(
                                  icon: Icons.apple_rounded,
                                  label: 'Apple',
                                  onTap: _handleLogin,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ── Sign up link ──────────────────────────────────
                      const SizedBox(height: 28),
                      Center(
                        child: GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.signup),
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 13),
                              children: [
                                TextSpan(
                                  text: 'New here?  ',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.3),
                                  ),
                                ),
                                TextSpan(
                                  text: 'Create an account',
                                  style: TextStyle(
                                    fontFamily: 'Sora',
                                    color: AppColors.orangeEnd,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
