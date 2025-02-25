import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_architecture_template/product/init/application_initialize.dart';
import 'package:my_architecture_template/product/init/product_localization.dart';
import 'package:my_architecture_template/product/init/state_initialize.dart';
import 'package:my_architecture_template/product/init/theme/custom_dark_theme.dart';
import 'package:my_architecture_template/product/init/theme/custom_light_theme.dart';
import 'package:my_architecture_template/product/navigation/app_router.dart';
import 'package:my_architecture_template/product/state/view_model/product_view_model.dart';
import 'package:widgets/widgets.dart';

Future<void> main() async {
  await ApplicationInitialize().make();
  runApp(ProductLocalization(child: const StateInitialize(child: _MyApp())));
}

class _MyApp extends StatelessWidget {
  const _MyApp();
  static final appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter.config(),
      theme: CustomLightTheme().themedata,
      darkTheme: CustomDarkTheme().themedata,
      builder: CustomResponsive.build,
      themeMode: context.watch<ProductViewModel>().state.themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
    );
  }
}
