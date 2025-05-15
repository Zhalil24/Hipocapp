/// Product Service Path
enum ProductServicePath {
  titles('Title/GetAllTitles'),
  lastEntries('Entry/GetLastEntries'),
  randomEntries('Entry/GetRandomEntries'),
  headers('api/header/GetHeaderIdByHeaderName'),
  createEntry('api/entry/create'),
  entryList('Entry/GetEntriesByTitleName'),
  content('api/draw/'),
  login('api/user/Login'),
  updateProfile('api/user/Edit'),
  changePassword('api/user/PasswordChange'),
  deleteEntry('api/Entry/DeleteEntry'),
  forgotPassword('api/user/ForgotPasswordApi'),
  entriesByTitleName('api/Title/SearchEntriesByTitleName'),
  allUser('api/user/all'),
  getByUserId('api/chat/GetByUserId'),
  lastMessageList('api/chat/LastMessages'),
  saveMessage('api/chat/MessageSave'),
  unReadMessageCount('api/chat/GetUnreadMessagesForUser'),
  groups('api/chat/GetGroupsForMobile'),
  markMessage('api/chat/MarkMessagesAsRead'),
  getMessageList('api/chat/MessageList'),
  profile('api/User/GetProfile');

  final String value;
  const ProductServicePath(this.value);

  /// [withQuery] is add query to path
  ///
  /// Example: users/123
  String withQuery(String value) {
    return '${this.value}/$value';
  }
}
