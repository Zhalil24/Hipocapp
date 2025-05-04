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
      create: (context) => profileViewModel,
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
    );
  }

  Widget _buildTabContent(ProfileTabType tab, ProfileViewState state) {
    switch (tab) {
      case ProfileTabType.profile:
        return ProfileInfoWidget(
          onTop: () {
            profileViewModel.logout(context);
          },
          message: state.seviceResultMessage ?? '',
          imageURL: state.profileModel?.photoURL ?? '',
          name: state.profileModel?.name ?? '',
          surname: state.profileModel?.surname ?? '',
          email: state.profileModel?.email ?? '',
          username: state.profileModel?.username ?? '',
        );
      case ProfileTabType.editProfile:
        return EditProfileWidget(
          message: state.seviceResultMessage ?? '',
          passwordController: passwordController,
          passwordReController: passwordReController,
          selectedPhoto: state.photo,
          onPickImage: pickImageFromGallery,
          nameController: nameController,
          surnameController: surnameController,
          usernameController: usernameController,
          emailController: emailController,
          onUpdate: (name, surname, username, email, password, passwordRe) {
            profileViewModel.updateProfile(
              name,
              surname,
              email,
              username,
              password,
              passwordRe,
            );
          },
        );
      case ProfileTabType.changePassword:
        return ChangePasswordWidget(
          message: state.seviceResultMessage ?? '',
          passwordChangeController: passwordChangeController,
          newPasswordChangeController: newPasswordChangeController,
          newPasswordReChangeController: newPasswordReChangeController,
          onChangePressed: () => profileViewModel.changePassword(
            passwordChangeController.text,
            newPasswordChangeController.text,
            newPasswordReChangeController.text,
          ),
        );
      case ProfileTabType.entries:
        return ListView.builder(
          itemCount: state.profileModel?.entries?.length,
          itemBuilder: (context, index) {
            return MyEntriesWidget(
              message: state.seviceResultMessage ?? '',
              desc: state.profileModel?.entries?[index].description ?? '',
              titleName: state.profileModel?.entries?[index].titleName ?? '',
              onPressed: () => profileViewModel.deleteEntry(
                state.profileModel?.entries?[index].id ?? 0,
              ),
            );
          },
        );
    }
  }
}
