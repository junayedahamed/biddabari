import 'package:biddabari/course/data/repository/course_repository.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CourseController extends GetxController {
  final CourseRepository _courseRepository = CourseRepository();
  @override
  void onInit() {
    _courseRepository.getCourses();
    super.onInit();
  }
}
