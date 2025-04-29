import 'package:flutter/material.dart';
import 'package:hipocapp/feature/home/view_model/state/home_view_state.dart';
import 'package:hipocapp/product/service/interface/content_operarion.dart';
import 'package:hipocapp/product/service/interface/entry_operation.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';
import 'package:hipocapp/product/utility/enums/content_type.dart';

/// Manage your home view business login-c
final class HomeViewModel extends BaseCubit<HomeViewState> {
  /// [LastEntryOperation] service
  HomeViewModel({
    required LastEntryOperation lastEntriesOperation,
    required ContentOperarion contentOperation,
    required RandomEntryOperation randomEntryOperation,
  })  : _lastEntriesOperation = lastEntriesOperation,
        _randomEntryOperation = randomEntryOperation,
        _contentOperarion = contentOperation,
        super(HomeViewState(isLoading: false));
  late final LastEntryOperation _lastEntriesOperation;
  late final RandomEntryOperation _randomEntryOperation;
  late final ContentOperarion _contentOperarion;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void changeEntries(bool isChange) {
    emit(state.copyWith(
      isLastEntries: isChange,
      isRandomEntries: !isChange,
    ));

    if (isChange) {
      getLastEntries();
    } else {
      getRandomEntries();
    }
  }

  /// Get last entries
  Future<void> getLastEntries() async {
    changeLoading();
    final resp = await _lastEntriesOperation.getLastEntries();
    emit(state.copyWith(lastEntries: resp));
    changeLoading();
  }

  /// Get random entries
  Future<void> getRandomEntries() async {
    changeLoading();
    final resp = await _randomEntryOperation.getRandomEntries();
    emit(state.copyWith(randomEntries: resp));
    changeLoading();
  }

  /// Change contet type
  void handleNavigation(BuildContext context, int index) {
    final contentTypes = <ContentTypeEnum>[
      ContentTypeEnum.home,
      ContentTypeEnum.getCampains,
      ContentTypeEnum.getJobAdvertisements,
      ContentTypeEnum.getThesisConsultation,
      ContentTypeEnum.getDraws,
    ];

    final selectedContentType = contentTypes[index];

    if (selectedContentType == ContentTypeEnum.home) {
      emit(state.copyWith(contentType: selectedContentType.value));
      return;
    }

    emit(state.copyWith(contentType: selectedContentType.value));
    getContentList(selectedContentType.value);
  }

  /// Get random entries
  Future<void> getContentList(String contentName) async {
    changeLoading();
    final resp = await _contentOperarion.getContentList(contentName);
    emit(state.copyWith(contentModel: resp));
    changeLoading();
  }
}
