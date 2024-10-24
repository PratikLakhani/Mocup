import 'package:flutter/material.dart';
import 'package:plug2go/extensions/ext_build_context.dart';
import 'package:plug2go/utils/app_colors.dart';
import 'package:plug2go/utils/app_size.dart';
import 'package:plug2go/widgets/app_button.dart';

class OptionPopUp extends StatelessWidget {
  const OptionPopUp({
    required this.title,
    required this.body,
    required this.icon,
    required this.onPositive,
    required this.onNegative,
    required this.positive,
    required this.negative,
    super.key,
  });
  final String title;
  final String body;
  final Widget icon;
  final VoidCallback onPositive;
  final VoidCallback onNegative;
  final String positive;
  final String negative;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: context.width,
        margin: EdgeInsets.all(AppSize.h30),
        padding: EdgeInsets.all(AppSize.h20),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppSize.r20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: AppSize.h10),
            Container(
              height: AppSize.h90,
              width: AppSize.h90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.r20),
                color: AppColors.black,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.25),
                    offset: const Offset(0, 20),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Center(
                child: icon,
              ),
            ),
            SizedBox(height: AppSize.h20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium?.copyWith(fontSize: AppSize.sp22, fontWeight: FontWeight.bold),
            ),
            Text(
              body,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium
                  ?.copyWith(fontSize: AppSize.sp14, fontWeight: FontWeight.w500, color: AppColors.greyTextColor),
            ),
            SizedBox(height: AppSize.h30),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    onTap: onPositive,
                    title: positive,
                  ),
                ),
                SizedBox(width: AppSize.w16),
                Expanded(
                  child: AppButton(
                    onTap: onNegative,
                    title: negative,
                    titleColor: AppColors.black,
                    fillColor: AppColors.greyButtonColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
