import 'package:gen/gen.dart';

abstract class MessageOperation {
  Future<List<MessageModel>?> getLastMessageFromUserId(int userId);
  Future<List<MessageListModel>> getMessageList(int fromUserId, int toUserId);
  Future<String?> markMessage(MarkMessageModel model);
  Future<UnReadMessageResponseModel?> getUnReadMessagCount(int userId);
  Future<GroupResponseModel?> getGroups(int userId);
  Future<List<GroupMessageModel>?> getGroupMessage(int groupId);
}
