import 'dart:convert';
import 'package:http/http.dart' as http;
import 'recipe.dart';

class RecipeService {
  final String apiKey = 'ac511176f3394adb94a686d8bc3aff70';
  final String baseUrl = 'https://api.spoonacular.com/recipes';

  Future<List<Recipe>> fetchRecipes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/complexSearch?apiKey=$apiKey&addRecipeInformation=true'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['results'];
      List<Recipe> recipes = data.map((json) => Recipe.fromJson(json)).toList();
      return recipes;
    } else {
      // Print or log the response body for debugging
      print('Failed to load recipes: ${response.statusCode}');
      throw Exception('Failed to load recipes: ${response.reasonPhrase}');
    }
  }

  Future<Recipe> fetchRecipeDetails(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$id/information?apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return Recipe.fromJson(data);
    } else {
      // Print or log the response body for debugging
      print('Failed to load recipe details: ${response.statusCode}');
      throw Exception('Failed to load recipe details: ${response.reasonPhrase}');
    }
  }
}
