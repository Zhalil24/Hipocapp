import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kartal/kartal.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherWidget extends StatefulWidget {
  const LauncherWidget({super.key, required this.link});
  final String link;
  @override
  State<LauncherWidget> createState() => _LauncherWidgetState();
}

class _LauncherWidgetState extends State<LauncherWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final url = widget.link.startsWith('http') ? widget.link : 'https://${widget.link}';
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Text(
        widget.link,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.blue,
              decoration: TextDecoration.underline,
              fontSize: context.sized.normalValue,
            ),
      ),
    );
  }
}
