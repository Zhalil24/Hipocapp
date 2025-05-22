import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:hipocapp/product/utility/enums/chat_tab_type.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

class CustomCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final String? userName;
  final String? date;
  final int? userId;
  final bool isHomeCard;
  const CustomCardWidget({
    super.key,
    required this.title,
    required this.description,
    this.userName,
    this.date,
    this.userId,
    required this.isHomeCard,
  });

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  @override
  Widget build(BuildContext context) {
    String formatDate(String dateString) {
      final cleanedDateString = dateString.replaceFirst('Tarih: ', '').split('.').first;
      final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      final outputFormat = DateFormat('dd.MM.yyyy HH:mm');
      final dateTime = inputFormat.parse(cleanedDateString);
      return outputFormat.format(dateTime);
    }

    return Card(
      margin: EdgeInsets.all(context.sized.normalValue),
      elevation: context.padding.medium.bottom,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(context.sized.normalValue)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            SizedBox(height: context.sized.mediumValue),
            Text(widget.description),
            if (widget.userName != null) ...[
              const SizedBox(height: 6),
              Text('${widget.userName}'),
            ],
            SizedBox(height: context.sized.mediumValue),
            if (widget.date != null) Text('Tarih: ${formatDate(widget.date ?? '')}'),
            if (widget.isHomeCard)
              TextButton(
                  onPressed: () {
                    // context.router.push(ChatRoute(
                    //   toUserId: widget.userId,
                    //   toUserName: widget.userName,
                    // )
                    context.router.push(ChatUserListRoute(
                      tab: ChatTabType.users,
                      query: widget.userName,
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Bu kişiye mesaj gönder ',
                        style: TextStyle(
                          fontSize: context.sized.normalValue * 0.8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Icon(Icons.chat),
                    ],
                  ))
          ],
        ),
      ),
    );
  }
}
