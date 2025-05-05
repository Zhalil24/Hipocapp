import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';
import 'package:hipocapp/product/widget/circle_avatar/custom_circle_avatar.dart';
import 'package:kartal/kartal.dart';
import '../../../../../product/widget/toggle_buton/toggle_button.dart';

class ProfileInfoWidget extends StatefulWidget {
  const ProfileInfoWidget(
      {super.key,
      required this.name,
      required this.surname,
      required this.username,
      required this.email,
      required this.imageURL,
      required this.onTop});
  final String name;
  final String surname;
  final String username;
  final String email;
  final String imageURL;
  final VoidCallback onTop;
  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.sized.mediumValue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CustomCircleAvatar(imageURL: widget.imageURL, radius: context.sized.highValue),
          ),
          SizedBox(height: context.sized.mediumValue),
          const ToggleButton(),
          SizedBox(height: context.sized.mediumValue),
          ProfileInfoRow(label: 'Ad', value: widget.name),
          ProfileInfoRow(label: 'Soyad', value: widget.surname),
          ProfileInfoRow(label: 'Kullanıcı Adı', value: widget.username),
          ProfileInfoRow(label: 'Email', value: widget.email),
          SizedBox(height: context.sized.mediumValue),
          CustomActionButton(onTop: widget.onTop, text: 'Çıkış Yap')
        ],
      ),
    );
  }
}

class ProfileInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const ProfileInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.sized.normalValue),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
