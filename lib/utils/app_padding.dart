import 'package:flutter/material.dart';

class AppPadding extends StatelessWidget {
  const AppPadding({
    super.key,
    this.bottom = 0.0,
    this.left = 0.0,
    this.top = 0.0,
    this.right = 0.0,
    this.child,
  });

  const AppPadding.all({
    required double padding,
    super.key,
    this.child,
  })  : top = padding,
        bottom = padding,
        right = padding,
        left = padding;

  const AppPadding.symmetric({
    double? horizontal,
    double? vertical,
    super.key,
    this.child,
  })  : top = vertical ?? 0,
        bottom = vertical ?? 0,
        right = horizontal ?? 0,
        left = horizontal ?? 0;

  // const AppPadding.fromLTRB(
  //   this.left,
  //   this.top,
  //   this.right,
  //   this.bottom, {
  //   super.key,
  //   this.child,
  // });

  final Widget? child;
  final double left;
  final double top;
  final double right;
  final double bottom;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
      ),
      child: child,
    );
  }
}
