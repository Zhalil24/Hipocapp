import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherWidget extends StatefulWidget {
  const LauncherWidget({super.key, required this.link});
  final String link;

  @override
  State<LauncherWidget> createState() => _LauncherWidgetState();
}

class _LauncherWidgetState extends State<LauncherWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final displayText = widget.link.replaceFirst(RegExp(r'^https?://'), '');
    final truncatedText = displayText.length > 40 ? '${displayText.substring(0, 37)}...' : displayText;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () async {
          final url = widget.link.startsWith('http') ? widget.link : 'https://${widget.link}';
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.sized.lowValue * 0.8,
            vertical: context.sized.lowValue * 0.4,
          ),
          decoration: BoxDecoration(
            color: _isHovering ? colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(context.sized.lowValue * 0.6),
            border: Border.all(
              color: _isHovering ? colorScheme.primary : colorScheme.primary.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.open_in_new_rounded,
                size: context.sized.normalValue * 0.85,
                color: colorScheme.primary,
              ),
              SizedBox(width: context.sized.lowValue * 0.6),
              Flexible(
                child: Text(
                  truncatedText,
                  style: TextStyle(
                    color: colorScheme.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: colorScheme.primary.withValues(alpha: 0.5),
                    fontSize: context.sized.normalValue * 0.9,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
