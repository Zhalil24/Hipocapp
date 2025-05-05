import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomActionButton extends StatefulWidget {
  const CustomActionButton({
    super.key,
    required this.onTop,
    required this.text,
    required this.message,
    this.controllers,
    this.passwordMatchControllers,
  });
  final VoidCallback onTop;
  final String text;
  final String message;
  final List<TextEditingController>? controllers;
  final List<TextEditingController>? passwordMatchControllers;

  @override
  State<CustomActionButton> createState() => _CustomActionButtonState();
}

class _CustomActionButtonState extends State<CustomActionButton> {
  void _showAwesomeOverlay(BuildContext context, String message, ContentType type) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + context.sized.mediumValue,
        left: context.sized.normalValue,
        right: context.sized.normalValue,
        child: Material(
          color: Colors.transparent,
          child: AwesomeSnackbarContent(
            title: 'Sayın Kullanıcımız',
            message: message,
            contentType: type,
            inMaterialBanner: true,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future<void>.delayed(const Duration(seconds: 2)).then((_) {
      overlayEntry.remove();
    });
  }

  void _handleTap() {
    // Boş alan kontrolü
    if (widget.controllers != null && widget.controllers!.any((c) => c.text.trim().isEmpty)) {
      _showAwesomeOverlay(context, 'Lütfen tüm alanları doldurunuz.', ContentType.failure);
      return;
    }

    // Şifre kontrolü (isteğe bağlı)
    if (widget.passwordMatchControllers != null && widget.passwordMatchControllers!.length == 2) {
      final pass = widget.passwordMatchControllers![0].text.trim();
      final confirm = widget.passwordMatchControllers![1].text.trim();

      // 🔒 Boş şifre kontrolü
      if (pass.isEmpty || confirm.isEmpty) {
        _showAwesomeOverlay(context, 'Şifre alanları boş bırakılamaz.', ContentType.failure);
        return;
      }

      // 🔁 Eşleşme kontrolü
      if (pass != confirm) {
        _showAwesomeOverlay(context, 'Yeni şifreler uyuşmuyor.', ContentType.warning);
        return;
      }
    }

    // Başarılıysa mesaj ve işlemi çağır
    _showAwesomeOverlay(context, widget.message, ContentType.success);
    Future<void>.delayed(const Duration(seconds: 2)).then((_) => widget.onTop());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.sized.highValue,
          vertical: context.sized.lowValue,
        ),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(context.sized.normalValue),
          border: Border.all(color: Colors.blue),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
