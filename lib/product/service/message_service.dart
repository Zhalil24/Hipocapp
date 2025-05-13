import 'dart:convert';

import 'package:gen/gen.dart';
import 'package:hipocapp/product/init/config/app_environment.dart';
import 'package:hipocapp/product/service/interface/message_operation.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

/// Get last entries service
final class MessageService extends MessageOperation {
  MessageService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;
  @override
  Future<List<MessageModel>?> getLastMessageFromUserId(int userId) async {
    final response = await _networkManager.send<MessageResponseModel, MessageResponseModel>(ProductServicePath.lastMessageList.value,
        parseModel: MessageResponseModel(),
        method: RequestType.GET,
        queryParameters: {
          'userId': userId,
        });

    return response.data?.messages;
  }

  @override
  Future<List<MessageListModel>> getMessageList(int fromUserId, int toUserId) async {
    final url = '${ProductServicePath.getMessageList.value}?fromUserId=$fromUserId&toUserId=$toUserId';

    final response = await _networkManager.sendPrimitive<String>(url);

    if (response != null) {
      final decodedJson = jsonDecode(response);
      final dataList = decodedJson['Data'] as List;
      return dataList.map((e) => MessageListModel.fromJson(e as Map<String, dynamic>)).toList();
    }

    return [];
  }

  @override
  Future<MessageResponseModel?> saveMesage(MessageModel model) async {
    final response = await _networkManager.send<MessageResponseModel, MessageResponseModel>(
      ProductServicePath.saveMessage.value,
      parseModel: MessageResponseModel(),
      method: RequestType.POST,
      data: model,
    );
    return response.data;
  }

  @override
  Future<String?> markMessage(MarkMessageModel model) async {
    final dio = Dio();
    final fullUrl = "${AppEnvironmentItems.baseUrl.value + ProductServicePath.markMessage.value}";

    final response = await dio.put<String>(
      fullUrl,
      data: model.toJson(),
    );
    return response.data;
  }

  @override
  Future<UnReadMessageResponseModel?> getUnReadMessagCount(int userId) async {
    final response = await _networkManager.send<UnReadMessageResponseModel, UnReadMessageResponseModel>(
      ProductServicePath.unReadMessageCount.value,
      parseModel: UnReadMessageResponseModel(),
      method: RequestType.GET,
      queryParameters: {
        'userId': userId,
      },
    );
    return response.data;
  }
}
