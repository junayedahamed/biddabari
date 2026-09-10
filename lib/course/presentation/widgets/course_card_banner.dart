import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:biddabari/course/presentation/widgets/discount_countdown_chip.dart';

class CourseCardBanner extends StatelessWidget {
  final String bannerUrl;
  final bool isLive;
  final bool hasDiscount;
  final int discountPercentage;
  final String? discountEndDate;
  final String? altText;

  const CourseCardBanner({
    super.key,
    required this.bannerUrl,
    this.isLive = false,
    this.hasDiscount = false,
    this.discountPercentage = 0,
    this.discountEndDate,
    this.altText,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Cached Network Banner Image
        AspectRatio(
          aspectRatio: 16 / 9,
          child: CachedNetworkImage(
            imageUrl:
                "https://storage.biddabari.online/biddabari-bucket/backend/assets/uploaded-files/course/course-banners/courses-1785592301-771938478695716.webp",
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey.shade200,
              child: const Center(child: CircularProgressIndicator()),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey.shade200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_not_supported_outlined,
                    color: Colors.grey.shade400,
                    size: 36,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    altText ?? "",
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.2),
                ],
              ),
            ),
          ),
        ),

        if (hasDiscount)
          Positioned(
            top: 10,
            left: 10,
            child: DiscountCountdownChip(
              hasDiscount: hasDiscount,
              discountPercentage: discountPercentage,
              discountEndDate: discountEndDate,
            ),
          ),

        if (isLive)
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.65),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(
                  color: Colors.redAccent.withValues(alpha: 0.8),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 7.0,
                    height: 7.0,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  const Text(
                    'LIVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
