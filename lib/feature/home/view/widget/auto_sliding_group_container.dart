import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:hipocapp/feature/home/view/widget/group_card_skeleton_widget.dart';
import 'package:hipocapp/product/init/language/locale_keys.g.dart';
import 'package:hipocapp/product/navigation/app_router.dart';
import 'package:kartal/kartal.dart';

class AutoSlidingGroupContainer extends StatefulWidget {
  const AutoSlidingGroupContainer({
    required this.groups,
    super.key,
  });

  final List<GroupListModel> groups;

  @override
  State<AutoSlidingGroupContainer> createState() =>
      _AutoSlidingGroupContainerState();
}

class _AutoSlidingGroupContainerState extends State<AutoSlidingGroupContainer> {
  int _currentIndex = 0;
  bool _visible = true;
  Timer? _autoSlideTimer;

  bool get _shouldAutoSlide => widget.groups.length > 1;

  @override
  void initState() {
    super.initState();
    if (_shouldAutoSlide) {
      _startAutoSlide();
    }
  }

  @override
  void didUpdateWidget(covariant AutoSlidingGroupContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.groups.isEmpty) {
      _currentIndex = 0;
      _autoSlideTimer?.cancel();
      _autoSlideTimer = null;
      return;
    }

    if (_currentIndex >= widget.groups.length) {
      _currentIndex = 0;
    }

    if (_shouldAutoSlide) {
      if (_autoSlideTimer == null || !_autoSlideTimer!.isActive) {
        _startAutoSlide();
      }
      return;
    }

    _autoSlideTimer?.cancel();
    _autoSlideTimer = null;
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted || widget.groups.isEmpty) return;

      setState(() => _visible = false);

      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted || widget.groups.isEmpty) return;

        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.groups.length;
          _visible = true;
        });
      });
    });
  }

  void _goToNextGroup() {
    if (widget.groups.isEmpty) return;

    _autoSlideTimer?.cancel();
    setState(() => _visible = false);

    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted || widget.groups.isEmpty) return;

      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.groups.length;
        _visible = true;
      });
    });

    if (_shouldAutoSlide) {
      _startAutoSlide();
    }
  }

  void _goToPreviousGroup() {
    if (widget.groups.isEmpty) return;

    _autoSlideTimer?.cancel();
    setState(() => _visible = false);

    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted || widget.groups.isEmpty) return;

      setState(() {
        _currentIndex =
            (_currentIndex - 1 + widget.groups.length) % widget.groups.length;
        _visible = true;
      });
    });

    if (_shouldAutoSlide) {
      _startAutoSlide();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.groups.isEmpty) {
      return const GroupSkeleton();
    }

    final group = widget.groups[_currentIndex];
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.sized.lowValue),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withValues(alpha: 0.85),
              colorScheme.primary,
            ],
          ),
          borderRadius: BorderRadius.circular(context.sized.normalValue),
          boxShadow: [
            BoxShadow(
              color: colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -30,
              top: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              left: -20,
              bottom: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(context.sized.normalValue * 1.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.home_group_carousel_title.tr(),
                        style: TextStyle(
                          fontSize: context.sized.normalValue * 1.1,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.sized.lowValue,
                          vertical: context.sized.lowValue * 0.5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          borderRadius:
                              BorderRadius.circular(context.sized.lowValue),
                        ),
                        child: Text(
                          '${_currentIndex + 1}/${widget.groups.length}',
                          style: TextStyle(
                            fontSize: context.sized.lowValue * 0.9,
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.sized.normalValue),
                  AnimatedSlide(
                    offset: _visible ? Offset.zero : const Offset(0.5, 0),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    child: AnimatedOpacity(
                      opacity: _visible ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            group.groupName ??
                                LocaleKeys.home_group_fallback_title.tr(),
                            style: TextStyle(
                              fontSize: context.sized.normalValue * 1.3,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          SizedBox(height: context.sized.lowValue * 0.5),
                          Text(
                            group.description ??
                                LocaleKeys.home_group_fallback_description.tr(),
                            style: TextStyle(
                              fontSize: context.sized.normalValue * 0.9,
                              color:
                                  colorScheme.onPrimary.withValues(alpha: 0.85),
                              height: 1.5,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: context.sized.normalValue * 1.2),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final useCompactLayout = constraints.maxWidth < 320;
                      final navigationButtons = Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _NavigationButton(
                            colorScheme: colorScheme,
                            icon: Icons.chevron_left_rounded,
                            onPressed: _goToPreviousGroup,
                          ),
                          SizedBox(width: context.sized.lowValue * 0.5),
                          _NavigationButton(
                            colorScheme: colorScheme,
                            icon: Icons.chevron_right_rounded,
                            onPressed: _goToNextGroup,
                          ),
                        ],
                      );

                      final actionButton = FilledButton.icon(
                        onPressed: () async {
                          await context.router.push(const GroupListRoute());
                        },
                        icon: const Icon(Icons.arrow_forward_rounded),
                        label: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            LocaleKeys.home_group_join_cta.tr(),
                            style: TextStyle(
                              fontSize: context.sized.lowValue * 1.1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.25),
                          foregroundColor: colorScheme.onPrimary,
                          padding: EdgeInsets.symmetric(
                            horizontal: context.sized.normalValue,
                            vertical: context.sized.lowValue * 1.2,
                          ),
                        ),
                      );

                      if (useCompactLayout) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            actionButton,
                            SizedBox(height: context.sized.lowValue),
                            Align(
                              alignment: Alignment.centerRight,
                              child: navigationButtons,
                            ),
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(child: actionButton),
                          SizedBox(width: context.sized.lowValue),
                          navigationButtons,
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  const _NavigationButton({
    required this.colorScheme,
    required this.icon,
    required this.onPressed,
  });

  final ColorScheme colorScheme;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        iconSize: context.sized.normalValue * 1.2,
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }
}
