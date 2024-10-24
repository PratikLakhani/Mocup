// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:plug2go/utils/app_colors.dart';
import 'package:plug2go/utils/app_size.dart';

abstract class ThemePreferences {
  ThemeData get dark;
  ThemeData get light;
}

class CustomTheme extends ThemePreferences {
  @override
  ThemeData get light => ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.white,
        dialogBackgroundColor: Colors.white,
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: AppColors.black),
          contentTextStyle: TextStyle(color: AppColors.black),
        ),
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.selected)) {
              return TextStyle(
                color: AppColors.black,
                fontSize: AppSize.sp12,
                fontWeight: FontWeight.bold,
              );
            }
            return TextStyle(
              color: AppColors.greyBorderColor,
              fontSize: AppSize.sp12,
              fontWeight: FontWeight.bold,
            );
          }),
        ),
        colorScheme: const ColorScheme(
          onPrimary: AppColors.black,
          surface: Color.fromRGBO(255, 240, 240, 1),
          brightness: Brightness.light,
          onSecondary: AppColors.black,
          onError: AppColors.primaryColor,
          onSurface: AppColors.black,
          error: AppColors.errorColor,
          primary: AppColors.primaryColor,
          secondary: AppColors.white,
          surfaceContainerHighest: AppColors.white,
        ),
        primaryColor: AppColors.primaryColor,
        primaryColorDark: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.black),
          backgroundColor: AppColors.white,
        ),
        scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          // thumbVisibility: WidgetStateProperty.all(true),
          radius: Radius.circular(AppSize.r10),
          // thumbColor: WidgetStateProperty.all(Colors.grey),
          // thickness: WidgetStateProperty.all(AppSize.sp4),
          minThumbLength: 100,
        ),
        highlightColor: Colors.transparent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              double.infinity,
              AppSize.h60,
            ),
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.r14),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ),
        // dividerColor: AppColors.mediumGrey,
        splashColor: AppColors.transparent,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: AppColors.black,
            fontSize: AppSize.sp34,
            fontWeight: FontWeight.w600,
          ),
          headlineMedium: TextStyle(
            color: AppColors.black,
            fontSize: AppSize.sp30,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.25,
            height: 1.25,
          ),
          bodyLarge: TextStyle(
            color: AppColors.black,
            fontSize: AppSize.sp26,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            color: AppColors.black,
            fontSize: AppSize.sp24,
            fontWeight: FontWeight.w600,
          ),
          bodySmall: TextStyle(
            color: AppColors.black,
            fontSize: AppSize.sp20,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            color: AppColors.black,
            fontSize: AppSize.sp18,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: TextStyle(
            color: AppColors.black,
            fontSize: AppSize.sp14,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: TextStyle(
            color: AppColors.black,
            fontSize: AppSize.sp12,
            fontWeight: FontWeight.w500,
          ),
        ),
        // shadowColor: AppColors.optionLineColor,
        disabledColor: Colors.grey,
      );

  @override
  ThemeData get dark => ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.transparent,
        dialogBackgroundColor: Colors.white,
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: AppColors.black),
          contentTextStyle: TextStyle(color: AppColors.black),
        ),
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.resolveWith((state) {
            if (state.contains(WidgetState.selected)) {
              return TextStyle(
                color: AppColors.black,
                fontSize: AppSize.sp12,
                fontWeight: FontWeight.bold,
              );
            }
            return TextStyle(
              color: AppColors.greyTextColor,
              fontSize: AppSize.sp12,
              fontWeight: FontWeight.bold,
            );
          }),
        ),
        colorScheme: const ColorScheme(
          onPrimary: AppColors.white,
          // background: AppColors.secondaryBGColor,
          surface: Color.fromARGB(255, 0, 0, 0),
          brightness: Brightness.dark,
          onSecondary: AppColors.white,
          onError: AppColors.primaryColor,
          onSurface: AppColors.white,
          // onBackground: AppColors.secondaryBGColor,
          error: AppColors.black,
          primary: AppColors.primaryColor,
          secondary: AppColors.black,
          // surfaceVariant: AppColors.secondaryBGColor,
        ),
        primaryColor: AppColors.primaryColor,
        primaryColorDark: AppColors.primaryColor,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.white),
          backgroundColor: AppColors.black,
        ),
        scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          // thumbVisibility: MaterialStateProperty.all(true),
          radius: Radius.circular(AppSize.r10),
          // thumbColor: MaterialStateProperty.all(Colors.grey),
          // thickness: MaterialStateProperty.all(AppSize.sp4),
          minThumbLength: 100,
        ),
        highlightColor: Colors.transparent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              double.infinity,
              AppSize.h60,
            ),
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.r14),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
        // dividerColor: AppColors.mediumGrey,
        splashColor: AppColors.transparent,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            color: AppColors.white,
            fontSize: AppSize.sp34,
            fontWeight: FontWeight.w500,
          ),
          headlineMedium: TextStyle(
            color: AppColors.white,
            fontSize: AppSize.sp30,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: TextStyle(
            color: AppColors.white,
            fontSize: AppSize.sp18,
            fontWeight: FontWeight.w500,
          ),
          titleMedium: TextStyle(
            color: AppColors.white,
            fontSize: AppSize.sp14,
            fontWeight: FontWeight.w500,
          ),
          titleSmall: TextStyle(
            color: AppColors.white,
            fontSize: AppSize.sp12,
            fontWeight: FontWeight.w500,
          ),
        ),
        // shadowColor: AppColors.optionLineColor,
        disabledColor: Colors.grey,
      );
}
