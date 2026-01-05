import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/loading_button.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String email;
  final bool isPasswordReset;
  final bool isRegistration;
  final String? devCode;

  const OtpScreen({
    super.key,
    required this.email,
    this.isPasswordReset = false,
    this.isRegistration = false,
    this.devCode,
  });

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen>
    with SingleTickerProviderStateMixin {
  final _otpController = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;
  bool _hasError = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );
    _startTimer();
    if (widget.devCode != null) {
      _otpController.text = widget.devCode!;
    }
    // Auto-focus OTP field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _canResend = false;
    _timer?.cancel();
    _animationController.reset();
    _animationController.forward();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  Future<void> _resendOtp() async {
    if (!_canResend) return;

    // Haptic feedback
    HapticFeedback.mediumImpact();

    final authNotifier = ref.read(authProvider.notifier);
    try {
      final result = widget.isPasswordReset
          ? await authNotifier.sendPasswordResetOTP(widget.email)
          : await authNotifier.sendVerificationOTP(widget.email);
      _startTimer();
      _otpController.clear();
      if (result.code != null) {
        _otpController.text = result.code!;
      }
      if (mounted) {
        setState(() => _hasError = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال كود جديد'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        HapticFeedback.heavyImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.length != 6) return;

    // Haptic feedback
    HapticFeedback.lightImpact();

    final authNotifier = ref.read(authProvider.notifier);

    try {
      if (widget.isPasswordReset) {
        // Verify OTP and go to reset password screen
        await authNotifier.verifyOtp(
          widget.email,
          _otpController.text,
          type: 'password_reset',
        );
        if (mounted) {
          HapticFeedback.mediumImpact();
          context.push('/reset-password', extra: {
            'email': widget.email,
            'otp': _otpController.text,
          });
        }
      } else if (widget.isRegistration) {
        // Verify OTP first, then go back with success
        await authNotifier.verifyOtp(
          widget.email,
          _otpController.text,
          type: 'verification',
        );
        if (mounted) {
          HapticFeedback.mediumImpact();
          context.pop(_otpController.text); // Return the OTP code
        }
      } else {
        // Verify OTP and go to registration
        await authNotifier.verifyOtp(
          widget.email,
          _otpController.text,
          type: 'verification',
        );
        if (mounted) {
          HapticFeedback.mediumImpact();
          context.push('/register', extra: {
            'email': widget.email,
            'otp': _otpController.text,
          });
        }
      }
    } catch (e) {
      if (mounted) {
        HapticFeedback.heavyImpact();
        setState(() => _hasError = true);
        _otpController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String get _stepTitle {
    if (widget.isPasswordReset) {
      return 'استعادة كلمة المرور';
    } else if (widget.isRegistration) {
      return 'تأكيد البريد الإلكتروني';
    }
    return 'التحقق من البريد';
  }

  String get _stepDescription {
    if (widget.isPasswordReset) {
      return 'أدخل الكود لاستعادة كلمة المرور';
    } else if (widget.isRegistration) {
      return 'أدخل الكود لتأكيد بريدك الإلكتروني';
    }
    return 'أدخل الكود للتحقق من بريدك';
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_stepTitle),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Step Indicator
              _StepIndicator(
                currentStep: widget.isPasswordReset ? 1 : (widget.isRegistration ? 2 : 1),
                totalSteps: widget.isPasswordReset ? 2 : 3,
                labels: widget.isPasswordReset
                    ? ['إدخال البريد', 'التحقق', 'كلمة مرور جديدة']
                    : ['البريد', 'التحقق', 'البيانات'],
              ),
              const SizedBox(height: 32),

              // Circular Timer with Icon
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Animated circular progress
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: _CircularTimerPainter(
                              progress: 1 - (_secondsRemaining / 60),
                              color: _canResend
                                  ? Colors.green
                                  : theme.colorScheme.primary,
                              backgroundColor: Colors.grey[200]!,
                            ),
                          );
                        },
                      ),
                    ),
                    // Icon
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: _hasError
                            ? Colors.red.withValues(alpha: 0.1)
                            : theme.colorScheme.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _hasError
                            ? Icons.error_outline
                            : (widget.isPasswordReset
                                ? Icons.lock_reset
                                : Icons.mark_email_read_outlined),
                        size: 48,
                        color: _hasError
                            ? Colors.red
                            : theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                _stepDescription,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'تم إرسال كود مكون من 6 أرقام إلى',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.email,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),

              // OTP Input
              Directionality(
                textDirection: TextDirection.ltr,
                child: PinCodeTextField(
                  appContext: context,
                  controller: _otpController,
                  focusNode: _focusNode,
                  length: 6,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.scale,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(16),
                    fieldHeight: 60,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    selectedFillColor: theme.colorScheme.primary.withValues(alpha: 0.05),
                    inactiveFillColor: Colors.grey[50],
                    activeColor: _hasError ? Colors.red : theme.colorScheme.primary,
                    selectedColor: theme.colorScheme.primary,
                    inactiveColor: Colors.grey[300],
                    errorBorderColor: Colors.red,
                  ),
                  enableActiveFill: true,
                  cursorColor: theme.colorScheme.primary,
                  animationDuration: const Duration(milliseconds: 200),
                  onChanged: (value) {
                    if (_hasError && value.isNotEmpty) {
                      setState(() => _hasError = false);
                    }
                  },
                  onCompleted: (_) => _verifyOtp(),
                  beforeTextPaste: (text) {
                    // Allow pasting 6-digit codes
                    if (text == null) return false;
                    return text.length == 6 && int.tryParse(text) != null;
                  },
                ),
              ),

              // Error message
              if (_hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'الكود غير صحيح، حاول مرة أخرى',
                    style: TextStyle(color: Colors.red[700], fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),

              const SizedBox(height: 24),

              // Verify Button
              LoadingButton(
                text: 'تأكيد',
                onPressed: _verifyOtp,
                isLoading: authState.isLoading,
              ),
              const SizedBox(height: 16),

              // Resend OTP with timer
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'لم تستلم الكود؟',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    if (_canResend)
                      TextButton.icon(
                        onPressed: _resendOtp,
                        icon: const Icon(Icons.refresh),
                        label: const Text('إعادة إرسال الكود'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.green,
                        ),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 18,
                            color: Colors.grey[500],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'إعادة الإرسال خلال $_secondsRemaining ثانية',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              // Dev Code Display
              if (widget.devCode != null)
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.developer_mode, color: Colors.amber[700]),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Development Mode',
                              style: TextStyle(
                                color: Colors.amber[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Code: ${widget.devCode}',
                              style: TextStyle(
                                color: Colors.amber[800],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Step Indicator Widget
class _StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> labels;

  const _StepIndicator({
    required this.currentStep,
    required this.totalSteps,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: List.generate(totalSteps * 2 - 1, (index) {
        if (index.isOdd) {
          // Connector line
          final stepIndex = index ~/ 2;
          final isCompleted = stepIndex < currentStep;
          return Expanded(
            child: Container(
              height: 2,
              color: isCompleted
                  ? theme.colorScheme.primary
                  : Colors.grey[300],
            ),
          );
        } else {
          // Step circle
          final stepIndex = index ~/ 2;
          final isActive = stepIndex == currentStep;
          final isCompleted = stepIndex < currentStep;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? theme.colorScheme.primary
                      : (isActive
                          ? theme.colorScheme.primary.withValues(alpha: 0.2)
                          : Colors.grey[200]),
                  shape: BoxShape.circle,
                  border: isActive
                      ? Border.all(
                          color: theme.colorScheme.primary,
                          width: 2,
                        )
                      : null,
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : Text(
                          '${stepIndex + 1}',
                          style: TextStyle(
                            color: isActive
                                ? theme.colorScheme.primary
                                : Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                ),
              ),
              if (labels.length > stepIndex) ...[
                const SizedBox(height: 4),
                Text(
                  labels[stepIndex],
                  style: TextStyle(
                    fontSize: 10,
                    color: isActive
                        ? theme.colorScheme.primary
                        : Colors.grey[600],
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ],
          );
        }
      }),
    );
  }
}

// Circular Timer Painter
class _CircularTimerPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  _CircularTimerPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 4.0;

    // Background circle
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius - strokeWidth / 2, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircularTimerPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
