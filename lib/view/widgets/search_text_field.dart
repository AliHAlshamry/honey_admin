import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../generated/assets.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/text_styles.dart';

class SearchWidget extends StatefulWidget {
  final String? hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Color backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final Color hintColor;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry padding;

  const SearchWidget({
    super.key,
    this.hintText,
    required this.onChanged,
    required this.onSubmitted,
    this.controller,
    this.focusNode,
    this.backgroundColor = Colors.white,
    this.iconColor,
    this.textColor,
    this.hintColor = Colors.grey,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.only(top :16),
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 10.0,
      vertical: 10.0,
    ),
  });

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          style: TextStyle(color: widget.textColor),
          onChanged: (value) {
            widget.onChanged(value);
          },
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'enter_order_number_or_enter_name'.tr,
            hintStyle: TextStyles.textRegular12,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 4),
              child: SvgPicture.asset(
                Assets.iconsIcSearch,
                colorFilter: ColorFilter.mode(
                  widget.iconColor ?? AppColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            prefixIconConstraints: BoxConstraints( minHeight: 20, minWidth: 20),
            suffixIcon:
                _showClearButton
                    ? IconButton(
                      icon: Icon(Icons.clear, color: widget.iconColor ?? AppColors.primaryColor),
                      onPressed: () {
                        _controller.clear();
                        widget.onChanged('');
                        _focusNode.unfocus();
                      },
                    )
                    : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
            contentPadding: widget.contentPadding,
            fillColor: widget.backgroundColor,
            filled: true,
          ),
          textInputAction: TextInputAction.search,
        ),
      ),
    );
  }
}
