import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/enum.dart';
import 'animation_toast_message.dart';

void showCustomMessage({
  required String title,
  String? subtitle,
  MessageType status = MessageType.success,
  IconData? icon,
  Duration duration = const Duration(seconds: 3),
}) {
  final overlay = Get.overlayContext;
  if (overlay == null) return;

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => Positioned(
      top: 60,
      left: 0,
      right: 0,
      child: AnimatedToastMessage(
        title: title,
        subtitle: subtitle,
        status: status,
        icon: icon,
        duration: duration,
        onDismissed: () => entry.remove(),
      ),
    ),
  );

  Overlay.of(overlay).insert(entry);
}