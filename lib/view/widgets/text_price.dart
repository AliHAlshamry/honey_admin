import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/constants/app_strings.dart';

class TextPrice extends StatelessWidget {
  const TextPrice({
    super.key,
    required this.price,
    this.discount = false,
    this.isDinar = true,
    this.showAsDouble = false,
    this.fontSize,
    this.style,
    this.numberOfDigitShow = 12,
  });

  final double price;
  final bool showAsDouble;
  final bool discount;
  final bool isDinar;
  final double? fontSize;
  final TextStyle? style;
  final int numberOfDigitShow;

  @override
  Widget build(BuildContext context) {
    String formattedPrice = showAsDouble ? '$price' : NumberFormat('#,###', 'en_US').format(price.round());

    if (formattedPrice.length > numberOfDigitShow) {
      formattedPrice = '...${formattedPrice.substring(0, numberOfDigitShow)}';
    }

    return Text(
      '$formattedPrice ${AppStrings.iqd}',
      style: style ??
          (Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).textTheme.headlineSmall!.color!.withValues(alpha: 0.87),
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              )),
    );
  }
}
