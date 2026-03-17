import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/feature/drawer/view/widget/input_dialog_widget.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class SubItemSelectionWidget extends StatelessWidget {
  const SubItemSelectionWidget({
    super.key,
    required this.isSubItemSelected,
    required this.isLoggedIn,
    required this.selectedHeaderText,
    required this.titleController,
    required this.descController,
    required this.onCreateEntry,
  });

  final bool isSubItemSelected;
  final bool isLoggedIn;
  final String? selectedHeaderText;
  final TextEditingController titleController;
  final TextEditingController descController;
  final Future<void> Function(String, String) onCreateEntry;

  @override
  Widget build(BuildContext context) {
    if (!isSubItemSelected) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;
    final selectedLabel = (selectedHeaderText?.trim().isNotEmpty ?? false)
        ? selectedHeaderText!.trim()
        : 'Secili kategori';

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.026),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.sized.height * 0.055,
                height: context.sized.height * 0.055,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(normal),
                ),
                child: Icon(
                  Icons.edit_note_rounded,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: normal),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Katki alanin hazir',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: low * 0.45),
                    Text(
                      isLoggedIn
                          ? 'Bu kategori icin yeni bir baslik acip topluluga hizlica katki saglayabilirsin.'
                          : 'Baslik acmak icin once hesabina giris yapman gerekiyor.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: normal),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: normal,
              vertical: low * 0.9,
            ),
            decoration: BoxDecoration(
              color: colorScheme.secondary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(normal * 1.2),
              border: Border.all(
                color: colorScheme.secondary.withValues(alpha: 0.14),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.bookmark_added_rounded,
                  color: colorScheme.secondary,
                  size: context.sized.normalValue,
                ),
                SizedBox(width: low * 0.65),
                Expanded(
                  child: Text(
                    selectedLabel,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: normal),
          SizedBox(
            width: double.infinity,
            child: isLoggedIn
                ? FilledButton.icon(
                    onPressed: () async {
                      titleController.clear();
                      descController.clear();
                      await showDialog<void>(
                        context: context,
                        builder: (dialogContext) => InputDialogWidget(
                          titleController: titleController,
                          descController: descController,
                          headerLabel: selectedLabel,
                          onSubmit: onCreateEntry,
                        ),
                      );
                    },
                    icon: const Icon(Icons.add_comment_rounded),
                    label: const Text('Yeni baslik ekle'),
                    style: FilledButton.styleFrom(
                      minimumSize:
                          Size.fromHeight(context.sized.height * 0.062),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(normal * 1.15),
                      ),
                    ),
                  )
                : OutlinedButton.icon(
                    onPressed: () async {
                      titleController.clear();
                      descController.clear();
                      final router = context.router;
                      Navigator.of(context).pop();
                      await router.navigate(const LoginRoute());
                    },
                    icon: const Icon(Icons.login_rounded),
                    label: const Text('Giris yap ve katki ver'),
                    style: OutlinedButton.styleFrom(
                      minimumSize:
                          Size.fromHeight(context.sized.height * 0.062),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(normal * 1.15),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
