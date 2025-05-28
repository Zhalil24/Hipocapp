class Validators {
  static String? notEmpty(String? v) => (v == null || v.trim().isEmpty) ? 'Bu alan boş bırakılamaz' : null;

  static String? match(String? v, String? other, String fieldName) {
    // Boş mu kontrolü
    if (v == null || v.isEmpty) {
      return '$fieldName boş olamaz';
    }
    // Eşleşme kontrolü
    if (v != other) {
      return '$fieldName eşleşmiyor';
    }
    return null; // Geçerli
  }

  static String? email(String? v) {
    final pattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return (v != null && pattern.hasMatch(v.trim())) ? null : 'Geçerli bir e-posta girin';
  }
}
