import 'package:biddabari/course/data/models/course_model.dart';
import 'package:biddabari/course/data/repository/course_repository.dart';
import 'package:get/get.dart';

class CourseController extends GetxController {
  final CourseRepository _courseRepository = CourseRepository();
  @override
  void onInit() {
    getCourses();
    super.onInit();
  }

  RxList<CourseModel> courseList = <CourseModel>[].obs;
  final _isGettingCourses = false.obs;
  RxBool get isGettingCourses => _isGettingCourses;

  Future<void> getCourses() async {
    try {
      _isGettingCourses.value = true;
      final result = await _courseRepository.getCourses();
      courseList.value = result;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      _isGettingCourses.value = false;
    }
  }
}
