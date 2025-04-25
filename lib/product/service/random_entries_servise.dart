import 'package:gen/gen.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/service/manager/product_service_path.dart';
import 'package:vexana/vexana.dart';

/// Get last entries service
final class RandomEntriesService extends RandomEntryOperation {
  RandomEntriesService(INetworkManager<EmptyModel> networkManager) : _networkManager = networkManager;

  final INetworkManager<EmptyModel> _networkManager;
  @override
  Future<List<RandomEntriesModel>?> getRandomEntries() async {
    final response = await _networkManager.send<RandomEntriesResponseModel, RandomEntriesResponseModel>(
      ProductServicePath.randomEntries.value,
      parseModel: RandomEntriesResponseModel(),
      method: RequestType.GET,
    );

    return response.data?.randomEntries ?? [];
  }
}
