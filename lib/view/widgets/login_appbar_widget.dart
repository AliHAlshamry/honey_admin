import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class LoginAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const LoginAppBarWidget({super.key});

  @override
  Size get preferredSize =>
      Size.fromHeight(Get.height * 0.15); // Set the desired height

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: SvgPicture.asset(
        './assets/images/toolbar_image.svg',
        fit: BoxFit.fill,
        height: Get.height * 0.15,
      ),
    );
  }
}
