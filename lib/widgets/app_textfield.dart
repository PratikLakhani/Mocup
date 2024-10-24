import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plug2go/extensions/ext_build_context.dart';
import 'package:plug2go/utils/app_colors.dart';
import 'package:plug2go/utils/app_padding.dart';
import 'package:plug2go/utils/app_size.dart';
import 'package:plug2go/widgets/app_spacebox.dart';
import 'package:plug2go/widgets/app_text_widget.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    this.title,
    this.titleStyle,
    this.controller,
    this.validator,
    this.suffixPadding,
    this.prefixIcon,
    this.hintText,
    this.shadow,
    this.labelText,
    this.inputFormatters,
    this.maxTextLength,
    this.readOnly = false,
    this.keyboardType,
    this.onTap,
    this.subTitle,
    this.prefixPadding,
    this.isStartTime = true,
    super.key,
    this.textAction,
    this.suffix,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.cursorColor,
    this.inputBorder,
    this.maxLine = 1,
    this.fillColor = AppColors.white,
    this.focusNode,
    this.fontSize,
    this.onSaved,
    this.contentHeight,
    this.borderRadius,
    this.style,
    this.contentWidth,
    this.hintStyle,
    this.borderSide,
    this.textAlignVertical,
    this.prefix,
    this.isDense,
    this.prefixIconConstraints,
    this.autofocus,
    this.suffixIconConstraints,
    this.floatingLabelColor,
    this.autofillHints,
    this.textAlign = TextAlign.start,
  });
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? title;
  final TextStyle? titleStyle;
  final void Function(String?)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isStartTime;
  final Widget? suffix;
  final BoxShadow? shadow;
  final double? suffixPadding;
  final String? hintText;
  final String? labelText;
  final EdgeInsetsGeometry? prefixPadding;
  final Color? floatingLabelColor;
  final int? maxTextLength;
  final Color? cursorColor;
  final bool readOnly;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textAction;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? inputBorder;
  final int? maxLine;
  final FocusNode? focusNode;
  final double? fontSize;
  final void Function(String?)? onSaved;
  final double? contentHeight;
  final double? contentWidth;
  final double? borderRadius;
  final Color? fillColor;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final BorderSide? borderSide;
  final TextAlignVertical? textAlignVertical;
  final Widget? prefix;
  final bool? isDense;
  final BoxConstraints? prefixIconConstraints;
  final String? subTitle;
  final bool? autofocus;
  final BoxConstraints? suffixIconConstraints;
  final Iterable<String>? autofillHints;
  final TextAlign textAlign;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _isFocused = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    if (widget.focusNode == null) {
      _focusNode.addListener(() {
        _isFocused.value = _focusNode.hasFocus;
      });
    } else {
      widget.focusNode!.addListener(() {
        _isFocused.value = widget.focusNode!.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          AppTextWidget(
            widget.title!,
            style: widget.titleStyle ??
                context.textTheme.titleMedium!.copyWith(
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.textFieldTitleColor,
                ),
          )
        else
          const SizedBox(),
        if (widget.title != null) SpaceV(AppSize.h6) else const SizedBox(),
        ValueListenableBuilder(
          valueListenable: _isFocused,
          builder: (context, isFocused, child) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              decoration: BoxDecoration(
                boxShadow: widget.shadow != null
                    ? [widget.shadow!]
                    : isFocused
                        ? [
                            const BoxShadow(
                              color: AppColors.lightPurpleBorderColor,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? AppSize.r10,
                ),
              ),
              child: TextFormField(
                focusNode: widget.focusNode ?? _focusNode,
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                maxLength: widget.maxTextLength,
                cursorColor: widget.cursorColor ?? AppColors.primaryColor,
                validator: widget.validator,
                textInputAction: widget.textAction,
                onChanged: widget.onChanged,
                readOnly: widget.readOnly,
                obscureText: widget.obscureText,
                onTap: widget.onTap,
                onSaved: widget.onSaved,
                maxLines: widget.maxLine,
                inputFormatters: widget.inputFormatters,
                textAlignVertical: widget.textAlignVertical,
                textAlign: widget.textAlign,
                autofocus: widget.autofocus ?? false,
                autofillHints: widget.autofillHints,
                style: widget.style ??
                    context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: widget.contentWidth ?? AppSize.w15,
                    vertical: widget.contentHeight ?? AppSize.h18,
                  ),
                  errorMaxLines: 2,
                  counterText: '',
                  prefixIconConstraints: widget.prefixIconConstraints ?? const BoxConstraints(),
                  suffixIconConstraints: widget.suffixIconConstraints,
                  isDense: widget.isDense ?? false,
                  border: widget.inputBorder ??
                      OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius ?? AppSize.r10,
                        ),
                        borderSide: widget.borderSide ?? BorderSide.none,
                      ),
                  prefixIcon: widget.prefixIcon == null
                      ? null
                      : Padding(
                          padding: widget.prefixPadding ?? EdgeInsets.zero,
                          child: widget.prefixIcon,
                        ),
                  prefix: widget.prefix == null
                      ? null
                      : Padding(
                          padding: widget.prefixPadding ?? EdgeInsets.zero,
                          child: widget.prefix,
                        ),
                  suffix: widget.suffix,
                  suffixIcon: widget.suffixIcon == null
                      ? null
                      : widget.suffixPadding != null
                          ? AppPadding.all(
                              padding: widget.suffixPadding ?? 0,
                              child: widget.suffixIcon,
                            )
                          : AppPadding(
                              right: AppSize.w14,
                              left: AppSize.w8,
                              top: 18,
                              bottom: 18,
                              child: widget.suffixIcon,
                            ),
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  floatingLabelStyle: TextStyle(
                    fontSize: widget.fontSize ?? AppSize.sp16,
                    color: widget.floatingLabelColor ?? AppColors.black,
                  ),
                  labelStyle: TextStyle(
                    fontSize: widget.fontSize ?? AppSize.sp15,
                    color: AppColors.black,
                  ),
                  hintStyle: widget.hintStyle ??
                      context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.hintTextColor,
                      ),
                  errorStyle: TextStyle(
                    color: AppColors.errorColor,
                    fontSize: AppSize.sp12,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? AppSize.r10,
                    ),
                    borderSide: widget.borderSide ??
                        BorderSide(
                          width: AppSize.w2,
                        ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? AppSize.r10,
                    ),
                    borderSide: widget.borderSide ??
                        BorderSide(
                          width: AppSize.w2,
                          color: AppColors.lightPurpleBorderColor,
                        ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? AppSize.r10,
                    ),
                    borderSide: widget.borderSide ??
                        BorderSide(
                          color: AppColors.purpleBorderColor,
                          width: AppSize.w2,
                        ),
                  ),
                  errorBorder:
                      // UnderlineInputBorder(
                      OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      widget.borderRadius ?? AppSize.r10,
                    ),
                    borderSide: widget.borderSide ??
                        BorderSide(
                          width: AppSize.w2,
                        ),
                  ),
                  filled: widget.fillColor != null,
                  fillColor: widget.fillColor ?? AppColors.white,
                ),
              ),
            );
          },
        ),
        if (widget.subTitle != null) SpaceV(AppSize.h3) else const SizedBox(),
        if (widget.subTitle != null)
          AppPadding(
            left: AppSize.w10,
            child: AppTextWidget(
              widget.subTitle!,
              style: widget.titleStyle ??
                  context.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.sp11,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                  ),
            ),
          ),
      ],
    );
  }
}
