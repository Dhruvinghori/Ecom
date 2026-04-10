import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_view_model.dart';
import 'ui/screens/product_detail_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductViewModel(),
      child: const MaterialApp(
        title: 'Premium Product Page',
        debugShowCheckedModeBanner: false,
        home: ProductDetailScreen(),
      ),
    ),
  );
}