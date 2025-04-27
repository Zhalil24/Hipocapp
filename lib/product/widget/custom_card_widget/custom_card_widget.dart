import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final String title;
  final String description;
  final String? userName;
  final String date;

  const CustomCardWidget({
    super.key,
    required this.title,
    required this.description,
    this.userName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            Text(description),
            if (userName != null) ...[
              const SizedBox(height: 6),
              Text('Kullanıcı: $userName'),
            ],
            const SizedBox(height: 6),
            Text('Tarih: $date'),
          ],
        ),
      ),
    );
  }
}
