// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseResponseModel _$CourseResponseModelFromJson(Map<String, dynamic> json) =>
    CourseResponseModel(
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseResponseModelToJson(
  CourseResponseModel instance,
) => <String, dynamic>{
  'courses': instance.courses?.map((e) => e.toJson()).toList(),
};

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  subTitle: json['sub_title'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  banner: json['banner'] as String?,
  discountType: (json['discount_type'] as num?)?.toInt(),
  discountAmount: (json['discount_amount'] as num?)?.toDouble(),
  discountStartDate: json['discount_start_date'] as String?,
  discountEndDate: json['discount_end_date'] as String?,
  altText: json['alt_text'] as String?,
  bannerTitle: json['banner_title'] as String?,
  durationInMonth: json['duration_in_month'],
  totalClass: json['total_class'],
  totalExam: json['total_exam'],
  totalLive: json['total_live'],
  orderStatus: json['order_status'] as String?,
);

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'sub_title': instance.subTitle,
      'price': instance.price,
      'banner': instance.banner,
      'discount_type': instance.discountType,
      'discount_amount': instance.discountAmount,
      'discount_start_date': instance.discountStartDate,
      'discount_end_date': instance.discountEndDate,
      'alt_text': instance.altText,
      'banner_title': instance.bannerTitle,
      'duration_in_month': instance.durationInMonth,
      'total_class': instance.totalClass,
      'total_exam': instance.totalExam,
      'total_live': instance.totalLive,
      'order_status': instance.orderStatus,
    };
