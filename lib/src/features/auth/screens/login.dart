import 'package:around_us/src/features/auth/widgets/divider.dart';
import 'package:around_us/src/utils/common/common_button.dart';
import 'package:around_us/src/utils/common/common_social_button.dart';
import 'package:around_us/src/utils/common/common_text_field.dart';
import 'package:around_us/src/utils/theme/app_colors.dart';
import 'package:around_us/src/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../widgets/logo.dart';

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
      duration: const Duration(milliseconds: 700),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, .08),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  const LogoWidget(),
                  const SizedBox(height: 44),

                  Text('Welcome\nback 👋', style: t.heading),
                  const SizedBox(height: 10),
                  Text(
                    "Sign in to see what's happening around you.",
                    style: t.subHeading,
                  ),

                  const SizedBox(height: 40),

                  CommonTextField(
                    controller: _emailCtrl,
                    hint: 'Email address',
                    icon: Icons.mail_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),

                  CommonTextField(
                    controller: _passwordCtrl,
                    hint: 'Password',
                    icon: Icons.lock_outline_rounded,
                    obscure: _obscure,
                    suffix: GestureDetector(
                      onTap: () => setState(() => _obscure = !_obscure),
                      child: Icon(
                        _obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: c.textSecondary,
                        size: 20,
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.orange,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  CommonButton(
                    title: 'Sign in',
                    loading: _loading,
                    onTap: _handleLogin,
                  ),

                  const SizedBox(height: 28),
                  const DividerWidget(),
                  const SizedBox(height: 20),

                  CommonSocialButton(
                    icon: '🍎',
                    label: 'Continue with Apple',
                    onTap: _handleLogin,
                  ),
                  const SizedBox(height: 12),
                  CommonSocialButton(
                    icon: '🌐',
                    label: 'Continue with Google',
                    onTap: _handleLogin,
                  ),

                  const SizedBox(height: 36),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New here? ',
                        style: TextStyle(color: c.textSecondary, fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.signup),
                        child: const Text(
                          'Create account',
                          style: TextStyle(
                            color: AppColors.orange,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
