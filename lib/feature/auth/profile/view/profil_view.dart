import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/auth/profile/view/mixin/profile_view_mixin.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/change_password_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/edit_profile_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/my_entries_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_info_widget.dart';
import 'package:hipocapp/product/widget/tab_buttons/tab_buttons_widget.dart';
import 'package:hipocapp/feature/auth/profile/view_model/profile_view_model.dart';
import 'package:hipocapp/feature/auth/profile/view_model/state/profile_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';
import 'package:hipocapp/product/utility/extension/service_snack_bar.dart';
import 'package:hipocapp/product/widget/custom_loader/custom_loader_widget.dart';
import 'package:kartal/kartal.dart';

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
          context.read<ProfileViewModel>().clearServiceMessage();
          if (msg != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              createServiceSnackBar(msg),
            );
            context.read<ProfileViewModel>().clearServiceMessage();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Profilim'),
          ),
          body: BlocBuilder<ProfileViewModel, ProfileViewState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CustomLoader());
              }
              if (nameController.text.isEmpty && state.profileModel != null) {
                nameController.text = state.profileModel!.name.toString();
                surnameController.text = state.profileModel!.surname.toString();
                usernameController.text = state.profileModel!.username.toString();
                emailController.text = state.profileModel!.email.toString();
              }
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: context.sized.mediumValue),
                    child: TabButtonsWidget<ProfileTabType>(
                      activeTabIndex: state.activeTab.index,
                      tabs: ProfileTabType.values,
                      onTap: (index) => profileViewModel.changeTab(
                        ProfileTabType.values[index],
                      ),
                    ),
                  ),
                  SizedBox(height: context.sized.normalValue),
                  Expanded(
                    child: _buildTabContent(state.activeTab, profileViewModel.state),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Returns the widget based on the given [tab] and [state].
  ///
  /// If [tab] is [ProfileTabType.profile], it returns [ProfileInfoWidget] with
  /// the profile information of the user.
  ///
  /// If [tab] is [ProfileTabType.editProfile], it returns [EditProfileWidget]
  /// with the ability to edit the user's profile information.
  ///
  /// If [tab] is [ProfileTabType.changePassword], it returns [ChangePasswordWidget]
  /// with the ability to change the user's password.
  ///
  /// If [tab] is [ProfileTabType.entries], it returns a [ListView] with the
  /// entries of the user.
  Widget _buildTabContent(ProfileTabType tab, ProfileViewState state) {
    switch (tab) {
      case ProfileTabType.profile:
        return ProfileInfoWidget(
          onTop: () {
            profileViewModel.logout(context);
          },
          imageURL: state.profileModel?.photoURL ?? '',
          name: state.profileModel?.name ?? '',
          surname: state.profileModel?.surname ?? '',
          email: state.profileModel?.email ?? '',
          username: state.profileModel?.username ?? '',
        );
      case ProfileTabType.editProfile:
        return EditProfileWidget(
          selectedPhoto: state.photo,
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
          onChangePressed: () async {
            await profileViewModel.changePassword(
              passwordChangeController.text,
              newPasswordChangeController.text,
              newPasswordReChangeController.text,
              productViewModel.state.currentUserId!,
            );
          },
        );
      case ProfileTabType.entries:
        return ListView.builder(
          itemCount: state.profileModel?.entries?.length,
          itemBuilder: (context, index) {
            return MyEntriesWidget(
              desc: state.profileModel?.entries?[index].description ?? '',
              titleName: state.profileModel?.entries?[index].titleName ?? '',
              onPressed: () {
                final entryId = state.profileModel?.entries?[index].id;
                profileViewModel.deleteEntry(entryId ?? 0);
              },
            );
          },
        );
    }
  }
}
