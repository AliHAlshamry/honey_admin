import 'package:flutter/material.dart';

Color getOrderStatusColor(String status) {
  switch (status) {
    case 'NEW':
    case 'PREPARING':
      return Colors.orange.shade100;
    case 'READY':
      return Colors.teal.shade100;
    case 'SUSPENDED':
      return Colors.grey.shade300;
    case 'CANCELLED':
      return Colors.red.shade100;
    case 'DELIVERING':
      return Colors.indigo.shade100;
    case 'RETURNED':
      return Colors.red.shade200;
    case 'RESTOCKED':
      return Colors.brown.shade100;
    case 'DELIVERED':
      return Colors.green.shade100;
    default:
      return Colors.grey.shade100;
  }
}

Color getOrderStatusTextColor(String status) {
  switch (status) {
    case 'NEW':
      return Colors.blue.shade800;
    case 'PREPARING':
      return Colors.orange.shade800;
    case 'READY':
      return Colors.teal.shade800;
    case 'SUSPENDED':
      return Colors.grey.shade800;
    case 'CANCELLED':
      return Colors.red.shade700;
    case 'DELIVERING':
      return Colors.indigo.shade800;
    case 'RETURNED':
      return Colors.red.shade900;
    case 'RESTOCKED':
      return Colors.brown.shade800;
    case 'DELIVERED':
      return Colors.green.shade800;
    default:
      return Colors.black87;
  }
}
