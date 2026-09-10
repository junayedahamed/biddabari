import 'dart:async';
import 'package:biddabari/course/data/models/course_model.dart';
import 'package:biddabari/course/data/repository/course_repository.dart';
import 'package:get/get.dart';

class CourseController extends GetxController {
  final CourseRepository _courseRepository = CourseRepository();
  final Rx<DateTime> _now = DateTime.now().obs;
  Timer? _clockTimer;

  @override
  void onInit() {
    getCourses();
    _startClockTimer();
    super.onInit();
  }

  void _startClockTimer() {
    _clockTimer?.cancel();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _now.value = DateTime.now();
    });
  }

  @override
  void onClose() {
    _clockTimer?.cancel();
    super.onClose();
  }

  RxList<CourseModel> courseList = <CourseModel>[].obs;
  final _isGettingCourses = false.obs;
  RxBool get isGettingCourses => _isGettingCourses;
  final _errorMessage = ''.obs;
  RxString get errorMessage => _errorMessage;

  Future<void> getCourses() async {
    try {
      _isGettingCourses.value = true;
      final result = await _courseRepository.getCourses();
      courseList.value = result;
    } catch (e) {
      _errorMessage.value = e.toString();
      Get.snackbar("Error", e.toString());
    } finally {
      _isGettingCourses.value = false;
    }
  }

  /// Formats a duration into countdown format (e.g. 1d 04h 23m or 04h 23m 10s).
  String formatDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (days > 0) {
      return '${days}d ${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m';
    } else if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
    } else {
      return '${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
    }
  }

  /// Evaluates the current remaining countdown text and expired state for a discount.
  /// Subscribes to [_now] so Obx callers automatically update every second reactively.
  ({String? countdownText, bool isExpired}) evaluateDiscountCountdown({
    required bool hasDiscount,
    required String? discountEndDate,
  }) {
    // Access reactive _now to bind Obx updates to controller timer
    final currentTime = _now.value;

    if (!hasDiscount) {
      return (countdownText: null, isExpired: true);
    }

    if (discountEndDate == null || discountEndDate.isEmpty) {
      return (countdownText: null, isExpired: false);
    }

    final endDate = DateTime.tryParse(discountEndDate);
    if (endDate == null) {
      return (countdownText: null, isExpired: false);
    }

    final remaining = endDate.difference(currentTime);
    if (remaining.isNegative || remaining == Duration.zero) {
      return (countdownText: null, isExpired: true);
    }

    return (countdownText: formatDuration(remaining), isExpired: false);
  }
}
