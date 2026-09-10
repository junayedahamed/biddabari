import 'package:json_annotation/json_annotation.dart';

part 'course_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CourseResponseModel {
  final List<CourseModel>? courses;

  CourseResponseModel({this.courses});

  factory CourseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseResponseModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class CourseModel {
  final int? id;
  final String? title;
  final String? subTitle;
  final double? price;
  final String? banner;
  final int? discountType;
  final double? discountAmount;
  final String? discountStartDate;
  final String? discountEndDate;
  final String? altText;
  final String? bannerTitle;
  final String? durationInMonth;
  final String? totalClass;
  final int? totalExam;
  final int? totalLive;
  final String? orderStatus;

  CourseModel({
    this.id,
    this.title,
    this.subTitle,
    this.price,
    this.banner,
    this.discountType,
    this.discountAmount,
    this.discountStartDate,
    this.discountEndDate,
    this.altText,
    this.bannerTitle,

    this.orderStatus,
    this.durationInMonth,
    this.totalClass,
    this.totalExam,
    this.totalLive,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  // Convenient helper getters for UI presentation
  String get displayTitle => title ?? '';
  String get displaySubtitle => subTitle ?? '';
  String get bannerUrl => banner ?? '';
  double get effectivePrice => price?.toDouble() ?? 0.0;

  DateTime? get parsedDiscountStartDate {
    if (discountStartDate == null || discountStartDate!.isEmpty) return null;
    return DateTime.tryParse(discountStartDate!);
  }

  DateTime? get parsedDiscountEndDate {
    if (discountEndDate == null || discountEndDate!.isEmpty) return null;
    return DateTime.tryParse(discountEndDate!);
  }

  bool isDiscountActive([DateTime? now]) {
    if (discountAmount == null ||
        discountAmount! <= 0 ||
        discountAmount! >= (price ?? 0)) {
      return false;
    }
    final currentTime = now ?? DateTime.now();
    final startDate = parsedDiscountStartDate;
    if (startDate != null && currentTime.isBefore(startDate)) {
      return false;
    }
    final endDate = parsedDiscountEndDate;
    if (endDate != null && currentTime.isAfter(endDate)) {
      return false;
    }
    return true;
  }

  double? get effectiveDiscountPrice =>
      isDiscountActive() ? discountAmount!.toDouble() : null;

  Duration? discountRemainingDuration([DateTime? now]) {
    final currentTime = now ?? DateTime.now();
    if (!isDiscountActive(currentTime)) return null;
    final endDate = parsedDiscountEndDate;
    if (endDate == null) return null;
    final remaining = endDate.difference(currentTime);
    return remaining.isNegative ? Duration.zero : remaining;
  }

  String? formatDiscountCountdown([DateTime? now]) {
    final remaining = discountRemainingDuration(now);
    if (remaining == null || remaining == Duration.zero) return null;

    final days = remaining.inDays;
    final hours = remaining.inHours.remainder(24);
    final minutes = remaining.inMinutes.remainder(60);
    final seconds = remaining.inSeconds.remainder(60);

    if (days > 0) {
      return '${days}d ${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m';
    } else if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}h ${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
    } else {
      return '${minutes.toString().padLeft(2, '0')}m ${seconds.toString().padLeft(2, '0')}s';
    }
  }

  String? get formattedDiscountCountdown => formatDiscountCountdown();

  int get parsedDurationInMonths =>
      int.tryParse(durationInMonth?.toString() ?? '') ?? 0;
  int get parsedTotalClasses => int.tryParse(totalClass?.toString() ?? '') ?? 0;
  int get parsedTotalExams => int.tryParse(totalExam?.toString() ?? '') ?? 0;
  int get parsedTotalLive => int.tryParse(totalLive?.toString() ?? '') ?? 0;
  bool get isLiveCourse => parsedTotalLive > 0;
}
