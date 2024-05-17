import 'package:flutter/material.dart';

class AppConstants {
  static hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static bool isDarkMode({
    required BuildContext context,
  }) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  // static showSnackbar({
  //   required Color backgroundColor,
  //   IconData? iconData,
  //   required String text,
  // }) {
  //   AppConfig.rootScaffoldMessengerKey.currentState!.showSnackBar(
  //     SnackBar(
  //       backgroundColor: backgroundColor,
  //       content: Row(
  //         children: [
  //           Icon(
  //             backgroundColor == AppColors.error
  //                 ? Iconsax.close_square
  //                 : backgroundColor == AppColors.warning
  //                     ? Iconsax.warning_2
  //                     : backgroundColor == AppColors.success
  //                         ? Iconsax.tick_circle
  //                         : iconData,
  //             color: AppColors.white,
  //           ),
  //           SizedBox(
  //             width: 15.w,
  //           ),
  //           Expanded(
  //             child: Text(
  //               text,
  //               style:
  //                   Theme.of(AppConfig.rootScaffoldMessengerKey.currentContext!)
  //                       .textTheme
  //                       .titleSmall!
  //                       .copyWith(
  //                         color: AppColors.white,
  //                       ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       behavior: SnackBarBehavior.floating,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(
  //           8.r,
  //         ),
  //       ),
  //       padding: EdgeInsets.symmetric(
  //         horizontal: 15.w,
  //         vertical: 10.h,
  //       ),
  //       duration: const Duration(
  //         seconds: 2,
  //       ),
  //     ),
  //   );
  // }
}
