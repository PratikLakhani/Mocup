import 'package:flutter/material.dart';
import 'package:plug2go/extensions/ext_build_context.dart';
import 'package:plug2go/utils/app_colors.dart';
import 'package:plug2go/utils/app_padding.dart';
import 'package:plug2go/utils/app_size.dart';
import 'package:plug2go/widgets/app_spacebox.dart';
import 'package:plug2go/widgets/app_text_widget.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    this.title,
    this.titleFontWeight,
    this.fillColor = AppColors.primaryColor,
    this.titleColor,
    this.titleFontSize,
    this.suffixGap,
    this.prefixGap,
    this.titleTextStyle,
    this.height,
    this.boxShadow = true,
    this.textAlign,
    this.width,
    this.onTap,
    this.radius,
    this.prefix,
    this.suffix,
    super.key,
    this.horizontalPadding,
    this.verticalPadding,
  })  : borderColor = AppColors.transparent,
        strokeWidth = 0;

  const AppButton.outlined({
    this.title,
    this.titleFontWeight,
    this.borderColor = AppColors.greyTextColor,
    this.titleFontSize,
    this.boxShadow = true,
    this.titleTextStyle,
    this.suffixGap,
    this.prefixGap,
    this.titleColor,
    this.textAlign,
    this.height,
    this.width,
    this.onTap,
    this.radius,
    this.strokeWidth,
    this.prefix,
    this.suffix,
    super.key,
    this.horizontalPadding,
    this.verticalPadding,
    this.fillColor = AppColors.transparent,
  });

  const AppButton.filledWithBorder({
    this.title,
    this.titleFontWeight,
    this.borderColor = AppColors.greyTextColor,
    this.fillColor = AppColors.primaryColor,
    this.titleFontSize,
    this.titleTextStyle,
    this.suffixGap,
    this.prefixGap,
    this.height,
    this.titleColor,
    this.textAlign,
    this.boxShadow = true,
    this.width,
    this.onTap,
    this.radius,
    this.strokeWidth,
    this.prefix,
    this.suffix,
    super.key,
    this.horizontalPadding,
    this.verticalPadding,
  });

  final String? title;
  final Color fillColor;
  final Color borderColor;
  final void Function()? onTap;
  final double? radius;
  final TextAlign? textAlign;
  final TextStyle? titleTextStyle;
  final Color? titleColor;
  final FontWeight? titleFontWeight;
  final double? titleFontSize;
  final double? height;
  final bool boxShadow;
  final double? width;
  final double? suffixGap;
  final double? prefixGap;
  final double? strokeWidth;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Widget? prefix;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? BtnDefaults.height,
        width: width ?? BtnDefaults.width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(radius ?? BtnDefaults.radius),
          border: Border.all(
            width: strokeWidth ?? BtnDefaults.strokeWidth,
            color: borderColor,
          ),
          boxShadow: boxShadow
              ? [
                  BoxShadow(
                    color: fillColor.withOpacity(0.2),
                    // spreadRadius: 1,
                    offset: const Offset(0, 10),
                    blurRadius: 20,
                  ),
                ]
              : [],
        ),
        child: AppPadding.symmetric(
          horizontal: horizontalPadding ?? BtnDefaults.horiZontalPadding,
          vertical: verticalPadding ?? BtnDefaults.verticalPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefix != null) ...[
                prefix!,
                if (title != null) SpaceH(prefixGap ?? BtnDefaults.titlePrefixGap),
              ],
              if (suffix != null) SpaceH(BtnDefaults.titlePrefixGap),
              if (title != null)
                Flexible(
                  child: AppTextWidget(
                    title!,
                    textAlign: textAlign,
                    style: titleTextStyle ??
                        context.textTheme.titleMedium?.copyWith(
                          fontWeight: titleFontWeight ?? FontWeight.w600,
                          color: titleColor ?? AppColors.white,
                        ),
                  ),
                ),
              if (suffix != null) ...[
                SpaceH(suffixGap ?? BtnDefaults.titlePrefixGap),
                suffix!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class BtnDefaults {
  BtnDefaults._();
  static final height = AppSize.h54;
  static const width = double.infinity;
  static final radius = AppSize.r14;
  static final strokeWidth = AppSize.w2;
  static final horiZontalPadding = AppSize.w16;
  static final verticalPadding = AppSize.h8;
  static final titleFontSize = AppSize.sp16;
  static final titlePrefixGap = AppSize.sp8;
}
