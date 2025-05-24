import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/restaurant.dart';

class RestaurantService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  static Future<RestaurantListResponse?> getRestaurants() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/list'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return RestaurantListResponse.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      print('Error fetching restaurants: $e');
      return null;
    }
  }

  static Future<RestaurantDetailResponse?> getRestaurantDetail(
      String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/detail/$id'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return RestaurantDetailResponse.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      print('Error fetching restaurant detail: $e');
      return null;
    }
  }

  static String getImageUrl(String pictureId) {
    return '$baseUrl/images/small/$pictureId';
  }
}
