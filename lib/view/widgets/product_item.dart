import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:honey_admin/controllers/cart_controller.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/items_controller.dart';
import '../../models/item_model.dart';
import '../../utils/constants/api_urls.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/app_strings.dart';
import '../../utils/constants/text_styles.dart';
import 'custom_inkwell.dart';
import 'text_price.dart';

class CartItem extends StatelessWidget {
  CartItem({super.key, required this.product, required this.quantity, this.type= 'internal'});

  final ItemModel product;
  final int quantity;
  final controller = Get.find<ItemController>();
  final directController = Get.find<CartController>();
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            elevation: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                //image
                SizedBox(
                  height: 124,
                  width: 94,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16.0),
                        topLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0),
                        // bottomLeft: Radius.zero,
                      ),
                      child:
                          product.attachments.isNotEmpty
                              ? CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl:
                                    product.attachments.isNotEmpty
                                        ? '${ApiUrls.attachmentsUrl}${product.attachments[0].url}'
                                        : '',
                              )
                              : Container(color: AppColors.grey500Color),
                    ),
                  ),
                ),

                //product info
                Expanded(
                  child: Card(
                    margin: EdgeInsets.zero,
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        bottomLeft: Radius.circular(16.0),
                        bottomRight: Radius.circular(0),
                      ),
                    ),
                    elevation: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // product name
                        Padding(
                          padding: const EdgeInsets.only(top: 8, right: 8, bottom: 2),
                          child: Text(product.name, style: TextStyles.textMedium16),
                        ),

                        // product qty
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            product.qty != null
                                ? '${AppStrings.availableQuantity} : ${product.qty}'
                                : AppStrings.noAvailableInfo,
                            style: TextStyles.textRegular12,
                          ),
                        ),

                        // price and discount info
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //item qty
                              Row(
                                children: [
                                  CustomInkwell(
                                    onTap: () {
                                        if (type == 'EXTERNAL') {
                                          controller.addCustomItem(
                                            product.name,
                                            product.orginalPrice,
                                            1,
                                            description: product.description,
                                          );
                                        } else {
                                          controller.addItem(product);
                                        }
                                    },
                                    child: SvgPicture.asset(
                                      './assets/icons/ic_plus.svg',
                                      height: 28,
                                      width: 28,
                                      colorFilter:
                                          (product.qty == null || ((product.qty ?? 0) > 0))
                                              ? null
                                              : ColorFilter.mode(AppColors.grey600Color, BlendMode.srcIn),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Obx(
                                      () => SizedBox(
                                        width: controller.getProductQuantity(product.id).toString().length >= 3 ? 38 : 24,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          '${controller.getProductQuantity(product.id)}',
                                          style: TextStyles.textBold16,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  CustomInkwell(
                                    onTap: () => controller.decrementItem(product),
                                    child: SvgPicture.asset('./assets/icons/ic_minus.svg'),
                                  ),
                                ],
                              ),
                              Spacer(),
                              // price
                              TextPrice(
                                price: double.parse(product.discountedPrice ?? product.orginalPrice),
                                style: TextStyles.textMedium16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Get share cart url loading...
Future tProductUrlLoadingDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder:
        (context) => SimpleDialog(
          children: [
            Column(
              children: [
                Lottie.asset("assets/images/lottie/cartIn.json", width: MediaQuery.of(context).size.width * 0.8),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(),
          ],
        ),
  );
} //TODO separate this widget
