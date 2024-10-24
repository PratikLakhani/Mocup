import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plug2go/extensions/ext_build_context.dart';
import 'package:plug2go/extensions/ext_string.dart';
import 'package:plug2go/utils/app_colors.dart';
import 'package:plug2go/utils/app_size.dart';
import 'package:plug2go/widgets/app_spacebox.dart';
import 'package:plug2go/widgets/app_text_widget.dart';
import 'package:plug2go/widgets/textfield_with_label.dart';

class AppDropdown extends StatelessWidget {
  const AppDropdown({
    required this.values,
    required this.onChanged,
    required this.hintText,
    required this.errorText,
    this.onTap,
    super.key,
    this.suffixIcon,
    this.textController,
    this.requestFocusOnTap,
    this.initialSelection,
    this.title,
    this.isShowError,
    this.border,
    this.width,
    this.suffixAssetsIcon,
    this.borderRadius,
    this.isEnabled,
    this.fillColor,
    this.suffixColor,
  });
  final List<String> values;
  final void Function(String value) onChanged;
  final void Function()? onTap;
  final TextEditingController? textController;
  final double? width;
  final String? title;
  final InputBorder? border;
  final String hintText;
  final String errorText;
  final bool? requestFocusOnTap;
  final bool? isEnabled;
  final bool? isShowError;
  final String? initialSelection;
  final String? suffixAssetsIcon;
  final Icon? suffixIcon;
  final Color? suffixColor;
  final Color? fillColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          AppTextWidget(
            title ?? '',
            style: context.textTheme.titleMedium?.copyWith(
              fontSize: AppSize.sp16,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (title != null) SpaceV(AppSize.h6) else const SizedBox(),
        GestureDetector(
          onTap: onTap,
          child: TextfieldWithLabel(
            textfield: DropdownMenu<String>(
              hintText: hintText,
              // errorText: errorText,
              initialSelection: initialSelection,
              enabled: isEnabled ?? true,
              requestFocusOnTap: requestFocusOnTap,
              selectedTrailingIcon: const Icon(Icons.keyboard_arrow_up_rounded),
              errorText: (isShowError ?? false) ? errorText : null,
              onSelected: (String? value) {
                onChanged(value!);
              },
              textStyle: context.textTheme.titleMedium,
              controller: textController,
              width: width ?? context.width - AppSize.w60,
              trailingIcon: suffixAssetsIcon != null
                  ? SvgPicture.asset(suffixAssetsIcon!)
                  : suffixIcon ??
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.black,
                      ),
              menuStyle: MenuStyle(
                backgroundColor: const WidgetStatePropertyAll(
                  AppColors.white,
                ),
                padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      borderRadius ?? AppSize.borderRadius,
                    ),
                  ),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSize.w12,
                  vertical: AppSize.h12,
                ),
                hintStyle: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.formHintColor,
                ),
                errorMaxLines: 2,
                errorStyle: const TextStyle(
                  color: AppColors.errorColor,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? AppSize.borderRadius,
                  ),
                  borderSide: const BorderSide(
                    color: AppColors.errorColor,
                  ),
                ),
                enabledBorder: border ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? AppSize.borderRadius,
                      ),
                      borderSide: BorderSide(
                        color: AppColors.lightPurpleBorderColor,
                        width: AppSize.w2,
                      ),
                    ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? AppSize.borderRadius,
                  ),
                  borderSide: const BorderSide(
                    color: AppColors.greyBorderColor,
                  ),
                ),
                disabledBorder: border ??
                    OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        borderRadius ?? AppSize.borderRadius,
                      ),
                      borderSide: const BorderSide(
                        color: AppColors.greyBorderColor,
                      ),
                    ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? AppSize.borderRadius,
                  ),
                  borderSide: const BorderSide(
                    color: AppColors.greyBorderColor,
                  ),
                ),
                filled: true,
                fillColor: fillColor ?? AppColors.white,
              ),
              menuHeight: AppSize.h200,
              dropdownMenuEntries: values.map((value) {
                return DropdownMenuEntry<String>(
                  value: value,
                  label: value.toTitleCase(),
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(AppColors.white),
                    overlayColor: const WidgetStatePropertyAll(AppColors.transparent),
                    splashFactory: NoSplash.splashFactory,
                    padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                    foregroundBuilder: (context, states, child) {
                      return Container(
                        width: width ?? context.width - AppSize.w60,
                        decoration: BoxDecoration(
                          border: values.last != value
                              ? const Border(
                                  bottom: BorderSide(
                                    color: AppColors.greyBorderColor,
                                  ),
                                )
                              : null,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.w12,
                          vertical: AppSize.h12,
                        ),
                        child: Text(
                          value.toTitleCase(),
                          style: context.textTheme.titleMedium?.copyWith(
                              // fontSize: AppSize.sp14,
                              ),
                        ),
                      );
                    },
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          borderRadius ?? AppSize.h0,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
