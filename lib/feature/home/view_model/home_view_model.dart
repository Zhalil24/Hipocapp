import 'package:core/core.dart';
import 'package:gen/gen.dart';
import 'package:my_architecture_template/feature/home/view_model/state/home_view_state.dart';
import 'package:my_architecture_template/product/cache/model/user_cache_model.dart';
import 'package:my_architecture_template/product/service/interface/authentication_operation.dart';
import 'package:my_architecture_template/product/state/base/base_cuibt.dart';

/// Manage your home view business login-c
final class HomeViewModel extends BaseCubit<HomeViewState> {
  /// [AuthenticationOperation] service
  HomeViewModel({
    required AuthenticationOperation operationService,
    required HiveCacheOperation<UserCacheModel> userCacheOperation,
  })  : _authenticationOperationService = operationService,
        _userCacheOperation = userCacheOperation,
        super(HomeViewState(isLoading: false));
  late final AuthenticationOperation _authenticationOperationService;
  late final HiveCacheOperation<UserCacheModel> _userCacheOperation;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  /// Get Users
  // Future<void> fetchUsers() async {
  //   print(usersFromCache);
  //   final response = await _authenticationOperationService.users();
  //   _saveItems(response);
  //   emit(state.copyWith(users: response));
  // }

  /// Save users to cache
  void _saveItems(List<User> user) {
    for (final element in user) {
      _userCacheOperation.add(UserCacheModel(user: element));
    }
  }

  /// Get users from cache
  List<User> get usersFromCache => _userCacheOperation.getAll().map((e) => e.user).toList();
}
