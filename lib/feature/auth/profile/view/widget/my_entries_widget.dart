import 'package:flutter/material.dart';
import 'package:hipocapp/product/widget/button/custom_action_button/custom_action_button.dart';
import 'package:hipocapp/product/widget/custom_card_widget/custom_card_widget.dart';
import 'package:kartal/kartal.dart';

class MyEntriesWidget extends StatefulWidget {
  const MyEntriesWidget({super.key, required this.titleName, required this.desc, required this.onPressed});
  final String titleName;
  final String desc;
  final VoidCallback onPressed;
  @override
  State<MyEntriesWidget> createState() => _MyEntriesWidgetState();
}

class _MyEntriesWidgetState extends State<MyEntriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCardWidget(
          description: widget.desc,
          title: widget.titleName,
          isHomeCard: false,
        ),
        CustomActionButton(onTop: widget.onPressed, text: 'Silmek için tıklayınız.'),
        Divider(
          color: Colors.grey,
          thickness: 3,
          height: context.sized.lowValue,
        ),
      ],
    );
  }
}
