// import 'package:biddabari/core/utils/api_client.dart';
import 'dart:developer';

import 'package:http/http.dart' as http;

class CourseRepository {
  // final ApiClient apiClient;

  // CourseRepository({required this.apiClient});

  final String baseUrl = "https://api.biddabari.com/api/v1/app-home-courses";

  Future<void> getCourses() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      );

      log(response.body);
      // return
    } catch (e) {
      rethrow;
    }
  }
}
