import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/models/product_variant.dart';
import '../data/repository/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductRepository _repo = ProductRepository();
  List<ProductVariant> _variants = [];
  Map<String, String> _selectedAttributes = {};
  ProductVariant? _currentVariant;
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  ProductVariant? get currentVariant => _currentVariant;
  Map<String, String> get selectedAttributes => _selectedAttributes;

  final List<String> colors = ['Red', 'Blue'];
  final List<String> sizes = ['S', 'M'];

  ProductViewModel() { _loadData(); }

  Future<void> _loadData() async {
    _variants = await _repo.fetchVariants();
    _resolveVariant({'Color': 'Red', 'Size': 'S'});
    _isLoading = false;
    notifyListeners();
  }

  void onOptionSelected(String category, String value) {
    HapticFeedback.lightImpact();
    final newSelections = Map<String, String>.from(_selectedAttributes);
    newSelections[category] = value;
    _resolveVariant(newSelections);
  }

  void _resolveVariant(Map<String, String> target) {
    var match = _variants.cast<ProductVariant?>().firstWhere(
          (v) => _mapEquals(v!.attributes, target),
      orElse: () => null,
    );

    if (match == null) {
      final intendedColor = target['Color'];
      match = _variants.firstWhere(
            (v) => v.attributes['Color'] == intendedColor,
        orElse: () => _variants.first,
      );
    }

    _selectedAttributes = Map<String, String>.from(match.attributes);
    _currentVariant = match;
    notifyListeners();
  }

  bool isOptionValid(String category, String value) {
    final testMap = Map<String, String>.from(_selectedAttributes);
    testMap[category] = value;
    return _variants.any((v) => _mapEquals(v.attributes, testMap));
  }

  bool _mapEquals(Map<String, String> a, Map<String, String> b) {
    return a['Color'] == b['Color'] && a['Size'] == b['Size'];
  }
}