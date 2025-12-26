import 'package:flutter/material.dart';
import 'package:hipocapp/feature/home/view/widget/launcher_widget.dart';
import 'package:hipocapp/product/init/config/app_environment.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(context.sized.lowValue),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: context.sized.normalValue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(context.sized.lowValue),
            ),
            child: Image.network(
              AppEnvironmentItems.baseUrl.value + widget.imageUrl,
              width: double.infinity,
              height: context.sized.highValue * 3,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  height: context.sized.highValue * 2,
                  child: const Center(child: Icon(Icons.error)),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(context.sized.normalValue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                SizedBox(height: context.sized.lowValue),
                LauncherWidget(link: widget.link),
                SizedBox(height: context.sized.lowValue),
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
