import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class DrawerViewState extends Equatable {
  const DrawerViewState({
    required this.isLoading,
    required this.headers,
    required this.titles,
    required this.isSubItemSelected,
    this.serviceResponseMessage,
  });

  static const Object _sentinel = Object();

  final bool isLoading;
  final HeaderModel headers;
  final List<TitleModel> titles;
  final bool isSubItemSelected;
  final String? serviceResponseMessage;

  @override
  List<Object?> get props => [
        isLoading,
        headers,
        titles,
        isSubItemSelected,
        serviceResponseMessage,
      ];

  DrawerViewState copyWith({
    bool? isLoading,
    HeaderModel? headers,
    List<TitleModel>? titles,
    bool? isSubItemSelected,
    Object? serviceResponseMessage = _sentinel,
  }) {
    return DrawerViewState(
      isLoading: isLoading ?? this.isLoading,
      headers: headers ?? this.headers,
      titles: titles ?? this.titles,
      isSubItemSelected: isSubItemSelected ?? this.isSubItemSelected,
      serviceResponseMessage: identical(serviceResponseMessage, _sentinel)
          ? this.serviceResponseMessage
          : serviceResponseMessage as String?,
    );
  }
}
