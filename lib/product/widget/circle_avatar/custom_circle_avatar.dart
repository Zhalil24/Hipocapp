import 'package:flutter/material.dart';
import 'package:hipocapp/product/init/config/app_environment.dart';

class CustomCircleAvatar extends StatefulWidget {
  const CustomCircleAvatar({
    super.key,
    required this.imageURL,
    required this.radius,
    this.icon = Icons.person,
    this.backgroundColor = const Color(0xFFBDBDBD), // default: grey[400]
  });

  final String imageURL;
  final double radius;
  final IconData icon;
  final Color backgroundColor;

  @override
  State<CustomCircleAvatar> createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar> {
  @override
  Widget build(BuildContext context) {
    final fullImageUrl = '${AppEnvironmentItems.baseUrl.value}${widget.imageURL}';

    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: widget.backgroundColor,
      backgroundImage: widget.imageURL.isNotEmpty ? NetworkImage(fullImageUrl) : null,
      child: widget.imageURL.isEmpty ? Icon(widget.icon, size: widget.radius) : null,
    );
  }
}
