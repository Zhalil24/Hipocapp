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
    _splashViewModel = SplashViewModel(
        userCacheOperation: ProductStateItems.productCache.userCacheOperation,
        onboardingCacheOperation: ProductStateItems.productCache.onboardingCacheOperation);
    _initControl();
  }

  Future<void> _onSplashComplete() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    final onboardingCache = await splashViewModel.getOnBoardingCache();
    if (onboardingCache == null || onboardingCache.showOnboarding == true) {
      await productViewModel.hideOnboarding();
      await AutoRouter.of(context).replace(const IntroductionRoute());
    } else {
      await AutoRouter.of(context).replace(const HomeRoute());
    }
  }

  Future<void> _initControl() async {
    if (!mounted) return;
    await productViewModel.initializeAuthState();
    await productViewModel.loadCachedTheme();
    await _onSplashComplete();
  }
}
