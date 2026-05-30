import 'package:usedev_uninassau/src/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;
  final String selectedSize;
  final String selectedColor;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.selectedSize = 'M',
    this.selectedColor = 'Bege',
  });

  double get totalValue => product.price * quantity;
}
