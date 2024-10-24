import 'package:flutter/material.dart';
import 'package:plug2go/widgets/app_sizedbox.dart';

/// widget for add space horizontal
class SpaceV extends StatelessWidget {
  /// constructor
  const SpaceV(this.size, {super.key});

  /// size in [double] for vertical space
  final double size;

  @override
  Widget build(BuildContext context) {
    return AppSizedBox(height: size);
  }
}

/// widget for add space horizontal
class SpaceH extends StatelessWidget {
  /// constructor
  const SpaceH(this.size, {super.key});

  /// size in [double] for horizontal space
  final double size;

  @override
  Widget build(BuildContext context) {
    return AppSizedBox(width: size);
  }
}
