import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/auth/profile/public/view/widget/public_profile_header_card_widget.dart';
import 'package:hipocapp/feature/auth/profile/view/widget/profile_background_widget.dart';
import 'package:kartal/kartal.dart';

class PublicProfilePageContentWidget extends StatelessWidget {
  const PublicProfilePageContentWidget({
    super.key,
    required this.profileModel,
    this.fallbackUsername,
  });

  final ProfileModel? profileModel;
  final String? fallbackUsername;

  @override
  Widget build(BuildContext context) {
    final normal = context.sized.normalValue;

    return Stack(
      children: [
        const Positioned.fill(
          child: ProfileBackgroundWidget(),
        ),
        Positioned.fill(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              normal * 0.82,
              normal * 1.2,
              normal * 0.82,
              normal * 1.5,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 860),
                child: PublicProfileHeaderCardWidget(
                  profileModel: profileModel,
                  fallbackUsername: fallbackUsername,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
