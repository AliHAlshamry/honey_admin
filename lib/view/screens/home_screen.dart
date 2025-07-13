import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:honey_admin/view/screens/orders_screen.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/constants/app_strings.dart';
import 'add_order_screen/add_order_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.directOrder),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [const PopupMenuItem<int>(value: 0, child: Text(AppStrings.logoutStr))],
              onSelected: (value) async {
                final AuthController authController =
                    Get.isRegistered<AuthController>() ? Get.find<AuthController>() : Get.put(AuthController());

                if (value == 0) {
                  EasyLoading.show(status: AppStrings.logout);
                  authController.signOut();
                  EasyLoading.dismiss();
                }
              },
            ),
          ],
          bottom: const TabBar(tabs: [Tab(text: AppStrings.addOrder), Tab(text: AppStrings.orders)]),
        ),
        body: TabBarView(
          children: [
            AddOrderScreen(),

            /// Second Tab
           OrdersScreen()
          ],
        ),
      ),
    );
  }
}
