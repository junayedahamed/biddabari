import 'package:biddabari/course/bindings/course_bindings.dart';
import 'package:biddabari/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      initialBinding: CourseBindings(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
    );
  }
}
