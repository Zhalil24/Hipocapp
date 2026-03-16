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

class _ContentCardState extends State<ContentCard> with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final shadowColor = isDark
        ? Colors.black.withValues(alpha: 0.08)
        : Colors.white.withValues(alpha: 0.72);

    return Padding(
      padding: EdgeInsets.only(bottom: context.sized.normalValue * 1.5),
      child: MouseRegion(
        onEnter: (_) => _hoverController.forward(),
        onExit: (_) => _hoverController.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(context.sized.normalValue),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.sized.normalValue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageSection(context, colorScheme),
                  _buildContentSection(context, colorScheme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context, ColorScheme colorScheme) {
    return Stack(
      children: [
        Image.network(
          AppEnvironmentItems.baseUrl.value + widget.imageUrl,
          width: double.infinity,
          height: context.sized.highValue * 3,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: context.sized.highValue * 3,
              color: colorScheme.surfaceContainerHighest,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_not_supported_outlined,
                      size: context.sized.highValue * 1.5,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    SizedBox(height: context.sized.lowValue),
                    Text(
                      'Görüntü Yüklenemedi',
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: context.sized.normalValue * 0.85,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context, ColorScheme colorScheme) {
    return Padding(
      padding: EdgeInsets.all(context.sized.normalValue * 1.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurface,
                  height: 1.3,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: context.sized.lowValue * 1.2),
          Row(
            children: [
              Icon(
                Icons.link_rounded,
                size: context.sized.normalValue * 0.9,
                color: colorScheme.primary,
              ),
              SizedBox(width: context.sized.lowValue * 0.5),
              Expanded(
                child: LauncherWidget(link: widget.link),
              ),
            ],
          ),
          SizedBox(height: context.sized.lowValue * 1.2),
          Container(
            padding: EdgeInsets.all(context.sized.lowValue),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(context.sized.lowValue * 0.8),
            ),
            child: Text(
              widget.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
