import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RequestSubmittedScreen extends StatefulWidget {
  final String requestId;
  final String? requestNumber;

  const RequestSubmittedScreen({
    super.key,
    required this.requestId,
    this.requestNumber,
  });

  @override
  State<RequestSubmittedScreen> createState() => _RequestSubmittedScreenState();
}

class _RequestSubmittedScreenState extends State<RequestSubmittedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              // Success Animation
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        size: 80,
                        color: Colors.green[600],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Title
              FadeTransition(
                opacity: _fadeAnimation,
                child: const Text(
                  'تم إرسال طلبك بنجاح!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),

              // Description
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'سيتم إشعارك عند استلام عروض أسعار من الصنايعية',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),

              // Request Number Card
              if (widget.requestNumber != null)
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.receipt_long, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'رقم الطلب: ',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          widget.requestNumber!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 32),

              // What's Next
              FadeTransition(
                opacity: _fadeAnimation,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'ماذا بعد؟',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildStep(
                          number: '1',
                          title: 'انتظر عروض الأسعار',
                          description: 'سيرسل الصنايعية عروضهم خلال دقائق',
                          icon: Icons.hourglass_empty,
                        ),
                        const SizedBox(height: 12),
                        _buildStep(
                          number: '2',
                          title: 'قارن واختر',
                          description: 'راجع العروض واختر الأنسب لك',
                          icon: Icons.compare_arrows,
                        ),
                        const SizedBox(height: 12),
                        _buildStep(
                          number: '3',
                          title: 'تواصل وأكد',
                          description: 'تواصل مع الصنايعي وحدد الموعد',
                          icon: Icons.handshake,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Buttons
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/request/${widget.requestId}');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('متابعة الطلب'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          context.go('/customer');
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('العودة للرئيسية'),
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

  Widget _buildStep({
    required String number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Icon(icon, color: Colors.grey[400], size: 20),
      ],
    );
  }
}
