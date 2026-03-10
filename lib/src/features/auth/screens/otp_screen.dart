import 'package:around_us/src/utils/common/common_button.dart';
import 'package:around_us/src/utils/theme/app_colors.dart';
import 'package:around_us/src/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_routes.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _loading = false;
  int _secondsLeft = 59;

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
    _startCountdown();
  }

  void _startCountdown() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
        return true;
      }
      return false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var ctrl in _controllers) {
      ctrl.dispose();
    }
    for (var fn in _focusNodes) {
      fn.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _handleVerify() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
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
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        color: c.surface,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: c.shadow,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: c.textPrimary,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      color: AppColors.orangeLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.message_rounded,
                      color: AppColors.orange,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 24),

                  Text('Verify your\nnumber', style: t.heading),
                  const SizedBox(height: 10),
                  Text(
                    'Enter the 6-digit code sent to your phone',
                    style: t.subHeading,
                  ),
                  const SizedBox(height: 44),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (i) {
                      return SizedBox(
                        width: 48,
                        height: 58,
                        child: TextFormField(
                          controller: _controllers[i],
                          focusNode: _focusNodes[i],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          onChanged: (v) => _onChanged(v, i),
                          style: GoogleFonts.outfit(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: c.textPrimary,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: c.inputFill,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: AppColors.orange,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 36),
                  CommonButton(
                    title: 'Verify & Continue',
                    loading: _loading,
                    onTap: _handleVerify,
                  ),
                  const SizedBox(height: 28),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Didn't receive the code? ", style: t.subHeading),
                      if (_secondsLeft > 0)
                        Text(
                          '0:${_secondsLeft.toString().padLeft(2, '0')}',
                          style: GoogleFonts.inter(
                            color: AppColors.orange,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        )
                      else
                        TextButton(
                          onPressed: () => setState(() {
                            _secondsLeft = 59;
                            _startCountdown();
                          }),
                          child: Text(
                            'Resend',
                            style: GoogleFonts.inter(
                              color: AppColors.orange,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
