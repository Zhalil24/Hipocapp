import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class DrawerViewState extends Equatable {
  DrawerViewState(
      {required this.isLoading, required this.headers, required this.titles, required this.isSubItemSelected, required this.serviceResultMessage});
  final bool isLoading;
  final HeaderModel headers;
  final List<TitleModel> titles;
  final bool isSubItemSelected;
  final String serviceResultMessage;
  @override
  List<Object?> get props => [isLoading, headers, titles, isSubItemSelected, serviceResultMessage];

  DrawerViewState copyWith({bool? isLoading, HeaderModel? headers, List<TitleModel>? titles, bool? isSubItemSelected, String? serviceResultMessage}) {
    return DrawerViewState(
      isLoading: isLoading ?? this.isLoading,
      headers: headers ?? this.headers,
      titles: titles ?? this.titles,
      isSubItemSelected: isSubItemSelected ?? this.isSubItemSelected,
      serviceResultMessage: serviceResultMessage ?? this.serviceResultMessage,
    );
  }
}
