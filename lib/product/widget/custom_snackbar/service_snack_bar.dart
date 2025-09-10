// lib/widgets/service_snack_bar.dart
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

enum SnackType { success, error, info }

class ServiceSnackBar extends StatefulWidget {
  final String message;
  final SnackType type;

  const ServiceSnackBar({
    Key? key,
    required this.message,
    this.type = SnackType.success,
  }) : super(key: key);

  static void show(BuildContext context, String message) {
    final overlay = Overlay.of(context);

    final entry = OverlayEntry(builder: (ctx) {
      return Positioned(
        top: MediaQuery.of(ctx).padding.top + context.sized.normalValue,
        left: context.sized.normalValue,
        right: context.sized.normalValue,
        child: ServiceSnackBar(message: message),
      );
    });

    overlay.insert(entry);
    Future<void>.delayed(const Duration(seconds: 1)).then((_) => entry.remove());
  }

  @override
  _ServiceSnackBarState createState() => _ServiceSnackBarState();
}

class _ServiceSnackBarState extends State<ServiceSnackBar> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 150),
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
        return Colors.orange.shade600;
      case SnackType.success:
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
        return Icons.check_circle_outline;
    }
  }

  @override
  void initState() {
    super.initState();
    _ctrl.forward();
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
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.sized.normalValue, vertical: context.sized.normalValue),
          child: Row(
            children: [
              Icon(_iconData, color: Colors.white),
              SizedBox(width: context.sized.normalValue),
              Expanded(
                child: Text(
                  widget.message,
                  style: TextStyle(color: Colors.white, fontSize: context.sized.normalValue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
