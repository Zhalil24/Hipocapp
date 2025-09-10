import 'package:flutter/material.dart';

/// Project general Padding
final class ProjectPadding extends EdgeInsets {
  /// All Padding
  /// [ ProjectPadding.allNormal] is 8
  ProjectPadding.allNormal() : super.all(20);

  /// [ ProjectPadding.allMedium ] is 16
  ProjectPadding.allMedium() : super.all(16);

  /// [ ProjectPadding.allSmall ] is 8
  ProjectPadding.allSmall() : super.all(8);

  /// [ ProjectPadding.allLarge ] is 32
  ProjectPadding.allLarge() : super.all(32);

  /// Symetric
  /// only left, right, buttom
}
