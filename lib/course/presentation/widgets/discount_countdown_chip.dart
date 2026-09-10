import 'package:biddabari/course/logic/course_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Isolated discount countdown chip built as a StatelessWidget.
/// Uses Obx to listen to CourseController's reactive timer updates without setState.
class DiscountCountdownChip extends StatelessWidget {
  final bool hasDiscount;
  final int discountPercentage;
  final String? discountEndDate;

  const DiscountCountdownChip({
    super.key,
    required this.hasDiscount,
    this.discountPercentage = 0,
    this.discountEndDate,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<CourseController>()
        ? Get.find<CourseController>()
        : Get.put(CourseController());

    return Obx(() {
      final result = controller.evaluateDiscountCountdown(
        hasDiscount: hasDiscount,
        discountEndDate: discountEndDate,
      );

      if (!hasDiscount || result.isExpired) {
        return const SizedBox.shrink();
      }

      final hasPercentage = discountPercentage > 0;
      final countdownText = result.countdownText ?? '';
      final hasCountdown = countdownText.isNotEmpty;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF5252), Color(0xFFFF1744)],
          ),
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasPercentage) ...[
              Text(
                '$discountPercentage% OFF',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
              if (hasCountdown) ...[
                const SizedBox(width: 5.0),
                const Text(
                  '•',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5.0),
              ],
            ],
            if (hasCountdown) ...[
              const Icon(
                Icons.access_time_rounded,
                size: 12.0,
                color: Colors.white,
              ),
              const SizedBox(width: 3.0),
              Text(
                countdownText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}
