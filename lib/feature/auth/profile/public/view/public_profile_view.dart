import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/auth/profile/public/view/mixin/public_profile_view_mixin.dart';
import 'package:hipocapp/feature/auth/profile/public/view/widget/public_profile_page_content_widget.dart';
import 'package:hipocapp/feature/auth/profile/public/view_model/public_profile_view_model.dart';
import 'package:hipocapp/feature/auth/profile/public/view_model/state/public_profile_view_state.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/widget/appbar/custom_appbar_widget.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';

@RoutePage()
class PublicProfileView extends StatefulWidget {
  const PublicProfileView({
    required this.userId,
    this.username,
    super.key,
  });

  final int userId;
  final String? username;

  @override
  State<PublicProfileView> createState() => _PublicProfileViewState();
}

class _PublicProfileViewState extends BaseState<PublicProfileView>
    with PublicProfileViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => publicProfileViewModel,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          isDrawer: false,
          title: _resolveTitle(context),
        ),
        body: BlocBuilder<PublicProfileViewModel, PublicProfileViewState>(
          builder: (context, state) {
            if (state.isLoading && state.profileModel == null) {
              return const Center(
                child: CustomLoader(),
              );
            }

            return PublicProfilePageContentWidget(
              profileModel: state.profileModel,
              fallbackUsername: widget.username,
            );
          },
        ),
      ),
    );
  }

  String _resolveTitle(BuildContext context) {
    final state = publicProfileViewModel.state;
    final profileName = state.profileModel?.username?.trim() ?? '';
    if (profileName.isNotEmpty) {
      return profileName;
    }

    final initialName = widget.username?.trim() ?? '';
    if (initialName.isNotEmpty) {
      return initialName;
    }

    return LocaleKeys.auth_profile_tab_profile.tr();
  }
}
