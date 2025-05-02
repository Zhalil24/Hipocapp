import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kartal/kartal.dart';

class CustomCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final String? userName;
  final String? date;

  const CustomCardWidget({
    super.key,
    required this.title,
    required this.description,
    this.userName,
    this.date,
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
            if (widget.date != null) Text('Tarih: ${formatDate(widget.date ?? '')}')
          ],
        ),
      ),
    );
  }
}
