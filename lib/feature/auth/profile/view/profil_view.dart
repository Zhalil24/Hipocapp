import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hipocapp/feature/auth/profile/view/mixin/profile_view_mixin.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/change_password_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/edit_profile_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/my_entries_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_info_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/tab_buttons_widget.dart';
import 'package:hipocapp/feature/auth/profile/view_model/profile_view_model.dart';
import 'package:hipocapp/feature/auth/profile/view_model/state/profile_view_state.dart';
import 'package:hipocapp/product/state/base/base_state.dart';
import 'package:hipocapp/product/utility/enums/profile_tab_type.dart';
import 'package:hipocapp/product/utility/extension/service_snack_bar.dart';
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
          appBar: AppBar(),
          body: BlocBuilder<ProfileViewModel, ProfileViewState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (nameController.text.isEmpty && state.profileModel != null) {
                nameController.text = state.profileModel!.name.toString();
                surnameController.text = state.profileModel!.surname.toString();
                usernameController.text = state.profileModel!.username.toString();
                emailController.text = state.profileModel!.email.toString();
              }
              return Column(
                children: [
                  TabButtonsWidget(
                    activeTabIndex: state.activeTab.index,
                    onTap: (index) => profileViewModel.changeTab(ProfileTabType.values[index]),
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
