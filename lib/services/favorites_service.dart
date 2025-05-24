import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/restaurant.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites';

  static Future<List<Restaurant>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_favoritesKey) ?? [];

    return favoritesJson
        .map((json) => Restaurant.fromJson(jsonDecode(json)))
        .toList();
  }

  static Future<void> addToFavorites(Restaurant restaurant) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    // Check if already exists
    if (!favorites.any((fav) => fav.id == restaurant.id)) {
      favorites.add(restaurant);
      final favoritesJson = favorites
          .map((restaurant) => jsonEncode(restaurant.toJson()))
          .toList();
      await prefs.setStringList(_favoritesKey, favoritesJson);
    }
  }

  static Future<void> removeFromFavorites(String restaurantId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = await getFavorites();

    favorites.removeWhere((restaurant) => restaurant.id == restaurantId);
    final favoritesJson =
        favorites.map((restaurant) => jsonEncode(restaurant.toJson())).toList();
    await prefs.setStringList(_favoritesKey, favoritesJson);
  }

  static Future<bool> isFavorite(String restaurantId) async {
    final favorites = await getFavorites();
    return favorites.any((restaurant) => restaurant.id == restaurantId);
  }
}
