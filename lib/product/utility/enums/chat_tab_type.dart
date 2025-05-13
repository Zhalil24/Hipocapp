import 'package:flutter/material.dart';

enum ChatTabType {
  users('Kullanıcılar', Icons.chat),
  pastMessages('Geçmiş Mesajlar', Icons.star),
  groups("Gruplar", Icons.group);

  final String label;
  final IconData icon;
  const ChatTabType(this.label, this.icon);

  String withQuery(String query) {
    return "$label/$query";
  }
}
