import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/items_controller.dart';
import '../../models/item_model.dart';

class ItemsScreen extends GetView<ItemsController> {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Items')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.error.isNotEmpty) {
          return Center(child: Text(controller.error.value));
        }

        return ListView.builder(
          itemCount: controller.items.length,
          itemBuilder: (context, index) {
            final item = controller.items[index];
            return ItemCard(item: item);
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.fetchItems,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final ItemModel item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: item.attachments.isNotEmpty
            ? Image.network(item.attachments.firstWhere((a) => a.isPrimary).url)
            : null,
        title: Text(item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.description),
            Text('Price: ${item.orginalPrice} ${item.pricingCurrency}'),
            Text('Stock: ${item.qty}'),
          ],
        ),
      ),
    );
  }
}