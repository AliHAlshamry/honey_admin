import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/text_styles.dart';

class AppTheme {
  static final OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: const BorderSide(color: AppColors.grey100Color),
  );

  ThemeData lightTheme = ThemeData(
    //fontFamily: 'IBMPlexSansArabic',
    scaffoldBackgroundColor: AppColors.bgColor,

    ///app bar theme
    appBarTheme: AppBarTheme(
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      backgroundColor: AppColors.bgColor,
      iconTheme: IconThemeData(color: AppColors.tritryColor),
      elevation: 0.0,
      titleTextStyle: TextStyles.textMedium16.copyWith(
        color: Colors.black87,
      ),
    ),

    ///input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      fillColor: Colors.white,
      filled: true,
      border: _outlineInputBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.grey100Color),
      ),
      enabledBorder: _outlineInputBorder,
      focusedBorder: _outlineInputBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.yellow200Color),
      ),
      errorBorder: _outlineInputBorder.copyWith(
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: _outlineInputBorder.copyWith(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
      disabledBorder: _outlineInputBorder,
      helperMaxLines: 4,
      hintStyle: TextStyles.textBold12.copyWith(color: AppColors.tritryColor),
    ),

    ///text theme
    textTheme: const TextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size.fromHeight(50)),
        backgroundColor: const WidgetStatePropertyAll(AppColors.yellow500Color),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
  );
}
