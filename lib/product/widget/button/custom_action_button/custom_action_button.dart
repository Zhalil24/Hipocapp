import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomActionButton extends StatefulWidget {
  const CustomActionButton({super.key, required this.onTop, required this.text, required this.message});
  final VoidCallback onTop;
  final String text;
  final String message;
  @override
  State<CustomActionButton> createState() => _CustomActionButtonState();
}

class _CustomActionButtonState extends State<CustomActionButton> {
  void _showAwesomeOverlay(BuildContext context) {
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
            message: widget.message,
            contentType: ContentType.success,
            inMaterialBanner: true,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future<void>.delayed(const Duration(seconds: 2)).then((_) {
      overlayEntry.remove();
      widget.onTop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showAwesomeOverlay(context),
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
