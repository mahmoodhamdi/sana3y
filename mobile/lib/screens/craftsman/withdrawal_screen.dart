import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/loading_button.dart';

class WithdrawalScreen extends ConsumerStatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  ConsumerState<WithdrawalScreen> createState() => _WithdrawalScreenState();
}

class _WithdrawalScreenState extends ConsumerState<WithdrawalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  String _selectedMethod = 'vodafone_cash';
  final _accountController = TextEditingController();
  bool _isSubmitting = false;

  // Mock balance
  final double _availableBalance = 2500.0;

  final List<_WithdrawalMethod> _methods = [
    _WithdrawalMethod(
      id: 'vodafone_cash',
      name: 'فودافون كاش',
      icon: Icons.phone_android,
      hint: 'رقم الموبايل',
    ),
    _WithdrawalMethod(
      id: 'orange_cash',
      name: 'أورانج كاش',
      icon: Icons.phone_android,
      hint: 'رقم الموبايل',
    ),
    _WithdrawalMethod(
      id: 'bank_transfer',
      name: 'تحويل بنكي',
      icon: Icons.account_balance,
      hint: 'رقم الحساب البنكي',
    ),
    _WithdrawalMethod(
      id: 'instapay',
      name: 'انستاباي',
      icon: Icons.payments,
      hint: 'رقم الحساب أو الموبايل',
    ),
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب سحب'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Balance Card
              Card(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_balance_wallet,
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'الرصيد المتاح للسحب',
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            '${_availableBalance.toInt()} ج.م',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Amount Input
              const Text(
                'مبلغ السحب',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'أدخل المبلغ',
                  suffixText: 'ج.م',
                  prefixIcon: const Icon(Icons.attach_money),
                  helperText: 'الحد الأدنى: 50 ج.م | الحد الأقصى: ${_availableBalance.toInt()} ج.م',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال المبلغ';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null) {
                    return 'الرجاء إدخال مبلغ صحيح';
                  }
                  if (amount < 50) {
                    return 'الحد الأدنى للسحب 50 ج.م';
                  }
                  if (amount > _availableBalance) {
                    return 'المبلغ أكبر من الرصيد المتاح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

              // Quick Amount Buttons
              Wrap(
                spacing: 8,
                children: [100, 200, 500, 1000].map((amount) {
                  return ActionChip(
                    label: Text('$amount ج.م'),
                    onPressed: amount <= _availableBalance
                        ? () => _amountController.text = amount.toString()
                        : null,
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Withdrawal Method
              const Text(
                'طريقة السحب',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...(_methods.map((method) => _MethodCard(
                method: method,
                isSelected: _selectedMethod == method.id,
                onTap: () {
                  setState(() {
                    _selectedMethod = method.id;
                    _accountController.clear();
                  });
                },
              ))),
              const SizedBox(height: 16),

              // Account Details
              TextFormField(
                controller: _accountController,
                keyboardType: _selectedMethod.contains('bank')
                    ? TextInputType.number
                    : TextInputType.phone,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: _methods.firstWhere((m) => m.id == _selectedMethod).hint,
                  prefixIcon: const Icon(Icons.account_circle_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال بيانات الحساب';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Info Box
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.orange[700]),
                        const SizedBox(width: 8),
                        Text(
                          'معلومات هامة',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '• يتم تحويل المبلغ خلال 24-48 ساعة عمل',
                      style: TextStyle(color: Colors.orange[800], fontSize: 13),
                    ),
                    Text(
                      '• تأكد من صحة بيانات الحساب قبل الإرسال',
                      style: TextStyle(color: Colors.orange[800], fontSize: 13),
                    ),
                    Text(
                      '• لا يوجد رسوم إضافية على السحب',
                      style: TextStyle(color: Colors.orange[800], fontSize: 13),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: LoadingButton(
                  text: 'إرسال طلب السحب',
                  isLoading: _isSubmitting,
                  onPressed: _submitWithdrawal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitWithdrawal() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text('تم إرسال الطلب'),
              ],
            ),
            content: Text(
              'تم إرسال طلب سحب بمبلغ ${_amountController.text} ج.م بنجاح. سيتم التحويل خلال 24-48 ساعة.',
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('موافق'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل في إرسال الطلب: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}

class _WithdrawalMethod {
  final String id;
  final String name;
  final IconData icon;
  final String hint;

  _WithdrawalMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.hint,
  });
}

class _MethodCard extends StatelessWidget {
  final _WithdrawalMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  const _MethodCard({
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(color: Theme.of(context).primaryColor, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  method.icon,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey[600],
                ),
              ),
              const SizedBox(width: 16),
              Text(
                method.name,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const Spacer(),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).primaryColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
