// lib/widgets/service_snack_bar.dart
import 'package:flutter/material.dart';

enum SnackType { success, error, info }

class ServiceSnackBar extends StatefulWidget {
  final String message;
  final SnackType type;

  const ServiceSnackBar({
    Key? key,
    required this.message,
    this.type = SnackType.success,
  }) : super(key: key);

  @override
  _ServiceSnackBarState createState() => _ServiceSnackBarState();
}

class _ServiceSnackBarState extends State<ServiceSnackBar> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late final Animation<Offset> _offsetAnim = Tween<Offset>(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));

  Color get _bgColor {
    switch (widget.type) {
      case SnackType.error:
        return Colors.red.shade600;
      case SnackType.info:
        return Colors.blue.shade600;
      case SnackType.success:
      default:
        return Colors.green.shade600;
    }
  }

  IconData get _iconData {
    switch (widget.type) {
      case SnackType.error:
        return Icons.error_outline;
      case SnackType.info:
        return Icons.info_outline;
      case SnackType.success:
      default:
        return Icons.check_circle_outline;
    }
  }

  @override
  void initState() {
    super.initState();
    _ctrl.forward().then((_) {
      Future.delayed(const Duration(seconds: 3), () {
        _ctrl.reverse().then((_) {
          // SnackBar içindeki content widget’ı tamamen kaybolduğunda
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        });
      });
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnim,
      child: Material(
        color: _bgColor,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(_iconData, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  widget.message,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              GestureDetector(
                onTap: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
