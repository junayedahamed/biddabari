import 'package:biddabari/course/logic/course_controller.dart';
import 'package:biddabari/course/presentation/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseController = Get.find<CourseController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Courses",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        if (courseController.isGettingCourses.value &&
            courseController.courseList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (courseController.courseList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.menu_book_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  "No courses available right now.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => courseController.getCourses(),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => courseController.getCourses(),
          child: ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: courseController.courseList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16.0),
            itemBuilder: (context, index) {
              final course = courseController.courseList[index];
              return CourseCard.fromModel(
                course: course,
                onTap: () {
                  // Handle course tap
                },
                onEnrollTap: () {
                  // Handle enroll tap
                },
              );
            },
          ),
        );
      }),
    );
  }
}
