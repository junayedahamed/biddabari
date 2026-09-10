import 'package:biddabari/course/bindings/course_bindings.dart';
import 'package:biddabari/course/presentation/screens/details_screen.dart';
import 'package:biddabari/course/presentation/screens/home_screen.dart';
import 'package:get/get.dart';

abstract class AppRoutes {
  static const String home = '/';
  static const String courseDetails = '/course-details';

  static const String heroBannerPrefix = 'course-banner-';

  static final List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: CourseBindings(),
    ),
    GetPage(
      name: courseDetails,
      page: () {
        final id = Get.arguments as int?;
        return DetailsScreen(id: id ?? 0);
      },
      binding: CourseBindings(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
