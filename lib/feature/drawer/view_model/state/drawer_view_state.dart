import 'package:equatable/equatable.dart';
import 'package:gen/gen.dart';

final class DrawerViewState extends Equatable {
  DrawerViewState({required this.isLoading, required this.headers, required this.titles, required this.isSubItemSelected});
  final bool isLoading;
  final HeaderModel headers;
  final List<TitleModel> titles;
  final bool isSubItemSelected;
  @override
  List<Object?> get props => [isLoading, headers, titles, isSubItemSelected];

  DrawerViewState copyWith({bool? isLoading, HeaderModel? headers, List<TitleModel>? titles, bool? isSubItemSelected}) {
    return DrawerViewState(
        isLoading: isLoading ?? this.isLoading,
        headers: headers ?? this.headers,
        titles: titles ?? this.titles,
        isSubItemSelected: isSubItemSelected ?? this.isSubItemSelected);
  }
}
