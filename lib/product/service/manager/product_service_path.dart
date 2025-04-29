/// Product Service Path
enum ProductServicePath {
  titles("Title/GetAllTitles"),
  lastEntries('Entry/GetLastEntries'),
  randomEntries('Entry/GetRandomEntries'),
  headers("api/header/GetHeaderIdByHeaderName"),
  createEntry("api/entry/create"),
  entryList('Entry/GetEntriesByTitleName'),
  content('api/draw/'),
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
