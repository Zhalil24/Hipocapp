import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ChatUserSearchCardWidget extends StatelessWidget {
  const ChatUserSearchCardWidget({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.onChanged,
  });

  final TextEditingController searchController;
  final String searchQuery;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kullanici ara',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: low * 0.45),
          Text(
            'Bir kullanici adi yazarak uygun sohbet kisilerini hizlica filtrele.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          SizedBox(height: normal),
          TextField(
            controller: searchController,
            onChanged: onChanged,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: 'Kullanici ara',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        searchController.clear();
                        onChanged('');
                      },
                      icon: const Icon(Icons.close_rounded),
                    )
                  : null,
              filled: true,
              fillColor: colorScheme.surface.withValues(alpha: 0.82),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(normal * 1.2),
                borderSide: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.18),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(normal * 1.2),
                borderSide: BorderSide(
                  color: colorScheme.outline.withValues(alpha: 0.18),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(normal * 1.2),
                borderSide: BorderSide(
                  color: colorScheme.primary.withValues(alpha: 0.52),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: normal,
                vertical: low * 1.05,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
