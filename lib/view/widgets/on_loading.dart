import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../utils/constants/app_colors.dart';

class OnLoading extends StatelessWidget {
  const OnLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.stretchedDots(
        color: AppColors.yellow500Color,
        size: 60,
      ),
    );
  }
}