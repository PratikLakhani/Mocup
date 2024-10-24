import 'package:flutter/material.dart';
import 'package:plug2go/extensions/ext_build_context.dart';
import 'package:plug2go/gen/assets.gen.dart';
import 'package:plug2go/utils/app_colors.dart';
import 'package:plug2go/utils/app_navigations.dart';
import 'package:plug2go/utils/app_padding.dart';
import 'package:plug2go/utils/app_size.dart';

class AppAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppbar({
    required this.title,
    this.onTap,
    super.key,
    this.bottom,
    this.height,
    this.horiZontalPadding,
    this.verticalPadding,
  });
  final void Function()? onTap;
  final String title;
  final PreferredSizeWidget? bottom;
  final double? horiZontalPadding;
  final double? verticalPadding;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppPadding.symmetric(
      horizontal: horiZontalPadding ?? AppSize.w20,
      vertical: verticalPadding ?? AppSize.h14,
      child: AppBar(
        centerTitle: false,
        leadingWidth: AppSize.w46,
        surfaceTintColor: Colors.transparent,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTap ??
                  () {
                    if (FocusScope.of(context).isFirstFocus) {
                      FocusScope.of(context).unfocus();
                    }
                    AppNavigations.previousScreen(context);
                  },
              child: Container(
                height: AppSize.h44,
                width: AppSize.w44,
                margin: EdgeInsets.all(AppSize.h1),
                decoration: BoxDecoration(
                  color: AppColors.buttonBGColors,
                  borderRadius: BorderRadius.circular(AppSize.sp14),
                ),
                child: Assets.icons.icLeftArrow.svg(
                  height: AppSize.h14,
                  width: AppSize.w14,
                  fit: BoxFit.none,
                  colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                ),
              ),
            ),
          ],
        ),
        title: Text(
          title,
          style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        bottom != null ? bottom!.preferredSize.height + (height ?? AppSize.h86) : (height ?? AppSize.h86),
      );
}
