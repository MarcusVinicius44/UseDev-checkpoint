import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/models/cart_item_model.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  double get totalValue => _items.fold(0, (sum, item) => sum + item.totalValue);

  void addItem(Product product, {String size = 'M', String color = 'Bege', int quantity = 1}) {
    int index = _items.indexWhere((item) => 
      item.product.id == product.id && 
      item.selectedSize == size && 
      item.selectedColor == color
    );
    
    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(CartItem(
        product: product, 
        selectedSize: size, 
        selectedColor: color,
        quantity: quantity,
      ));
    }
    notifyListeners();
  }

  void removeItem(int productId, String size, String color) {
    _items.removeWhere((item) => 
      item.product.id == productId && 
      item.selectedSize == size && 
      item.selectedColor == color
    );
    notifyListeners();
  }

  void incrementQuantity(int productId, String size, String color) {
    int index = _items.indexWhere((item) => 
      item.product.id == productId && 
      item.selectedSize == size && 
      item.selectedColor == color
    );
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(int productId, String size, String color) {
    int index = _items.indexWhere((item) => 
      item.product.id == productId && 
      item.selectedSize == size && 
      item.selectedColor == color
    );
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
