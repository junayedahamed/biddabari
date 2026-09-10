import 'dart:convert';
import 'dart:developer';
import 'package:biddabari/course/data/models/course_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CourseRepository {
  static const String _cacheKey = 'cached_courses';
  final GetStorage _storage = GetStorage();
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
      log(response.body);
      switch (response.statusCode) {
        case 200:
          // Cache raw JSON on success
          await _storage.write(_cacheKey, response.body);
          return CourseResponseModel.fromJson(
                jsonDecode(response.body),
              ).courses ??
              [];

        default:
          final err = jsonDecode(response.body);
          throw Exception(err["message"]);
      }
    } catch (e) {
      // On any failure, try returning cached data
      final cached = _getCachedCourses();
      if (cached != null && cached.isNotEmpty) {
        return cached;
      }

      // No cache available, throw meaningful error
      if (e is http.ClientException) {
        throw Exception("No internet connection and no cached data available");
      } else {
        rethrow;
      }
    }
  }

  List<CourseModel>? _getCachedCourses() {
    final cachedJson = _storage.read<String>(_cacheKey);
    if (cachedJson == null || cachedJson.isEmpty) return null;
    try {
      return CourseResponseModel.fromJson(jsonDecode(cachedJson)).courses ?? [];
    } catch (_) {
      return null;
    }
  }

  bool get hasCachedData {
    final cached = _storage.read<String>(_cacheKey);
    return cached != null && cached.isNotEmpty;
  }
}
