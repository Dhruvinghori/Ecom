import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_view_model.dart';
import '../theme/app_colors.dart';
import '../widgets/color_swatch.dart';
import '../widgets/size_chip.dart';
import '../widgets/sticky_footer.dart';
import '../widgets/stock_status.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ProductViewModel>();
    if (vm.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.black)),
      );
    }

    final variant = vm.currentVariant!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            stretch: true,
            backgroundColor: variant.displayColor,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              background: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOutCubic,
                color: variant.displayColor,
                child: Center(
                  child: Hero(
                    tag: 'product_image',
                    child: Icon(
                      Icons.shopping_bag_outlined,
                      size: 120,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "PREMIUM SERIES",
                      style: TextStyle(
                        letterSpacing: 2,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Performance Tech Tee",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 12),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        "₹${variant.price}",
                        key: ValueKey(variant.price),
                        style: const TextStyle(
                          fontSize: 26,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    const Text(
                      "Color",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: vm.colors.map((c) {
                        final colorValue = c == 'Red'
                            ?  AppColors.accentRed
                            : AppColors.accentBlue;
                        return ColorSwatchWidget(
                          color: colorValue,
                          isSelected: vm.selectedAttributes['Color'] == c,
                          isEnabled: vm.isOptionValid('Color', c),
                          onTap: () => vm.onOptionSelected('Color', c),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      "Size",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 12,
                      children: vm.sizes
                          .map(
                            (s) => SizeChip(
                              label: s,
                              isSelected: vm.selectedAttributes['Size'] == s,
                              isEnabled: vm.isOptionValid('Size', s),
                              onTap: () => vm.onOptionSelected('Size', s),
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(height: 30),
                    StockStatus(isOutOfStock: variant.isOutOfStock),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: StickyFooter(variant: variant),
    );
  }
}
