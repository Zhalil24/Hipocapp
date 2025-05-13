import 'package:flutter/material.dart';

enum ProfileTabType {
  profile("Profil", Icons.person),
  editProfile("Profili Düzenle", Icons.account_circle),
  changePassword("Parola Değiştir", Icons.vpn_key),
  entries("Açılan Entryler", Icons.library_books);

  final String label;
  final IconData icon;

  const ProfileTabType(this.label, this.icon);

  String withQuery(String query) {
    return "$label/$query";
  }
}
