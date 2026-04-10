import 'dart:ui';

import '../../ui/theme/app_colors.dart';
import '../models/product_variant.dart';

class ProductRepository {
  Future<List<ProductVariant>> fetchVariants() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      ProductVariant(
        id: 'V1',
        attributes: {'Color': 'Red', 'Size': 'S'},
        price: 499,
        stock: 10,
        displayColor: AppColors.accentRed,
      ),
      ProductVariant(
        id: 'V2',
        attributes: {'Color': 'Red', 'Size': 'M'},
        price: 549,
        stock: 0,
        displayColor: AppColors.accentDarkRed,
      ),
      ProductVariant(
        id: 'V3',
        attributes: {'Color': 'Blue', 'Size': 'S'},
        price: 520,
        stock: 6,
        displayColor: AppColors.accentBlue,
      ),
    ];
  }
}
