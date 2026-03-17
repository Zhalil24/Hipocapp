import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';

class ChatComposerWidget extends StatelessWidget {
  const ChatComposerWidget({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.isGroupConversation,
    required this.onSend,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isGroupConversation;
  final Future<void> Function() onSend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final normal = context.sized.normalValue;
    final low = context.sized.lowValue;

    return AppSurfaceCard(
      padding: EdgeInsets.fromLTRB(
        normal,
        low * 0.85,
        low * 0.85,
        low * 0.85,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              minLines: 1,
              maxLines: 4,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: isGroupConversation
                    ? 'Grupla paylasmak istedigin seyi yaz'
                    : 'Mesajini yaz',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: low * 0.2,
                  vertical: low * 0.8,
                ),
              ),
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(width: low * 0.65),
          FilledButton(
            onPressed: () async {
              await onSend();
            },
            style: FilledButton.styleFrom(
              padding: EdgeInsets.all(low * 0.95),
              minimumSize: Size(
                context.sized.height * 0.058,
                context.sized.height * 0.058,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(normal * 1.2),
              ),
            ),
            child: Icon(
              Icons.send_rounded,
              color: colorScheme.onPrimary,
              size: context.sized.normalValue * 1.08,
            ),
          ),
        ],
      ),
    );
  }
}
