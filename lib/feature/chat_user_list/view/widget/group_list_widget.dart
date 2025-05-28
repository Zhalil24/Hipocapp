import 'package:flutter/material.dart';
import 'package:hipocapp/product/utility/constans/list_tile/list_tile_decoration.dart';
import 'package:kartal/kartal.dart';

class GroupListWidget extends StatefulWidget {
  const GroupListWidget({super.key, this.groupName, required this.onTop});

  final String? groupName;
  final VoidCallback onTop;

  @override
  State<GroupListWidget> createState() => _GroupListWidgetState();
}

class _GroupListWidgetState extends State<GroupListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Container(
        padding: EdgeInsets.all(context.sized.lowValue),
        decoration: titleListDecoration(),
        child: Row(
          children: [
            Icon(
              Icons.group,
              size: context.sized.normalValue,
              color: Colors.black,
            ),
            SizedBox(width: context.sized.lowValue),
            Expanded(
              child: Text(
                widget.groupName ?? 'Bilinmeyen',
                style: TextStyle(
                  fontSize: context.sized.normalValue,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: widget.onTop,
    );
  }
}
