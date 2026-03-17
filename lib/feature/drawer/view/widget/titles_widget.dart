import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class DrawerTitlesWidget extends StatelessWidget {
  const DrawerTitlesWidget({
    super.key,
    required this.titles,
    required this.isLoading,
    required this.selectedHeaderText,
  });

  final List<TitleModel> titles;
  final bool isLoading;
  final String? selectedHeaderText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final hasSelection = selectedHeaderText?.trim().isNotEmpty ?? false;

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.026),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Baslik akisi',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: low * 0.45),
                    Text(
                      hasSelection
                          ? '${selectedHeaderText!.trim()} icin guncel basliklari buradan acabilirsin.'
                          : 'Bir alt kategori sectiginde ilgili basliklar burada listelenir.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              if (titles.isNotEmpty)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: normal * 0.75,
                    vertical: low * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(normal * 1.4),
                  ),
                  child: Text(
                    '${titles.length}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: normal),
          if (isLoading)
            SizedBox(
              height: context.sized.height * 0.18,
              child: const Center(
                child: CustomLoader(),
              ),
            )
          else if (titles.isEmpty)
            _EmptyTitlesState(
              hasSelection: hasSelection,
              selectedHeaderText: selectedHeaderText,
            )
          else
            Column(
              children: titles.map((title) {
                final titleName = title.name?.trim().isNotEmpty ?? false
                    ? title.name!.trim()
                    : 'Baslik';

                return Padding(
                  padding: EdgeInsets.only(bottom: low * 0.75),
                  child: Material(
                    color: colorScheme.primary.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(normal * 1.2),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(normal * 1.2),
                      onTap: () async {
                        final router = context.router;
                        Navigator.of(context).pop();
                        await router.push(
                          EntryListRoute(
                            titleName: titleName,
                            headerId: title.headerId ?? 0,
                            userId: title.userId ?? 0,
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: normal,
                          vertical: low,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: context.sized.height * 0.05,
                              height: context.sized.height * 0.05,
                              decoration: BoxDecoration(
                                color:
                                    colorScheme.primary.withValues(alpha: 0.10),
                                borderRadius: BorderRadius.circular(normal),
                              ),
                              child: Icon(
                                Icons.auto_stories_rounded,
                                color: colorScheme.primary,
                                size: context.sized.normalValue,
                              ),
                            ),
                            SizedBox(width: normal * 0.85),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    titleName,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: low * 0.2),
                                  Text(
                                    'Detay akisini ac ve entryleri tek ekranda takip et.',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: low * 0.8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}

class _EmptyTitlesState extends StatelessWidget {
  const _EmptyTitlesState({
    required this.hasSelection,
    required this.selectedHeaderText,
  });

  final bool hasSelection;
  final String? selectedHeaderText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(normal),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(normal * 1.3),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.16),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: context.sized.height * 0.075,
            height: context.sized.height * 0.075,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              hasSelection
                  ? Icons.hourglass_empty_rounded
                  : Icons.touch_app_rounded,
              color: colorScheme.primary,
              size: context.sized.height * 0.035,
            ),
          ),
          SizedBox(height: normal),
          Text(
            hasSelection ? 'Baslik bekleniyor' : 'Ilk secimini yap',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: low * 0.55),
          Text(
            hasSelection
                ? '${selectedHeaderText?.trim() ?? 'Bu kategori'} icin henuz bir baslik bulunmuyor. Yeni bir baslik ekleyerek akisi canlandirabilirsin.'
                : 'Bir alt kategori sectiginde uygun basliklar burada otomatik olarak gosterilecek.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
