import 'package:flutter/material.dart';

class CourseCardFooter extends StatelessWidget {
  final double price;
  final double? discountPrice;
  final String currencySymbol;
  final VoidCallback? onTap;
  final VoidCallback? onEnrollTap;

  const CourseCardFooter({
    super.key,
    required this.price,
    this.discountPrice,
    this.currencySymbol = '৳',
    this.onTap,
    this.onEnrollTap,
  });

  bool get _hasDiscount => discountPrice != null && discountPrice! < price;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectivePrice = _hasDiscount ? discountPrice! : price;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Price Container
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$currencySymbol${effectivePrice.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  if (_hasDiscount) ...[
                    const SizedBox(width: 6.0),
                    Text(
                      '$currencySymbol${price.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),

        // Action / Enroll Button designed with Container & InkWell
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: [
                theme.primaryColor,
                theme.primaryColor.withValues(alpha: 0.88),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.primaryColor.withValues(alpha: 0.35),
                blurRadius: 8.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
            child: InkWell(
              onTap: onEnrollTap ?? onTap,
              borderRadius: BorderRadius.circular(10.0),
              splashColor: Colors.white.withValues(alpha: 0.2),
              highlightColor: Colors.white.withValues(alpha: 0.1),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 9.0,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Enroll Now',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(width: 6.0),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
