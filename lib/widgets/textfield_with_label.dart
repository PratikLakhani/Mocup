import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextfieldWithLabel extends StatelessWidget {
  const TextfieldWithLabel({
    required this.textfield,
    super.key,
  });
  final Widget textfield;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textfield,
      ],
    );
  }
}
