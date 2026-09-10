import 'package:flutter/material.dart';
import 'package:biddabari/course/presentation/widgets/course_card_banner.dart';
import 'package:biddabari/course/presentation/widgets/course_card_footer.dart';
import 'package:biddabari/course/presentation/widgets/course_card_stats.dart';
import 'package:biddabari/router/app_routes.dart';

class CourseCard extends StatelessWidget {
  final int? courseId;
  final String title;
  final String subtitle;
  final String bannerUrl;
  final double price;
  final double? discountPrice;
  final String? discountEndDate;
  final int durationInMonths;
  final int totalClasses;
  final int totalExams;
  final bool isLive;
  final String currencySymbol;
  final VoidCallback? onTap;
  final VoidCallback? onEnrollTap;
  final String? altText;

  const CourseCard({
    super.key,
    this.courseId,
    required this.title,
    required this.subtitle,
    required this.bannerUrl,
    required this.price,
    this.discountPrice,
    this.discountEndDate,
    required this.durationInMonths,
    required this.totalClasses,
    required this.totalExams,
    this.isLive = false,
    this.currencySymbol = '৳',
    this.onTap,
    this.onEnrollTap,
    this.altText,
  });

  bool get _hasDiscount => discountPrice != null && discountPrice! < price;

  int get _discountPercentage {
    if (!_hasDiscount) return 0;
    return (((price - discountPrice!) / price) * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12.0,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.15),
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.0),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Banner Image with Hero animation
              Hero(
                tag: '${AppRoutes.heroBannerPrefix}$courseId',
                child: CourseCardBanner(
                  altText: altText,
                  bannerUrl: bannerUrl,
                  isLive: isLive,
                  hasDiscount: _hasDiscount,
                  discountPercentage: _discountPercentage,
                  discountEndDate: discountEndDate,
                ),
              ),

              // Card Content
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course Title
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    if (subtitle.isNotEmpty) ...[
                      const SizedBox(height: 4.0),
                      // Subtitle
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.grey.shade600,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],

                    const SizedBox(height: 12.0),

                    // Course Stats Row (Duration, Classes, Exams, Live)
                    CourseCardStats(
                      durationInMonths: durationInMonths,
                      totalClasses: totalClasses,
                      totalExams: totalExams,
                      isLive: isLive,
                    ),

                    const SizedBox(height: 14.0),
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: Color(0xFFF1F5F9),
                    ),
                    const SizedBox(height: 12.0),

                    // Price & Action Button Footer
                    CourseCardFooter(
                      price: price,
                      discountPrice: discountPrice,
                      currencySymbol: currencySymbol,
                      onTap: onTap,
                      onEnrollTap: onEnrollTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
