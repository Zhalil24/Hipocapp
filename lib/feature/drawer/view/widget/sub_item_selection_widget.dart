import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/feature/drawer/view/widget/input_dialog_widget.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
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

    final normal = context.sized.normalValue;
    final selectedLabel = (selectedHeaderText?.trim().isNotEmpty ?? false)
        ? selectedHeaderText!.trim()
        : LocaleKeys.general_fallback_selected_category.tr();

    return AppSurfaceCard(
      padding: EdgeInsets.all(context.sized.height * 0.026),
      child: SizedBox(
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
                label: Text(LocaleKeys.general_button_create_title.tr()),
                style: FilledButton.styleFrom(
                  minimumSize: Size.fromHeight(context.sized.height * 0.062),
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
                label: Text(LocaleKeys.general_button_login.tr()),
                style: OutlinedButton.styleFrom(
                  minimumSize: Size.fromHeight(context.sized.height * 0.062),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(normal * 1.15),
                  ),
                ),
              ),
      ),
    );
  }
}
