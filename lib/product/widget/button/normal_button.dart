import 'package:flutter/material.dart';
import 'package:my_architecture_template/product/utility/constans/project_radius/project_radius.dart';

/// Project is NormalButton
final class NormalButton extends StatelessWidget {
  /// Project is NormalButton constructor
  const NormalButton({super.key, required this.title, required this.OnPressed});

  /// Ttile text
  final String title;

  /// button on pressed
  final VoidCallback OnPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: ProjectRadius.medium.value,
      child: Text(title),
      onTap: () {},
    );
  }
}
