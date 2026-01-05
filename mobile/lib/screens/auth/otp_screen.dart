import 'dart:async';
import 'package:flutter/material.dart';
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

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _otpController = TextEditingController();
  Timer? _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    if (widget.devCode != null) {
      _otpController.text = widget.devCode!;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _canResend = false;
    _timer?.cancel();
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

    final authNotifier = ref.read(authProvider.notifier);
    try {
      final result = widget.isPasswordReset
          ? await authNotifier.sendPasswordResetOTP(widget.email)
          : await authNotifier.sendVerificationOTP(widget.email);
      _startTimer();
      if (result.code != null) {
        _otpController.text = result.code!;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم إرسال كود جديد'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
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
          context.push('/reset-password', extra: {
            'email': widget.email,
            'otp': _otpController.text,
          });
        }
      } else if (widget.isRegistration) {
        // OTP verified, go back with success
        if (mounted) {
          context.pop(true);
        }
      } else {
        // Verify OTP and go to registration
        await authNotifier.verifyOtp(
          widget.email,
          _otpController.text,
          type: 'verification',
        );
        if (mounted) {
          context.push('/register', extra: {
            'email': widget.email,
            'otp': _otpController.text,
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isPasswordReset ? 'استعادة كلمة المرور' : 'التحقق من البريد'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),

              // Icon
              Icon(
                Icons.email_outlined,
                size: 80,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 24),

              // Title
              Text(
                'أدخل كود التحقق',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'تم إرسال كود مكون من 6 أرقام إلى\n${widget.email}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // OTP Input
              Directionality(
                textDirection: TextDirection.ltr,
                child: PinCodeTextField(
                  appContext: context,
                  controller: _otpController,
                  length: 6,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12),
                    fieldHeight: 56,
                    fieldWidth: 48,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.grey[100],
                    activeColor: theme.colorScheme.primary,
                    selectedColor: theme.colorScheme.primary,
                    inactiveColor: Colors.grey[300],
                  ),
                  enableActiveFill: true,
                  onCompleted: (_) => _verifyOtp(),
                  onChanged: (_) {},
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

              // Resend OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'لم تستلم الكود؟ ',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  if (_canResend)
                    TextButton(
                      onPressed: _resendOtp,
                      child: const Text('إعادة الإرسال'),
                    )
                  else
                    Text(
                      'إعادة الإرسال خلال $_secondsRemaining ثانية',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                ],
              ),

              // Dev Code Display
              if (widget.devCode != null)
                Container(
                  margin: const EdgeInsets.only(top: 24),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Development Code: ${widget.devCode}',
                    style: TextStyle(color: Colors.yellow[900]),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
