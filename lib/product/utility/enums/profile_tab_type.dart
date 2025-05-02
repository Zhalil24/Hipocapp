enum ProfileTabType {
  profile("Profil"),
  editProfile("Profili Düzenle"),
  changePassword("Parola Değiştir"),
  entries("Açılan Entryler");

  final String label;
  const ProfileTabType(this.label);

  String withQuery(String query) {
    return "$label/$query";
  }
}
