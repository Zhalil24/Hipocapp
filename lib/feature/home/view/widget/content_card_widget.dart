import 'package:flutter/material.dart';
import 'package:hipocapp/feature/home/view/widget/launcher_widget.dart';
import 'package:kartal/kartal.dart';

class ContentCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String link;
  final String description;

  const ContentCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.link,
    required this.description,
  });

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: context.sized.normalValue),
      elevation: context.padding.medium.bottom,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.sized.normalValue)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.imageUrl,
                width: context.sized.normalValue,
                height: context.sized.normalValue,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: context.sized.normalValue),
                  LauncherWidget(link: widget.link),
                  SizedBox(height: context.sized.normalValue),
                  Text(
                    widget.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
