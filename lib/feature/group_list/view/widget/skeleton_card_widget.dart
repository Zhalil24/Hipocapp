import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SkeletonCardWidget extends StatefulWidget {
  const SkeletonCardWidget({super.key});

  @override
  State<SkeletonCardWidget> createState() => _SkeletonCardWidgetState();
}

class _SkeletonCardWidgetState extends State<SkeletonCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.sized.lowValue),
      ),
      child: Padding(
        padding: EdgeInsets.all(context.sized.normalValue),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Container(
              height: 16,
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
            ),

            SizedBox(height: context.sized.lowValue),

            // Date
            Container(
              height: 12,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
            ),

            SizedBox(height: context.sized.lowValue),

            // Description lines
            Container(
              height: 12,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            SizedBox(height: 6),
            Container(
              height: 12,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
