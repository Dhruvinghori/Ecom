import 'dart:ui';

class ProductVariant {
  final String id;
  final Map<String, String> attributes;
  final double price;
  final int stock;
  final Color displayColor;
  final bool exists;

  ProductVariant({
    required this.id,
    required this.attributes,
    required this.price,
    required this.stock,
    required this.displayColor,
    this.exists = true,
  });

  bool get isOutOfStock => stock <= 0;
}