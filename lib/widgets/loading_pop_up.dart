import 'package:flutter/material.dart';
import 'package:plug2go/extensions/ext_build_context.dart';
import 'package:plug2go/utils/app_colors.dart';
import 'package:plug2go/utils/app_size.dart';
import 'package:plug2go/widgets/circular_loader.dart';

class LoadingPopUp extends StatelessWidget {
  const LoadingPopUp({required this.title, required this.body, super.key});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: context.width,
        margin: EdgeInsets.all(AppSize.h30),
        padding: EdgeInsets.all(AppSize.h10),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppSize.r20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
            SizedBox(height: AppSize.h50),
            const CircularLoader(),
            SizedBox(height: AppSize.h50),
          ],
        ),
      ),
    );
  }
}
