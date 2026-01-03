import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/loading_button.dart';

class PhoneScreen extends ConsumerStatefulWidget {
  const PhoneScreen({super.key});

  @override
  ConsumerState<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends ConsumerState<PhoneScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLogin = true;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  String _formatPhone(String phone) {
    String cleaned = phone.replaceAll(RegExp(r'\D'), '');
    if (cleaned.startsWith('0') && cleaned.length == 11) {
      return '+20${cleaned.substring(1)}';
    }
    if (cleaned.length == 10 && cleaned.startsWith('1')) {
      return '+20$cleaned';
    }
    if (cleaned.startsWith('20') && cleaned.length == 12) {
      return '+$cleaned';
    }
    return phone;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرجاء إدخال رقم الهاتف';
    }
    final formatted = _formatPhone(value);
    final regex = RegExp(r'^\+20(10|11|12|15)[0-9]{8}$');
    if (!regex.hasMatch(formatted)) {
      return 'رقم الهاتف غير صالح';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final phone = _formatPhone(_phoneController.text);
    final authNotifier = ref.read(authProvider.notifier);

    try {
      final result = await authNotifier.sendOtp(
        phone,
        type: _isLogin ? 'login' : 'verification',
      );

      if (mounted) {
        context.push(
          '/otp',
          extra: {
            'phone': phone,
            'isLogin': _isLogin,
            'devCode': result.code, // Only in development
          },
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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),

                // Logo
                Icon(
                  Icons.handyman,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  'صنايعي',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'كل الصنايعية في إيدك',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),

                // Toggle Login/Register
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isLogin = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: _isLogin ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: _isLogin
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                      )
                                    ]
                                  : null,
                            ),
                            child: Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontWeight: _isLogin ? FontWeight.bold : FontWeight.normal,
                                color: _isLogin ? theme.colorScheme.primary : Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _isLogin = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: !_isLogin ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: !_isLogin
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                      )
                                    ]
                                  : null,
                            ),
                            child: Text(
                              'حساب جديد',
                              style: TextStyle(
                                fontWeight: !_isLogin ? FontWeight.bold : FontWeight.normal,
                                color: !_isLogin ? theme.colorScheme.primary : Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Phone Input
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  decoration: InputDecoration(
                    labelText: 'رقم الهاتف',
                    hintText: '01XXXXXXXXX',
                    prefixIcon: const Icon(Icons.phone_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                  validator: _validatePhone,
                ),
                const SizedBox(height: 24),

                // Submit Button
                LoadingButton(
                  text: _isLogin ? 'تسجيل الدخول' : 'إنشاء حساب',
                  onPressed: _submit,
                  isLoading: authState.isLoading,
                ),
                const SizedBox(height: 16),

                // Error Message
                if (authState.errorMessage != null)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      authState.errorMessage!,
                      style: TextStyle(color: Colors.red[700]),
                      textAlign: TextAlign.center,
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
