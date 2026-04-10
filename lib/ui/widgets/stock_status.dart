import 'package:flutter/material.dart';

class StockStatus extends StatelessWidget {
  final bool isOutOfStock;

  const StockStatus({super.key, required this.isOutOfStock});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isOutOfStock ? const Color(0xFFFDEDEC) : const Color(0xFFEAFAF1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            isOutOfStock ? Icons.info_outline : Icons.verified_user_outlined,
            color: isOutOfStock
                ? const Color(0xFFC0392B)
                : const Color(0xFF27AE60),
          ),
          const SizedBox(width: 12),
          Text(
            isOutOfStock ? "Out of Stock" : "Available in Warehouse",
            style: TextStyle(
              color: isOutOfStock
                  ? const Color(0xFF922B21)
                  : const Color(0xFF1D8348),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
