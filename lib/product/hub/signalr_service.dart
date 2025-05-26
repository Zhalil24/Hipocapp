import 'package:hipocapp/product/init/config/app_environment.dart';
import 'package:hipocapp/product/utility/constans/hub_constants/hub_methods.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/signalr_client.dart';

final class SignalRService {
  late final HubConnection _hubConnection;

  HubConnection get connection => _hubConnection;

  SignalRService() {
    _hubConnection = HubConnectionBuilder()
        .withUrl(
          AppEnvironmentItems.baseUrl.value + HubMethods.hub,
          options: HttpConnectionOptions(
            transport: HttpTransportType.WebSockets,
          ),
        )
        .build();
  }

  Future<void> startConnection() async {
    if (_hubConnection.state != HubConnectionState.Connected) {
      await _hubConnection.start();
    }
  }

  void on(String methodName, void Function(List<Object?>? args) callback) {
    _hubConnection.on(methodName, callback);
  }

  Future<void> send(String method, List<Object> args) async {
    await _hubConnection.invoke(method, args: args);
  }

  Future<void> stop() async {
    await _hubConnection.stop();
  }
}
