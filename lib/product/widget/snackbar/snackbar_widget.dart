import 'package:flutter/material.dart';

class SnackbarWidget extends StatefulWidget {
  final String message;

  const SnackbarWidget({super.key, required this.message});

  @override
  State<SnackbarWidget> createState() => _SnackbarWidgetState();
}

class _SnackbarWidgetState extends State<SnackbarWidget> {
  @override
  void initState() {
    super.initState();

    // Widget ekrana geldikten sonra snackBar göster
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text(widget.message)),
            ],
          ),
          backgroundColor: Colors.blue,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Bu widget sadece SnackBar tetiklediği için görünmez olabilir
    return const SizedBox.shrink();
  }
}
