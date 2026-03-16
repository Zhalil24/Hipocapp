import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/auth/profile/view/mixin/profile_view_mixin.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/change_password_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/edit_profile_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_entries_tab_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_info_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_page_content_widget.dart';
import 'package:hipocapp/feature/auth/profile/view_model/profile_view_model.dart';
import 'package:hipocapp/feature/auth/profile/view_model/state/profile_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';
import 'package:hipocapp/product/utility/extension/service_snack_bar.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';

@RoutePage()
class ProfilView extends StatefulWidget {
  const ProfilView({super.key});

  @override
  State<ProfilView> createState() => _ProfilViewState();
}

class _ProfilViewState extends BaseState<ProfilView> with ProfileViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => profileViewModel,
      child: BlocListener<ProfileViewModel, ProfileViewState>(
        listenWhen: (prev, curr) => prev.serviceResponseMessage != curr.serviceResponseMessage && curr.serviceResponseMessage != null,
        listener: (context, state) {
          final msg = state.serviceResponseMessage;
          if (msg == null) return;
          ScaffoldMessenger.of(context).showSnackBar(
            createServiceSnackBar(msg),
          );
          context.read<ProfileViewModel>().clearServiceMessage();
        },
        child: Scaffold(
          body: BlocBuilder<ProfileViewModel, ProfileViewState>(
            builder: (context, state) {
              if (state.isLoading && state.profileModel == null) {
                return const Center(child: CustomLoader());
              }

              seedProfileControllers(state.profileModel);

              return ProfilePageContentWidget(
                profileModel: state.profileModel,
                selectedPhoto: state.photo,
                activeTab: state.activeTab,
                onLogout: () {
                  profileViewModel.logout(context);
                },
                onTabChanged: profileViewModel.changeTab,
                showBlockingLoader: state.isLoading && state.profileModel != null,
                child: _buildTabContent(state),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(ProfileViewState state) {
    switch (state.activeTab) {
      case ProfileTabType.profile:
        return ProfileInfoWidget(
          profileModel: state.profileModel,
        );
      case ProfileTabType.editProfile:
        return EditProfileWidget(
          selectedPhoto: state.photo,
          currentImageUrl: state.profileModel?.photoURL ?? '',
          onPickImage: pickImageFromGallery,
          nameController: nameController,
          surnameController: surnameController,
          usernameController: usernameController,
          emailController: emailController,
          onUpdate: (name, surname, username, email) {
            profileViewModel.updateProfile(
              name,
              surname,
              email,
              username,
              productViewModel.state.currentUserId!,
            );
          },
        );
      case ProfileTabType.changePassword:
        return ChangePasswordWidget(
          passwordChangeController: passwordChangeController,
          newPasswordChangeController: newPasswordChangeController,
          newPasswordReChangeController: newPasswordReChangeController,
          onChangePressed: () {
            profileViewModel.changePassword(
              passwordChangeController.text,
              newPasswordChangeController.text,
              newPasswordReChangeController.text,
              productViewModel.state.currentUserId!,
            );
          },
        );
      case ProfileTabType.entries:
        return ProfileEntriesTabWidget(
          profileModel: state.profileModel,
          onDelete: (entryId) {
            profileViewModel.deleteEntry(entryId);
          },
        );
    }
  }
}
