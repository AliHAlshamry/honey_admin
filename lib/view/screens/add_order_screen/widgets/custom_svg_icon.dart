import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constants/app_colors.dart';

class CustomSvgIcon extends StatelessWidget {
  const CustomSvgIcon({super.key, required this.assetsPath});
  final String assetsPath;
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          assetsPath,
          height: 24,
          width: 24,
          colorFilter: const ColorFilter.mode(AppColors.grey400Color, BlendMode.srcIn),
        ),
      );
  }
}
