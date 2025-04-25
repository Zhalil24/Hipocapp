/// Product Service Path
enum ProductServicePath {
  lastEntries('Entry/GetLastEntries'),
  randomEntries('Entry/GetRandomEntries'),
  headers("Header/GetHeaderIdByHeaderName"),
  login('api/user/Login');

  final String value;
  const ProductServicePath(this.value);

  /// [withQuery] is add query to path
  ///
  /// Example: users/123
  String withQuery(String value) {
    return '${this.value}/$value';
  }
}
