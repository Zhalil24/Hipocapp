import 'package:flutter/material.dart';
import 'package:hipocapp/product/state/base/base_state.dart';

class LoginRequiredPopup extends StatefulWidget {
  final VoidCallback onLoginPressed;

  const LoginRequiredPopup({
    super.key,
    required this.onLoginPressed,
  });

  @override
  State<LoginRequiredPopup> createState() => _LoginRequiredPopupState();
}

class _LoginRequiredPopupState extends BaseState<LoginRequiredPopup> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    if (!productViewModel.state.isLogin) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => _isVisible = true);
        _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _close() {
    _controller.reverse().then((_) {
      if (mounted) {
        setState(() => _isVisible = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (productViewModel.state.isLogin || !_isVisible) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: _close,
            child: Container(
              color: Colors.black54,
            ),
          ),
        ),

        // Popup card
        Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Material(
                borderRadius: BorderRadius.circular(16),
                color: colorScheme.surface,
                elevation: 12,
                child: SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                            onTap: _close,
                            child: const Icon(Icons.close, size: 22),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 48,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Entry açmak, etkileşimde bulunmak ve mesajlaşmak için giriş yapın.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Uygulamadaki etkileşim ve mesajlaşma özelliklerini kullanabilmek için giriş yapmanız gerekmektedir.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: widget.onLoginPressed,
                            child: const Text('Giriş Yap'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
