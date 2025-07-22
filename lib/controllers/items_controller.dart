import 'package:get/get.dart';
import '../../models/item_model.dart';
import '../../models/custom_product_model.dart';
import '../../models/product_model.dart';

class ItemController extends GetxController with StateMixin<Map<ItemModel, double>> {
  final items = <CartEntry>[].obs;
  final customItems = <CartEntry>[].obs;
  final products = <CartEntry>[].obs;
  final customProducts = <CustomProductModel>[].obs;
  final RxDouble totalPrice = 0.0.obs;

  /// Add or increment item
  void addItem(ItemModel product, {int qty = 1}) {
    if(product.qty==0) return;
    final idx = items.indexWhere((e) => e.product.id == product.id);
    if (idx >= 0) {
      if(product.qty! <(items[idx].qty + 1)){
        return;
      }
      items[idx].qty += qty;
    } else {
      items.add(CartEntry(
        product: product,
        qty: qty,
        sourceType: 'INTERNAL',
        identifier: product.id
      ));
    }
    updateTotalPrice();
    items.refresh();
  }

  /// Decrease quantity or remove item
  void decrementItem(ItemModel product) {
    final idx = items.indexWhere((e) => e.product.id == product.id);
    if (idx >= 0) {
      if (items[idx].qty > 1) {
        items[idx].qty--;
      } else {
        items.removeAt(idx);
      }
      updateTotalPrice();
      items.refresh();
    }
  }

  /// Completely delete item
  void deleteItem(ProductModel product) {
    items.removeWhere((entry) => entry.product.id == product.id);
    customProducts.removeWhere((custom) => custom.id == product.id);
    updateTotalPrice();
  }

  /// Add external/custom item
  CartEntry addCustomItem(String name, String price, int qty, {String? description, String? imagePath}) {
    // Check if item already exists
    final idx = items.indexWhere((e) => e.identifier == name && e.sourceType == 'EXTERNAL');

    if (idx >= 0) {
      // Increment qty
      items[idx].qty += qty;
      items.refresh();
      updateTotalPrice();
      return items[idx];
    }

    // Else create new custom item
    final customProduct = CustomProductModel(
          (p0) => p0
        ..id = name
        ..name = name
        ..price = price
        ..availableQty = qty
        ..description = description
        ..imagePath = imagePath,
    );

    customProducts.add(customProduct);

    final productModel = customProduct.toItemModel();
    final cartEntry = CartEntry(
      product: productModel,
      qty: qty,
      sourceType: 'EXTERNAL',
      identifier: name,
    );

    customItems.add(cartEntry);
    items.add(cartEntry);
    updateTotalPrice();
    return cartEntry;
  }

  /// Edit custom item
  CartEntry? editCustomItem(String productId, String name, String price, int qty,
      {String? description, String? imagePath}) {
    final customIdx = customProducts.indexWhere((c) => c.id == productId);
    if (customIdx >= 0) {
      customProducts[customIdx] = CustomProductModel(
            (p0) => p0
          ..id = name
          ..name = name
          ..price = price
          ..availableQty = qty
          ..description = description
          ..imagePath = imagePath,
      );
      customProducts.refresh();
      updateTotalPrice();

      final cartIdx = items.indexWhere((e) => e.product.id == productId);
      final customCartIndex = customItems.indexWhere((e) => e.product.id == productId);
      if (cartIdx >= 0) {
        final updatedProduct = customProducts[customIdx].toItemModel();
        final updatedEntry = CartEntry(
          product: updatedProduct,
          qty: items[cartIdx].qty.clamp(1, qty),
          sourceType: 'EXTERNAL',
          identifier: name
        );
        customItems[cartIdx] = updatedEntry;
        items[customCartIndex] = updatedEntry;
        items.refresh();
        updateTotalPrice();
        return updatedEntry;
      }
    }
    return null;
  }

  /// Check if product is already added
  bool isInCart(String productId) => items.any((e) => e.product.id == productId);

  void updateTotalPrice() {
    totalPrice.value = items.fold(
      0.0,
          (sum, entry) =>
      sum + double.parse(entry.product.discountedPrice ?? entry.product.orginalPrice) * entry.qty,
    );
  }

  int getProductQuantity(String productId) {
    final entry = items.firstWhereOrNull((e) => e.product.id == productId);
    return entry?.qty ?? 0;
  }

  // Get custom product details by ID
  CustomProductModel? getCustomProduct(String productId) {
    try {
      return customProducts.firstWhere((custom) => custom.id == productId);
    } catch (e) {
      return null;
    }
  }

  void removeItem(ItemModel item) {
    // Remove from items list
    items.removeWhere((e) => e.product.id == item.id);
    customItems.removeWhere((e) => e.product.id == item.id);

    // If it's a custom product, remove it from customProducts too
    customProducts.removeWhere((custom) => custom.id == item.id);

    items.refresh();
    customProducts.refresh();
    updateTotalPrice();
  }


  /// Get total item count
  int get totalItemCount => items.fold(0, (sum, entry) => sum + entry.qty);

  /// Clear all cart
  void clear() {
    items.clear();
    customProducts.clear();
    customItems.clear();
    products.clear();
    totalPrice.value = 0.0;
  }
}

/// Used to represent a single cart item with source type and identifier
class CartEntry {
  final ItemModel product;
  int qty;
  final String sourceType; // "INTERNAL" or "EXTERNAL"
  final String identifier; // UUID or name

  CartEntry({
    required this.product,
    this.qty = 1,
    required this.sourceType,
    required this.identifier
  });
}
