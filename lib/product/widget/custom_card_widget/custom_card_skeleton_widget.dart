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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _skeletonLine(
                  context,
                  width: context.sized.highValue * 3,
                  height: context.sized.normalValue,
                ),
                SizedBox(height: context.sized.lowValue),
                _skeletonLine(
                  context,
                  width: double.infinity,
                  height: context.sized.lowValue * 1.2,
                ),
                SizedBox(height: context.sized.lowValue * 0.6),
                _skeletonLine(
                  context,
                  width: double.infinity,
                  height: context.sized.lowValue * 1.2,
                ),
                SizedBox(height: context.sized.lowValue * 0.6),
                _skeletonLine(
                  context,
                  width: double.infinity,
                  height: context.sized.lowValue * 1.2,
                ),
                SizedBox(height: context.sized.lowValue * 0.6),
                _skeletonLine(
                  context,
                  width: context.sized.highValue * 3.5,
                  height: context.sized.lowValue * 1.2,
                ),
                SizedBox(height: context.sized.lowValue),
                Align(
                  alignment: Alignment.centerRight,
                  child: _skeletonLine(
                    context,
                    width: context.sized.highValue * 2,
                    height: context.sized.lowValue * 1.4,
                  ),
                ),
                SizedBox(height: context.sized.lowValue),
                Row(
                  children: [
                    _skeletonCircle(context),
                    SizedBox(width: context.sized.lowValue),
                    _skeletonLine(
                      context,
                      width: context.sized.highValue * 1.8,
                      height: context.sized.lowValue,
                    ),
                    SizedBox(width: context.sized.normalValue),
                    _skeletonCircle(context),
                    SizedBox(width: context.sized.lowValue),
                    _skeletonLine(
                      context,
                      width: context.sized.highValue * 1.5,
                      height: context.sized.lowValue,
                    ),
                  ],
                ),
                SizedBox(height: context.sized.normalValue),
                Align(
                  alignment: Alignment.centerRight,
                  child: _skeletonLine(
                    context,
                    width: context.sized.highValue * 2.5,
                    height: context.sized.normalValue * 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(height: context.sized.normalValue, color: Colors.grey.shade300),
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
