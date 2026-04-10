import 'package:flutter/material.dart';

class ColorSwatchWidget extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback onTap;

  const ColorSwatchWidget({super.key,
    required this.color,
    required this.isSelected,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 20),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: isEnabled ? color : color.withOpacity(0.2),
            shape: BoxShape.circle,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: !isEnabled
              ? const Icon(Icons.close, size: 16, color: Colors.white)
              : (isSelected
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null),
        ),
      ),
    );
  }
}
