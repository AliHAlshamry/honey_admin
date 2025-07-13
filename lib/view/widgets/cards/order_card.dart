import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:honey_admin/utils/extensions/date_time_extensions.dart';
import 'package:intl/intl.dart';

import '../../../controllers/orders_controller.dart';
import '../../../models/order_model.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/constants/text_styles.dart';
import '../../../utils/helper/order_status_color.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    String formattedPrice = NumberFormat('#,###', 'en_US').format(double.parse(order.price).round());

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0),
              minVerticalPadding: 0,
              minTileHeight: 0,
              title: Text(order.custName, style: TextStyles.textSemiBold14.copyWith(color: Colors.black)),
              trailing: PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: Colors.black),
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onSelected: (value) {
                  if (value == 'cancel') {
                    OrdersController controller = Get.find();
                    controller.cancelOrder(order.id, order.deliveryRepresentativeId);
                  }
                },
                itemBuilder:
                    (BuildContext context) => [
                      PopupMenuItem<String>(value: 'cancel', child: Text(AppStrings.cancelOrder)),
                    ],
              ),
            ),
            SizedBox(height: 16),
            Text(order.note, style: TextStyles.textRegular12.copyWith(color: AppColors.secondaryColor)),
            ListTile(
              contentPadding: EdgeInsets.zero,
              minTileHeight: 0,
              title: Text(
                '${order.addressDetails} - ${order.custDistrict} - ${order.custGovernorate}',
                style: TextStyles.textRegular12.copyWith(color: AppColors.secondaryColor),
              ),
              trailing: Text(
                '$formattedPrice ${AppStrings.iqd}',
                style: TextStyles.textSemiBold16.copyWith(color: AppColors.primaryColor),
              ),
            ),
            Divider(),
            SizedBox(
              height: 28,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /*CustomInkwell(
                          child: Icon(Icons.copy, size: 16, color: AppColors.primaryColor),
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: order.id));
                            //showCustomMessage(title: 'copy_to_clipboard'.tr, subtitle: order.code);
                          },
                        ),*/
                        Text(
                          AppStrings.getOrderType(order.orderType.toUpperCase()),
                          style: TextStyles.textSemiBold12.copyWith(color: AppColors.secondaryColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  //Expanded(child: Center(child: Text('Text'))),
                  VerticalDivider(color: Colors.grey, thickness: 1, width: 20),
                  Expanded(
                    child: Center(
                      child: Text(
                        order.createdAt.toLocal().toString().to12HourFormat(),
                        style: TextStyles.textSemiBold12.copyWith(color: AppColors.secondaryColor),
                      ),
                    ),
                  ),
                  VerticalDivider(color: Colors.grey, thickness: 1, width: 20),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: getOrderStatusColor(order.status),
                      border: Border.all(color: getOrderStatusTextColor(order.status)),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.getOrderStatus(order.status.toUpperCase()),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: getOrderStatusTextColor(order.status),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
