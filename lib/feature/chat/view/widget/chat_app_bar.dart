import 'package:flutter/material.dart';

// class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
//   const ChatAppBar({
//     super.key,
//     this.userName,
//     this.groupName,
//     this.isOnline,
//     this.showOnlineStatus = true,
//   });
//   final String? userName;
//   final String? groupName;
//   final bool? isOnline;
//   final bool showOnlineStatus;
//   @override
//   State<ChatAppBar> createState() => _ChatAppBarState();

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }

// class _ChatAppBarState extends State<ChatAppBar> {
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       centerTitle: true,
//       title: Row(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Text(
//             (widget.userName?.isNotEmpty ?? false)
//                 ? widget.userName!
//                 : (widget.groupName?.isNotEmpty ?? false)
//                     ? widget.groupName!
//                     : '',
//             style: TextStyle(
//               fontSize: context.sized.normalValue,
//             ),
//           ),
//           if (widget.showOnlineStatus) ...[
//             SizedBox(width: context.sized.lowValue),
//             Container(
//               width: context.sized.lowValue,
//               height: context.sized.lowValue,
//               decoration: BoxDecoration(
//                 color: widget.isOnline == true ? Colors.green : Colors.grey,
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ]
//         ],
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/services.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ChatAppBar({
    super.key,
    this.userName,
    this.groupName,
    this.isOnline,
    this.showOnlineStatus = true,
  });

  final String? userName;
  final String? groupName;
  final bool? isOnline;
  final bool showOnlineStatus;

  @override
  State<ChatAppBar> createState() => _ChatAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ChatAppBarState extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          systemOverlayStyle: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          iconTheme: IconThemeData(color: colorScheme.onSurface),
          title: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  (widget.userName?.isNotEmpty ?? false)
                      ? widget.userName!
                      : (widget.groupName?.isNotEmpty ?? false)
                          ? widget.groupName!
                          : '',
                  style: TextStyle(
                    fontSize: 18, // istediğin değeri ayarlayabilirsin
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (widget.showOnlineStatus) ...[
                const SizedBox(width: 8),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: widget.isOnline == true ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
