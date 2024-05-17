import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:models/models.dart';
import 'package:verbly/core/constants/app_colors.dart';
import 'package:verbly/main.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
  });

  final Message message;
  @override
  Widget build(BuildContext context) {
    final alignment = (message.senderUserId != userId1)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    final color = (message.senderUserId != userId1)
        ? AppColors.primaryColor
        : AppColors.secondaryColor;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: 1.sw * 0.66),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        margin: EdgeInsets.only(bottom: 8.h, left: 5.w, right: 5.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          message.content ?? "",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: AppColors.white,
                fontSize: 14.sp,
              ),
        ),
      ),
    );
  }
}
