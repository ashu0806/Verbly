import 'package:flutter/material.dart';
import 'package:verbly/core/constants/app_colors.dart';

class CircleAvatarWidget extends StatelessWidget {
  const CircleAvatarWidget({
    super.key,
    required this.imageUrl,
    required this.radius,
  });

  final String imageUrl;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.grey,
      backgroundImage: NetworkImage(
        imageUrl,
      ),
      radius: radius,
    );
  }
}
