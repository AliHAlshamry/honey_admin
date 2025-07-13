import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/text_styles.dart';
import '../../utils/enum.dart';

class AnimatedToastMessage extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final MessageType status;
  final Duration duration;
  final VoidCallback onDismissed;

  const AnimatedToastMessage({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.status,
    this.duration = const Duration(seconds: 3),
    required this.onDismissed,
  });

  @override
  State<AnimatedToastMessage> createState() => _AnimatedToastMessageState();
}

class _AnimatedToastMessageState extends State<AnimatedToastMessage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    Future.delayed(widget.duration, () async {
      await _controller.reverse();
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.status == MessageType.error ? AppColors.errorColor : AppColors.greenSecondary;
    final backgroundColor = widget.status == MessageType.error ? AppColors.brandRed : AppColors.backgroundGreen;

    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: backgroundColor),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: Icon(
                widget.icon ?? Icons.info,
                color: widget.status == MessageType.error ? AppColors.iconError : AppColors.greenSuccess,
              ),
              title: Text(widget.title, style: TextStyles.textSemiBold16.copyWith(color: color)),
              subtitle:
                  widget.subtitle != null
                      ? Text(
                        widget.subtitle!,
                        style: TextStyles.textSemiBold14.copyWith(color: color, fontWeight: FontWeight.bold),
                      )
                      : null,
            ),
          ),
        ),
      ),
    );
  }
}
