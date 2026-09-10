import 'package:biddabari/course/logic/course_controller.dart';
import 'package:get/get.dart';

class CourseBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseController>(() => CourseController());
  }
}
