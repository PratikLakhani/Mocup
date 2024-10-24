import 'package:flutter/material.dart';

/// A wrapper for keeping the state of a widget alive
class KeepAliveWrapper extends StatefulWidget {
  /// constructor
  const KeepAliveWrapper({required this.child, super.key});

  /// child widget
  final Widget child;

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
