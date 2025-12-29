import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/home/view/widget/group_card_skeleton_widget.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:kartal/kartal.dart';

class AutoSlidingGroupContainer extends StatefulWidget {
  const AutoSlidingGroupContainer({required this.groups, super.key});
  final List<GroupListModel> groups;

  @override
  State<AutoSlidingGroupContainer> createState() => _AutoSlidingGroupContainerState();
}

class _AutoSlidingGroupContainerState extends State<AutoSlidingGroupContainer> {
  int _currentIndex = 0;
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!mounted) return;

      setState(() => _visible = false);

      Future.delayed(const Duration(milliseconds: 400), () {
        if (!mounted) return;

        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.groups.length;
          _visible = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.groups.isEmpty) {
      return const GroupSkeleton();
    }

    final group = widget.groups[_currentIndex];
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(context.sized.lowValue),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(context.sized.normalValue * 1.2),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(context.sized.lowValue),
          border: Border.all(
            color: colorScheme.primary,
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kanallarımız',
              style: TextStyle(
                fontSize: context.sized.normalValue * 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: context.sized.lowValue),
            AnimatedSlide(
              offset: _visible ? Offset.zero : const Offset(1, 0),
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: AnimatedOpacity(
                opacity: _visible ? 1 : 0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  padding: EdgeInsets.all(context.sized.lowValue),
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(context.sized.lowValue),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        group.groupName ?? '',
                        style: TextStyle(
                          fontSize: context.sized.normalValue,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(height: context.sized.lowValue),
                      Text(
                        group.description ?? '',
                        style: TextStyle(
                          fontSize: context.sized.normalValue * 0.8,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: context.sized.lowValue),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  await context.router.push(const GroupListRoute());
                },
                child: Text(
                  'Daha Fazlası • Katılmak İçin Tıklayınız',
                  style: TextStyle(
                    fontSize: context.sized.normalValue * 0.8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
