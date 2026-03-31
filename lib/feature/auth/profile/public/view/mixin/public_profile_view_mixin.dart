import 'package:hipocapp/feature/auth/profile/public/view/public_profile_view.dart';
import 'package:hipocapp/feature/auth/profile/public/view_model/public_profile_view_model.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/service/user_service.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

mixin PublicProfileViewMixin on BaseState<PublicProfileView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final PublicProfileViewModel _publicProfileViewModel;

  PublicProfileViewModel get publicProfileViewModel => _publicProfileViewModel;

  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: _productNetworkErrorManager.handleError,
    );
    _publicProfileViewModel = PublicProfileViewModel(
      userOperation: UserService(ProductStateItems.productNetworkManager),
    );
    _publicProfileViewModel.getProfile(widget.userId);
  }
}
