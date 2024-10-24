import 'package:flutter/material.dart';
import 'package:plug2go/main.dart';
import 'package:plug2go/utils/app_colors.dart';
import 'package:plug2go/utils/app_size.dart';
import 'package:plug2go/widgets/app_text_widget.dart';

class AppSnackbar {
  static dynamic showSnackbar({
    required String message,
    required BuildContext context,
    VoidCallback? onActionPress,
    Color? color,
    double? bottomMargin,
    int? durationInSecond,
  }) {
    return ScaffoldMessenger.of(rootNavKey.currentContext ?? context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: bottomMargin ?? AppSize.h30,
            left: AppSize.w10,
            right: AppSize.w10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSize.r10,
            ),
          ),
          action: onActionPress != null
              ? SnackBarAction(
                  label: 'Yes',
                  textColor: Colors.white,
                  onPressed: onActionPress,
                )
              : null,
          content: AppTextWidget(
            message,
            style: Theme.of(rootNavKey.currentContext!).textTheme.titleSmall?.copyWith(
                  color: AppColors.white,
                ),
          ),
          backgroundColor: color ?? AppColors.primaryColor.withOpacity(.8),
          duration: Duration(seconds: durationInSecond ?? 2),
        ),
      );
  }
}
