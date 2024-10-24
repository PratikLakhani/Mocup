import 'package:flutter/material.dart';
import 'package:plug2go/extensions/ext_build_context.dart';
import 'package:plug2go/gen/assets.gen.dart';
import 'package:plug2go/utils/app_colors.dart';
import 'package:plug2go/utils/app_size.dart';
import 'package:plug2go/widgets/app_button.dart';

class SuccessPopUp extends StatelessWidget {
  const SuccessPopUp({required this.title, required this.body, required this.showFinishBtn, this.onFinish, super.key});
  final String title;
  final String body;
  final bool showFinishBtn;
  final VoidCallback? onFinish;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: context.width,
        margin: EdgeInsets.all(AppSize.h30),
        padding: EdgeInsets.all(AppSize.h30),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppSize.r20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium?.copyWith(fontSize: AppSize.sp22, fontWeight: FontWeight.bold),
            ),
            Text(
              body,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium?.copyWith(fontSize: AppSize.sp14, fontWeight: FontWeight.w300, color: AppColors.greyBorderColor),
            ),
            // SizedBox(height: AppSize.h50),
            Assets.lottie.success.lottie(
              height: AppSize.h200,
              width: AppSize.h200,
              repeat: false,
            ),
            // SizedBox(height: AppSize.h50),
            if (showFinishBtn)
              AppButton(
                onTap: () {
                  onFinish?.call();
                },
                title: 'Finish',
              ),
          ],
        ),
      ),
    );
  }
}
