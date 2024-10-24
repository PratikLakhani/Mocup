import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget(
    this.text, {
    super.key,
    this.style,
    this.maxLines,
    this.textAlign,
  });
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: style,
    );
  }
}
