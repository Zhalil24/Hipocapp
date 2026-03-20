import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomCardWidgetSkeleton extends StatelessWidget {
  const CustomCardWidgetSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.symmetric(
            horizontal: context.sized.lowValue,
            vertical: context.sized.lowValue,
          ),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(context.sized.lowValue),
          ),
          child: Padding(
            padding: EdgeInsets.all(context.sized.lowValue),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _skeletonLine(
                      context,
                      width: maxWidth * 0.56,
                      height: context.sized.normalValue,
                    ),
                    SizedBox(height: context.sized.lowValue),
                    _skeletonLine(
                      context,
                      width: maxWidth,
                      height: context.sized.lowValue * 1.2,
                    ),
                    SizedBox(height: context.sized.lowValue * 0.6),
                    _skeletonLine(
                      context,
                      width: maxWidth,
                      height: context.sized.lowValue * 1.2,
                    ),
                    SizedBox(height: context.sized.lowValue * 0.6),
                    _skeletonLine(
                      context,
                      width: maxWidth,
                      height: context.sized.lowValue * 1.2,
                    ),
                    SizedBox(height: context.sized.lowValue * 0.6),
                    _skeletonLine(
                      context,
                      width: maxWidth * 0.72,
                      height: context.sized.lowValue * 1.2,
                    ),
                    SizedBox(height: context.sized.lowValue),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _skeletonLine(
                        context,
                        width: maxWidth * 0.38,
                        height: context.sized.lowValue * 1.4,
                      ),
                    ),
                    SizedBox(height: context.sized.lowValue),
                    Wrap(
                      spacing: context.sized.normalValue,
                      runSpacing: context.sized.lowValue,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        _SkeletonMetaItem(
                          circle: _skeletonCircle(context),
                          line: _skeletonLine(
                            context,
                            width: maxWidth * 0.24,
                            height: context.sized.lowValue,
                          ),
                        ),
                        _SkeletonMetaItem(
                          circle: _skeletonCircle(context),
                          line: _skeletonLine(
                            context,
                            width: maxWidth * 0.2,
                            height: context.sized.lowValue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.sized.normalValue),
                    Align(
                      alignment: Alignment.centerRight,
                      child: _skeletonLine(
                        context,
                        width: maxWidth * 0.46,
                        height: context.sized.normalValue * 1.4,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        Divider(
          height: context.sized.normalValue,
          color: Colors.grey.shade300,
        ),
      ],
    );
  }

  Widget _skeletonLine(
    BuildContext context, {
    required double width,
    required double height,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(context.sized.lowValue * 0.6),
      ),
    );
  }

  Widget _skeletonCircle(BuildContext context) {
    return Container(
      width: context.sized.normalValue,
      height: context.sized.normalValue,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _SkeletonMetaItem extends StatelessWidget {
  const _SkeletonMetaItem({
    required this.circle,
    required this.line,
  });

  final Widget circle;
  final Widget line;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        circle,
        SizedBox(width: context.sized.lowValue),
        line,
      ],
    );
  }
}
