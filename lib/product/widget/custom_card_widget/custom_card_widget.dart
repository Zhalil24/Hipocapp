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

class _CustomCardWidgetState extends State<CustomCardWidget> with TickerProviderStateMixin {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    String formatDate(String dateString) {
      final cleanedDateString = dateString.replaceFirst('Tarih: ', '').split('.').first;
      final inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
      final outputFormat = DateFormat('dd.MM.yyyy');
      final dateTime = inputFormat.parse(cleanedDateString);
      return outputFormat.format(dateTime);
    }

    return Column(
      children: [
        Card(
          color: Colors.white, // kart rengi beyaz
          margin: EdgeInsets.zero, // aralığı ListView üzerinden kontrol edelim
          elevation: 0, // gölge kaldırıldı
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // köşe yuvarlama kaldırıldı
          ),
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
                Text(
                  widget.description,
                  maxLines: isExpanded ? null : 5,
                  overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? 'Gizle' : 'Devamını Göster',
                      style: TextStyle(
                        fontSize: context.sized.normalValue * 0.8,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                if (widget.userName != null) Text('${widget.userName}'),
                if (widget.date != null) Text('Tarih: ${formatDate(widget.date ?? '')}'),
                if (widget.isHomeCard)
                  TextButton(
                    onPressed: () {
                      context.router.push(ChatUserListRoute(
                        tab: ChatTabType.users,
                        query: widget.userName,
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Mesaj gönder ',
                          style: TextStyle(
                            fontSize: context.sized.normalValue * 0.8,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.secondary,
                          ),
                        ),
                        Icon(
                          Icons.chat,
                          color: colorScheme.secondary,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        const Divider(height: 1, color: Colors.grey), // kartın altına çizgi
      ],
    );
  }
}
