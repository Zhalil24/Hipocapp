import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/signalr_client.dart';

final class SignalRService {
  late final HubConnection _hubConnection;

  HubConnection get connection => _hubConnection;

  SignalRService() {
    _hubConnection = HubConnectionBuilder()
        .withUrl(
          'https://hipocapp.com/exampleTypeSafeHub',
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
