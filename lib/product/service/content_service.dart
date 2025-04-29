import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/interface/content_operarion.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

/// Get last entries service
final class ContentService extends ContentOperarion {
  ContentService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;
  @override
  Future<List<ContentModel>?> getContentList(String contentType) async {
    final response = await _networkManager.send<ContentResponseModel, ContentResponseModel>(
      ProductServicePath.content.value + contentType,
      parseModel: ContentResponseModel(),
      method: RequestType.GET,
    );

    return response.data?.contentModel ?? [];
  }
}
