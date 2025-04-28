import 'package:hipocapp/feature/entry_list/view/entry_list_view.dart';
import 'package:hipocapp/feature/entry_list/view_model/entry_list_view_model.dart';
import 'package:hipocapp/product/service/entry_list_service.dart';
import 'package:hipocapp/product/service/entry_service.dart';
import 'package:hipocapp/product/service/manager/product_network_error_manager.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/state/container/product_satate_items.dart';

mixin EntryListViewMixin on BaseState<EntryListView> {
  late final ProductNetworkErrorManager _productNetworkErrorManager;
  late final EntryListViewModel _entryListViewModel;

  EntryListViewModel get entryListViewModel => _entryListViewModel;
  @override
  void initState() {
    super.initState();
    _productNetworkErrorManager = ProductNetworkErrorManager(context: context);
    ProductStateItems.productNetworkManager.listenErrorState(onErrorStatus: _productNetworkErrorManager.handleError);
    _entryListViewModel = EntryListViewModel(
      entryListOperation: EntryListService(ProductStateItems.productNetworkManager),
      entryOperation: EntryService(ProductStateItems.productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
    );
    _entryListViewModel.getEntryList(widget.titleName);
  }
}
