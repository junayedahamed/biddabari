import 'package:flutter_test/flutter_test.dart';
import 'package:biddabari/course/data/models/course_model.dart';

void main() {
  group('CourseModel Discount Logic', () {
    test(
      'isDiscountActive returns true when discount end date is in the future',
      () {
        final futureDate = DateTime.now()
            .add(const Duration(days: 1, hours: 4, minutes: 23))
            .toIso8601String();
        final course = CourseModel(
          price: 1000,
          discountAmount: 800,
          discountEndDate: futureDate,
        );

        expect(course.isDiscountActive, true);
        expect(course.effectiveDiscountPrice, 800.0);
      },
    );

    test(
      'isDiscountActive returns false and effectiveDiscountPrice is null when discount end date has passed',
      () {
        final pastDate = DateTime.now()
            .subtract(const Duration(hours: 1))
            .toIso8601String();
        final course = CourseModel(
          price: 1000,
          discountAmount: 800,
          discountEndDate: pastDate,
        );

        expect(course.isDiscountActive, false);
        expect(course.effectiveDiscountPrice, null);
        expect(course.formattedDiscountCountdown, null);
      },
    );

    test('formatDiscountCountdown formats duration like 1d 04h 23m', () {
      final now = DateTime(2026, 9, 10, 12, 0, 0);
      final endDate = DateTime(2026, 9, 11, 16, 23, 0);
      final course = CourseModel(
        price: 1000,
        discountAmount: 800,
        discountEndDate: endDate.toIso8601String(),
      );

      final countdown = course.formatDiscountCountdown(now);
      expect(countdown, '1d 04h 23m');
    });

    test('formatDiscountCountdown formats duration under 24 hours', () {
      final now = DateTime(2026, 9, 10, 12, 0, 0);
      final endDate = DateTime(2026, 9, 10, 16, 23, 10);
      final course = CourseModel(
        price: 1000,
        discountAmount: 800,
        discountEndDate: endDate.toIso8601String(),
      );

      final countdown = course.formatDiscountCountdown(now);
      expect(countdown, '04h 23m 10s');
    });
  });
}
