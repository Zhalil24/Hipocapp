import 'package:hipocapp/feature/introduction/view_model/state/introduction_view_state.dart';
import 'package:hipocapp/product/state/base/base_cuibt.dart';

final class IntroductionViewModel extends BaseCubit<IntroductionViewState> {
  IntroductionViewModel() : super(IntroductionViewState(isLoading: false));

  /// Load introduction data. This method is used to load introduction data from the server.
  /// It first emits an IntroductionViewState with isLoading set to true, then waits for 2 seconds, and finally emits an IntroductionViewState with isLoading set to false.
  Future<void> loadIntroduction() async {
    emit(state.copyWith(isLoading: true));
    //await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(isLoading: false));
  }
}
