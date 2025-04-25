import 'package:auto_route/auto_route.dart';
import 'package:hipocapp/feature/splash/view/splah_view.dart';
import 'package:hipocapp/feature/splash/view_model/splash_view_model.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

import '../../../../product/navigation/app_router.dart';

mixin SplashViewMixin on BaseState<SplashView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final SplashViewModel _splashViewModel;
  SplashViewModel get splashViewModel => _splashViewModel;

  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(onErrorStatus: _productNetworkErrorManager.handleError);
    _splashViewModel = SplashViewModel(userCacheOperation: ProductStateItems.productCache.userCacheOperation);
    _initControl();
  }

  Future<void> _initControl() async {
    if (!mounted) return;
    await Future<void>.delayed(const Duration(seconds: 3));
    if (_splashViewModel.state.isLoggedIn) {
      await context.router.replace(const HomeRoute());
    } else {
      await context.router.replace(const LoginRoute());
    }
  }
}
