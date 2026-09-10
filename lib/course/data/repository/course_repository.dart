// import 'package:biddabari/core/utils/api_client.dart';
import 'dart:convert';

import 'package:biddabari/course/data/models/course_model.dart';
import 'package:http/http.dart' as http;

class CourseRepository {
  // final ApiClient apiClient;

  // CourseRepository({required this.apiClient});

  final String baseUrl = "https://api.biddabari.com/api/v1/app-home-courses";

  Future<List<CourseModel>> getCourses() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      switch (response.statusCode) {
        case 200:
          return CourseResponseModel.fromJson(
                jsonDecode(response.body),
              ).courses ??
              [];

        default:
          final err = jsonDecode(response.body);
          throw Exception(err["message"]);
      }
      // return
    } catch (e) {
      rethrow;
    }
  }
}
