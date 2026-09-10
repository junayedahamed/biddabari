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
  final dynamic durationInMonth;
  final dynamic totalClass;
  final dynamic totalExam;
  final dynamic totalLive;
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
    this.durationInMonth,
    this.totalClass,
    this.totalExam,
    this.totalLive,
    this.orderStatus,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  // Convenient helper getters for UI presentation
  String get displayTitle => title ?? '';
  String get displaySubtitle => subTitle ?? '';
  String get bannerUrl => banner ?? '';
  double get effectivePrice => price?.toDouble() ?? 0.0;
  double? get effectiveDiscountPrice =>
      (discountAmount != null &&
          discountAmount! > 0 &&
          discountAmount! < (price ?? 0))
      ? discountAmount!.toDouble()
      : null;

  int get parsedDurationInMonths =>
      int.tryParse(durationInMonth?.toString() ?? '') ?? 0;
  int get parsedTotalClasses => int.tryParse(totalClass?.toString() ?? '') ?? 0;
  int get parsedTotalExams => int.tryParse(totalExam?.toString() ?? '') ?? 0;
  int get parsedTotalLive => int.tryParse(totalLive?.toString() ?? '') ?? 0;
  bool get isLiveCourse => parsedTotalLive > 0;
}
